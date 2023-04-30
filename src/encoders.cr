require "base64"
require "digest/md5"
require "digest/sha1"
require "digest/sha256"
require "digest/sha512"
require "uri"

def encode(str, encoders)
    result = ""
    if encoders.size > 0 && str != ""
        target = encoders.pop
        case target.strip
        when "base64", "base64-encode"
            result = Base64.encode(str.to_s)
        when "base64-decode"
            result = Base64.decode(str.to_s)
        when "md5"
            result = Digest::MD5.hexdigest(str.to_s)
        when "sha1"
            result = Digest::SHA1.base64digest(str.to_s)
        when "sha256"
            result = Digest::SHA256.base64digest(str.to_s)
        when "sha512"
            result = Digest::SHA512.base64digest(str.to_s)
        when "url", "url-encode"
            result = URI.encode_www_form(str.to_s)
        when "url-decode"
            result = URI.decode_www_form(str.to_s)
        when "upcase"
            result = str.to_s.upcase
        when "downcase"
            result = str.to_s.downcase
        when "redacted", "redaction"
            size = str.to_s.size
            result = "◼" * size
        else
            result = str
        end 
        result = encode(result, encoders)
    else 
        result = str
    end
    return result.to_s.strip
end