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
      first_move = board.moves.first
      expect(first_move.location).to eq({row: 1, col: 1})
      expect(first_move.empty?).to eq(true)
      last_move = board.moves.last
      expect(last_move.location).to eq({row: 3, col: 3})
      expect(last_move.empty?).to eq(true)
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
  context "winning column move" do
    #-XO 
    #-XO
    #-X-
    board = Tic::Board::new(3,3)
    board.make_move(1,2)
    board.make_move(1,3)
    board.make_move(2,2)
    board.make_move(2,3)
    board.make_move(3,2)
    it 'returns winner X' do
      expect(board.game_status).to eq(:X)
    end
  end
  context "winning row move" do
  #X-- 
  #-X-
  #OOO
  board = Tic::Board::new(3,3,"O")
  board.make_move(3,1)
  board.make_move(1,1)
  board.make_move(3,3)
  board.make_move(2,2)
  board.make_move(3,2)
    it 'returns winner O' do
      expect(board.game_status).to eq(:O)
    end
  end
  context "winning diaganal move" do
  #O-- 
  #XO-
  #XXO
  board = Tic::Board::new(3,3)
  board.make_move(2,1)
  board.make_move(1,1)
  board.make_move(3,1)
  board.make_move(3,3)
  board.make_move(3,2)
  board.make_move(2,2)
    it 'returns winner O' do
      expect(board.game_status).to eq(:O)
    end
  end
  context "Draw  move" do
  #XOX 
  #XXO
  #OXO
  board = Tic::Board::new(3,3)
  board.make_move(1,1)
  board.make_move(1,2)
  board.make_move(1,3)
  board.make_move(2,3)
  board.make_move(2,1)
  board.make_move(3,1)
  board.make_move(2,2)
  board.make_move(3,3)
  board.make_move(3,2)
    it 'returns :D as draw' do
      expect(board.game_status).to eq(:D)
    end
  end
  context "no complete game  move" do
  #XOX
  #O--
  #---
  board = Tic::Board::new(3,3)
  board.make_move(1,1)
  board.make_move(1,2)
  board.make_move(1,3)
  board.make_move(2,1)
    it 'returns :NC as status is not commplete' do
      expect(board.game_status).to eq(:NC)
    end
  end
end
