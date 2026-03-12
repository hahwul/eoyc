# Digest-related encoder registrations
require "./core"
require "digest/md5"
require "digest/sha1"
require "digest/sha256"
require "digest/sha512"
require "openssl"

# MD5 hex
Encoders.register(
  EncoderSpec.new(
    "md5",
    %w[md5],
    "MD5 hex digest",
    category: "hash",
    flags: %w[one-way digest]
  ) do |str|
    begin
      Digest::MD5.hexdigest(str)
    rescue
      str
    end
  end
)

# SHA1 Base64
Encoders.register(
  EncoderSpec.new(
    "sha1",
    %w[sha1],
    "SHA1 Base64 digest",
    category: "hash",
    flags: %w[one-way digest]
  ) do |str|
    begin
      Digest::SHA1.base64digest(str)
    rescue
      str
    end
  end
)

# SHA1 hex
Encoders.register(
  EncoderSpec.new(
    "sha1-hex",
    %w[sha1-hex],
    "SHA1 hex digest",
    category: "hash",
    flags: %w[one-way digest]
  ) do |str|
    begin
      Digest::SHA1.hexdigest(str)
    rescue
      str
    end
  end
)

# SHA256 Base64
Encoders.register(
  EncoderSpec.new(
    "sha256",
    %w[sha256],
    "SHA256 Base64 digest",
    category: "hash",
    flags: %w[one-way digest]
  ) do |str|
    begin
      Digest::SHA256.base64digest(str)
    rescue
      str
    end
  end
)

# SHA256 hex
Encoders.register(
  EncoderSpec.new(
    "sha256-hex",
    %w[sha256-hex],
    "SHA256 hex digest",
    category: "hash",
    flags: %w[one-way digest]
  ) do |str|
    begin
      Digest::SHA256.hexdigest(str)
    rescue
      str
    end
  end
)

# SHA512 Base64
Encoders.register(
  EncoderSpec.new(
    "sha512",
    %w[sha512],
    "SHA512 Base64 digest",
    category: "hash",
    flags: %w[one-way digest]
  ) do |str|
    begin
      Digest::SHA512.base64digest(str)
    rescue
      str
    end
  end
)

# SHA512 hex
Encoders.register(
  EncoderSpec.new(
    "sha512-hex",
    %w[sha512-hex],
    "SHA512 hex digest",
    category: "hash",
    flags: %w[one-way digest]
  ) do |str|
    begin
      Digest::SHA512.hexdigest(str)
    rescue
      str
    end
  end
)

# SHA384 Base64
Encoders.register(
  EncoderSpec.new(
    "sha384",
    %w[sha384],
    "SHA384 Base64 digest",
    category: "hash",
    flags: %w[one-way digest]
  ) do |str|
    begin
      digest = OpenSSL::Digest.new("SHA384")
      digest.update(str)
      Base64.strict_encode(digest.final)
    rescue
      str
    end
  end
)

# SHA384 hex
Encoders.register(
  EncoderSpec.new(
    "sha384-hex",
    %w[sha384-hex],
    "SHA384 hex digest",
    category: "hash",
    flags: %w[one-way digest]
  ) do |str|
    begin
      digest = OpenSSL::Digest.new("SHA384")
      digest.update(str)
      digest.final.map(&.to_s(16).rjust(2, '0')).join
    rescue
      str
    end
  end
)
