require './puzzle'

class Solverson
  def solve_grid puzzle
    puzzle.grid.each_with_index do
      |row, index|
      puzzle.grid[index] = solve_clue_and_row(puzzle.x_clues[index],row)
    end

    puzzle.grid
  end

  def solve_row puzzle
    clue, row = puzzle
    solve_clue_and_row(clue, row)
  end

  def solve_clue_and_row clue, row
    if clue.kind_of?(Enumerator.class) == false || clue.length == 1
      clue = [clue].flatten.first
      if clue == 0
        return row.fill_X
      end
      if clue == row.length
        return row.fill_O
      end

      if clue_is_satisfied(clue, row)
        return fill_empty_with_X(row)
      end

      if row_is_padded(clue, row)
        front_pad = []
        back_pad = []

        while(row.first == :X)
          front_pad << row.shift
        end

        while(row.last == :X)
          back_pad << row.pop
        end

        return front_pad + solve_clue_and_row(clue, row) + back_pad
      end
    end
  end
  
  private

  def fill_empty_with_X row
    row.map {|c| c == :_ ? :X : :O }
  end
  
  def clue_is_satisfied(clue, row)
    cluestring = 'O'*clue
    rowstring = row.map { |c| c.to_s }.join
    rowstring.include? cluestring
  end

  def row_is_padded(clue, row)
    row.first == :X || row.last == :X
  end
end
