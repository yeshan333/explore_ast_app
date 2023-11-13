defmodule ExploreAstApp.MixProject do
  use Mix.Project

  def project do
    [
      app: :explore_ast_app,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      default_release: :explore_ast_app,
      releases: [
        explore_ast_app: [
          strip_beams: [keep: ["Docs", "Dbgi"]],
          applications: [runtime_tools: :permanent]
        ]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {ExploreAstApp.Application, []}
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:jason, "~> 1.3"},
      {:distillery, "~> 2.1"},
      {:poison, "~> 5.0"},
      {:excoveralls, "~> 0.14.5", only: :test},
      {:ex_integration_coveralls, "~> 0.4.0"}
    ]
  end
end
