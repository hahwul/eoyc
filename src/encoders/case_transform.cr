require "./core"

# Title Case
Encoders.register(
  EncoderSpec.new(
    "title-case",
    %w[title-case],
    "Title Case transform",
    category: "transform",
    flags: %w[transform text]
  ) do |str|
    str.split(/(\s+)/).map do |word|
      if word =~ /^\s+$/
        word
      else
        word[0].upcase.to_s + (word.size > 1 ? word[1..].downcase : "")
      end
    end.join
  end
)

# camelCase
Encoders.register(
  EncoderSpec.new(
    "camel-case",
    %w[camel-case],
    "camelCase transform",
    category: "transform",
    flags: %w[transform text]
  ) do |str|
    words = str.split(/[\s_\-]+/)
    next "" if words.empty?
    words[0].downcase + words[1..].map do |word|
      word[0].upcase.to_s + (word.size > 1 ? word[1..].downcase : "")
    end.join
  end
)

# snake_case
Encoders.register(
  EncoderSpec.new(
    "snake-case",
    %w[snake-case],
    "snake_case transform",
    category: "transform",
    flags: %w[transform text]
  ) do |str|
    str.gsub(/([a-z])([A-Z])/, "\\1_\\2")
      .gsub(/[\s\-]+/, "_")
      .downcase
  end
)

# kebab-case
Encoders.register(
  EncoderSpec.new(
    "kebab-case",
    %w[kebab-case],
    "kebab-case transform",
    category: "transform",
    flags: %w[transform text]
  ) do |str|
    str.gsub(/([a-z])([A-Z])/, "\\1-\\2")
      .gsub(/[\s_]+/, "-")
      .downcase
  end
)

# PascalCase
Encoders.register(
  EncoderSpec.new(
    "pascal-case",
    %w[pascal-case],
    "PascalCase transform",
    category: "transform",
    flags: %w[transform text]
  ) do |str|
    str.split(/[\s_\-]+/).map do |word|
      word[0].upcase.to_s + (word.size > 1 ? word[1..].downcase : "")
    end.join
  end
)
