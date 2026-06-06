require "option_parser"
require "json"
require "./utils.cr"
require "./encoders.cr"

module Eoyc
  VERSION = "0.4.0"

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

choice = ""
regex = ""
output = ""
encoders = [] of String
json_mode = false
list_json = false
describe_encoder = ""
search_keyword = ""
show_categories = false
chain_info = false
show_capabilities = false
trim_input = false

begin
  OptionParser.parse do |parser|
    parser.banner = "Usage: eoyc [arguments]"
    parser.on "-s STRING", "--string=STRING", "Your choice string" { |var| choice = var }
    parser.on "-r REGEX", "--regex=REGEX", "Your choice regex pattern" { |var| regex = var }
    parser.on "-e ENCODERS", "--encoders=ENCODERS", "Encoders chain [char: >|,]" do |var|
      origin = var.split(/>|\||,/).map(&.strip).reject(&.empty?)
      encoders = origin.reverse
    end
    parser.on "-o PATH", "--output=PATH", "Output file" { |var| output = var }
    parser.on "-v", "--version", "Show version" do
      puts Eoyc::VERSION
      exit
    end
    parser.on "-l", "--list", "List encoders" do
      puts "Encoders (#{encoder_help_lines.size}):"
      encoder_help_lines.each do |line|
        puts "  #{line}"
      end
      exit
    end

    # AI-friendly flags
    parser.on "--json", "JSON output mode" { json_mode = true }
    parser.on "--list-json", "List all encoders as JSON" { list_json = true }
    parser.on "--describe=NAME", "Describe an encoder (JSON)" { |var| describe_encoder = var }
    parser.on "--search=KEYWORD", "Search encoders by keyword (JSON)" { |var| search_keyword = var }
    parser.on "--categories", "List encoder categories (JSON)" { show_categories = true }
    parser.on "--chain-info", "Show step-by-step chain results (JSON)" { chain_info = true }
    parser.on "--capabilities", "Show tool capabilities (JSON)" { show_capabilities = true }
    parser.on "--trim", "Trim trailing whitespace/newlines from each input line" { trim_input = true }

    parser.on "-h", "--help", "Show help" do
      puts parser
      puts
      puts "Encoders: #{encoder_help_lines.size} available. Use -l/--list to list all, or --list-json for machine-readable."
      puts "Categories: #{Encoders.categories.join(", ")}"
      puts "Chain with > | or ,   (e.g. base64>hex  or  url|upcase|md5)"
      puts "Add --trim to strip trailing newlines (useful with echo)."
      exit
    end
    parser.invalid_option do |flag|
      STDERR.puts "ERROR: #{flag} is not a valid option."
      STDERR.puts parser
      exit(1)
    end
  end
rescue ex : OptionParser::Exception
  STDERR.puts "ERROR: #{ex.message}"
  STDERR.puts "Run `eoyc -h` for usage."
  exit(1)
end

# Handle AI-friendly discovery commands (no stdin needed)
if show_capabilities
  puts(JSON.build do |json|
    json.object do
      json.field "tool", "eoyc"
      json.field "version", Eoyc::VERSION
      json.field "description", "Chainable encoding/decoding CLI tool"
      json.field "encoder_count", Encoders.specs.size
      json.field "categories", Encoders.categories
      json.field "input", "stdin (line-by-line)"
      json.field "chain_separators", [">", "|", ","]
      json.field "flags" do
        json.object do
          json.field "-e", "Encoder chain (e.g., base64>url>hex)"
          json.field "-s", "Target specific substring"
          json.field "-r", "Target regex-matched content"
          json.field "-o", "Output to file"
          json.field "--json", "JSON output mode"
          json.field "--list-json", "List encoders as JSON"
          json.field "--describe", "Describe a specific encoder"
          json.field "--search", "Search encoders by keyword"
          json.field "--categories", "List encoder categories"
          json.field "--chain-info", "Show step-by-step chain results"
          json.field "--trim", "Trim trailing whitespace from input lines"
        end
      end
      json.field "usage_examples" do
        json.array do
          json.object do
            json.field "description", "Encode string to base64 (direct arg)"
            json.field "command", "eoyc -e base64 hello"
          end
          json.object do
            json.field "description", "Chain multiple encoders (pipe or args)"
            json.field "command", "eoyc -e 'base64>hex' hello"
          end
          json.object do
            json.field "description", "Encode only matched part via regex"
            json.field "command", "echo 'key=value' | eoyc -r 'value' -e base64"
          end
          json.object do
            json.field "description", "JSON output with per-step results"
            json.field "command", "eoyc -e 'base64>hex' hello --json --chain-info"
          end
          json.object do
            json.field "description", "Trim newlines from echo before hashing"
            json.field "command", "echo 'hello' | eoyc --trim -e sha256-hex"
          end
        end
      end
    end
  end)
  exit
