module Tic
  class Board
    class Move
      attr_reader :player
      attr_reader :location
      def initialize(row, col, player = nil)
        @player = player
        @location = {
          row: row,
          col: col
        }
      end
      def set_player(player)
        raise Tic::DuplicateMove unless empty? 
        @player = player
      end
      def empty?
        @player.nil?
      end
    end
  end
end
