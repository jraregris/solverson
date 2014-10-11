class Solverson
  def self.solve_row puzzle
    clue, grid = puzzle
    if clue.length == 1
      if clue.first == 0
        return fill_cross(grid)
      end
      if clue.first == grid.length
        return fill_fill(grid)
      end
    end
  end
  
  private

  def self.fill_cross grid
    grid.fill :cross
  end

  def self.fill_fill grid
    grid.fill :fill
  end
end

require 'minitest/autorun'

describe Solverson do
  describe 'zero dimensional puzzles' do
    it '0[ ] -> [X]' do
      puzzle = [[0], [:blank]]
      Solverson.solve_row(puzzle).must_equal [:cross]
    end

    it '1[ ] -> [O]' do
      puzzle = [[1],[:blank]]
      Solverson.solve_row(puzzle).must_equal [:fill]
    end
  end

  describe 'one dimensional puzzles' do
    it '0[ | ] -> [X|X]' do
      puzzle = [[0], [:blank, :blank]]
      Solverson.solve_row(puzzle).must_equal [:cross, :cross]
    end
    
    it '2[ | ] -> [O|O]' do
      puzzle = [[2],[:blank,:blank]]
      Solverson.solve_row(puzzle).must_equal [:fill, :fill]
    end
  end
end
