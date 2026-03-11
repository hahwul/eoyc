# Core encoder framework
#
# This file provides the shared primitives for defining and using
# encoders / transformers inside the project.
#
# Responsibilities:
# - EncoderSpec: metadata + execution wrapper
# - Global registry with thread-safe registration
# - Lookup + help text generation
# - Chain execution (encode)
# - Shared utility helpers (EncoderUtils) for common low-level routines
#
# Usage (in another file):
#
#   require "./encoders/core"
#
#   Encoders.register(
#     EncoderSpec.new("base64", %w[base64 base64-encode], "Base64 encode") { |s|
#       Base64.encode(s)
#     }
#   )
#
#   # Then elsewhere:
#   output = encode("hello", ["base64"])
#
# Backward compatibility helpers:
#   available_encoders  -> Array(EncoderSpec)
#   encoder_help_lines  -> Array(String)
#   encode(str, encoders:Array(String)) -> String
#
# New preferred API (module scoped):
#   Encoders.specs
#   Encoders.help_lines
#   Encoders.encode_chain(str, encoders)
#
# NOTE: The chain semantics expect the provided encoders array to be
#       treated like a stack (last element applied first). The CLI
#       already reverses user input before passing it here.

require "mutex"
require "base64"

# Single specification for an encoder / transformer.
struct EncoderSpec
  getter primary : String
  getter names : Array(String)
  getter description : String
  getter proc : Proc(String, String)

  def initialize(primary : String, names : Array(String), description : String, &block : String -> String)
    unless names.includes?(primary)
      raise ArgumentError.new("Primary name '#{primary}' must be included in names array")
    end
    @primary = primary
    @names = names
    @description = description
    @proc = block
  end

  def apply(input : String) : String
    @proc.call(input)
  end

  def alias_list : Array(String)
    names.reject { |name| name == primary }
  end
end

