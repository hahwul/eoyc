require "logger"
require "option_parser"
require "./utils.cr"
require "./encoders.cr"

module Eoyc
  VERSION = "0.1.0"
end

all = false
choice = ""
regex = ""
output = ""
encoders = [""]

OptionParser.parse do |parser|
  parser.banner = "Usage: eoyc [arguments]"
  parser.on "-a", "--all", "Convert all string" { all = true }
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
    exit
  end
  parser.invalid_option do |flag|
    STDERR.puts "ERROR: #{flag} is not a valid option."
    STDERR.puts parser
    exit(1)
  end
end

log = Logger.new(STDOUT)

STDIN.each_line do |line|
  new_encoders = encoders.clone
  target = ""
  if all
    target = line
  else
    if choice != ""
      target = choice
    elsif regex != ""
      target = find(line, regex)
    end
  end
  replacement = encode(target, new_encoders)
  puts replace(line, target, replacement)
end
