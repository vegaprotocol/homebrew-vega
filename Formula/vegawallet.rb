class Vegawallet < Formula
  desc "Command-line tool to manage your Vega Protocol wallet"
  homepage "https://docs.vega.xyz/docs/tools/vega-wallet/cli-wallet/latest/create-wallet"
  url "https://github.com/vegaprotocol/vegawallet/archive/refs/tags/v0.11.0.tar.gz"
  sha256 "c928373d6a84575107d235525c2f7f98bf2e6cb84f75e7a51de66a02189a35ff"
  license "MIT"
  revision 1
  head "https://github.com/vegaprotocol/vegawallet.git", branch: "develop"

  bottle do
    root_url "https://github.com/vegaprotocol/homebrew-vega/releases/download/vegawallet-0.11.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "1317731fb5f9fc45095b08f6b789941d97db1359d6cab02df623633291f08b13"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ab91168417b7bdda8fa70a2aacdeb5493a98de4d1c2e790b70f1359105f5c02e"
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
