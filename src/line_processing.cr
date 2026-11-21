require "./utils"
require "./encoders"

module Eoyc
  # Process a single line with the given choice, regex, and encoders
  def self.process_line(line : String, choice : String, regex : Regex | String, encoders : Array(String)) : String
    if !choice.empty?
      replace(line, choice, encode(choice, encoders))
    elsif regex.is_a?(Regex) || !regex.empty?
      return line unless match = find(line, regex)

      group = match[1]? ? 1 : 0
      start = match.byte_begin(group)
      finish = match.byte_end(group)
      line.byte_slice(0, start) + encode(match[group], encoders) + line.byte_slice(finish)
    else
      encode(line, encoders)
    end
  end
end