end

if list_json
  puts Encoders.to_json_array
  exit
end

if describe_encoder != ""
  result = Encoders.describe_json(describe_encoder)
  if result
    puts result
  else
    STDERR.puts(JSON.build { |j| j.object { j.field "error", "encoder '#{describe_encoder}' not found" } })
    exit(1)
  end
  exit
end

if search_keyword != ""
  results = Encoders.search(search_keyword)
  puts(JSON.build do |json|
    json.object do
      json.field "query", search_keyword
      json.field "count", results.size
      json.field "results" do
        json.array do
          results.each(&.to_json(json))
        end
      end
    end
  end)
  exit
end

if show_categories
  puts Encoders.categories_json
  exit
end

unknown_encoders = Encoders.unknown_names(encoders)
unless unknown_encoders.empty?
  STDERR.puts "ERROR: unknown encoder#{unknown_encoders.size == 1 ? "" : "s"}: #{unknown_encoders.join(", ")}"
  STDERR.puts "Run `eoyc --list` to see available encoders."
  exit(1)
end

compiled_regex = begin
  regex.empty? ? "" : Regex.new(regex)
rescue ex : ArgumentError
  STDERR.puts "ERROR: invalid regex '#{regex}': #{ex.message}"
  exit(1)
end

# Collect input lines: positional args (if any) take precedence over stdin (enables `eoyc -e base64 hello`)
input_lines = ARGV.dup
if input_lines.empty?
  # No positional args; read from stdin (filter mode)
  STDIN.each_line { |line| input_lines << line }
end

if trim_input
  input_lines = input_lines.map(&.rstrip)
end

# Main processing loop
io = if output != ""
       begin
         File.open(output, "w")
       rescue ex
         STDERR.puts "ERROR: cannot open output file '#{output}': #{ex.message}"
         exit(1)
       end
     else
       STDOUT
     end
begin
  if json_mode
    lines = input_lines

    io.puts(JSON.build do |json|
      json.object do
        json.field "input", lines
        json.field "encoders", encoders.reverse

        if chain_info && !encoders.empty?
          json.field "steps" do
            json.array do
              lines.each do |line|
                target = if choice != ""
                           choice
                         elsif compiled_regex.is_a?(Regex)
                           m = find(line, compiled_regex)
                           m ? (m[1]? || m[0]) : line
                         else
                           line
                         end
                steps = Encoders.encode_chain_steps(target.to_s, encoders)
                json.object do
                  json.field "input", line
                  json.field "chain" do
                    json.array do
                      steps.each do |step|
                        json.object do
                          json.field "encoder", step[:encoder]
                          json.field "output", step[:output]
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end

        json.field "output" do
          json.array do
            lines.each do |line|
              json.string Eoyc.process_line(line, choice, compiled_regex, encoders)
            end
          end
        end
      end
    end)
  else
    input_lines.each do |line|
      io.puts Eoyc.process_line(line, choice, compiled_regex, encoders)
    end
  end
ensure
  io.close unless io == STDOUT
end
