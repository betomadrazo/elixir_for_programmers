defmodule Dictionary.Runtime.Server do

  @type t :: pid()

  @proc __MODULE__

  alias Dictionary.Impl.WordList

  def start_link, do: Agent.start_link(&WordList.word_list/0, name: @proc)

  def random_word() do
    Agent.get(@proc, &WordList.random_word/1)
  end
end
