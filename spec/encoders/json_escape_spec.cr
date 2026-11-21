require "../spec_helper"

describe "JSON string escaping" do
  it "round-trips literal escape sequences and control characters" do
    input = %q(\n \u0061 \\ \" \/) + "\n\t\b\f\r\u001f"
    encode(input, %w[json-unescape json-escape]).should eq(input)
  end

  it "decodes escaped slashes, Unicode code points, and surrogate pairs" do
    encode(%q(\/ \u00e9 \uD83D\uDE03), ["json-unescape"]).should eq("/ é 😃")
  end

  it "unescapes fragments alongside raw quotes and unknown escapes" do
    input = %q(frag "text" \q \uD800 \uDC00 \u００４１ \t) + "\n"
    encode(input, ["json-unescape"]).should eq(%q(frag "text" \q \uD800 \uDC00 \u００４１ ) + "\t\n")
  end
end
