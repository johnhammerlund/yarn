yarn
====

Swift steganography tool to better-conceal secrets within Mach-O data layouts.

**Warning:** Sensitive secrets should _never_ be stored in an executable. This tool should be used to increase the difficulty of exposing interesting information that may speed up proceeding attacks, i.e. exposing base URL's or client ID's via `strings`.

### Build and Run

This tool uses Swift Package manager. You can test/run the executable directly or export it:
```
# Usage: yarn /path/to/keys.plist
# Output: A generated Swift class

# Run
$ swift run yarn /path/to/keys.plist

# Build and run
$ swift build -c release
$ ./.build/release/yarn /path/to/keys.plist

# Test
$ swift test
```