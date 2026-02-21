class Nostos < Formula
  desc "Functional programming language with lightweight processes and non-blocking I/O"
  homepage "https://github.com/pegesund/nostos"
  version "0.2.17"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pegesund/nostos/releases/download/v0.2.17/nostos-v0.2.17-aarch64-apple-darwin.tar.gz"
      sha256 "e74c48e3f7b0978441500daf2b8c294ba969f01b5413734ddb7c935a4249f54e"
    else
      url "https://github.com/pegesund/nostos/releases/download/v0.2.17/nostos-v0.2.17-x86_64-apple-darwin.tar.gz"
      sha256 "82053168da1bc2639d7784a8100607369e087c6fbdfdbdd8350c0f597fd58cc1"
    end
  end

  on_linux do
    url "https://github.com/pegesund/nostos/releases/download/v0.2.17/nostos-v0.2.17-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "67f00ff16d0ba38ed64106e3a9343d0a683e1fa97de5908316abc0c44efeb630"
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
