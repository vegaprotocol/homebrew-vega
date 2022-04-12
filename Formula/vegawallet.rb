class Vegawallet < Formula
  desc "Command-line tool to manage your Vega Protocol wallet"
  homepage "https://docs.vega.xyz/docs/tools/vega-wallet/cli-wallet"
  url "https://github.com/vegaprotocol/vegawallet/archive/refs/tags/v0.14.0.tar.gz"
  sha256 "bc6ae1706600f6bb241f164fd0169b0e8fcd5cfad9525814f9616326c5b66eb3"
  license "MIT"
  head "https://github.com/vegaprotocol/vegawallet.git", branch: "develop"

  bottle do
    root_url "https://github.com/vegaprotocol/homebrew-vega/releases/download/vegawallet-0.14.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "68fcd46302f2806451eb37edf7e4529e9e3fba6195ab1a88b78b2832c408a41d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b0525ac3763a93f062cb4fe7685057cdd1c09ca5b80d9d4c94698d0182815bb0"
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
