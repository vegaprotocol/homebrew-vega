class Vegawallet < Formula
  desc "Command-line tool to manage your Vega Protocol wallet"
  homepage "https://docs.vega.xyz/mainnet/tools/vega-wallet/cli-wallet"
  url "https://github.com/vegaprotocol/vega.git", tag: "v0.73.5", revision: "034a665805ee74d077e9ca274ea5ab157c468814"
  license all_of: ["MIT", "BSL-1.0"]
  head "https://github.com/vegaprotocol/vega.git", branch: "develop"

  bottle do
    root_url "https://github.com/vegaprotocol/homebrew-vega/releases/download/vegawallet-0.73.5"
    sha256 cellar: :any_skip_relocation, monterey:     "269f6489a08dc34d6c0a1e944d61f2101f183179b727c9d9af3659e4da526ea1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e5c0a7c4a88a29b40e3a9f8d7a979a97dbdcffd6e5703333a39d6e128ed1d2d0"
  end

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
