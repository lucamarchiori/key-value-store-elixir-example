defmodule KVStore.MixProject do
  use Mix.Project

  def project do
    [
      app: :k_v_store,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {KVStore.Application, []},
      extra_applications: [:logger, :recon]
    ]
  end

  defp deps do
    [
      {:recon, "~> 2.5"}
    ]
  end
end
