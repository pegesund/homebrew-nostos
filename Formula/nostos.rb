class Nostos < Formula
  desc "Functional programming language with lightweight processes and non-blocking I/O"
  homepage "https://github.com/pegesund/nostos"
  version "0.2.10"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pegesund/nostos/releases/download/v0.2.10/nostos-v0.2.10-aarch64-apple-darwin.tar.gz"
      sha256 "2b7e7ee59443f88ba3ad47f07c6cee4c4741fa27fa2f69ec0af8174215783a34"
    else
      url "https://github.com/pegesund/nostos/releases/download/v0.2.10/nostos-v0.2.10-x86_64-apple-darwin.tar.gz"
      sha256 "aa7aa584e2fbe3848b08b344f72e8adefe35eca24bc57a5592eb3b8adddb675b"
    end
  end

  on_linux do
    url "https://github.com/pegesund/nostos/releases/download/v0.2.10/nostos-v0.2.10-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "8a454fcf7f0cbe583bce92977bd16e7f535fe3b5a7b2e61282a3a6d5c7fa1eb1"
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
