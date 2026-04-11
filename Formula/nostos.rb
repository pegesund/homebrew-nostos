class Nostos < Formula
  desc "Functional programming language with lightweight processes and non-blocking I/O"
  homepage "https://github.com/pegesund/nostos"
  version "0.2.20"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pegesund/nostos/releases/download/v0.2.20/nostos-v0.2.20-aarch64-apple-darwin.tar.gz"
      sha256 "d1730e410cce6c8ef19b3f93039e84f61070a6f260da0bb95bf3ffa1fe0f9bac"
    else
      url "https://github.com/pegesund/nostos/releases/download/v0.2.20/nostos-v0.2.20-x86_64-apple-darwin.tar.gz"
      sha256 "363301013815e22df57ad70da1ce1c3acaf9b5d43406343a72ee91f87870bfba"
    end
  end

  on_linux do
    url "https://github.com/pegesund/nostos/releases/download/v0.2.20/nostos-v0.2.20-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "76188b2b2b22460963156c10105207242cd2e7fbee1c8f5085139ec6a0e57ea5"
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
