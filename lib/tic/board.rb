require_relative 'errors'
require_relative 'board/move'
module Tic
  class Board
    attr_reader :moves
    attr_reader :next_player
    def initialize(rows = 3, cols = 3, first_player = :X)
      @rows = rows
      @cols = cols
      @next_player = first_player.to_sym
      @moves = init_moves
    end

    def free_moves
      empty_moves.count
    end

    def make_move(row, col)
      @moves[row_col_to_array_pos(row, col)].set_player(next_player)
      switch_player
    end

    def get_move(row, col)
      @moves[row_col_to_array_pos(row, col)]
    end

    def clear(next_player = :X)
      @moves = init_moves
      @next_player = next_player
    end
    def game_status
      winner = check_winner
      return winner if winner
      return :D if free_moves == 0
      :NC
    end


    private 

    #checking for winners
      def check_winner
      (1..@rows).each do | i |
        result = check_row(i)
        return result if result
      end
      (1..@cols).each do | i |
        result = check_col(i)
        return result if result
      end
      check_diaganals
    end
    def check_row(row)
      this_row = @moves.select{| move | move.location[:row] == row && !move.empty?}
      is_winner?(this_row)
    end

    def check_col(col)
      this_col = @moves.select{| move | move.location[:col]  == col && !move.empty?}
      is_winner?(this_col)
    end

    def check_diaganals
      diag= []
      (0..board_size).step(@cols+1).each do | i | 
        diag.push(@moves[i]) if !@moves[i].empty?
      end
      winner = is_winner?(diag)
      return winner if winner
      diag = []
      ((@cols-1)..(board_size-(@cols-1))).step(@cols-1) do | i |
        diag.push(@moves[i]) if !@moves[i].empty?
      end
      is_winner?(diag)
    end

    def is_winner?(line)
      return false if line.count != @rows
      players = line.map{ |move| move.player}
      players.first if players.uniq.count == 1
    end

    def row_col_to_array_pos(row, col)
      (((row - 1) * @cols) + col)-1
    end

    def board_size 
      @rows*@cols
    end

    def empty_moves
      @moves.select{|i| i.empty? }
    end

    def switch_player
      @next_player = if @next_player == :X then :O  else :X end
    end

    def init_moves
      a = Array.new(board_size)
      row = 1
      col = 1
      a.map! do | item |
         move = Move.new(row, col)
        if col == @cols
          col = 1
          row += 1
        else
          col += 1
        end
        move
      end
    end
  end
end

