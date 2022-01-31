class Vegawallet < Formula
  desc "Command-line tool to manage your Vega Protocol wallet"
  homepage "https://docs.vega.xyz/docs/tools/vega-wallet/cli-wallet/latest/create-wallet"
  url "https://github.com/vegaprotocol/vegawallet/archive/refs/tags/v0.11.0.tar.gz"
  sha256 "c928373d6a84575107d235525c2f7f98bf2e6cb84f75e7a51de66a02189a35ff"
  license "MIT"
  head "https://github.com/vegaprotocol/vegawallet.git", branch: "develop"

  bottle do
    rebuild 1
    root_url "https://github.com/vegaprotocol/homebrew-vega/releases/download/vegawallet-0.11.0_1"
    sha256 cellar: :any_skip_relocation, big_sur:      "75de666ca55e788d32699373ec2569183a231a4a9a32d478b12a5197ebe3891d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "777e31ba910d0eb621088001bbb6dfb3fb81681eabb95fb26170cdbf03220b26"
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
