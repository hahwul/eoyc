require "spec"
require "../spec_helper"

describe "hex" do
  it "hex encode single char" do
    result = encode("a", ["hex"])
    result.should eq("61")
  end

  it "hex encode multiple chars" do
    result = encode("abc", ["hex"])
    result.should eq("616263")
  end

  it "hex decode single char" do
    result = encode("61", ["hex-decode"])
    result.should eq("a")
  end

  it "hex decode multiple chars" do
    result = encode("616263", ["hex-decode"])
    result.should eq("abc")
  end

  it "hex encode-decode round trip" do
    original = "hello"
    encoded = encode(original, ["hex"])
    decoded = encode(encoded, ["hex-decode"])
    decoded.should eq(original)
  end

  it "hex decode invalid input" do
    result = encode("invalid", ["hex-decode"])
    result.should eq("invalid")
  end

  it "hex decode with mixed case input" do
    result = encode("6A6b", ["hex-decode"])
    result.should eq("jk")
  end

  it "hex decode with invalid odd-length input" do
    result = encode("68656c6c6", ["hex-decode"])
    result.should eq("68656c6c6")
  end

  it "hex decode with invalid characters" do
    result = encode("68656c6c6g", ["hex-decode"])
    result.should eq("68656c6c6g")
  end

  it "hex decode with surrounding whitespace" do
    result = encode("  68656c6c6f  ", ["hex-decode"])
    result.should eq("hello")
  end

  it "hex decode uppercase characters" do
    result = encode("68656C6C6F", ["hex-decode"])
    result.should eq("hello")
  end
end
