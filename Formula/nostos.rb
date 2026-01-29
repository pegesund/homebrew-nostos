class Nostos < Formula
  desc "Functional programming language with lightweight processes and non-blocking I/O"
  homepage "https://github.com/pegesund/nostos"
  version "0.2.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pegesund/nostos/releases/download/v0.2.3/nostos-v0.2.3-aarch64-apple-darwin.tar.gz"
      sha256 "851257a9741d8dc2b291e2b0ae90a9e0c08e836538e27a67059ddee227e75b14"
    else
      url "https://github.com/pegesund/nostos/releases/download/v0.2.3/nostos-v0.2.3-x86_64-apple-darwin.tar.gz"
      sha256 "34f3d14132b36f539d4e803b1c396ec888e1e7c78bed7fb80e6261f5cd2daee6"
    end
  end

  on_linux do
    url "https://github.com/pegesund/nostos/releases/download/v0.2.3/nostos-v0.2.3-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "ef1cfa051a2944a5078b2247b0f13d46fe15886ac7d7b645209e60f5e1756ae6"
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
