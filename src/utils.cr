def find(str, match)
  regex = Regex.new(match)
  regex.match(str)
end

def replace(str, find, replacement)
  str.gsub(find.to_s, replacement.to_s)
end
