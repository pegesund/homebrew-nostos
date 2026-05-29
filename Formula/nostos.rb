class Nostos < Formula
  desc "Functional programming language with lightweight processes and non-blocking I/O"
  homepage "https://github.com/pegesund/nostos"
  version "0.2.21"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pegesund/nostos/releases/download/v0.2.21/nostos-v0.2.21-aarch64-apple-darwin.tar.gz"
      sha256 "20c13f40123c7577cef80106056a7be5519138dd8c9ba47a411de3702af41e2c"
    else
      url "https://github.com/pegesund/nostos/releases/download/v0.2.21/nostos-v0.2.21-x86_64-apple-darwin.tar.gz"
      sha256 "27f3c80792ab42c4851459ed8d839276aa5bf3461311285f522bf7b4d8504664"
    end
  end

  on_linux do
    url "https://github.com/pegesund/nostos/releases/download/v0.2.21/nostos-v0.2.21-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "70d2b382658b1a1ae2e8194b440e58c22314b570c4b50b89e9345106cb26a518"
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
