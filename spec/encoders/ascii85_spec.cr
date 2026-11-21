require "../spec_helper"

describe "ASCII85" do
  it "decodes zero shorthand, partial tuples, and whitespace" do
    encode("<~z 9jqo\n~>", ["ascii85-decode"]).should eq("\0\0\0\0Man")
    encode("9jqo^", ["ascii85-decode"]).should eq("Man ")
  end

  it "round trips the highest four-byte tuple" do
    original = String.new(Bytes[255, 255, 255, 255])
    encoded = encode(original, ["ascii85"])
    encoded.should eq("<~s8W-!~>")
    encode(encoded, ["ascii85-decode"]).should eq(original)
  end

  it "preserves input with invalid tuples" do
    ["<~!~>", "<~!z!!!~>", "<~!!!!!v!~>", "<~uuuuu~>"].each do |input|
      encode(input, ["ascii85-decode"]).should eq(input)
    end
  end
end
