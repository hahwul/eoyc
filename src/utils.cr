# Finds the first match of a regex pattern in a string
# Returns a Regex::MatchData if found, nil otherwise
def find(str, match)
  regex = Regex.new(match)
  regex.match(str)
end

# Replaces all occurrences of a substring with a replacement string
# Returns a new string with all substitutions made
def replace(str, find, replacement)
  str.gsub(find.to_s, replacement.to_s)
end
