class Nostos < Formula
  desc "Functional programming language with lightweight processes and non-blocking I/O"
  homepage "https://github.com/pegesund/nostos"
  version "0.2.21"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pegesund/nostos/releases/download/v0.2.21/nostos-v0.2.21-aarch64-apple-darwin.tar.gz"
      sha256 "dea25c330d67bd82f37e8bf4234402f680a77007fe4286dc59326b1cab74e2c8"
    else
      url "https://github.com/pegesund/nostos/releases/download/v0.2.21/nostos-v0.2.21-x86_64-apple-darwin.tar.gz"
      sha256 "005c3f33b91dd0678bd9fea99369bc04e3fd4d53e2fe70e8462050fd74cf0096"
    end
  end

  on_linux do
    url "https://github.com/pegesund/nostos/releases/download/v0.2.21/nostos-v0.2.21-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "bba15d4e2af4476b575b85063a237f3abd178ff27ac26220cf0e9d467db2eda0"
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
