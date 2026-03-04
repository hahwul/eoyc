require "./core"

# Title Case
Encoders.register(
  EncoderSpec.new(
    "title-case",
    %w[title-case],
    "Title Case transform"
  ) { |s|
    s.split(/(\s+)/).map { |word|
      if word =~ /^\s+$/
        word
      else
        word[0].upcase.to_s + (word.size > 1 ? word[1..].downcase : "")
      end
    }.join
  }
)

# camelCase
Encoders.register(
  EncoderSpec.new(
    "camel-case",
    %w[camel-case],
    "camelCase transform"
  ) { |s|
    words = s.split(/[\s_\-]+/)
    next "" if words.empty?
    words[0].downcase + words[1..].map { |w|
      w[0].upcase.to_s + (w.size > 1 ? w[1..].downcase : "")
    }.join
  }
)

# snake_case
Encoders.register(
  EncoderSpec.new(
    "snake-case",
    %w[snake-case],
    "snake_case transform"
  ) { |s|
    # Split on spaces, hyphens, underscores, and camelCase boundaries
    s.gsub(/([a-z])([A-Z])/, "\\1_\\2")
      .gsub(/[\s\-]+/, "_")
      .downcase
  }
)

# kebab-case
Encoders.register(
  EncoderSpec.new(
    "kebab-case",
    %w[kebab-case],
    "kebab-case transform"
  ) { |s|
    s.gsub(/([a-z])([A-Z])/, "\\1-\\2")
      .gsub(/[\s_]+/, "-")
      .downcase
  }
)

# PascalCase
Encoders.register(
  EncoderSpec.new(
    "pascal-case",
    %w[pascal-case],
    "PascalCase transform"
  ) { |s|
    s.split(/[\s_\-]+/).map { |w|
      w[0].upcase.to_s + (w.size > 1 ? w[1..].downcase : "")
    }.join
  }
)
