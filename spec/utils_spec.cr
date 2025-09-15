require "spec"
require "./spec_helper"

describe "find" do
  it "returns the correct value" do
    result = find("abcd", "bc")
    result.should_not be_nil
    result.try(&.[0].should(eq("bc")))
  end
end

describe "replace" do
  it "returns the correct value" do
    result = replace("abcd", "bc", "ef")
    result.should eq("aefd")
  end
end
