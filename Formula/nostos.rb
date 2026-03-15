class Nostos < Formula
  desc "Functional programming language with lightweight processes and non-blocking I/O"
  homepage "https://github.com/pegesund/nostos"
  version "0.2.18"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pegesund/nostos/releases/download/v0.2.18/nostos-v0.2.18-aarch64-apple-darwin.tar.gz"
      sha256 "4486ef624be2a99cd82fd943e17666dd0cc499dfc0c39bf4ce191699c775603c"
    else
      url "https://github.com/pegesund/nostos/releases/download/v0.2.18/nostos-v0.2.18-x86_64-apple-darwin.tar.gz"
      sha256 "24aea7e04595329189f993a4a2a9f49efd330cfecd6e886698728b92f1f641b1"
    end
  end

  on_linux do
    url "https://github.com/pegesund/nostos/releases/download/v0.2.18/nostos-v0.2.18-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "92f6e1b13c395773b5cee3f256bc61155e61e03d2b6b63cc83f5441ccb3b8551"
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
