class SecretPrompt < Formula
  desc "Themed macOS panel that asks you for a secret on an agent's behalf"
  homepage "https://github.com/theonewiththegun/secret-prompt"
  url "https://github.com/theonewiththegun/secret-prompt/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "c9f1fb753ed07f357cce6f76f3d171f01d621651cc3bb3c3e9b3617927fe0bdd"
  license "MIT"

  depends_on :macos

  def install
    system "make", "install", "PREFIX=#{prefix}", "ARCHS=#{Hardware::CPU.arm? ? "arm64" : "x86_64"}"
  end

  test do
    (testpath/"config").write "theme = catppuccin-latte\naccent = #89B4FA # blue\n"
    output = shell_output("SECRET_PROMPT_CONFIG=#{testpath}/config #{bin}/secret-prompt --dump-theme")
    assert_match "theme = catppuccin-latte", output
    assert_match "accent = #89B4FA", output
    assert_match "usage: with-secret", shell_output("#{bin}/with-secret 2>&1", 2)
  end
end
