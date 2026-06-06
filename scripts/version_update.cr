require "yaml"

# Bumps the version string in every file that embeds it, keeping them in
# sync. Run via `just version-update` (or `crystal run
# scripts/version_update.cr`) and enter the new version when prompted.

# Version file locations
SHARD_FILE     = "shard.yml"
EOYC_FILE      = "src/eoyc.cr"
SNAPCRAFT_FILE = "snap/snapcraft.yaml"
PKGBUILD_FILE  = "aur/PKGBUILD"

# Extract version from shard.yml
def get_shard_version : String?
  shard = YAML.parse(File.read(SHARD_FILE))
  shard["version"].as_s
rescue
  nil
end

# Extract VERSION from src/eoyc.cr
def get_eoyc_version : String?
  content = File.read(EOYC_FILE)
  match = content.match(/VERSION\s*=\s*"([^"]+)"/)
  match ? match[1] : nil
rescue
  nil
end

# Extract version from snap/snapcraft.yaml
def get_snapcraft_version : String?
  snapcraft = YAML.parse(File.read(SNAPCRAFT_FILE))
  snapcraft["version"].as_s
rescue
  nil
end

# Extract pkgver from aur/PKGBUILD
def get_pkgbuild_version : String?
  content = File.read(PKGBUILD_FILE)
  match = content.match(/^pkgver=([\d.]+)/m)
  match ? match[1] : nil
rescue
  nil
end

# Update shard.yml version
def update_shard_version(new_version : String) : Bool
  content = File.read(SHARD_FILE)
  updated = content.gsub(/^(version:\s*)[\d.]+/m, "\\1#{new_version}")
  File.write(SHARD_FILE, updated)
  true
rescue ex
  puts "  Error updating #{SHARD_FILE}: #{ex.message}"
  false
end

# Update src/eoyc.cr VERSION
def update_eoyc_version(new_version : String) : Bool
  content = File.read(EOYC_FILE)
  updated = content.gsub(/VERSION\s*=\s*"[^"]+"/, "VERSION = \"#{new_version}\"")
  File.write(EOYC_FILE, updated)
  true
rescue ex
  puts "  Error updating #{EOYC_FILE}: #{ex.message}"
  false
end

# Update snap/snapcraft.yaml version
def update_snapcraft_version(new_version : String) : Bool
  content = File.read(SNAPCRAFT_FILE)
  updated = content.gsub(/^(version:\s*)['"]?[\d.]+['"]?/m, "\\1#{new_version}")
  File.write(SNAPCRAFT_FILE, updated)
  true
rescue ex
  puts "  Error updating #{SNAPCRAFT_FILE}: #{ex.message}"
  false
end

# Update aur/PKGBUILD pkgver (and reset pkgrel to 1)
def update_pkgbuild_version(new_version : String) : Bool
  content = File.read(PKGBUILD_FILE)
  updated = content.gsub(/^pkgver=[\d.]+/m, "pkgver=#{new_version}")
  updated = updated.gsub(/^pkgrel=\d+/m, "pkgrel=1")
  File.write(PKGBUILD_FILE, updated)
  true
rescue ex
  puts "  Error updating #{PKGBUILD_FILE}: #{ex.message}"
  false
end

# Validate version format (semver-like: X.Y.Z)
def valid_version?(version : String) : Bool
  !!(version =~ /^\d+\.\d+\.\d+$/)
end

# Main logic
puts "=" * 50
puts "Eoyc Version Update Tool"
puts "=" * 50
puts

shard_v = get_shard_version
eoyc_v = get_eoyc_version
snapcraft_v = get_snapcraft_version
pkgbuild_v = get_pkgbuild_version

puts "Current versions:"
puts "  #{SHARD_FILE.ljust(25)} #{shard_v || "Not found"}"
puts "  #{EOYC_FILE.ljust(25)} #{eoyc_v || "Not found"}"
puts "  #{SNAPCRAFT_FILE.ljust(25)} #{snapcraft_v || "Not found"}"
puts "  #{PKGBUILD_FILE.ljust(25)} #{pkgbuild_v || "Not found"}"
puts

versions = [shard_v, eoyc_v, snapcraft_v, pkgbuild_v].compact
unique_versions = versions.uniq

if unique_versions.size > 1
  puts "⚠️  Warning: Versions do not match!"
  puts "   Unique versions found: #{unique_versions.join(", ")}"
  puts
end

current_version = shard_v || eoyc_v || snapcraft_v || "unknown"
puts "Current version: #{current_version}"
puts

print "Enter new version (or press Enter to cancel): "
input = gets
new_version = input.try(&.strip) || ""

if new_version.empty?
  puts "Cancelled."
  exit 0
end

unless valid_version?(new_version)
  puts "❌ Invalid version format. Please use semantic versioning (e.g., 1.2.3)"
  exit 1
end

if new_version == current_version
  puts "⚠️  New version is the same as current version. No changes made."
  exit 0
end

puts
puts "Updating to version #{new_version}..."
puts

success_count = 0
total_count = 0

if shard_v
  total_count += 1
  print "  Updating #{SHARD_FILE}... "
  if update_shard_version(new_version)
    puts "✓"
    success_count += 1
  else
    puts "✗"
  end
end

if eoyc_v
  total_count += 1
  print "  Updating #{EOYC_FILE}... "
  if update_eoyc_version(new_version)
    puts "✓"
    success_count += 1
  else
    puts "✗"
  end
end

if snapcraft_v
  total_count += 1
  print "  Updating #{SNAPCRAFT_FILE}... "
  if update_snapcraft_version(new_version)
    puts "✓"
    success_count += 1
  else
    puts "✗"
  end
end

if pkgbuild_v
  total_count += 1
  print "  Updating #{PKGBUILD_FILE}... "
  if update_pkgbuild_version(new_version)
    puts "✓"
    success_count += 1
  else
    puts "✗"
  end
end

puts
if success_count == total_count
  puts "✅ All #{success_count} files updated successfully to version #{new_version}"
else
  puts "⚠️  Updated #{success_count}/#{total_count} files"
  exit 1
end
