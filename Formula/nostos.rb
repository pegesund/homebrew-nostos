class Nostos < Formula
  desc "Functional programming language with lightweight processes and non-blocking I/O"
  homepage "https://github.com/pegesund/nostos"
  version "0.2.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pegesund/nostos/releases/download/v0.2.5/nostos-v0.2.5-aarch64-apple-darwin.tar.gz"
      sha256 "010af1eee304bb77eb54f4a82825a175db656fc9dcab2a92553e575ad8c8fb28"
    else
      url "https://github.com/pegesund/nostos/releases/download/v0.2.5/nostos-v0.2.5-x86_64-apple-darwin.tar.gz"
      sha256 "42b40b40e8b7c3be1d4f5de58d8ea688fc2bbcef09dc31f1b98fcaa35696ebc6"
    end
  end

  on_linux do
    url "https://github.com/pegesund/nostos/releases/download/v0.2.5/nostos-v0.2.5-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "b52d6d112d99c49fd7c08c9417fb803e3d9a43b3d9f5c8e8f54112ae53c89a2d"
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
