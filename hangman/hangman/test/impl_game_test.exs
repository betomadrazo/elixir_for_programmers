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
    assert MapSet.equal? game.used, MapSet.new(["d", "o", "y"])
  end

  test "we recognize a letter in the word" do
    game = Game.new_game "wombat"
    { _game, tally } = Game.make_move(game, "m")
    assert tally.game_state == :good_guess

    { _game, tally } = Game.make_move(game, "t")
    assert tally.game_state == :good_guess
  end

  test "we recognize a letter NOT in the word" do
    game = Game.new_game "wombat"
    { _game, tally } = Game.make_move(game, "x")
    assert tally.game_state == :bad_guess

    { _game, tally } = Game.make_move(game, "w")
    assert tally.game_state == :good_guess

    { _game, tally } = Game.make_move(game, "y")
    assert tally.game_state == :bad_guess
  end

  test "can handle a sequence of moves" do
    [
      # guess      state    turns_left           letters               used
      [ "a",    :bad_guess,     6,     [ "_", "_", "_", "_", "_", ], [ "a" ] ],
      [ "a",    :bad_guess,     5,     [ "_", "_", "_", "_", "_", ], [ "a" ] ],
      [ "e",    :good_guess,    5,     [ "_", "e", "_", "_", "_", ], [ "a", "e" ] ],
      [ "x",    :bad_guess,     4,     [ "_", "e", "_", "_", "_", ], [ "a", "e", "x" ] ],
    ]
    |> test_sequence_of_moves()
  end

  def test_sequence_of_moves(script) do
    game = Game.new_game "hello"
    Enum.reduce(script, game, &check_one_move/2)
  end

  def check_one_move([ guess, state, turns, letters, used ], game) do
    { game, tally } = Game.make_move(game, guess)

    assert tally.game_state == state
    assert tally.turns_left == turns
    assert tally.letters    == letters
    assert tally.used       == used

    game
end
