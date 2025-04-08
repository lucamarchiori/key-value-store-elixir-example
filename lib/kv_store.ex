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

# | ~/onboarding/k_v_store
# └> iex -S mix                                                                                                                                                                     k8s ctx minikube
# Erlang/OTP 27 [erts-15.2.2] [source] [64-bit] [smp:32:32] [ds:32:32:10] [async-threads:1] [jit:ns]

# Compiling 1 file (.ex)
# Generated k_v_store app
# Interactive Elixir (1.18.3) - press Ctrl+C to exit (type h() ENTER for help)
# iex(1)> {:ok, _pid} = KVStore.start_link(%{})
# {:ok, #PID<0.157.0>}
# iex(2)> KVStore.store({"key1", "value1"})
# :ok
# iex(3)> KVStore.store({"key2", "value2"})
# :ok
# iex(4)> KVStore.get("key1")
# "value1"
# iex(5)> KVStore.get("key3")
# :not_found
# iex(6)> KVStore.get_all()
# %{"key1" => "value1", "key2" => "value2"}
# iex(7)> KVStore.delete("key1")
# :ok
# iex(8)> KVStore.get("key1")
# :not_found
# iex(9)> KVStore.get_all()
# %{"key2" => "value2"}
# iex(10)>
