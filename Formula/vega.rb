class Vega < Formula
  desc "Command-line tool that manages your Vega Protocol node"
  homepage "https://docs.vega.xyz/mainnet/node-operators"
  url "https://github.com/vegaprotocol/vega.git", tag: "v0.71.4", revision: "61d1f77ee360bf1679d5eb0e0efdb1cce977c9db"
  license all_of: ["MIT", "BSL-1.0"]
  head "https://github.com/vegaprotocol/vega.git", branch: "develop"

  depends_on "go@1.19" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/vega"
  end

  test do
    require "json"
    info = JSON.parse(shell_output("#{bin}/vega version --output json"))
    assert_equal("v#{version}", info["version"])
  end
end
