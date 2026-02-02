class Nostos < Formula
  desc "Functional programming language with lightweight processes and non-blocking I/O"
  homepage "https://github.com/pegesund/nostos"
  version "0.2.9"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pegesund/nostos/releases/download/v0.2.9/nostos-v0.2.9-aarch64-apple-darwin.tar.gz"
      sha256 "ff39f2f86ab9f5118d12f198526e5fbe008f7c615cf544b22bd0cb977ec2cff4"
    else
      url "https://github.com/pegesund/nostos/releases/download/v0.2.9/nostos-v0.2.9-x86_64-apple-darwin.tar.gz"
      sha256 "8583a128e5dbf66d155b2b00df321f11777a37ac16bb6d756984a7104b65daca"
    end
  end

  on_linux do
    url "https://github.com/pegesund/nostos/releases/download/v0.2.9/nostos-v0.2.9-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "a1039e41f9d3b4fa79af0be7688f1f78b014e9f1c04177cd6c4ef9b76eef7e7d"
  end

  def install
    bin.install "nostos"
    bin.install "nostos-lsp" if File.exist?("nostos-lsp")
    
    # Install stdlib
    (share/"nostos"/"stdlib").install Dir["stdlib/*"] if File.directory?("stdlib")
  end

  def caveats
    <<~EOS
      Nostos has been installed!

      To get started:
        nostos                    # Start the REPL
        nostos myfile.nos         # Run a program

      The stdlib is installed at:
        #{share}/nostos/stdlib

      VS Code extension available at:
        https://github.com/pegesund/nostos/tree/master/editors/vscode
    EOS
  end

  test do
    assert_match "42", shell_output("echo 'main() = 42' | #{bin}/nostos /dev/stdin")
  end
end
