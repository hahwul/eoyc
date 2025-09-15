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
end
