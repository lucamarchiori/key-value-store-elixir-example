# KVStore

Example application to try GenServer

## Behavior
```sh
| ~/onboarding/k_v_store
└> iex -S mix                                                                                                                                                                     k8s ctx minikube
Erlang/OTP 27 [erts-15.2.2] [source] [64-bit] [smp:32:32] [ds:32:32:10] [async-threads:1] [jit:ns]

Compiling 1 file (.ex)
Generated k_v_store app
Interactive Elixir (1.18.3) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> {:ok, _pid} = KVStore.start_link(%{})
{:ok, #PID<0.157.0>}
iex(2)> KVStore.store({"key1", "value1"})
:ok
iex(3)> KVStore.store({"key2", "value2"})
:ok
iex(4)> KVStore.get("key1")
"value1"
iex(5)> KVStore.get("key3")
:not_found
iex(6)> KVStore.get_all()
%{"key1" => "value1", "key2" => "value2"}
iex(7)> KVStore.delete("key1")
:ok
iex(8)> KVStore.get("key1")
:not_found
iex(9)> KVStore.get_all()
%{"key2" => "value2"}
iex(10)>

```

## Running in Docker
´´´sh
docker compose up
docker exec -it kvstore /app/bin/k_v_store remote  
´´´