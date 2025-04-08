defmodule KVStore do
  use GenServer

  def start_link(state \\ %{}) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  ### GenServer Callbacks

  # Get the whole KV store
  def handle_call(:getall, _from, state) do
    {:reply, state, state}
  end

  # Get a specific key-value pair from the store
  def handle_call({:get, key}, _from, state) do
    case Map.get(state, key) do
      nil -> {:reply, :not_found, state}
      value -> {:reply, value, state}
    end
  end

  # Add a key-value pair to the store
  def handle_cast({:store, {key, value}}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  # Remove a key-value pair from the store
  def handle_cast({:delete, key}, state) do
    {:noreply, Map.delete(state, key)}
  end

  # Initialize the GenServer state
  def init(state), do: {:ok, state}

  ### Client API

  def store({key, value}), do: GenServer.cast(__MODULE__, {:store, {key, value}})

  def delete(key), do: GenServer.cast(__MODULE__, {:delete, key})

  def get(key), do: GenServer.call(__MODULE__, {:get, key})

  def get_all, do: GenServer.call(__MODULE__, :getall)
end
