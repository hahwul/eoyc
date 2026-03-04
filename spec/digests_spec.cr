require "spec"
require "./spec_helper"

describe "digests" do
  describe "sha1" do
    it "encodes 'test' to SHA1 Base64" do
      result = encode("test", ["sha1"])
      result.should eq("qUqP5cyxm6YcTAhz05Hph5gvu9M=")
    end

    it "encodes 'abc' to SHA1 Base64" do
      result = encode("abc", ["sha1"])
      result.should eq("qZk+NkcGgWq6PiVxeFDCbJzQ2J0=")
    end
  end

  describe "sha1-hex" do
    it "encodes 'test' to SHA1 hex" do
      result = encode("test", ["sha1-hex"])
      result.should eq("a94a8fe5ccb19ba61c4c0873d391e987982fbbd3")
    end

    it "encodes 'abc' to SHA1 hex" do
      result = encode("abc", ["sha1-hex"])
      result.should eq("a9993e364706816aba3e25717850c26c9cd0d89d")
    end
  end
end
