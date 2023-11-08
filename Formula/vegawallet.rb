class Vegawallet < Formula
  desc "Command-line tool to manage your Vega Protocol wallet"
  homepage "https://docs.vega.xyz/mainnet/tools/vega-wallet/cli-wallet"
  url "https://github.com/vegaprotocol/vega.git", tag: "v0.73.3", revision: "f76796a4a8c1f60650f35cf907a7d6ac492d7f97"
  license all_of: ["MIT", "BSL-1.0"]
  head "https://github.com/vegaprotocol/vega.git", branch: "develop"

  depends_on "go@1.20" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/vegawallet"

    generate_completions_from_executable(
      bin/"vegawallet",
      "completion",
      base_name: "vegawallet",
      shells:    [:bash, :zsh, :fish],
    )
  end

  test do
    require "json"
    info = JSON.parse(shell_output("#{bin}/vegawallet software version --output json"))
    assert_equal("v#{version}", info["version"])
  end
end
