require "base64"

def encode(str, encoders)
    result = ""
    if encoders.size > 0 && str != ""
        target = encoders.pop
        case target.strip
        when "base64", "base64-encode"
            result = Base64.encode(str.to_s)
        when "base64-decode"
            result = Base64.decode(str.to_s)
        else
            result = str
        end 
        result = encode(result, encoders)
    else 
        result = str
    end
    return result.to_s.strip
end