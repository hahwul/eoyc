require "./spec_helper"

# Define the Eoyc module here since requiring src/eoyc.cr would trigger CLI parsing.
# This mirrors the process_line method from src/eoyc.cr.
module Eoyc
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

describe "Eoyc.process_line" do
  it "encodes full line when no choice or regex given" do
    result = Eoyc.process_line("hello", "", "", ["base64"])
    result.should eq("aGVsbG8=")
  end

  it "encodes only the choice string (-s option)" do
    result = Eoyc.process_line("hello world", "world", "", ["base64"])
    result.should eq("hello d29ybGQ=")
  end

  it "encodes regex match (-r option)" do
    regex = Regex.new("w\\w+")
    result = Eoyc.process_line("hello world", "", regex, ["base64"])
    result.should eq("hello d29ybGQ=")
  end

  it "returns original line when regex does not match" do
    regex = Regex.new("zzz")
    result = Eoyc.process_line("hello world", "", regex, ["base64"])
    result.should eq("hello world")
  end

  it "encodes regex capture group when present" do
    regex = Regex.new("hello (\\w+)")
    result = Eoyc.process_line("hello world", "", regex, ["base64"])
    result.should eq("hello d29ybGQ=")
  end

  it "applies chain encoding" do
    result = Eoyc.process_line("hello", "", "", ["url", "base64"])
    result.should eq("aGVsbG8%3D%0A")
  end

  it "does not mutate the encoders array" do
    encoders = ["base64"]
    Eoyc.process_line("hello", "", "", encoders)
    encoders.should eq(["base64"])
  end
end
