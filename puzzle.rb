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
      grid << Row.new(y_clues.length,:_)
    end

    grid
  end
end

class Row < Array
  def fill_X
    fill :X
  end

  def fill_O
    fill :O
  end

  def to_s
    map do |c|
      case c
      when :O
        '█'
      when :X
        '░'
      when :_
        ' '
      end
    end.join
  end
end
