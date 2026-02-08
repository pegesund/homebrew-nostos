class Nostos < Formula
  desc "Functional programming language with lightweight processes and non-blocking I/O"
  homepage "https://github.com/pegesund/nostos"
  version "0.2.13"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pegesund/nostos/releases/download/v0.2.13/nostos-v0.2.13-aarch64-apple-darwin.tar.gz"
      sha256 "8ebe33fd2141a4e64dd6214e1d42f676fc3255f4b47bca79a4e7ba846d83e7bc"
    else
      url "https://github.com/pegesund/nostos/releases/download/v0.2.13/nostos-v0.2.13-x86_64-apple-darwin.tar.gz"
      sha256 "bcf9451e3568af4e36784187587c4627e167a03578f0fc4ad34aa51bc4f6fb46"
    end
  end

  on_linux do
    url "https://github.com/pegesund/nostos/releases/download/v0.2.13/nostos-v0.2.13-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "fd10963c8e8f927ac2ca77d0ca60c402fd4323da7a8dcfc9e1c7c5162dfca080"
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
