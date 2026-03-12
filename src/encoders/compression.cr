require "./core"
require "compress/zlib"
require "compress/gzip"

# Zlib Encode (compress + base64)
Encoders.register(
  EncoderSpec.new(
    "zlib-encode",
    %w[zlib-encode zlib],
    "Zlib compress then Base64 encode",
    category: "compression",
    flags: %w[encode reversible compression]
  ) do |str|
    begin
      compressed = IO::Memory.new
      Compress::Zlib::Writer.open(compressed) do |zlib|
        zlib.print(str)
      end
      Base64.strict_encode(compressed.to_slice)
    rescue
      str
    end
  end
)

# Zlib Decode (base64 + decompress)
Encoders.register(
  EncoderSpec.new(
    "zlib-decode",
    %w[zlib-decode],
    "Base64 decode then Zlib decompress",
    category: "compression",
    flags: %w[decode reversible compression]
  ) do |str|
    begin
      decoded = Base64.decode(str)
      input = IO::Memory.new(decoded)
      Compress::Zlib::Reader.open(input) do |zlib|
        zlib.gets_to_end
      end
    rescue
      str
    end
  end
)

# Gzip Encode (compress + base64)
Encoders.register(
  EncoderSpec.new(
    "gzip-encode",
    %w[gzip-encode gzip],
    "Gzip compress then Base64 encode",
    category: "compression",
    flags: %w[encode reversible compression]
  ) do |str|
    begin
      compressed = IO::Memory.new
      Compress::Gzip::Writer.open(compressed) do |gzip|
        gzip.print(str)
      end
      Base64.strict_encode(compressed.to_slice)
    rescue
      str
    end
  end
)

# Gzip Decode (base64 + decompress)
Encoders.register(
  EncoderSpec.new(
    "gzip-decode",
    %w[gzip-decode],
    "Base64 decode then Gzip decompress",
    category: "compression",
    flags: %w[decode reversible compression]
  ) do |str|
    begin
      decoded = Base64.decode(str)
      input = IO::Memory.new(decoded)
      Compress::Gzip::Reader.open(input) do |gzip|
        gzip.gets_to_end
      end
    rescue
      str
    end
  end
)
