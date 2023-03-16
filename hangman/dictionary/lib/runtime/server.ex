defmodule Dictionary.Runtime.Server do

  @type t :: pid()

  @proc __MODULE__

  use Agent

  alias Dictionary.Impl.WordList

  def start_link(_), do: Agent.start_link(&WordList.word_list/0, name: @proc)

  def random_word() do
    # if :rand.uniform < 0.33 do
    #   Agent.get(@proc, fn _ -> exit(:boom) end)
    # end
    Agent.get(@proc, &WordList.random_word/1)
  end
end
