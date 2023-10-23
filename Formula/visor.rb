class Visor < Formula
  desc "Command-line tool that manages Vega Protocol upgrades of nodes"
  homepage "https://docs.vega.xyz/mainnet/node-operators/get-started/setup-validator#configure-visor"
  url "https://github.com/vegaprotocol/vega.git", tag: "v0.72.14", revision: "282fe5a94609406fd638cc1087664bfacb8011bf"
  license all_of: ["MIT", "BSL-1.0"]
  head "https://github.com/vegaprotocol/vega.git", branch: "develop"

  bottle do
    root_url "https://github.com/vegaprotocol/homebrew-vega/releases/download/visor-0.72.14"
    sha256 cellar: :any_skip_relocation, monterey:     "a5affb4af98ebaecbd09c1f28fc434ae6a4a18ec76cdf73e945229eb5b509601"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ebc6e2fc9f499f92303b688f3d003417cc418444756db2506f5e8b2d7e355764"
  end

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
