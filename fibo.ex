defmodule Fibo do
  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n) do
    { :ok, agent } = Cache.start()
    Enum.each(2..n,
      fn _ ->
        Cache.add_fib_number(agent)
      end
    )
    state = Cache.get_sequence(agent)
    nth = Map.keys(state) |> Enum.sort() |> List.last()
    state[nth]
  end
end


defmodule Cache do
  def start(), do: Agent.start_link(fn -> %{0=> 0, 1=> 1} end)

  def add_fib_number(agent) do
    elts = get_sequence(agent)
    last = Map.keys(elts) |> Enum.sort() |> List.last()
    new_number = elts[last] + elts[last-1]
    Agent.update(agent, fn state -> Map.put(state, last+1, new_number) end)
  end

  def get_sequence(agent), do: Agent.get(agent, fn state -> state end)
end
