defmodule Demo do
  def reverse do
    IO.puts "receiving..."
    receive do
      {from_pid, msg} ->
        IO.inspect from_pid
        result = msg |> String.reverse()
        send from_pid, result
        IO.puts(result)
        reverse()
    end
  end
end