# Shared helpers for encoder implementations.
module EncoderUtils
  extend self

  # Convert an array of UInt8 bytes to a String
  def bytes_to_string(bytes : Array(UInt8)) : String
    String.new(Bytes.new(bytes.to_unsafe, bytes.size))
  end

  # URL-safe Base64 (no padding)
  def base64_url_encode(str : String) : String
    Base64.encode(str).gsub('+', '-').gsub('/', '_').gsub(/=+$/, "")
  end

  def base64_url_decode(str : String) : String
    work = str.tr("-", "+").tr("_", "/")
    padding = (4 - work.size % 4) % 4
    work += "=" * padding
    Base64.decode_string(work)
  rescue
    str
  end

  def hex_encode(str : String) : String
    str.to_slice.hexstring
  end

  def hex_decode(str : String) : String
    String.new(str.strip.hexbytes)
  rescue
    str
  end

  def rot13(str : String) : String
    str.tr("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", "nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM")
  end

  def redact(str : String) : String
    "◼" * str.size
  end

  def bin_encode(str : String) : String
    str.bytes.map(&.to_s(2).rjust(8, '0')).join(" ")
  end

  def bin_decode(str : String) : String
    clean = str.strip
    # Split on spaces and try to convert each 8-bit binary string back to a byte
    parts = clean.split(/\s+/)
    bytes = [] of UInt8

    parts.each do |part|
      # Check if it's a valid 8-bit binary string
      if part =~ /^[01]{1,8}$/
        bytes << part.to_i(2).to_u8
      else
        # If invalid binary, return original string
        return str
      end
    end

    bytes_to_string(bytes)
  rescue
    str
  end

  def oct_encode(str : String) : String
    str.bytes.map(&.to_s(8).rjust(3, '0')).join
  end

  def oct_decode(str : String) : String
    clean = str.strip
    return str if clean.empty? || clean.size % 3 != 0

    # Each character should be exactly 3 octal digits
    bytes = [] of UInt8
    i = 0

    while i < clean.size
      chunk = clean[i, 3]
      if chunk =~ /^[0-7]{3}$/
        val = chunk.to_i(8)
        if val <= 255
          bytes << val.to_u8
          i += 3
        else
          return str # Invalid octal value > 255
        end
      else
        return str # Invalid octal format
      end
    end

    bytes_to_string(bytes)
  rescue
    str
  end

  def unicode_encode(str : String) : String
    str.each_char.map { |char| "\\u" + char.ord.to_s(16).rjust(4, '0') }.join
  end

  def unicode_decode(str : String) : String
    # Match \uXXXX patterns and convert back to characters
    decoded = str.gsub(/\\u([0-9a-fA-F]{4})/) do |_|
      code_point = $1.to_i(16)
      code_point.chr.to_s
    end
    decoded
  rescue
    str
  end

  def charcode_encode(str : String) : String
    str.bytes.map(&.to_s).join(" ")
  end

  def charcode_decode(str : String) : String
    clean = str.strip
    return str if clean.empty?

    # Split on spaces and try to convert each decimal string back to a byte
    parts = clean.split(/\s+/)
    bytes = [] of UInt8

    parts.each do |part|
      # Check if it's a valid decimal number
      if part =~ /^[0-9]+$/
        val = part.to_i
        if val >= 0 && val <= 255
          bytes << val.to_u8
        else
          return str # Invalid char code value
        end
      else
        return str # Invalid format
      end
    end

    bytes_to_string(bytes)
  rescue
    str
  end

  def rot47(str : String) : String
    str.each_char.map do |char|
      ord = char.ord
      if ord >= 33 && ord <= 126
        ((ord - 33 + 47) % 94 + 33).chr
      else
        char
      end
    end.join
  end

  def atbash(str : String) : String
    str.each_char.map do |char|
      case char
      when 'a'..'z' then ('z'.ord - (char.ord - 'a'.ord)).chr
      when 'A'..'Z' then ('Z'.ord - (char.ord - 'A'.ord)).chr
      else                char
      end
    end.join
  end

  def html_encode(str : String) : String
    str.gsub('&', "&amp;")
      .gsub('<', "&lt;")
      .gsub('>', "&gt;")
      .gsub('"', "&quot;")
      .gsub('\'', "&#39;")
  end

  def html_decode(str : String) : String
    str.gsub("&#39;", "'")
      .gsub("&quot;", "\"")
      .gsub("&gt;", ">")
      .gsub("&lt;", "<")
      .gsub("&amp;", "&")
  end

  def json_escape(str : String) : String
    String.build do |io|
      str.each_char do |char|
        case char
        when '"'  then io << "\\\""
        when '\\' then io << "\\\\"
        when '\n' then io << "\\n"
        when '\r' then io << "\\r"
        when '\t' then io << "\\t"
        when '\b' then io << "\\b"
        when '\f' then io << "\\f"
        else
          if char.ord < 0x20
            io << "\\u" << char.ord.to_s(16).rjust(4, '0')
          else
            io << char
          end
        end
      end
    end
  end

  def json_unescape(str : String) : String
    result = str.gsub("\\\"", "\"")
      .gsub("\\\\", "\\")
      .gsub("\\n", "\n")
      .gsub("\\r", "\r")
      .gsub("\\t", "\t")
      .gsub("\\b", "\b")
      .gsub("\\f", "\f")
    result.gsub(/\\u([0-9a-fA-F]{4})/) { $1.to_i(16).chr.to_s }
  rescue
    str
  end

  MORSE_TABLE = {
    'A' => ".-", 'B' => "-...", 'C' => "-.-.", 'D' => "-..", 'E' => ".",
    'F' => "..-.", 'G' => "--.", 'H' => "....", 'I' => "..", 'J' => ".---",
    'K' => "-.-", 'L' => ".-..", 'M' => "--", 'N' => "-.", 'O' => "---",
    'P' => ".--.", 'Q' => "--.-", 'R' => ".-.", 'S' => "...", 'T' => "-",
    'U' => "..-", 'V' => "...-", 'W' => ".--", 'X' => "-..-", 'Y' => "-.--",
    'Z' => "--..", '0' => "-----", '1' => ".----", '2' => "..---",
    '3' => "...--", '4' => "....-", '5' => ".....", '6' => "-....",
    '7' => "--...", '8' => "---..", '9' => "----.",
  }

  MORSE_REVERSE = MORSE_TABLE.invert

  def morse_encode(str : String) : String
    str.upcase.split("").map do |char|
      if char == " "
        "/"
      elsif MORSE_TABLE.has_key?(char[0])
        MORSE_TABLE[char[0]]
      else
        char
      end
    end.join(" ")
  end

  def morse_decode(str : String) : String
    str.split(" ").map do |token|
      if token == "/"
        " "
      elsif MORSE_REVERSE.has_key?(token)
        MORSE_REVERSE[token].to_s
      else
        token
      end
    end.join
  rescue
    str
  end

  def ascii85_encode(str : String) : String
    bytes = str.bytes
    return "" if bytes.empty?

    String.build do |io|
      io << "<~"
      i = 0
      while i < bytes.size
        # Pack up to 4 bytes into a 32-bit value
        group_size = Math.min(4, bytes.size - i)
        val = 0_u32
        4.times do |j|
          val <<= 8
          val |= (j < group_size ? bytes[i + j].to_u32 : 0_u32)
        end

        if val == 0 && group_size == 4
          io << 'z'
        else
          chars = Array(Char).new(5, '!' )
          4.downto(0) do |j|
            chars[j] = (val % 85 + 33).chr
            val //= 85
          end
          # Output group_size + 1 characters
          (group_size + 1).times { |j| io << chars[j] }
        end
        i += 4
      end
      io << "~>"
    end
  end

  def ascii85_decode(str : String) : String
    work = str.strip
    work = work[2..] if work.starts_with?("<~")
    work = work[...-2] if work.ends_with?("~>")
    work = work.gsub(/\s/, "")

    bytes = [] of UInt8
    i = 0
    while i < work.size
      if work[i] == 'z'
        4.times { bytes << 0_u8 }
        i += 1
      else
        group_size = Math.min(5, work.size - i)
        chunk = work[i, group_size]
        # Pad with 'u' (84 + 33 = 117 = 'u') to make 5 chars
        padded = chunk + "u" * (5 - chunk.size)

        val = 0_u64
        padded.each_char do |char|
          val = val * 85 + (char.ord - 33).to_u64
        end

        out_bytes = group_size - 1
        out_bytes.times do |j|
          bytes << ((val >> (8 * (3 - j))) & 0xFF).to_u8
        end
        i += group_size
      end
    end

    String.new(Bytes.new(bytes.to_unsafe, bytes.size))
  rescue
    str
  end

  LEET_MAP = {
    'a' => '4', 'e' => '3', 'i' => '1', 'o' => '0', 's' => '5',
    't' => '7', 'l' => '1', 'g' => '9', 'b' => '8',
  }

  def leet(str : String) : String
    str.each_char.map do |char|
      lower = char.downcase
      if LEET_MAP.has_key?(lower)
        LEET_MAP[lower]
      else
        char
      end
    end.join
  end

  def punycode_encode(str : String) : String
    # Simple Punycode encoder (RFC 3492)
    n = 128
    delta = 0
    bias = 72
    output = [] of Char
    basic_chars = [] of Char
    non_basic = [] of Int32

    str.each_char do |char|
      if char.ord < 128
        basic_chars << char
        output << char
      else
        non_basic << char.ord
      end
    end

    h = basic_chars.size
    b = basic_chars.size

    output << '-' if b > 0 && non_basic.size > 0

    return str if non_basic.empty?

    all_codepoints = str.each_char.map(&.ord).to_a

    while h < str.each_char.to_a.size
      m = all_codepoints.select { |codepoint| codepoint >= n }.min

      delta += (m - n) * (h + 1)
      n = m

      all_codepoints.each do |codepoint|
        if codepoint < n
          delta += 1
        elsif codepoint == n
          q = delta
          k = 36
          loop do
            t = if k <= bias + 1
                  1
                elsif k >= bias + 26
                  26
                else
                  k - bias
                end
            break if q < t
            output << punycode_digit(t + (q - t) % (36 - t))
            q = (q - t) // (36 - t)
            k += 36
          end
          output << punycode_digit(q)
          bias = punycode_adapt(delta, h + 1, h == b)
          delta = 0
          h += 1
        end
      end

      delta += 1
      n += 1
    end

    output.join
  rescue
    str
  end

  def punycode_decode(str : String) : String
    # Find the last '-' to separate basic from encoded parts
    delim = str.rindex('-')
    output = if delim
               str[0...delim].each_char.to_a
             else
               [] of Char
             end
    encoded = if delim
                str[(delim + 1)..]
              else
                str
              end

    n = 128
    i = 0
    bias = 72
    idx = 0

    while idx < encoded.size
      old_i = i
      w = 1
      k = 36
      loop do
        break if idx >= encoded.size
        char = encoded[idx]
        idx += 1
        digit = punycode_digit_value(char)
        i += digit * w
        t = if k <= bias + 1
              1
            elsif k >= bias + 26
              26
            else
              k - bias
            end
        break if digit < t
        w *= (36 - t)
        k += 36
      end

      bias = punycode_adapt(i - old_i, output.size + 1, old_i == 0)
      n += i // (output.size + 1)
      i = i % (output.size + 1)
      output.insert(i, n.chr)
      i += 1
    end

    output.join
  rescue
    str
  end

  private def punycode_digit(d : Int32) : Char
    if d < 26
      ('a'.ord + d).chr
    else
      ('0'.ord + d - 26).chr
    end
  end

  private def punycode_digit_value(char : Char) : Int32
    case char
    when 'a'..'z' then char.ord - 'a'.ord
    when 'A'..'Z' then char.ord - 'A'.ord
    when '0'..'9' then char.ord - '0'.ord + 26
    else               0
    end
  end

  private def punycode_adapt(delta : Int32, numpoints : Int32, firsttime : Bool) : Int32
    d = firsttime ? delta // 700 : delta // 2
    d += d // numpoints
    k = 0
    while d > 455 # ((36 - 1) * 26) // 2
      d //= 35
      k += 36
    end
    k + (36 * d) // (d + 38)
  end

  # Base32 (RFC 4648) encode with padding
  def base32_encode(str : String) : String
    alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"
    bits = 0_u32
    bits_left = 0
    out_len = 0
    String.build do |io|
      bytes = str.to_slice
      i = 0
      while i < bytes.size
        bits = (bits << 8) | bytes[i].to_u32
        bits_left += 8
        while bits_left >= 5
          val = ((bits >> (bits_left - 5)) & 0x1F).to_i
          io << alphabet[val]
          out_len += 1
          bits_left -= 5
        end
        i += 1
      end
      if bits_left > 0
        val = ((bits << (5 - bits_left)) & 0x1F).to_i
        io << alphabet[val]
        out_len += 1
        bits_left = 0
      end
      while out_len % 8 != 0
        io << '='
        out_len += 1
      end
    end
  rescue
    str
  end

  # Base32 (RFC 4648) decode
  def base32_decode(str : String) : String
    cleaned = str.upcase.gsub(/[^A-Z2-7=]/, "")
    bits = 0_u32
    bits_left = 0
    bytes = [] of UInt8

    cleaned.each_char do |char|
      next if char == '='
      val = case char
            when 'A'..'Z' then char.ord - 'A'.ord
            when '2'..'7' then char.ord - '2'.ord + 26
            else
              return str
            end
      bits = (bits << 5) | val.to_u32
      bits_left += 5
      if bits_left >= 8
        byte = ((bits >> (bits_left - 8)) & 0xFF).to_u8
        bytes << byte
        bits_left -= 8
      end
    end

    bytes_to_string(bytes)
  rescue
    str
  end

  # CRC32 (IEEE 802.3) value as UInt32
  def crc32_uint(str : String) : UInt32
    crc = 0xFFFF_FFFF_u32
    str.each_byte do |b|
      crc ^= b.to_u32
      8.times do
        if (crc & 1_u32) == 1_u32
          crc = (crc >> 1) ^ 0xEDB8_8320_u32
        else
          crc >>= 1
        end
      end
    end
    crc ^ 0xFFFF_FFFF_u32
  rescue
    0_u32
  end

  # CRC32 hex string (lowercase, 8 chars)
  def crc32_hex(str : String) : String
    v = crc32_uint(str)
    v.to_s(16).rjust(8, '0')
  rescue
    "00000000"
  end
