cask "qwave" do
  version "2.0.3"
  sha256 "278b976254091dfff994e4b847e50ec8e181dfe9b3d08a644bc16dbbe1a6b82b"

  url "https://github.com/8b-is/qwave/releases/download/v#{version}/Qwave-v#{version}.dmg",
      verified: "github.com/8b-is/qwave/"
  name "Qwave"
  desc "The WebKit-native browser that proves what it sends — stable channel"
  homepage "https://github.com/8b-is/qwave"

  # The signed, notarised DMG straight from the GitHub Release — no build on
  # your machine. (The build-from-source formulae were retired: xcodebuild's
  # sandboxed package resolution cannot nest inside Homebrew's build sandbox.)
  depends_on macos: ">= :sonoma"

  app "Qwave.app"

  zap trash: [
    "~/Library/Application Support/Qwave",
    "~/Library/Caches/is.8b.qwave",
    "~/Library/Preferences/is.8b.qwave.plist",
  ]
end
