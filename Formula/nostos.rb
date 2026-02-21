class Nostos < Formula
  desc "Functional programming language with lightweight processes and non-blocking I/O"
  homepage "https://github.com/pegesund/nostos"
  version "0.2.17"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pegesund/nostos/releases/download/v0.2.17/nostos-v0.2.17-aarch64-apple-darwin.tar.gz"
      sha256 "156519ffcda85182b712efc593ea91c2c6c044c826566a7999e5c29753fc8609"
    else
      url "https://github.com/pegesund/nostos/releases/download/v0.2.17/nostos-v0.2.17-x86_64-apple-darwin.tar.gz"
      sha256 "bdf98624a79274570f927e134c7b983c83bbf8110d614c7cdad1b7daf497839f"
    end
  end

  on_linux do
    url "https://github.com/pegesund/nostos/releases/download/v0.2.17/nostos-v0.2.17-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "b7384668e2f8a81e4af8e02147a1f0f243daa872b6a8e78d7a0d80b0c01e4606"
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
