class Vegawallet < Formula
  desc "Command-line tool to manage your Vega Protocol wallet"
  homepage "https://docs.vega.xyz/docs/tools/vega-wallet/cli-wallet"
  url "https://github.com/vegaprotocol/vegawallet/archive/refs/tags/v0.12.0.tar.gz"
  sha256 "0aaaec28be20aa2ed749d896434a5b2cd52d0013d718725e7a66acff74eef577"
  license "MIT"
  head "https://github.com/vegaprotocol/vegawallet.git", branch: "develop"

  bottle do
    root_url "https://github.com/vegaprotocol/homebrew-vega/releases/download/vegawallet-0.12.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "cc55df33d91b8c90d0ca71195788df8e36fc9b079d3ec0a719458f91c572873d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "76d7f7c1e49a8e5dc90e937f89ecbd418eef5cb00d1bbbfb7334a4e0f7eaceed"
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
