require 'tic/board'
require 'spec_helper'
RSpec.describe Tic::Board do
  context "with no moves" do
    board = Tic::Board.new(3,3)
    it 'returns number of free moves' do
      expect(board.free_moves).to eq(9)
    end
    it 'returns all the moves on the board' do
      expect(board.moves.count).to eq(9)    
      expect(board.moves.first).to eq(nil)
    end
    it 'returns initializes next player' do
      expect(board.next_player).to eq(:X)
    end
  end
  context "with one move" do
    board = Tic::Board.new(3,3)
    board.make_move(1,2)
    it 'returns number of free moves' do
      expect(board.free_moves).to eq(8)
    end
    it 'get_move returns the move' do
      expect(board.moves.count).to eq(9)    
      expect(board.get_move(1,2).player).to eq(:X)
    end
   it 'changes the next player to :O' do
    expect(board.next_player).to eq(:O)    
    end
  end
  context "move made on existing move" do
    board = Tic::Board.new(3,3)
    board.make_move(1,2)
    board.make_move(2,2)
    it 'returns number of free moves' do
      expect(board.free_moves).to eq(7)
    end
    it 'changes the next player back to :X after two' do
      expect(board.next_player).to eq(:X)    
    end
    it 'returns a an exception if move already exists' do
      expect{board.make_move(1,2)}.to raise_error(Tic::DuplicateMove)
    end
    it 'clears the board for a new game defaults to X next player' do
      board.clear
      expect(board.free_moves).to eq(9)
      expect(board.next_player).to eq(:X)
    end
    it 'clears the board for a new game and sets next player' do
      board.clear(:O)
      expect(board.free_moves).to eq(9)
      expect(board.next_player).to eq(:O)
    end
  end
end
