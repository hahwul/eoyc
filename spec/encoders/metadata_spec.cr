require "spec"
require "json"
require "../spec_helper"

describe "EncoderSpec metadata" do
  it "has category field" do
    if found = Encoders.find("base64")
      found.category.should eq("encoding")
    else
      fail "base64 encoder not found"
    end
  end

  it "has flags field" do
    if found = Encoders.find("base64")
      found.flags.should contain("encode")
      found.flags.should contain("reversible")
    else
      fail "base64 encoder not found"
    end
  end

  it "hash encoders have one-way flag" do
    if found = Encoders.find("md5")
      found.flags.should contain("one-way")
    else
      fail "md5 encoder not found"
    end
  end

  it "cipher encoders have cipher category" do
    if found = Encoders.find("rot13")
      found.category.should eq("cipher")
    else
      fail "rot13 encoder not found"
    end
  end

  it "transform encoders have transform category" do
    if found = Encoders.find("upcase")
      found.category.should eq("transform")
    else
      fail "upcase encoder not found"
    end
  end

  it "compression encoders have compression category" do
    if found = Encoders.find("zlib-encode")
      found.category.should eq("compression")
    else
      fail "zlib-encode encoder not found"
    end
  end
end

describe "EncoderSpec#to_json" do
  it "serializes to valid JSON" do
    if found = Encoders.find("base64")
      json_str = JSON.build { |json| found.to_json(json) }
      parsed = JSON.parse(json_str)
      parsed["name"].as_s.should eq("base64")
      parsed["description"].as_s.should eq("Base64 encode")
      parsed["category"].as_s.should eq("encoding")
      parsed["aliases"].as_a.map(&.as_s).should contain("base64-encode")
      parsed["flags"].as_a.map(&.as_s).should contain("encode")
    else
      fail "base64 encoder not found"
    end
  end
end

describe "Encoders.search" do
  it "finds encoders by name" do
    results = Encoders.search("base64")
    results.size.should be > 0
    results.any? { |enc| enc.primary == "base64" }.should be_true
  end

  it "finds encoders by description keyword" do
    results = Encoders.search("hex digest")
    results.size.should be > 0
  end

  it "finds encoders by category" do
    results = Encoders.search("hash")
    results.size.should be > 0
    results.all? { |enc| enc.category == "hash" || enc.description.downcase.includes?("hash") || enc.primary.includes?("hash") }.should be_true
  end

  it "returns empty for non-matching keyword" do
    results = Encoders.search("zzz_nonexistent_zzz")
    results.size.should eq(0)
  end

  it "is case-insensitive" do
    results1 = Encoders.search("BASE64")
    results2 = Encoders.search("base64")
    results1.size.should eq(results2.size)
  end
end

describe "Encoders.categories" do
  it "returns unique categories" do
    cats = Encoders.categories
    cats.should contain("encoding")
    cats.should contain("hash")
    cats.should contain("cipher")
    cats.should contain("transform")
    cats.should contain("compression")
    cats.size.should eq(cats.uniq.size)
  end
end

describe "Encoders.to_json_array" do
  it "returns valid JSON array of all encoders" do
    json_str = Encoders.to_json_array
    parsed = JSON.parse(json_str)
    parsed.as_a.size.should eq(Encoders.specs.size)
    first = parsed.as_a.first
    first["name"].as_s.should_not be_empty
    first["category"].as_s.should_not be_empty
  end
end

describe "Encoders.describe_json" do
  it "returns JSON for existing encoder" do
    result = Encoders.describe_json("md5")
    result.should_not be_nil
    if json_str = result
      parsed = JSON.parse(json_str)
      parsed["name"].as_s.should eq("md5")
      parsed["category"].as_s.should eq("hash")
    end
  end

  it "returns nil for non-existing encoder" do
    result = Encoders.describe_json("nonexistent")
    result.should be_nil
  end
end

describe "Encoders.categories_json" do
  it "returns valid JSON grouped by category" do
    json_str = Encoders.categories_json
    parsed = JSON.parse(json_str)
    parsed.as_h.has_key?("encoding").should be_true
    parsed.as_h.has_key?("hash").should be_true
    parsed["encoding"].as_a.size.should be > 0
  end
end

describe "Encoders.encode_chain_steps" do
  it "returns step-by-step results" do
    steps = Encoders.encode_chain_steps("hello", ["hex", "base64"])
    steps.size.should eq(2)
    steps[0][:encoder].should eq("base64")
    steps[0][:output].should eq("aGVsbG8=")
    steps[1][:encoder].should eq("hex")
  end

  it "returns empty for no encoders" do
    steps = Encoders.encode_chain_steps("hello", [] of String)
    steps.size.should eq(0)
  end

  it "returns empty for empty string" do
    steps = Encoders.encode_chain_steps("", ["base64"])
    steps.size.should eq(0)
  end
end
