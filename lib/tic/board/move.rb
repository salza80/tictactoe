module Tic
  class Board
    class Move
      attr_reader :player
      attr_reader :location
      def initialize(player, row, col)
        @player = player
        @location = {
          row: row,
          col: col
        }
      end
    end
  end
end
