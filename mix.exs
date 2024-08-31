defmodule Pane.Mixfile do
  use Mix.Project

  @source_url "https://github.com/codedge-llc/pane"
  @version "0.4.1"

  def project do
    [
      app: :pane,
      build_embedded: Mix.env() == :prod,
      deps: deps(),
      dialyzer: dialyzer(),
      docs: docs(),
      elixir: "~> 1.13",
      name: "Pane",
      package: package(),
      start_permanent: Mix.env() == :prod,
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
      {:ex_doc, ">= 0.0.0", only: [:dev], runtime: false}
    ]
  end

  defp docs do
    [
      extras: [
        "CHANGELOG.md",
        "LICENSE.md": [title: "License"]
      ],
      formatters: ["html"],
      main: "Pane",
      source_ref: "v#{@version}",
      source_url: @source_url
    ]
  end

  defp dialyzer do
    [
      plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
    ]
  end

  defp package do
    [
      description: "Paginated printer for IEx.",
      files: ["lib", "mix.exs", "README*", "LICENSE*", "CHANGELOG*"],
      licenses: ["MIT"],
      links: %{
        "Changelog" => "https://hexdocs.pm/pane/changelog.html",
        "GitHub" => "https://github.com/codedge-llc/pane",
        "Sponsor" => "https://github.com/sponsors/codedge-llc"
      },
      maintainers: ["Henry Popp"]
    ]
  end
end
