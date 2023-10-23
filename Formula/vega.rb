class Vega < Formula
  desc "Command-line tool that manages your Vega Protocol node"
  homepage "https://docs.vega.xyz/mainnet/node-operators"
  url "https://github.com/vegaprotocol/vega.git", tag: "v0.71.4", revision: "61d1f77ee360bf1679d5eb0e0efdb1cce977c9db"
  license all_of: ["MIT", "BSL-1.0"]
  head "https://github.com/vegaprotocol/vega.git", branch: "develop"

  bottle do
    root_url "https://github.com/vegaprotocol/homebrew-vega/releases/download/vega-0.71.4"
    sha256 cellar: :any_skip_relocation, monterey:     "d64740699f3f8d39f3a1e4c5d8a8ba563eb89c5eb7e4842e225c494665e36048"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b78756af148938a5ecb42edc4527a4e25edeba709c614775e739e7f9eb50a3fd"
  end

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
