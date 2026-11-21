require "../spec_helper"

describe "case transforms" do
  it "capitalizes words while preserving surrounding and internal whitespace" do
    encode("  HELLO\twORLD \n", ["title-case"]).should eq("  Hello\tWorld \n")
    encode(" \t ", ["title-case"]).should eq(" \t ")
    encode("", ["title-case"]).should eq("")
  end

  it "ignores leading and trailing separators in camel case" do
    encode("_ customer-id_ ", ["camel-case"]).should eq("customerId")
    encode("_ - ", ["camel-case"]).should eq("")
  end

  it "ignores leading and trailing separators in Pascal case" do
    encode("_ customer-id_ ", ["pascal-case"]).should eq("CustomerId")
    encode("_ - ", ["pascal-case"]).should eq("")
  end
end
