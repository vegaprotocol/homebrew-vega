class Vegawallet < Formula
  desc "Command-line tool to manage your Vega Protocol wallet"
  homepage "https://docs.vega.xyz/docs/tools/vega-wallet/cli-wallet/latest/create-wallet"
  url "https://github.com/vegaprotocol/vegawallet/archive/refs/tags/v0.11.0.tar.gz"
  sha256 "c928373d6a84575107d235525c2f7f98bf2e6cb84f75e7a51de66a02189a35ff"
  license "MIT"
  head "https://github.com/vegaprotocol/vegawallet.git", branch: "develop"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    system bin/"vegawallet", "version"
  end
end
