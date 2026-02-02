class Nostos < Formula
  desc "Functional programming language with lightweight processes and non-blocking I/O"
  homepage "https://github.com/pegesund/nostos"
  version "0.2.11"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pegesund/nostos/releases/download/v0.2.11/nostos-v0.2.11-aarch64-apple-darwin.tar.gz"
      sha256 "38d8349615a4c9b3355f28b362f671df7bfa8ed9f99c13e3fa8892e1e2d4da4a"
    else
      url "https://github.com/pegesund/nostos/releases/download/v0.2.11/nostos-v0.2.11-x86_64-apple-darwin.tar.gz"
      sha256 "ace729e722a54b7b7c9137d5d6b7ff7992ee38ecb883c1b83b29960edd753bee"
    end
  end

  on_linux do
    url "https://github.com/pegesund/nostos/releases/download/v0.2.11/nostos-v0.2.11-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "dd42034bdcb2597924db3587212a0707be7204db3c7937fe740ea55a1d713837"
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
