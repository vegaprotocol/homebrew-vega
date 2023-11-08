class Vega < Formula
  desc "Command-line tool that manages your Vega Protocol node"
  homepage "https://docs.vega.xyz/mainnet/node-operators"
  url "https://github.com/vegaprotocol/vega.git", tag: "v0.73.3", revision: "f76796a4a8c1f60650f35cf907a7d6ac492d7f97"
  license all_of: ["MIT", "BSL-1.0"]
  head "https://github.com/vegaprotocol/vega.git", branch: "develop"

  bottle do
    root_url "https://github.com/vegaprotocol/homebrew-vega/releases/download/vega-0.73.3"
    sha256 cellar: :any_skip_relocation, monterey:     "cd074b7af23194ccc7111b40a4c68fbc2b079b9adc5483eeeb17112f9b35079e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5571127a320cfb7da07755c327f0862a92ed858bb554e87e016b7c62b89cb205"
  end

  depends_on "go@1.20" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/vega"
  end

  test do
    require "json"
    info = JSON.parse(shell_output("#{bin}/vega version --output json"))
    assert_equal("v#{version}", info["version"])
  end
end
