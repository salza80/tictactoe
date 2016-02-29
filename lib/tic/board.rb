require_relative 'errors'
require_relative 'board/move'
module Tic
  class Board
    attr_reader :moves
    attr_reader :next_player
    def initialize(rows = 3, cols = 3)
      @rows = rows
      @cols = cols
      reset_moves
      @next_player = :X
    end

    def free_moves
      empty_moves.count
    end

    def make_move(row, col)
      raise Tic::DuplicateMove unless @moves[row_col_to_array_pos(row, col)]  == nil
      @moves[row_col_to_array_pos(row, col)]  = Move.new(:X, row, col)
      switch_player
    end

    def get_move(row, col)
      @moves[row_col_to_array_pos(row, col)]
    end

    def clear(next_player = :X)
      reset_moves
      @next_player = next_player
    end


    private 

    def row_col_to_array_pos(row, col)
      ((row - 1) * @cols) + col
    end

    def board_size 
      @rows*@cols
    end

    def empty_moves
      @moves.select{|i| i == nil}
    end

    def switch_player
      @next_player = if @next_player == :X then :O  else :X end
    end

    def reset_moves
      @moves = Array.new(board_size)
    end

  end
end

