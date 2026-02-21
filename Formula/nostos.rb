class Nostos < Formula
  desc "Functional programming language with lightweight processes and non-blocking I/O"
  homepage "https://github.com/pegesund/nostos"
  version "0.2.17"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pegesund/nostos/releases/download/v0.2.17/nostos-v0.2.17-aarch64-apple-darwin.tar.gz"
      sha256 "004c30af7a894d01ca73df786484ea99c96dece54e84b98a3f3d67ef613c3c05"
    else
      url "https://github.com/pegesund/nostos/releases/download/v0.2.17/nostos-v0.2.17-x86_64-apple-darwin.tar.gz"
      sha256 "499433299265ef2747324ffbeda995f3525bce20e99b7c43d6ec9d45ecde193a"
    end
  end

  on_linux do
    url "https://github.com/pegesund/nostos/releases/download/v0.2.17/nostos-v0.2.17-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "e0de788388c8fa12f489f864ca3cf2adc68105ad8283e68bc634e0ed5b489326"
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
