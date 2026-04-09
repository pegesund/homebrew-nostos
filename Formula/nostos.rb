class Nostos < Formula
  desc "Functional programming language with lightweight processes and non-blocking I/O"
  homepage "https://github.com/pegesund/nostos"
  version "0.2.19"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pegesund/nostos/releases/download/v0.2.19/nostos-v0.2.19-aarch64-apple-darwin.tar.gz"
      sha256 "de02e50f7c809ee5ef2d7e7f139d7a0dc739c537c0cd949fd1cc6d9692d5e657"
    else
      url "https://github.com/pegesund/nostos/releases/download/v0.2.19/nostos-v0.2.19-x86_64-apple-darwin.tar.gz"
      sha256 "b8405395755ee11f3194730317ede84adf441747f5075baf60c51160616bdaaf"
    end
  end

  on_linux do
    url "https://github.com/pegesund/nostos/releases/download/v0.2.19/nostos-v0.2.19-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "50aeb47b037cef78e7d4eae3c31d341fb4adab42e84f138656e642d66673fcf3"
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
