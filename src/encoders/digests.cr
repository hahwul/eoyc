# Digest-related encoder registrations
#
# Provides hashing / digest transformations:
#   md5            -> MD5 hex digest
#   sha1           -> SHA1 Base64 digest
#   sha1-hex       -> SHA1 hex digest
#   sha256         -> SHA256 Base64 digest
#   sha256-hex     -> SHA256 hex digest
#   sha512         -> SHA512 Base64 digest
#   sha512-hex     -> SHA512 hex digest
#
# Dependencies:
#   ./core (EncoderSpec / Encoders)
#
# Behavior:
# - Always returns a String.
# - On internal errors (unexpected) the original input string is returned (fail-safe).
#
# NOTE:
# If duplicates are registered elsewhere (legacy monolithic file), the last
# registration wins for each alias.

require "./core"
require "digest/md5"
require "digest/sha1"
require "digest/sha256"
require "digest/sha512"

# MD5 hex
Encoders.register(
  EncoderSpec.new(
    "md5",
    %w[md5],
    "MD5 hex digest"
  ) do |s|
    begin
      Digest::MD5.hexdigest(s)
    rescue
      s
    end
  end
)

# SHA1 Base64
Encoders.register(
  EncoderSpec.new(
    "sha1",
    %w[sha1],
    "SHA1 Base64 digest"
  ) do |s|
    begin
      Digest::SHA1.base64digest(s)
    rescue
      s
    end
  end
)

# SHA1 hex
Encoders.register(
  EncoderSpec.new(
    "sha1-hex",
    %w[sha1-hex],
    "SHA1 hex digest"
  ) do |s|
    begin
      Digest::SHA1.hexdigest(s)
    rescue
      s
    end
  end
)

# SHA256 Base64
Encoders.register(
  EncoderSpec.new(
    "sha256",
    %w[sha256],
    "SHA256 Base64 digest"
  ) do |s|
    begin
      Digest::SHA256.base64digest(s)
    rescue
      s
    end
  end
)

# SHA256 hex
Encoders.register(
  EncoderSpec.new(
    "sha256-hex",
    %w[sha256-hex],
    "SHA256 hex digest"
  ) do |s|
    begin
      Digest::SHA256.hexdigest(s)
    rescue
      s
    end
  end
)

# SHA512 Base64
Encoders.register(
  EncoderSpec.new(
    "sha512",
    %w[sha512],
    "SHA512 Base64 digest"
  ) do |s|
    begin
      Digest::SHA512.base64digest(s)
    rescue
      s
    end
  end
)

# SHA512 hex
Encoders.register(
  EncoderSpec.new(
    "sha512-hex",
    %w[sha512-hex],
    "SHA512 hex digest"
  ) do |s|
    begin
      Digest::SHA512.hexdigest(s)
    rescue
      s
    end
  end
)
