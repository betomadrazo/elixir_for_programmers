defmodule B1Web.HangmanView.Helpers.FigureFor do


  def figure_for(0) do
    ~s{
      ______
      |    |
      |    |
      O    |
     /|\\   |
     / \\   |
           |
           |
    ========
    }
  end

  def figure_for(1) do
    ~s{
      ______
      |    |
      |    |
      O    |
     /|\\   |
     /     |
           |
           |
    ========
    }
  end

  def figure_for(2) do
    ~s{
      ______
      |    |
      |    |
      O    |
     /|\\   |
           |
           |
           |
    ========
    }
  end

  def figure_for(3) do
    ~s{
      ______
      |    |
      |    |
      O    |
     /|    |
           |
           |
           |
    ========
    }
  end

  def figure_for(4) do
    ~s{
      ______
      |    |
      |    |
      O    |
      |    |
           |
           |
           |
    ========
    }
  end

  def figure_for(5) do
    ~s{
      ______
      |    |
      |    |
      O    |
           |
           |
           |
           |
    ========
    }
  end

  def figure_for(6) do
    ~s{
      ______
      |    |
      |    |
           |
           |
           |
           |
           |
    ========
    }
  end

  def figure_for(7) do
    ~s{
      ______
      |    |
           |
           |
           |
           |
           |
           |
    ========
    }
  end
end
