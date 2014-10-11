class Solverson
  def self.solve_row puzzle  
    clue, row = puzzle
    self.solve_clue_and_row(clue, row)
  end

  def self.solve_clue_and_row clue, row
    if clue.kind_of?(Enumerator.class) == false || clue.length == 1
      clue = [clue].flatten.first
      if clue == 0
        return fill_X(row)
      end
      if clue == row.length
        return fill_O(row)
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

        return front_pad + self.solve_clue_and_row(clue, row) + back_pad
      end
    end

    row
  end
  
  private

  def self.fill_X row
    row.fill :X
  end

  def self.fill_O row
    row.fill :O
  end

  def self.fill_empty_with_X row
    row.map {|c| c == :_ ? :X : :O }
  end
  
  def self.clue_is_satisfied(clue, row)
    cluestring = 'O'*clue
    rowstring = row.map { |c| c.to_s }.join
    rowstring.include? cluestring
  end

  def self.row_is_padded(clue, row)
    row.first == :X || row.last == :X
  end
end

require 'minitest/autorun'

describe Solverson do
  describe 'zero dimensional puzzles' do
    it '0[ ] -> [X]' do
      puzzle = [[0], [:_]]
      Solverson.solve_row(puzzle).must_equal [:X]
    end

    it '1[ ] -> [O]' do
      puzzle = [[1],[:_]]
      Solverson.solve_row(puzzle).must_equal [:O]
    end
  end

  describe 'one dimensional puzzles' do
    it '0[ | ] -> [X|X]' do
      puzzle = [[0], [:_, :_]]
      Solverson.solve_row(puzzle).must_equal [:X, :X]
    end
    
    it '2[ | ] -> [O|O]' do
      puzzle = [[2],[:_,:_]]
      Solverson.solve_row(puzzle).must_equal [:O, :O]
    end

    it '1[ |O| ] -> [X|O|X]' do
      puzzle = [[1], [:_, :O, :_]]
      Solverson.solve_row(puzzle).must_equal [:X, :O, :X]
    end

    it '1[X| |X] -> [X|O|X]' do
      puzzle = [[1], [:X, :_, :X]]
      Solverson.solve_row(puzzle).must_equal [:X, :O, :X]
    end
  end
end
