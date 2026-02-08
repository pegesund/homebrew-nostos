class Nostos < Formula
  desc "Functional programming language with lightweight processes and non-blocking I/O"
  homepage "https://github.com/pegesund/nostos"
  version "0.2.14"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pegesund/nostos/releases/download/v0.2.14/nostos-v0.2.14-aarch64-apple-darwin.tar.gz"
      sha256 "adbe1f20ff5d7c066ebb02f3b56ee2eda0010b76558a922b6f2e494b3e5ba714"
    else
      url "https://github.com/pegesund/nostos/releases/download/v0.2.14/nostos-v0.2.14-x86_64-apple-darwin.tar.gz"
      sha256 "54e66be722be4a153d7a6f7af37c55bb88b0760395768f68c74d8ec31e2103e5"
    end
  end

  on_linux do
    url "https://github.com/pegesund/nostos/releases/download/v0.2.14/nostos-v0.2.14-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "91304d33bad35e688f19b2b155de80991a8be8b04d00e0e2413b885ca3aae342"
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
