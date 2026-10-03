class Qwave < Formula
  desc "WebKit-native browser that proves what it sends — stable channel"
  homepage "https://github.com/8b-is/qwave"
  license "MIT"

  # The v2.0.3 stable release. Moves with each tagged release
  # (docs/RELEASING.md in the main repository).
  url "https://github.com/8b-is/qwave/archive/refs/tags/v2.0.3.tar.gz"
  sha256 "bf1b4272f4bacfe86ab3ac3c8a7b37fb591d113ee69796147526b4771148b6a4"

  depends_on xcode: ["16.0", :build]
  depends_on "rust" => :build
  depends_on "xcodegen" => :build

  def install
    system "xcodegen", "generate", "--spec", "project.yml"
    # Resolve the SPM packages with the SYSTEM scm provider first: Xcode's
    # own sandboxed package resolution (`sandbox-exec`) cannot nest inside
    # Homebrew's build sandbox and dies with "sandbox_apply: Operation not
    # permitted". Resolving ahead of the build leaves nothing for the build
    # step to re-resolve.
    system "xcodebuild", "-resolvePackageDependencies", "-scmProvider", "system",
      "-project", "Qwave.xcodeproj", "-scheme", "Qwave",
      "-derivedDataPath", "build/DerivedData"
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
      "ENABLE_USER_SCRIPT_SANDBOXING=NO",
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
