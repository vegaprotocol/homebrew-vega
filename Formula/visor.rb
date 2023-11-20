class Visor < Formula
  desc "Command-line tool that manages Vega Protocol upgrades of nodes"
  homepage "https://docs.vega.xyz/mainnet/node-operators/get-started/setup-validator#configure-visor"
  url "https://github.com/vegaprotocol/vega.git", tag: "v0.73.5", revision: "034a665805ee74d077e9ca274ea5ab157c468814"
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
