require "../spec_helper"

describe "Punycode" do
  it "uses a delimiter to round-trip nonempty ASCII strings" do
    {"hello" => "hello-", "read-me" => "read-me-", "-" => "--"}.each do |original, encoded|
      encode(original, ["punycode"]).should eq(encoded)
      encode(encoded, ["punycode-decode"]).should eq(original)
    end
  end

  it "preserves mixed and non-ASCII Punycode vectors" do
    {"bücher" => "bcher-kva", "例え" => "r8jz45g", "☃-⌘" => "--dqo34k"}.each do |original, encoded|
      encode(original, ["punycode"]).should eq(encoded)
      encode(encoded, ["punycode-decode"]).should eq(original)
    end
  end

  it "keeps empty input empty" do
    encode("", %w[punycode-decode punycode]).should eq("")
  end
end
