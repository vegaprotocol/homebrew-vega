class Visor < Formula
  desc "Command-line tool that manages Vega Protocol upgrades of nodes"
  homepage "https://docs.vega.xyz/mainnet/node-operators/get-started/setup-validator#configure-visor"
  url "https://github.com/vegaprotocol/vega.git", tag: "v0.71.4", revision: "61d1f77ee360bf1679d5eb0e0efdb1cce977c9db"
  license all_of: ["MIT", "BSL-1.0"]
  head "https://github.com/vegaprotocol/vega.git", branch: "develop"

  bottle do
    root_url "https://github.com/vegaprotocol/homebrew-vega/releases/download/visor-0.71.4"
    sha256 cellar: :any_skip_relocation, monterey:     "a3f302a2c0d3aea9506c2f09aa40bba56dcd2fae1eec47e6def77045f9794e64"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "48e87f62c4d473957d2cf2ef85cc764c14f79abf53e72af6597bec250d1d8afb"
  end

  depends_on "go@1.19" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/visor"
  end

  test do
    require "json"
    info = JSON.parse(shell_output("#{bin}/visor version --output json"))
    assert_equal("v#{version}", info["version"])
  end
end
