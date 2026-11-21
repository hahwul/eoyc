require "spec"
require "../src/line_processing"

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
    result.should eq("aGVsbG8%3D")
  end

  it "does not mutate the encoders array" do
    encoders = ["base64"]
    Eoyc.process_line("hello", "", "", encoders)
    encoders.should eq(["base64"])
  end
end
