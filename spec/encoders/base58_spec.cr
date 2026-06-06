require "spec"
require "../spec_helper"

describe "base58" do
  it "base58 encode single char" do
    result = encode("a", ["base58"])
    result.should eq("2g")
  end

  it "base58 encode multiple chars" do
    result = encode("abc", ["base58"])
    result.should eq("ZiCa")
  end

  it "base58 decode single char" do
    result = encode("2g", ["base58-decode"])
    result.should eq("a")
  end

  it "base58 decode multiple chars" do
    result = encode("ZiCa", ["base58-decode"])
    result.should eq("abc")
  end

  it "base58 encode-decode round trip (ascii)" do
    original = "hello world"
    encoded = encode(original, ["base58"])
    decoded = encode(encoded, ["base58-decode"])
    decoded.should eq(original)
  end

  it "base58 encode-decode round trip with leading zero bytes" do
    original = "\x00\x00hello"
    encoded = encode(original, ["base58"])
    decoded = encode(encoded, ["base58-decode"])
    decoded.should eq(original)
  end

  it "base58 encode-decode round trip with high bytes" do
    original = "café\x80\xff"
    encoded = encode(original, ["base58"])
    decoded = encode(encoded, ["base58-decode"])
    decoded.should eq(original)
  end

  it "base58 decode invalid input returns original (resilient)" do
    result = encode("invalid0OIl", ["base58-decode"]) # contains characters not in alphabet (0, O, I, l are excluded)
    result.should eq("invalid0OIl")
  end

  it "base58 handles all zero bytes" do
    original = "\x00\x00\x00"
    encoded = encode(original, ["base58"])
    encoded.should eq("111")
    decoded = encode(encoded, ["base58-decode"])
    decoded.should eq(original)
  end

  it "base58 roundtrip empty string" do
    encoded = encode("", ["base58"])
    encoded.should eq("")
    decoded = encode("", ["base58-decode"])
    decoded.should eq("")
  end
end
