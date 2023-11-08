class Visor < Formula
  desc "Command-line tool that manages Vega Protocol upgrades of nodes"
  homepage "https://docs.vega.xyz/mainnet/node-operators/get-started/setup-validator#configure-visor"
  url "https://github.com/vegaprotocol/vega.git", tag: "v0.73.3", revision: "f76796a4a8c1f60650f35cf907a7d6ac492d7f97"
  license all_of: ["MIT", "BSL-1.0"]
  head "https://github.com/vegaprotocol/vega.git", branch: "develop"

  bottle do
    root_url "https://github.com/vegaprotocol/homebrew-vega/releases/download/visor-0.73.3"
    sha256 cellar: :any_skip_relocation, monterey:     "f25aa3ba4a3e57e762e30657a06d6a329dd5c7b85184d8c15074aa615ff8daa4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "04bad616fb7b93690a75c052047a4fa8ff21e873b8b167288b2ba93a2ba50840"
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
