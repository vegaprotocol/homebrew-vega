class Vegawallet < Formula
  desc "Command-line tool to manage your Vega Protocol wallet"
  homepage "https://docs.vega.xyz/mainnet/tools/vega-wallet/cli-wallet"
  url "https://github.com/vegaprotocol/vega.git", tag: "v0.71.4", revision: "61d1f77ee360bf1679d5eb0e0efdb1cce977c9db"
  license all_of: ["MIT", "BSL-1.0"]
  head "https://github.com/vegaprotocol/vega.git", branch: "develop"

  depends_on "go@1.19" => :build

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
