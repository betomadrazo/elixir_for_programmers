defmodule TextClient.Runtime.RemoteHangman do

  @remote_server :hangman@230595M90182893

  def connect do
    :rpc.call(@remote_server, Hangman, :new_game, [])
  end
end
