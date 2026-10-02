class QwaveNightly < Formula
  desc "WebKit-native browser that proves what it sends — nightly channel"
  homepage "https://github.com/8b-is/qwave"
  license "MIT"
  head "https://github.com/8b-is/qwave.git", branch: "main"

  depends_on xcode: ["16.0", :build]
  depends_on "rust" => :build
  depends_on "xcodegen" => :build

  def install
    system "xcodegen", "generate", "--spec", "project.yml"
    arch = Hardware::CPU.arm? ? "arm64" : "x86_64"
    # Mirrors tools/install-nightly.sh: host-arch slice only (no cross
    # toolchain needed), the nightly channel ON — every experimental WebKit
    # feature enabled and the mem|16-10 sovereign library linked.
    system "xcodebuild",
      "-project", "Qwave.xcodeproj",
      "-scheme", "QwaveNightly",
      "-configuration", "Release",
      "-destination", "platform=macOS,arch=#{arch}",
      "-derivedDataPath", "build/DerivedData",
      "ONLY_ACTIVE_ARCH=YES",
      "QWAVE_CHANNEL=nightly",
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

      Upgrade to the latest main with the usual Homebrew command:
        brew upgrade qwave-nightly
    EOS
  end
end
