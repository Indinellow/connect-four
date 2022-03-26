# frozen_string_literal: true

#class that holds the board of the game with methods to display it
class Board
  attr_accessor :board

  def initialize
    @board = make_empty_board
  end

  def make_empty_board
    board = Array.new(6) {Array.new(7) {'_'}}
  end

  def display_curr_board(board = @board)
    board.each do |row| 
      row.each do |spot| 
        print "#{spot}  "
      end
      puts "\n"
    end
  end

  def free_space?(row,column,board = @board)
    board[row][column] == '_'
  end

  def find_first_free_space(column, board = @board)
    curr_row = board.length - 1
    until curr_row < 0 || free_space?(curr_row,column,board)
      curr_row -= 1
    end
    curr_row
  end

  def insert_symbol_in_column(column, symbol)
    row = find_first_free_space(column,board)
    return nil if row == -1

    @board[row][column] = symbol
  end

  def one_row_win?(symbol,row_index,board = @board) 
    row = board[row_index] 
    row.each_with_index do |elem,index|
      return false if index >= 4

      return true if elem == symbol && row[index +1] == symbol && row[index +2] == symbol && row[index + 3] == symbol
    end    
  end

  def row_win?(symbol)
    6.times {|r_index| return true if one_row_win?(symbol,r_index)}
    false
  end

  def one_column_win?(symbol,c_index,board = @board)
    board.each_with_index do |row,r_index|
      return false if c_index >=3

      return true if row[c_index] == symbol && board[r_index+1][c_index] == symbol && board[r_index+2][c_index] == symbol && board[r_index+3][c_index] == symbol 
    end
    false
  end

  def column_win?(symbol)
    7.times {|c_index| return true if one_column_win?(symbol,c_index)}
    false
  end

  def diagonal_up_win?(symbol,board = @board) 
    board.each_with_index do |row, r_index|
      next if r_index <= 2

      row.each_with_index do |col, c_index|
        next if c_index >= 4

        return true if board[r_index][c_index] == symbol  && board[r_index-1][c_index+1] == symbol && board[r_index-2][c_index+2] == symbol && board[r_index-3][c_index+3] == symbol
      end
    end
    false 
  end

  def diagonal_down_win?(symbol,board = @board)
    board.each_with_index do |row, r_index|
      return false if r_index >= 3 

      row.each_with_index do |col, c_index|
        next if c_index >= 4

        return true if board[r_index][c_index] == symbol && board[r_index + 1][c_index + 1] == symbol && board[r_index + 2][c_index + 2] == symbol && board[r_index + 3][c_index + 3] == symbol
      end
    end
    false
  end

  def game_won?(symbol)
    row_win?(symbol) || column_win?(symbol) || diagonal_up_win?(symbol) || diagonal_down_win?(symbol)
  end
end
