defmodule FiboTest do
  use ExUnit.Case
  doctest Fibo

  test "greets the world" do
    assert Fibo.hello() == :world
  end
end
