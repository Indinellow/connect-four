# frozen_string_literal: true

require_relative '../lib/display_and_board.rb'

describe Board do

  describe '#make_empty_board' do
    subject(:empty_board) {described_class.new}

    context 'the newly made board will have the correct' do
    
      it 'amount of rows ' do 
        expect(subject.board.length).to eq(6)
      end

      it 'amount of columns' do 
        one_row = subject.board[1]
        expect(one_row.length).to eq(7)
      end

      it 'symbols representing empty spaces' do
        one_row = subject.board[3]
        expect(one_row).to all(be == '_')
      end
    end
  end

  describe '#free_space?' do
    subject(:free_board) {described_class.new}
    it 'returns true when space in board is free' do 
      expect(free_board.free_space?(0,5,free_board.board)).to eq(true)
    end

    it 'returns false when space is taken' do
      board  = [[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0]]
      expect(free_board.free_space?(1,3,board))
    end
  end

  describe 'find_first_free_space' do
    subject(:find_board) {described_class.new}

    it 'returns the # of the first row (bottom up) that has a free spot in the selected column' do
      board = find_board.board
      expect(find_board.find_first_free_space(0,board)).to eq(5)
    end

    it 'returns the # of the first row (bottom up) that has a free spot in the selected column (non-trivial)' do
      board = [['_','_','_','_','_','_','_'],['_','_','_','_','_','_','_'],['_','x','_','_','_','_','_'],['_','x','_','_','_','_','_'],['x','x','_','_','_','_','_'],['x','x','_','x','_','_','_']]
      expect(find_board.find_first_free_space(1,board)).to eq(1)
    end

    it 'returns the # of the first row (bottom up) that has a free spot in the selected column (non-trivial)' do
      board = [['_','_','_','_','_','_','_'],['_','_','_','_','_','_','_'],['_','x','_','_','_','_','_'],['_','x','_','_','_','_','_'],['x','x','_','_','_','_','_'],['x','x','_','x','_','_','_']]
      expect(find_board.find_first_free_space(0,board)).to eq(3)
    end

    it 'returns -1 when column is full' do
      board = [['_','x'],['_','x'],['_','x'],['_','x'],['_','x']]
      expect(find_board.find_first_free_space(1,board)).to eq(-1)
    end
  end

  describe '#insert_symbol_in_column' do 
    subject(:insert_board) {described_class.new}

    it 'inserts correctly into last row' do
      insert_board.insert_symbol_in_column(0,'x')
      expect(insert_board.board[5][0]).to eq('x')
    end

    it 'inserts correctly in any row' do
      insert_board.insert_symbol_in_column(0,'x')
      insert_board.insert_symbol_in_column(0,'x')
      expect(insert_board.board[4][0]).to eq('x')
    end

    it 'returns nill when a column is full' do
    6.times {insert_board.insert_symbol_in_column(0,'x')}
    expect(insert_board.insert_symbol_in_column(0,'x')).to eq(nil)
    end
  end

  describe '#one_row_win?' do
    subject(:row_board) {described_class.new}

    it 'returns false if there is no winning four in set row' do 
      expect(row_board.one_row_win?('x',0)).to eq(false)
    end

    it 'returns false if there is no winning four in set row' do 
      board = [['x','_','x','x','x','_','x']]
      expect(row_board.one_row_win?('x',0,board)).to eq(false)
    end

    it 'returns true if there is a winning four at the start of the row' do
      board = [['x','x','x','x','_','_','_']]
      expect(row_board.one_row_win?('x',0,board)).to eq(true)
    end

    it 'returns true if there is a winning four at the end of the row' do
      board = [['_','_','_','x','x','x','x']]
      expect(row_board.one_row_win?('x',0,board)).to eq(true)
    end
    
    it 'returns true if there is a winning four in the middle of the row' do
      board = [['_','x','x','x','x','_','x']]
      expect(row_board.one_row_win?('x',0,board)).to eq(true)
    end
  end

  describe '#one_column_win?' do 
    subject(:column_board) {described_class.new}
      
    it 'returns false if no winning four in one column' do 
      expect(column_board.one_column_win?('x',0)).to eq(false)
    end

    context 'with specific board it returns' do 
      before do 
        board = [['x','_','x'],['y','x','x'],['x','x','y'],['x','x','y'],['y','x','y'],['y','y','y']]
        column_board.display_curr_board(board)
      end

      
      it 'returns false for "x" and column 0' do 
        board = [['x','_','x'],['y','x','x'],['x','x','y'],['x','x','y'],['y','x','y'],['y','y','y']]
        expect(column_board.one_column_win?('x',0,board)).to eq(false)
      end

      it 'returns true for "y" and column 2' do
        board = [['x','_','x'],['y','x','x'],['x','x','y'],['x','x','y'],['y','x','y'],['y','y','y']]
        expect(column_board.one_column_win?('y',2,board)).to eq(true)
      end

      it 'returns true for "x" and column 1 ' do
        board = [['x','_','x'],['y','x','x'],['x','x','y'],['x','x','y'],['y','x','y'],['y','y','y']]
        expect(column_board.one_column_win?('x',1,board)).to eq(true)
      end
    end
  end 

  describe '#diagonal_up_win?' do
    subject(:diagonal_up_board) {described_class.new}
    
    it 'returns false when no win in diagonal' do
      expect(diagonal_up_board.diagonal_up_win?('x')).to eq(false)
    end
    context 'for specific board' do  
      before do 
        board = [['x','x','x','x','x','x','x'],['x','x','x','y','x','x','x'],['x','x','y','x','x','x','x'],['x','y','x','x','x','x','x'],['y','x','x','x','x','x','x'],['x','x','x','x','x','x','x']]
        diagonal_up_board.display_curr_board(board)
      end
      it 'returns true when there is a diagonal "up" win for y' do 
        board = [['x','x','x','x','x','x','x'],['x','x','x','y','x','x','x'],['x','x','y','x','x','x','x'],['x','y','x','x','x','x','x'],['y','x','x','x','x','x','x'],['x','x','x','x','x','x','x']]
        expect(diagonal_up_board.diagonal_up_win?('y',board)).to eq(true)
      end
    end
  end

  describe '#diagonal_down_win' do 
    subject(:diagonal_down_board) {described_class.new}
    
    it 'returns false when no win in diagonal' do
      expect(diagonal_down_board.diagonal_down_win?('x')).to eq(false)
    end
    context 'for specific board' do  
      before do 
        board = [['x','y','x','x','x','x','x'],['x','x','y','x','x','x','x'],['x','x','y','y','x','x','x'],['x','y','x','x','y','x','x'],['y','x','x','x','x','x','x'],['x','x','x','x','x','x','x']]
        diagonal_down_board.display_curr_board(board)
      end
      it 'returns true when there is a diagonal "up" win for y' do 
        board = [['x','y','x','x','x','x','x'],['x','x','y','x','x','x','x'],['x','x','y','y','x','x','x'],['x','y','x','x','y','x','x'],['y','x','x','x','x','x','x'],['x','x','x','x','x','x','x']]
        expect(diagonal_down_board.diagonal_down_win?('y',board)).to eq(true)
      end
    end
  end 

  describe '#game_won?' do 
    subject(:won_board) {described_class.new}
    it 'returns false when the game isnt over' do
      expect(won_board.game_won?('x')).to eq(false)
    end

    it 'returns true when the game is won' do 
      won_board.board = [['x','y','x','x','x','x','x'],['x','x','y','x','x','x','x'],['x','x','y','y','x','x','x'],['x','y','x','x','y','x','x'],['y','x','x','x','x','x','x'],['x','x','x','x','x','x','x']]
      expect(won_board.game_won?('y')).to eq(true)
    end
  end
end