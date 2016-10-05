defmodule Mollie.Mixfile do
  use Mix.Project

  def project do
    [app: :mollie,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:hackney, :poison,
    :logger]]
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
      {:hackney, "~> 1.6"},
      {:poison, "~> 2.2.0"},
      {:mix_test_watch, "~> 0.2", only: :dev},
      {:exvcr, "~> 0.7", only: :test},
    ]
  end
end
