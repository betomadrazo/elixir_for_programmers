defmodule Hangman.Runtime.Watchdog do

  def start(expiry_time) do
    spawn_link(fn -> watcher(expiry_time) end)
  end

  def im_alive(watcher) do
    send(watcher, :im_alive)
  end

  defp watcher(expiry_time) do
    receive do
      :im_alive ->
        watcher(expiry_time)

    after expiry_time ->
      IO.puts "I'm dead"
      Process.exit(self(), { :shutdown, :watchdog_triggered })
    end
  end
end
