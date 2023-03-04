defmodule SameVal do
  @doc """
  Write a function that takes two parameters.
  It should return true if the parameters are the same, false otherwise.
  You aren't allowed to use any conditional logic,
  so you'll have to rely on pattern matching.
  """

  # Dave's solution: are_same(a, a)
  def are_same(_a = _b, _b = _a) do
    true
  end
  # Dave's solution: are_same(_, _)
  def are_same(_a, _b) do
    false
  end
end
