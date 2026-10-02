class Qwave < Formula
  desc "WebKit-native browser that proves what it sends — stable channel"
  homepage "https://github.com/8b-is/qwave"
  license "MIT"

  # The v2.0.0 stable release — the Rust-core era. Moves with each tagged
  # release (docs/RELEASING.md in the main repository).
  url "https://github.com/8b-is/qwave/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "2eaa8f5dedc1584dc15ee623eef9b509ee52d8a5eb37f9185faf433e6b85db74"

  depends_on xcode: ["16.0", :build]
  depends_on "rust" => :build
  depends_on "xcodegen" => :build

  def install
    system "xcodegen", "generate", "--spec", "project.yml"
    arch = Hardware::CPU.arm? ? "arm64" : "x86_64"
    # Host-arch slice only (no cross toolchain needed), stable channel:
    # WebKit's defaults, no mem|16-10 link — Qwave's MIT posture.
    system "xcodebuild",
      "-project", "Qwave.xcodeproj",
      "-scheme", "Qwave",
      "-configuration", "Release",
      "-destination", "platform=macOS,arch=#{arch}",
      "-derivedDataPath", "build/DerivedData",
      "ONLY_ACTIVE_ARCH=YES",
      "CODE_SIGNING_ALLOWED=NO", "CODE_SIGN_IDENTITY=",
      "build"
    prefix.install "build/DerivedData/Build/Products/Release/Qwave.app"
  end

  test do
    assert_predicate prefix/"Qwave.app", :exist?
  end

  def caveats
    <<~EOS
      Qwave.app was installed in #{opt_prefix}.

      Launch it with:
        open #{opt_prefix}/Qwave.app

      or link it into /Applications yourself:
        ln -s #{opt_prefix}/Qwave.app /Applications/Qwave.app

      Upgrade to the next release with the usual Homebrew command:
        brew upgrade qwave
    EOS
  end
end
