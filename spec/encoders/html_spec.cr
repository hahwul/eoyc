require "../spec_helper"

describe "HTML entities" do
  it "decodes named and numeric references" do
    encode("&copy; &apos; &#65; &#x1f600; &NotEqualTilde;", ["html-decode"]).should eq("© ' A 😀 ≂̸")
  end

  it "does not recursively decode references" do
    encode("&amp;lt; &amp;#65;", ["html-decode"]).should eq("&lt; &#65;")
  end

  it "leaves plain ampersands and unrecognized references alone" do
    input = "Rock & Roll &unknown;"
    encode(input, ["html-decode"]).should eq(input)
  end

  it "round-trips HTML special characters with existing reference-like text" do
    input = %q(<a title="Rock & Roll's">&copy;</a>)
    encode(input, %w[html-decode html]).should eq(input)
  end
end
