## 8b-is tap

Formulae and casks for the 8b.is constellation:

```sh
brew tap 8b-is/tap
brew install 8b-is/tap/deepsiper-enthea    # enthea — the engine entry (pure-stdlib Go)

# Qwave, the WebKit-native browser that proves what it sends:
brew install --cask 8b-is/tap/qwave            # stable: signed, notarised DMG
brew upgrade --cask 8b-is/tap/qwave            # update to the next tagged release
brew install --cask 8b-is/tap/qwave-nightly    # nightly: rolling prerelease DMG
brew upgrade --cask --greedy 8b-is/tap/qwave-nightly  # re-pull the rolling build
```

The Qwave **casks** install the ready DMGs from the GitHub Releases — no
build on your machine. The build-from-source formulae were retired:
xcodebuild's sandboxed package resolution cannot nest inside Homebrew's
build sandbox (`sandbox-exec: sandbox_apply: Operation not permitted`), and
a signed GUI app belongs in a cask anyway. Nightly is unsigned by design;
stable passes Gatekeeper.

### Updating the Qwave cask

1. Pick the release in `8b-is/qwave`.
2. `shasum -a 256` the `Qwave-vX.Y.Z.dmg` asset.
3. Update `version` / `sha256` in `Casks/qwave.rb` (the nightly cask is
   `:no_check` and needs no bump — the release lane re-uploads
   `Qwave-nightly-latest.dmg` on every build).

*the constellation · 0 + 1 · fine touch from within · vaked.dev*
