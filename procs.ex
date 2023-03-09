defmodule Procs do
  def hello() do
    receive do
      msg ->
        IO.puts "Hello #{inspect msg}"
    end
    hello()
  end

  def hello_hello(count) do
    receive do
      { :quit } ->
        IO.puts "I'm outta here."
      { :crash, reason } ->
        exit(reason)
      { :reset } ->
        IO.puts "Count goes from #{count} to zero."
        hello_hello(0)
      { :add, n } ->
        hello_hello(count + n)
      msg ->
        IO.puts("#{count}: Hello #{inspect msg}")
        hello_hello(count)
    end
  end

  def greeter(what_to_say) do
    receive do
      msg ->
        IO.puts "#{what_to_say}: #{msg}"
    end
    greeter(what_to_say)
  end
end
