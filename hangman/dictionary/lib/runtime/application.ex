defmodule Dictionary.Runtime.Application do

  use Application # this is a behavior,
  # includes a bunch of defaults into this module

  def start(_type, _args) do
    children = [
      { Dictionary.Runtime.Server, [] },
    ]

    options = [
      name: Dictionary.Runtime.Supervisor,
      strategy: :one_for_one,
    ]

    Supervisor.start_link(children, options)
  end
end
