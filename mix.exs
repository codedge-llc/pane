defmodule Pane.Mixfile do
  use Mix.Project

  @version "0.4.1"

  def project do
    [
      app: :pane,
      build_embedded: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      dialyzer: dialyzer(),
      docs: docs(),
      elixir: "~> 1.5",
      name: "Pane",
      package: package(),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      version: @version
    ]
  end

  def application do
    [extra_applications: [:iex, :logger]]
  end

  defp deps do
    [
      {:credo, "~> 1.0", only: [:dev], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:excoveralls, "~> 0.7", only: [:test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: [:dev], runtime: false}
    ]
  end

  defp description do
    """
    Paginated printer for IEx
    """
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"]
    ]
  end

  defp dialyzer do
    [
      plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Henry Popp"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/codedge-llc/pane"}
    ]
  end
end
