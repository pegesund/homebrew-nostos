class Nostos < Formula
  desc "Functional programming language with lightweight processes and non-blocking I/O"
  homepage "https://github.com/pegesund/nostos"
  version "0.2.15"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pegesund/nostos/releases/download/v0.2.15/nostos-v0.2.15-aarch64-apple-darwin.tar.gz"
      sha256 "0e851ab2d7a9b19e178d42ee9c3105343609fd8a9a2267d146cd2821255c5752"
    else
      url "https://github.com/pegesund/nostos/releases/download/v0.2.15/nostos-v0.2.15-x86_64-apple-darwin.tar.gz"
      sha256 "5a2125dc9419203effefc1e992015917259ffa04a4343e04e153443b89e88afb"
    end
  end

  on_linux do
    url "https://github.com/pegesund/nostos/releases/download/v0.2.15/nostos-v0.2.15-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "b4d6054bbf305edf7af527f0c2be849480a742e8ed073d3f1dc4236068c5796b"
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
