require "logger"
require "option_parser"
require "./utils.cr"
require "./encoders.cr"

module Eoyc
  VERSION = "0.2.0"
end

choice = ""
regex = ""
output = ""
encoders = [""]

OptionParser.parse do |parser|
  parser.banner = "Usage: eoyc [arguments]"
  parser.on "-s STRING", "--string=STRING", "Your choice string" { |var| choice = var }
  parser.on "-r REGEX", "--regex=REGEX", "Your choice regex pattern" { |var| regex = var }
  parser.on "-e ENCODERS", "--encoders=ENCODERS", "Encoders chain [char: >|,]" do |var|
    origin = var.split(/>|\|/)
    encoders = origin.reverse
  end
  parser.on "-o PATH", "--output=PATH", "Output file" { |var| output = var }
  parser.on "-v", "--version", "Show version" do
    puts Eoyc::VERSION
    exit
  end
  parser.on "-h", "--help", "Show help" do
    puts parser
    puts
    puts "Encoders:"
    encoder_help_lines.each do |l|
      puts "  #{l}"
    end
    exit
  end
  parser.invalid_option do |flag|
    STDERR.puts "ERROR: #{flag} is not a valid option."
    STDERR.puts parser
    exit(1)
  end
end

STDIN.each_line do |line|
  new_encoders = encoders.clone
  target = ""
  if choice != ""
    target = choice
  elsif regex != ""
    target = find(line, regex)
  else
    target = line
  end
  replacement = encode(target, new_encoders)
  puts replace(line, target, replacement)
end
