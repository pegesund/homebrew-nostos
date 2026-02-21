class Nostos < Formula
  desc "Functional programming language with lightweight processes and non-blocking I/O"
  homepage "https://github.com/pegesund/nostos"
  version "0.2.17"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pegesund/nostos/releases/download/v0.2.17/nostos-v0.2.17-aarch64-apple-darwin.tar.gz"
      sha256 "f25babb7ce65577fd52f8840eae5d75203c92a9f38f48d6df142c2e2de931dc2"
    else
      url "https://github.com/pegesund/nostos/releases/download/v0.2.17/nostos-v0.2.17-x86_64-apple-darwin.tar.gz"
      sha256 "ab1139bfeef561318b5d83273643aa1ce388977085f162aae6279fc9965dcf2e"
    end
  end

  on_linux do
    url "https://github.com/pegesund/nostos/releases/download/v0.2.17/nostos-v0.2.17-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "aeda8822906f9bdfba40115e5302f547a15ee0c14e689c4662369d2161356a06"
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
