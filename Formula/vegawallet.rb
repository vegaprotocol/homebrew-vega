class Vegawallet < Formula
  desc "Command-line tool to manage your Vega Protocol wallet"
  homepage "https://docs.vega.xyz/mainnet/tools/vega-wallet/cli-wallet"
  url "https://github.com/vegaprotocol/vega.git", tag: "v0.73.3", revision: "f76796a4a8c1f60650f35cf907a7d6ac492d7f97"
  license all_of: ["MIT", "BSL-1.0"]
  head "https://github.com/vegaprotocol/vega.git", branch: "develop"

  bottle do
    root_url "https://github.com/vegaprotocol/homebrew-vega/releases/download/vegawallet-0.73.3"
    sha256 cellar: :any_skip_relocation, monterey:     "b83568e48bec1aaaec87405fdf8c88c5b2fdd6e8939b2608dda056ee76c9884d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a85c5da90af6259e5e272cf6ba2640c5b174d9b2b5c7bbfdf63b0d7599d57a45"
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
