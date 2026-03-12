require "spec"
require "../spec_helper"

describe "unicode" do
  it "unicode encode single char" do
    result = encode("a", ["unicode"])
    result.should eq("\\u0061")
  end

  it "unicode encode multiple chars" do
    result = encode("hello", ["unicode"])
    result.should eq("\\u0068\\u0065\\u006c\\u006c\\u006f")
  end

  it "unicode decode single char" do
    result = encode("\\u0061", ["unicode-decode"])
    result.should eq("a")
  end

  it "unicode decode multiple chars" do
    result = encode("\\u0068\\u0065\\u006c\\u006c\\u006f", ["unicode-decode"])
    result.should eq("hello")
  end

  it "unicode encode-decode round trip" do
    original = "test"
    encoded = encode(original, ["unicode"])
    decoded = encode(encoded, ["unicode-decode"])
    decoded.should eq(original)
  end

  it "unicode decode invalid input" do
    result = encode("invalid", ["unicode-decode"])
    result.should eq("invalid")
  end

  it "unicode encode special characters" do
    result = encode("@", ["unicode"])
    result.should eq("\\u0040")
  end

  it "unicode decode mixed valid and invalid" do
    result = encode("\\u0061 normal text \\u0062", ["unicode-decode"])
    result.should eq("a normal text b")
  end
end
