defmodule Cache do
  @moduledoc """
  The function 'lookup' tries to look the value up in the cache,
  and then calls 'complete_if_not_found'. This takes 2 forms.
  If there was no value in the cache, it calls the function passed in
  by the client to supply it(the value), updating the cache at the same time.
  Else, it simply returns the cached value.
  """
  def run(body) do
    { :ok, pid } = Agent.start_link(fn -> %{ 0 => 0, 1 => 1 } end)
    IO.puts inspect pid
    result = body.(pid)
    # Agent.stop(pid)
    {result, pid}
  end

  def lookup(cache, n, if_not_found) do
    # IO.inspect all_cache(cache)
    Agent.get(cache, fn map -> map[n] end)
    |> complete_if_not_found(cache, n, if_not_found)
  end

  defp complete_if_not_found(nil, cache, n, if_not_found) do
    IO.inspect all_cache(cache)
    IO.puts "> #{n} not found, complete it"
    if_not_found.()
    |> set(cache, n)
  end

  defp complete_if_not_found(value, _cache, _n, _if_not_found) do
    IO.inspect all_cache(_cache)
    IO.puts "#{value}----- found, just pass it along"
    value
  end

  defp set(val, cache, n) do
    IO.puts "setting #{n}: "
    IO.inspect all_cache(cache)
    Agent.get_and_update(cache, fn map ->
      { val, Map.put(map, n, val) }
    end)
  end

  def all_cache(cache) do
    Agent.get(cache, fn map -> map end)
  end
end
