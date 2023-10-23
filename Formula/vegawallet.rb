class Vegawallet < Formula
  desc "Command-line tool to manage your Vega Protocol wallet"
  homepage "https://docs.vega.xyz/mainnet/tools/vega-wallet/cli-wallet"
  url "https://github.com/vegaprotocol/vega.git", tag: "v0.71.4", revision: "61d1f77ee360bf1679d5eb0e0efdb1cce977c9db"
  license all_of: ["MIT", "BSL-1.0"]
  head "https://github.com/vegaprotocol/vega.git", branch: "develop"

  bottle do
    root_url "https://github.com/vegaprotocol/homebrew-vega/releases/download/vegawallet-0.71.4"
    sha256 cellar: :any_skip_relocation, monterey:     "f5d0dcc50de9be398347e3af7bd89b2193712cda7062012b24e787f870aab93b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "46706f06a7d6bce166246cf953cc3e07eef95fae01392dbe94583118a51e12b9"
  end

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
