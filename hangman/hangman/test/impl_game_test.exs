defmodule Hangman.Impl.Game.Test do
  use ExUnit.Case
  alias Hangman.Impl.Game

  test "new game returns structure" do
    game = Game.new_game

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "New game returns correct word" do
    game = Game.new_game "wombat"

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
    assert game.letters == ["w", "o", "m", "b", "a", "t",]
  end

  test "Every word in the word is lowercase" do
    game = Game.new_game

    word = game.letters

    word
    |> Enum.all?(&(&1 =~ ~r(^[^a-z]*$)))

    assert Enum.all?(word, &(&1 =~ ~r/[a-z]/))
  end

  test "state doesn't change if a game is won or lost" do
    for state <- [:won, :lost] do
      game = Game.new_game "wombat"
      game = Map.put(game, :game_state, state)
      { new_game, _tally } = Game.make_move(game, "x")
      assert new_game == game
    end
  end

  test "a duplicated letter is reported" do
    game = Game.new_game "scooby"
    { game, _tally } = Game.make_move(game, "s")
    assert game.game_state != :already_used
    { game, _tally } = Game.make_move(game, "y")
    assert game.game_state != :already_used
    { game, _tally } = Game.make_move(game, "s")
    assert game.game_state == :already_used
  end

  test "we record letters used" do
    game = Game.new_game "dooby"
    { game, _tally } = Game.make_move(game, "d")
    { game, _tally } = Game.make_move(game, "o")
    { game, _tally } = Game.make_move(game, "y")

    assert Enum.sort(game.used) == Enum.sort(["d", "o", "y"])
  end

end
