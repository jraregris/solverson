class Puzzle
  attr_accessor :grid, :x_clues, :y_clues

  def initialize x_clues, y_clues
    @grid = init_grid(x_clues, y_clues)
    @x_clues = x_clues
    @y_clues = y_clues
  end

  def init_grid x_clues, y_clues
    grid = []
    x_clues.length.times do 
      grid << Array.new(y_clues.length,:_)
    end

    grid
  end
end
