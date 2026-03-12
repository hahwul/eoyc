require "spec"
require "../spec_helper"

describe "leet encoder" do
  it "encodes lowercase leet characters" do
    result = encode("aeiostlgb", ["leet"])
    result.should eq("431057198")
  end

  it "encodes uppercase leet characters" do
    result = encode("AEIOSTLGB", ["leet"])
    result.should eq("431057198")
  end

  it "ignores non-leet characters" do
    result = encode("xyz123", ["leet"])
    result.should eq("xyz123")
  end

  it "handles empty string" do
    result = encode("", ["leet"])
    result.should eq("")
  end

  it "works with l33t alias" do
    result = encode("leet", ["l33t"])
    result.should eq("1337")
  end
end
