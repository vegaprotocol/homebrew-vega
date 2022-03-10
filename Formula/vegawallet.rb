class Vegawallet < Formula
  desc "Command-line tool to manage your Vega Protocol wallet"
  homepage "https://docs.vega.xyz/docs/tools/vega-wallet/cli-wallet"
  url "https://github.com/vegaprotocol/vegawallet/archive/refs/tags/v0.13.1.tar.gz"
  sha256 "e6d95dfdfdbd3b145c3fbda0cc71dcb1beb70281d9f985d04682d92374e48f88"
  license "MIT"
  head "https://github.com/vegaprotocol/vegawallet.git", branch: "develop"

  bottle do
    root_url "https://github.com/vegaprotocol/homebrew-vega/releases/download/vegawallet-0.13.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "9316af5dbbdfdef5462c28019ec32bfdc430021c22075a9bc68a8b82c5d4369c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4f7454722f9bd77e9b330d63df859c37b9d2c9ad6b5524be16034751a60274f8"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    require "json"
    info = JSON.parse(shell_output("#{bin}/vegawallet version --output json"))
    assert_equal("v#{version}", info["version"])
  end
end
