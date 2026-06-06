require "yaml"

# Verifies that the version string is identical across every file that
# embeds it. Run via `just version-check` (or `crystal run
# scripts/version_check.cr`) before tagging a release.

# Extract version from shard.yml
def get_shard_version : String?
  shard = YAML.parse(File.read("shard.yml"))
  shard["version"].as_s
rescue
  nil
end

# Extract VERSION from src/eoyc.cr
def get_eoyc_version : String?
  content = File.read("src/eoyc.cr")
  match = content.match(/VERSION\s*=\s*"([^"]+)"/)
  match ? match[1] : nil
rescue
  nil
end

# Extract version from snap/snapcraft.yaml
def get_snapcraft_version : String?
  snapcraft = YAML.parse(File.read("snap/snapcraft.yaml"))
  snapcraft["version"].as_s
rescue
  nil
end

shard_v = get_shard_version
eoyc_v = get_eoyc_version
snapcraft_v = get_snapcraft_version

puts "Shard version:     #{shard_v || "Not found"}"
puts "Eoyc version:      #{eoyc_v || "Not found"}"
puts "Snapcraft version: #{snapcraft_v || "Not found"}"

versions = [shard_v, eoyc_v, snapcraft_v].compact

if versions.empty?
  puts "No versions found!"
  exit 1
end

unique_versions = versions.uniq

if unique_versions.size == 1
  puts "All versions match: #{unique_versions.first}"
else
  puts "Versions do not match!"
  puts "Unique versions found: #{unique_versions.join(", ")}"
  exit 1
end
