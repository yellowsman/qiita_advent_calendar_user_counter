defmodule QiitaAdventCalendarUserCounter.MixProject do
  use Mix.Project

  def project do
    [
      app: :qiita_advent_calendar_user_counter,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: [main_module: QiitaAdventCalendarUserCounter.CLI]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:meeseeks, "~> 0.16.1"}
    ]
  end
end
