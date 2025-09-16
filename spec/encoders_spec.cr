require "spec"
require "./spec_helper"

describe "encode" do
  it "single case" do
    result = encode("abcd", ["base64"])
    result.should eq("YWJjZA==")
  end

  it "multiple case" do
    encoders = ["base64", "url"]
    result = encode("abcd", encoders.reverse)
    result.should eq("YWJjZA%3D%3D%0A")
  end

  it "binary encode single case" do
    result = encode("abc", ["bin"])
    result.should eq("01100001 01100010 01100011")
  end

  it "binary decode single case" do
    result = encode("01100001 01100010 01100011", ["bin-decode"])
    result.should eq("abc")
  end

  it "binary encode-decode round trip" do
    original = "test"
    encoded = encode(original, ["bin"])
    decoded = encode(encoded, ["bin-decode"])
    decoded.should eq(original)
  end

  it "octal encode single case" do
    result = encode("a", ["oct"])
    result.should eq("141")
  end

  it "octal encode multiple chars" do
    result = encode("abc", ["oct"])
    result.should eq("141142143")
  end

  it "octal decode single case" do
    result = encode("141", ["oct-decode"])
    result.should eq("a")
  end

  it "octal decode multiple chars" do
    result = encode("141142143", ["oct-decode"])
    result.should eq("abc")
  end

  it "octal encode-decode round trip" do
    original = "hello"
    encoded = encode(original, ["oct"])
    decoded = encode(encoded, ["oct-decode"])
    decoded.should eq(original)
  end

  it "octal decode invalid input" do
    result = encode("invalid", ["oct-decode"])
    result.should eq("invalid")
  end

  it "octal encode with leading zeros" do
    result = encode(" ", ["oct"]) # space = 32 = 040 in octal
    result.should eq("040")
  end

  it "octal encode-decode with special chars" do
    original = "AB" # 'A' = 65 = 101, 'B' = 66 = 102
    encoded = encode(original, ["oct"])
    encoded.should eq("101102")
    decoded = encode(encoded, ["oct-decode"])
    decoded.should eq(original)
  end

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
