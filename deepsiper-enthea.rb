class DeepsipserEnthea < Formula
  desc "enthea — the deepsiper-enthea engine entry (pure-stdlib Go)"
  homepage "https://github.com/8b-is/enthea"
  url "https://github.com/8b-is/enthea/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "93934b71e83724a52bed56b58ad2b238cba11c3a63f3255d432b1a49d1fb7e2c"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: "enthea", ldflags: "-s -w")
  end

  test do
    assert_match "enthea 0.1.0", shell_output("#{bin}/enthea version")
  end
end
