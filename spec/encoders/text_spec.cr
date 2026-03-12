require "spec"
require "../spec_helper"

describe "text" do
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

  it "upcase encode lowercase text" do
    result = encode("hello", ["upcase"])
    result.should eq("HELLO")
  end

  it "upcase encode mixed case text" do
    result = encode("HeLlO wOrLd", ["upcase"])
    result.should eq("HELLO WORLD")
  end

  it "upcase encode already uppercase text" do
    result = encode("HELLO", ["upcase"])
    result.should eq("HELLO")
  end

  it "upcase encode with special characters and numbers" do
    result = encode("hello 123 !@#", ["upcase"])
    result.should eq("HELLO 123 !@#")
  end

  it "downcase encode uppercase string" do
    result = encode("HELLO", ["downcase"])
    result.should eq("hello")
  end

  it "downcase encode mixed case string" do
    result = encode("HeLlO", ["downcase"])
    result.should eq("hello")
  end

  it "downcase encode string with numbers" do
    result = encode("HELLO123", ["downcase"])
    result.should eq("hello123")
  end

  it "reverse encode single case" do
    result = encode("abc", ["reverse"])
    result.should eq("cba")
  end

  it "reverse encode with spaces" do
    result = encode("hello world", ["reverse"])
    result.should eq("dlrow olleh")
  end

  it "reverse encode empty string" do
    result = encode("", ["reverse"])
    result.should eq("")
  end

  it "reverse encode-decode round trip" do
    original = "reversible"
    encoded = encode(original, ["reverse"])
    decoded = encode(encoded, ["reverse"])
    decoded.should eq(original)
  end

  it "redacted encode standard string" do
    result = encode("hello", ["redacted"])
    result.should eq("◼◼◼◼◼")
  end

  it "redacted encode empty string" do
    result = encode("", ["redacted"])
    result.should eq("")
  end

  it "redacted encode with spaces and special chars" do
    result = encode("a b c!", ["redacted"])
    result.should eq("◼◼◼◼◼◼")
  end

  it "redaction alias works" do
    result = encode("secret", ["redaction"])
    result.should eq("◼◼◼◼◼◼")
  end
end
