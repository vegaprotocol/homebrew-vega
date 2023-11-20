class Vega < Formula
  desc "Command-line tool that manages your Vega Protocol node"
  homepage "https://docs.vega.xyz/mainnet/node-operators"
  url "https://github.com/vegaprotocol/vega.git", tag: "v0.73.5", revision: "034a665805ee74d077e9ca274ea5ab157c468814"
  license all_of: ["MIT", "BSL-1.0"]
  head "https://github.com/vegaprotocol/vega.git", branch: "develop"

  bottle do
    root_url "https://github.com/vegaprotocol/homebrew-vega/releases/download/vega-0.73.5"
    sha256 cellar: :any_skip_relocation, monterey:     "8ce056a3155686ab004a35f8a466527a7f45dcb7f5d5f1a5cb1963a9edfdaeb2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "42a40a35faa039c57c7680b58e2009332678493c268ebedb5be60ee33db2271a"
  end

  depends_on "go@1.20" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/vega"
  end

  test do
    require "json"
    info = JSON.parse(shell_output("#{bin}/vega version --output json"))
    assert_equal("v#{version}", info["version"])
  end
end
