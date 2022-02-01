class Vegawallet < Formula
  desc "Command-line tool to manage your Vega Protocol wallet"
  homepage "https://docs.vega.xyz/docs/tools/vega-wallet/cli-wallet/latest/create-wallet"
  url "https://github.com/vegaprotocol/vegawallet/archive/refs/tags/v0.11.0.tar.gz"
  sha256 "c928373d6a84575107d235525c2f7f98bf2e6cb84f75e7a51de66a02189a35ff"
  license "MIT"
  head "https://github.com/vegaprotocol/vegawallet.git", branch: "develop"

  bottle do
    root_url "https://github.com/vegaprotocol/homebrew-vega/releases/download/vegawallet-0.11.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "feaeafb4a064da19d98f31f5c7641aa4a48ba0f63c627ca419288b77760d3afe"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "71cb4cf2557749f69d26cecb09affe7aa59d772e783705facef4b88ed8ac3912"
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
