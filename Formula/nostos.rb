class Nostos < Formula
  desc "Functional programming language with lightweight processes and non-blocking I/O"
  homepage "https://github.com/pegesund/nostos"
  version "0.2.19"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pegesund/nostos/releases/download/v0.2.19/nostos-v0.2.19-aarch64-apple-darwin.tar.gz"
      sha256 "91917a1facef6cc1f99064ffd08a2af8122521c153e534936613b93348b0d452"
    else
      url "https://github.com/pegesund/nostos/releases/download/v0.2.19/nostos-v0.2.19-x86_64-apple-darwin.tar.gz"
      sha256 "bf66476c65266f0c287f8e11bee789c0422276d269ddde06c4b4fcce0d8287bb"
    end
  end

  on_linux do
    url "https://github.com/pegesund/nostos/releases/download/v0.2.19/nostos-v0.2.19-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "b0e8770aafe577431a04fece9ca688f1b408e04dcd27c5156baeb1307d84de4c"
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
