require "spec"
require "./spec_helper"

describe "digests" do
  it "md5 digest" do
    result = encode("abc", ["md5"])
    result.should eq("900150983cd24fb0d6963f7d28e17f72")
  end

  it "sha1 Base64 digest" do
    result = encode("abc", ["sha1"])
    result.should eq("qZk+NkcGgWq6PiVxeFDCbJzQ2J0=")
  end

  it "sha1 hex digest" do
    result = encode("abc", ["sha1-hex"])
    result.should eq("a9993e364706816aba3e25717850c26c9cd0d89d")
  end

  it "sha256 Base64 digest" do
    result = encode("abc", ["sha256"])
    result.should eq("ungWv48Bz+pBQUDeXa4iI7ADYaOWF3qctBD/YfIAFa0=")
  end

  it "sha256 hex digest" do
    result = encode("abc", ["sha256-hex"])
    result.should eq("ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad")
  end

  it "sha512 Base64 digest" do
    result = encode("abc", ["sha512"])
    result.should eq("3a81oZNherrMQXNJriBBMRLm+k6JqX6iCp7u5ktV05ohkpkqJ0/BqDa6PCOj/uu9RU1EI2Q86A4qmslPpUyknw==")
  end

  it "sha512 hex digest" do
    result = encode("abc", ["sha512-hex"])
    result.should eq("ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f")
  end

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