end

module Encoders
  extend self

  @@specs = [] of EncoderSpec
  @@name_to_spec = Hash(String, EncoderSpec).new
  @@mutex = Mutex.new

  # Register a new encoder specification.
  # If a name/alias already exists it will be overwritten by this spec.
  def register(spec : EncoderSpec)
    @@mutex.synchronize do
      @@specs << spec
      spec.names.each do |name|
        @@name_to_spec[name.downcase] = spec
      end
    end
  end

  # Return all registered specs (in registration order).
  def specs : Array(EncoderSpec)
    @@specs
  end

  # Lookup a spec by any name or alias (case-insensitive).
  def find(name : String) : EncoderSpec?
    @@name_to_spec[name.downcase]?
  end

  # Produce lines suited for help output.
  def help_lines : Array(String)
    specs.map do |spec|
      aliases = spec.alias_list
      alias_part = aliases.empty? ? "" : " (aliases: #{aliases.join(", ")})"
      "#{spec.primary.ljust(17)} - #{spec.description}#{alias_part}"
    end
  end

  # Apply a chain of encoders (processes from last to first).
  def encode_chain(str, encoders : Array(String)) : String
    current = str.to_s
    return current.strip if current.empty? || encoders.empty?

    (encoders.size - 1).downto(0) do |i|
      name = encoders[i].strip.downcase
      spec = find(name)
      if spec
        begin
          current = spec.apply(current)
        rescue
          # fail-safe: keep current value
        end
      end
    end
    current.to_s.strip
  end
end

# Backward-compatible top-level functions (existing callers rely on these).

def available_encoders : Array(EncoderSpec)
  Encoders.specs
end

def encoder_help_lines : Array(String)
  Encoders.help_lines
end

def encode(str, encoders)
  # Accept nil gracefully (Crystal type flexibility)
  ary = encoders.as(Array(String))
  Encoders.encode_chain(str, ary)
end
