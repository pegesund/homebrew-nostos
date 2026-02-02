class Nostos < Formula
  desc "Functional programming language with lightweight processes and non-blocking I/O"
  homepage "https://github.com/pegesund/nostos"
  version "0.2.12"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pegesund/nostos/releases/download/v0.2.12/nostos-v0.2.12-aarch64-apple-darwin.tar.gz"
      sha256 "37a6770847d6645d043fbbc6d72b5400f089f42ff522377a9ab3d2ed55fd8a84"
    else
      url "https://github.com/pegesund/nostos/releases/download/v0.2.12/nostos-v0.2.12-x86_64-apple-darwin.tar.gz"
      sha256 "ebf81b5ff2e9436fafc2b5ff6240ff9995b2d4a70797cea4001cbf1fc34b8fbf"
    end
  end

  on_linux do
    url "https://github.com/pegesund/nostos/releases/download/v0.2.12/nostos-v0.2.12-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "b6183c5f9436b80ff732bddc63904524067d16f91d8e575f0b245a71b7fd4393"
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
