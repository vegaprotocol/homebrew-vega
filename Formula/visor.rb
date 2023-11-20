class Visor < Formula
  desc "Command-line tool that manages Vega Protocol upgrades of nodes"
  homepage "https://docs.vega.xyz/mainnet/node-operators/get-started/setup-validator#configure-visor"
  url "https://github.com/vegaprotocol/vega.git", tag: "v0.73.5", revision: "034a665805ee74d077e9ca274ea5ab157c468814"
  license all_of: ["MIT", "BSL-1.0"]
  head "https://github.com/vegaprotocol/vega.git", branch: "develop"

  bottle do
    root_url "https://github.com/vegaprotocol/homebrew-vega/releases/download/visor-0.73.5"
    sha256 cellar: :any_skip_relocation, monterey:     "0ad73660ed06a749a04252b06ed9fb7de87aa0af8c11ccf012266467b58f3c9f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7fb26c3521709bbc61e3f58eeefd6359a0f574aef78ccbc68f308513bc51bffc"
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
