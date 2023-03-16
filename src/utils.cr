
def find(str, match)
    regex = Regex.new(match)
    return regex.match(str)
end

def replace(str, find, replacement)
    return str.gsub(find.to_s,replacement.to_s)
end