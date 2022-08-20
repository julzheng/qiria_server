defmodule QiriaServer.MixProject do
  use Mix.Project

  def project do
    [
      app: :qiria,
      version: "0.1.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :runtime_tools, :vaultex],
      mod: {QiriaServer.Application, []}
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:absinthe, "~> 1.6"},
      {:absinthe_plug, "~> 1.5"},
      {:argon2_elixir, "~> 2.4"},
      {:corsica, "~> 1.0"},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:ecto_morph, "~> 0.1.25"},
      {:ecto_sql, "~> 3.0"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:jose, "~> 1.11.2"},
      {:kaur, "~> 1.1.0"},
      {:mox, "~> 1.0", only: :test},
      {:myxql, "~> 0.5.0"},
      {:phoenix, "~> 1.5.10"},
      {:phoenix_live_dashboard, "~> 0.4"},
      {:plug_cowboy, "~> 2.0"},
      {:pow, "~> 1.0.24"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:vaultex, "~> 0.8"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get"]
    ]
  end
end
