cask "qwave-nightly" do
  version "latest"
  sha256 :no_check

  url "https://github.com/8b-is/qwave/releases/download/nightly/Qwave-nightly-latest.dmg",
      verified: "github.com/8b-is/qwave/"
  name "Qwave Nightly"
  desc "The WebKit-native browser that proves what it sends — nightly channel"
  homepage "https://github.com/8b-is/qwave/releases/tag/nightly"

  # Rolling prerelease: every experimental WebKit feature ON, mem|16-10
  # linked. Unsigned by design — the stable cask is the signed lane.
  depends_on macos: ">= :sonoma"

  app "Qwave.app"

  zap trash: [
    "~/Library/Application Support/Qwave",
    "~/Library/Caches/is.8b.qwave",
    "~/Library/Preferences/is.8b.qwave.plist",
  ]
end
