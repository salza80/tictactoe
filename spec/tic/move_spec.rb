require 'tic/board'
require 'tic/board/move'
RSpec.describe Tic::Board::Move do
  context 'new move with player' do
    move = Tic::Board::Move.new(1, 1, :X)
    # it 'has a board' do
    #   expect(move.board.class.name).to eq('Board')
    # end
    it 'has a player' do
      expect(move.player).to eq(:X)
    end
    it 'has a location' do
      expect(move.location).to eq({row: 1, col: 1})
    end
    it 'is empty' do
      expect(move.empty?).to eq(false)
    end
  end
  context 'new empty move' do
    move = Tic::Board::Move.new(3, 2)
    it 'has a location' do
      expect(move.location).to eq({row: 3, col: 2})
    end
    it 'is empty' do
      expect(move.empty?).to eq(true)
    end
    it 'sets a player' do
      move.set_player(:X)
      expect(move.player).to eq(:X)
    end
    it 'raises an error when player is already set' do
      expect{move.set_player(:O)}.to raise_error(Tic::DuplicateMove)

    end
  end
end
