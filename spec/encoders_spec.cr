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
end