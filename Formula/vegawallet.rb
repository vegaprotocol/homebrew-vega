class Vegawallet < Formula
  desc "Command-line tool to manage your Vega Protocol wallet"
  homepage "https://docs.vega.xyz/docs/tools/vega-wallet/cli-wallet"
  url "https://github.com/vegaprotocol/vegawallet/archive/refs/tags/v0.14.1.tar.gz"
  sha256 "f1df18114df190aa003d00c95fdbe582c1445d7bf869a24f6339cd130c916a3c"
  license "MIT"
  head "https://github.com/vegaprotocol/vegawallet.git", branch: "develop"

  bottle do
    root_url "https://github.com/vegaprotocol/homebrew-vega/releases/download/vegawallet-0.14.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "34c0b06d1657abf9572c87a10597aca9ff76896f6d887929dec1b7d1f277902e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "866c5419d59f89b37724f170860fffd5d98f19e7388bbed86b2bb08c5684c845"
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
