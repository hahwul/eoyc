require "./utils"
require "./encoders"

module Eoyc
  # Process a single line with the given choice, regex, and encoders
  def self.process_line(line : String, choice : String, regex : Regex | String, encoders : Array(String)) : String
    if choice != ""
      target = choice
    elsif regex.is_a?(Regex) || !regex.empty?
      m = find(line, regex)
      if m
        if g = m[1]?
          target = g
        else
          target = m[0]
        end
      else
        return line
      end
    else
      target = line
    end

    replacement = encode(target, encoders)
    replace(line, target, replacement)
  end
end
