## 8b-is tap

Formulae for the 8b.is constellation. Install an entry:

```sh
brew tap 8b-is/tap
brew install 8b-is/tap/deepsipser-enthea    # enthea — the engine entry (pure-stdlib Go)
brew install 8b-is/tap/qwave               # Qwave browser, stable channel (tagged releases)
# qwave-nightly is HEAD-only — it always builds the latest main:
brew install --HEAD 8b-is/tap/qwave-nightly  # Qwave browser, nightly channel
brew upgrade --fetch-HEAD 8b-is/tap/qwave-nightly  # re-pull latest main
```

The Qwave formulae build from source on your machine (`xcodegen` +
`xcodebuild` + the Rust sovereign core), unsigned — the same thing
`tools/install-nightly.sh` does in the
[qwave repository](https://github.com/8b-is/qwave). For signed, notarised,
Sparkle-updating builds see
[docs/RELEASING.md](https://github.com/8b-is/qwave/blob/main/docs/RELEASING.md)
there. Requirements: macOS 14+, Xcode 16+, network access for SwiftPM
resolution at build time.

### Updating a Qwave formula

1. Pick the release commit/tag in `8b-is/qwave`.
2. `curl -L -o /tmp/qwave.tar.gz https://github.com/8b-is/qwave/archive/<sha-or-tag>.tar.gz`
   then `shasum -a 256 /tmp/qwave.tar.gz`.
3. Update `url` / `sha256` in `qwave.rb` (the nightly formula is head-only
   and needs no bump).

*the constellation · 0 + 1 · fine touch from within · vaked.dev*
