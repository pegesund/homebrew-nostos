class Nostos < Formula
  desc "Functional programming language with lightweight processes and non-blocking I/O"
  homepage "https://github.com/pegesund/nostos"
  version "0.2.16"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pegesund/nostos/releases/download/v0.2.16/nostos-v0.2.16-aarch64-apple-darwin.tar.gz"
      sha256 "c026f1d7f023be8f0827655feca73f56066b9261569dab2cc0208d19c4bd6f32"
    else
      url "https://github.com/pegesund/nostos/releases/download/v0.2.16/nostos-v0.2.16-x86_64-apple-darwin.tar.gz"
      sha256 "db5aff619ba4156d4ada37e45f342ce686de341bb483177ddd6efb770b645688"
    end
  end

  on_linux do
    url "https://github.com/pegesund/nostos/releases/download/v0.2.16/nostos-v0.2.16-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "ab7f7f2411ff70b6eea278429eee7ffc57df15f0ecdb29549349ec0a2a436d84"
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
