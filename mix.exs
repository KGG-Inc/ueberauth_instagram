defmodule Ueberauth.Instagram.Mixfile do
  use Mix.Project

  @source_url "https://github.com/ueberauth/ueberauth_instagram"
  @version "0.9.0"

  def project do
    [
      app: :ueberauth_instagram,
      version: @version,
      name: "Überauth Instagram",
      elixir: "~> 1.3",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    [
      applications: [:logger, :oauth2, :ueberauth]
    ]
  end

  defp deps do
    [
      {:ueberauth, "~> 0.7"},
      {:oauth2, "~> 1.0 or ~> 2.0"},
      {:credo, "~> 0.8.10", only: [:dev, :test]},
      {:ex_doc, ">= 0.24.2", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      extras: [
        "CHANGELOG.md",
        "CONTRIBUTING.md",
        {:LICENSE, [title: "License"]},
        "README.md"
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}",
      homepage_url: @source_url,
      formatters: ["html"]
    ]
  end

  defp package do
    [
      description: "An Überauth strategy for Instagram authentication.",
      files: ["lib", "mix.exs", "README.md", "CHANGELOG.md", "CONTRIBUTING.md", "LICENSE"],
      maintainers: ["Sean Callan"],
      licenses: ["MIT"],
      links: %{
        Changelog: "https://hexdocs.pm/ueberauth_instagram/changelog.html",
        GitHub: @source_url
      }
    ]
  end
end
