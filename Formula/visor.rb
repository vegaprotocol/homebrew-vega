class Visor < Formula
  desc "Command-line tool that manages Vega Protocol upgrades of nodes"
  homepage "https://docs.vega.xyz/mainnet/node-operators/get-started/setup-validator#configure-visor"
  url "https://github.com/vegaprotocol/vega.git", tag: "v0.72.14", revision: "282fe5a94609406fd638cc1087664bfacb8011bf"
  license all_of: ["MIT", "BSL-1.0"]
  head "https://github.com/vegaprotocol/vega.git", branch: "develop"

  depends_on "go@1.20" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/visor"
  end

  test do
    require "json"
    info = JSON.parse(shell_output("#{bin}/visor version --output json"))
    assert_equal("v#{version}", info["version"])
  end
end
