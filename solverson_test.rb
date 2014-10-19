require 'simplecov'
SimpleCov.start

require 'minitest/autorun'

require './solverson.rb'

describe Solverson do
  describe 'cells' do
    it '0[ ] -> [X]' do
      puzzle = [[0], Row.new([:_])]
      solver = Solverson.new
      solver.solve_row(puzzle).must_equal [:X]
    end

    it '1[ ] -> [O]' do
      puzzle = [[1], Row.new([:_])]
      solver = Solverson.new
      solver.solve_row(puzzle).must_equal [:O]
    end
  end

  describe 'rows' do
    it '0[ | ] -> [X|X]' do
      puzzle = [[0], Row.new([:_, :_])]
      solver = Solverson.new
      solver.solve_row(puzzle).must_equal [:X, :X]
    end
    
    it '2[ | ] -> [O|O]' do
      puzzle = [[2], Row.new([:_,:_])]
      solver = Solverson.new
      solver.solve_row(puzzle).must_equal [:O, :O]
    end

    it '1[ |O| ] -> [X|O|X]' do
      puzzle = [[1], [:_, :O, :_]]
      solver = Solverson.new
      solver.solve_row(puzzle).must_equal [:X, :O, :X]
    end

    it '1[X| |X] -> [X|O|X]' do
      puzzle = [[1], Row.new([:X, :_, :X])]
      solver = Solverson.new
      solver.solve_row(puzzle).must_equal [:X, :O, :X]
    end
  end

  describe 'grids' do
    it '
          1 1 1 1 1   
        5[ | | | | ] -> [O|O|O|O|O] ' do

      puzzle = Puzzle.new([[5]],[[1],[1],[1],[1],[1]])
      solver = Solverson.new
      solver.solve_grid(puzzle).must_equal [[:O, :O, :O, :O, :O]]
    end

#    it '[[3],[5],[5]], [[2],[3],[3],[3],[2]]' do
#      puzzle = Puzzle.new([[3],[5],[5]], [[2],[3],[3],[3],[2]])
#      solver.solve_grid(puzzle).must_equal [[:X,:O,:O,:O,:X],
#                                               [:O,:O,:O,:O,:O],
#                                               [:O,:O,:O,:O,:O]]
#    end
  end
end
