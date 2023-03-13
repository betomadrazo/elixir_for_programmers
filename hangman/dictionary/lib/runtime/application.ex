defmodule Dictionary.Runtime.Application do

  use Application # this is a behavior,
  # includes a bunch of defaults into this module

  def start(_type, _args) do
    Dictionary.Runtime.Server.start_link()
  end
end
