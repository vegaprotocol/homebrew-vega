class Vegawallet < Formula
  desc "Command-line tool to manage your Vega Protocol wallet"
  homepage "https://docs.vega.xyz/docs/tools/vega-wallet/cli-wallet"
  url "https://github.com/vegaprotocol/vegawallet/archive/refs/tags/v0.13.0.tar.gz"
  sha256 "5dfdd154aaa72a5d28144dbaf1ab407070830bc539ce9ac3cae20f15d98c352f"
  license "MIT"
  head "https://github.com/vegaprotocol/vegawallet.git", branch: "develop"

  bottle do
    root_url "https://github.com/vegaprotocol/homebrew-vega/releases/download/vegawallet-0.13.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "136ddce6c5d03d108b1290c87f7c40ead82e3b3c6a0adc07414049072856479b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "375f2a28bb7da319e7fce353e5aac047c687cb871070ba027a845fd41ffef29f"
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
