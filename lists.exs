defmodule Lists do
  def len([]), do: 0
  def len([_h | t]), do: 1 + len(t)

  def sum([]), do: 0
  def sum([h | t]), do: h + sum(t)

  def square([]), do: []
  def square([h | t]), do: [h * h | square(t)]

  def double([]), do: []
  def double([h | t]), do: [h * 2 | double(t)]

  def map([], _function), do: []
  def map([h | t], function), do: [function.(h) | map(t, function)]

  def sum_pairs([]), do: []
  def sum_pairs([e1, e2 | t]), do: [e1 + e2 | sum_pairs(t)]

  def even_length?([]), do: false
end
