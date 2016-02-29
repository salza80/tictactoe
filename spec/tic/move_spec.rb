require 'tic/board'
require 'tic/board/move'
RSpec.describe Tic::Board::Move do
  move = Tic::Board::Move.new(:X, 1, 1)
  # it 'has a board' do
  #   expect(move.board.class.name).to eq('Board')
  # end
  it 'has a player' do
    expect(move.player).to eq(:X)
  end
  it 'has a location' do
    expect(move.location).to eq({row: 1, col: 1})
  end
end
