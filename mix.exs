defmodule SilviAsAService.Mixfile do
  use Mix.Project

  def project do
    [app: :silvi_as_a_service,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :maru, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:mix_test_watch, "~> 0.2", only: :dev},
      {:floki, "~> 0.8"},
      {:maru, "~> 0.9"},
      {:httpoison, "~> 0.8.0"}
    ]
  end
end
