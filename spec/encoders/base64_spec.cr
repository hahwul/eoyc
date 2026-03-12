require "spec"
require "../spec_helper"

describe "base64" do
  it "single case" do
    result = encode("abcd", ["base64"])
    result.should eq("YWJjZA==")
  end

  it "base32 encode single case" do
    result = encode("f", ["base32"])
    result.should eq("MY======")
  end

  it "base32 decode single case" do
    result = encode("MY======", ["base32-decode"])
    result.should eq("f")
  end

  it "base32 encode-decode round trip" do
    original = "foobar"
    encoded = encode(original, ["base32"])
    decoded = encode(encoded, ["base32-decode"])
    decoded.should eq(original)
  end

  it "crc32 standard test vector" do
    result = encode("123456789", ["crc32"])
    result.should eq("cbf43926")
  end

  it "base64-url decode unpadded single char (2 padding chars needed)" do
    encoded = encode("A", ["base64-url"])
    encoded.should eq("QQ")
    decoded = encode(encoded, ["base64-url-decode"])
    decoded.should eq("A")
  end

  it "base64-url decode unpadded two chars (1 padding char needed)" do
    encoded = encode("AB", ["base64-url"])
    encoded.should eq("QUI")
    decoded = encode(encoded, ["base64-url-decode"])
    decoded.should eq("AB")
  end

  it "base64-url decode unpadded three chars (0 padding chars needed)" do
    encoded = encode("ABC", ["base64-url"])
    encoded.should eq("QUJD")
    decoded = encode(encoded, ["base64-url-decode"])
    decoded.should eq("ABC")
  end

  it "base64-url encode-decode with characters requiring - and _" do
    original = String.new(Bytes[255, 239, 191])
    encoded = encode(original, ["base64-url"])
    encoded.should eq("_--_")
    decoded = encode(encoded, ["base64-url-decode"])
    decoded.should eq(original)
  end

  it "base64-url-pad encode-decode round trip" do
    original = "abcd"
    encoded = encode(original, ["base64-url-pad"])
    decoded = encode(encoded, ["base64-url-pad-decode"])
    decoded.should eq(original)
  end

  it "base64-url-pad decode compatibility" do
    original = "abcd"
    encoded_unpadded = encode(original, ["base64-url"])
    decoded = encode(encoded_unpadded, ["base64-url-pad-decode"])
    decoded.should eq(original)
  end

  it "multiple encoder chain case" do
    encoders = ["base64", "url"]
    result = encode("abcd", encoders.reverse)
    result.should eq("YWJjZA%3D%3D%0A")
  end
end
