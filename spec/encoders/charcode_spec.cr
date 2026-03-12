require "spec"
require "../spec_helper"

describe "charcode" do
  it "charcode encode single char" do
    result = encode("a", ["charcode"])
    result.should eq("97")
  end

  it "charcode encode multiple chars" do
    result = encode("abcd", ["charcode"])
    result.should eq("97 98 99 100")
  end

  it "charcode decode single char" do
    result = encode("97", ["charcode-decode"])
    result.should eq("a")
  end

  it "charcode decode multiple chars" do
    result = encode("97 98 99 100", ["charcode-decode"])
    result.should eq("abcd")
  end

  it "charcode encode-decode round trip" do
    original = "hello"
    encoded = encode(original, ["charcode"])
    decoded = encode(encoded, ["charcode-decode"])
    decoded.should eq(original)
  end

  it "charcode decode invalid input" do
    result = encode("invalid", ["charcode-decode"])
    result.should eq("invalid")
  end

  it "charcode encode special characters" do
    result = encode("@", ["charcode"])
    result.should eq("64")
  end

  it "charcode decode out of range value" do
    result = encode("256", ["charcode-decode"])
    result.should eq("256")
  end

  it "charcode encode-decode with spaces and special chars" do
    original = "A B"
    encoded = encode(original, ["charcode"])
    encoded.should eq("65 32 66")
    decoded = encode(encoded, ["charcode-decode"])
    decoded.should eq(original)
  end
end
