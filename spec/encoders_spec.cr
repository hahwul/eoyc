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

  it "md5 digest standard test vector" do
    result = encode("123456789", ["md5"])
    result.should eq("25f9e794323b453885f5181f1b624d0b")
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
    # Bytes [255, 239, 191] encode to "/++/" in base64, which is "_--_" in base64-url
    original = String.new(Bytes[255, 239, 191])
    encoded = encode(original, ["base64-url"])
    encoded.should eq("_--_")
    decoded = encode(encoded, ["base64-url-decode"])
  it "rot13 encode lowercase" do
    result = encode("hello", ["rot13"])
    result.should eq("uryyb")
  end

  it "rot13 encode uppercase" do
    result = encode("HELLO", ["rot13"])
    result.should eq("URYYB")
  end

  it "rot13 encode mixed case" do
    result = encode("Hello World", ["rot13"])
    result.should eq("Uryyb Jbeyq")
  end

  it "rot13 ignores non-alphabetic characters" do
    result = encode("123!@#", ["rot13"])
    result.should eq("123!@#")
  end

  it "rot13 encode-decode round trip" do
    original = "The quick brown fox jumps over the lazy dog! 123"
    encoded = encode(original, ["rot13"])
    decoded = encode(encoded, ["rot13"])
    decoded.should eq(original)
  end
end
