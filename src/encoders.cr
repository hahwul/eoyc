# Unified encoder aggregation file
#
# This file replaces the previous monolithic implementation with
# modular encoder registration spread across ./encoders/*.cr
# Keeping backward-compatible public API:
#   encode(str, encoders)
#   available_encoders
#   encoder_help_lines
#
# Encoders are registered at require-time. Order of requires below
# establishes help listing order (initial registration order).
# Add new encoder files under ./encoders and add a corresponding
# require line here.
#
# Directory structure:
#   encoders/
#     core.cr       -> framework + registry + utils
#     base64.cr     -> base64 related encoders
#     digests.cr    -> hashing/digest encoders
#     hex.cr        -> hex encode/decode
#     url_form.cr   -> url form encode/decode
#     text.cr       -> text transforms (rot13, case, reverse, redact)
#
# To add a new encoder:
#   1. Create encoders/<name>.cr
#   2. require "./encoders/core"
#   3. Call Encoders.register with an EncoderSpec
#   4. Add a require line here (optional if some other file requires it indirectly)
#
# NOTE: Keep this file lightweight; logic resides in component files.
#
require "./encoders/core"
require "./encoders/base64"
require "./encoders/digests"
require "./encoders/hex"
require "./encoders/url_form"
require "./encoders/text"
require "./encoders/binary"
require "./encoders/octal"
require "./encoders/unicode"
#
# Optionally force a no-op reference to ensure the module is linked
# (useful in some build optimization scenarios)
Encoders.specs
#
# The encode / available_encoders / encoder_help_lines methods are
# defined in encoders/core.cr and intentionally re-exported at the
# top-level by virtue of being defined globally there. Nothing else
# needed here.
#
# End of file
