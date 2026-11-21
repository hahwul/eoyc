require "./utils"
require "./encoders"

module Eoyc
  # Process a single line with the given choice, regex, and encoders
  def self.process_line(line : String, choice : String, regex : Regex | String, encoders : Array(String)) : String
    process_line(line, choice, regex) { |target| encode(target, encoders) }
  end

  def self.process_line(line : String, choice : String, regex : Regex | String, &encode_target : String -> String) : String
    if !choice.empty?
      return line unless line.includes?(choice)

      replace(line, choice, encode_target.call(choice))
    elsif regex.is_a?(Regex) || !regex.empty?
      return line unless match = find(line, regex)

      group = match[1]? ? 1 : 0
      start = match.byte_begin(group)
      finish = match.byte_end(group)
      line.byte_slice(0, start) + encode_target.call(match[group]) + line.byte_slice(finish)
    else
      encode_target.call(line)
    end
  end
end
