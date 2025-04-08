defmodule KVStore.Application do
  use Application

  def start(_type, _args) do
    children = [
      KVStore # Start the KVStore GenServer
    ]

    opts = [strategy: :one_for_one, name: KVStore.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
