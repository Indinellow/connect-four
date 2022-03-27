# frozen_string_literal: true

require './display_and_board.rb'
require './player.rb'

# class that holds the functionality of the game
class Game
  attr_accessor :grid,:player1, :player2
  
  def initialize 
    @grid = Board.new
    @player1 = create_player1
    @player2 = create_player2
  end

  def create_player1
    puts "Enter a name for player 1"
    name = gets.chomp
    puts "What symbol do you want to use?"
    puts "Enter 1 for \u26AA or 2 for \u26AB"
    choice = gets.chomp
    choice == '1' ? symbol = "\u26AA" : symbol = "\u26AB"  
    Player.new(name,symbol)  
  end

  def get_other_symbol
    @player1.symbol == "\u26AB" ? symbol = "\u26AA" : symbol = "\u26AB"
  end

  def create_player2
    puts "Enter a name for player 2"
    name = gets.chomp
    while name == @player1.name 
      puts "Do you really want to have the same name? Please pick something else"
      name = gets.chomp
    end
    symbol = get_other_symbol
    puts "Ok,#{name}, since #{@player1.name} chose symbol #{player1.symbol}, You get the symbol #{symbol}"
    Player.new(name,symbol)
  end

  def game_over?
    @grid.game_won?(@player1.symbol) || @grid.game_won?(@player2.symbol) || @grid.game_draw?
  end

  def ask_for_column_input(player)
    "#{player.name}, pick the column you wanna insert your symbol."
    puts "You can pick a column by entering a number from 0 to 6."
    p_choice = gets.chomp
    until p_choice.match(/\b[0-6]\b/)
      puts "Thats not a valid column. Please choose again"
      p_choice = gets.chomp
    end
    p_choice.to_i
  end

  def play_turn(player)
    p_choice = ask_for_column_input(player)
    @grid.insert_symbol_in_column(p_choice,player.symbol)
    @grid.display_curr_board
  end

  def connect_four
    @grid.display_curr_board
    until (game_over?)
      play_turn(@player1)
      if @grid.game_won?(@player1.symbol)
        puts "Congratulations #{@player1.name}, you won!"
        break
      end
      play_turn(@player2)
      puts "It's a draw!" if @grid.game_draw?
      if @grid.game_won?(@player2.symbol)
        puts "Congratulations #{@player2.name}, you won!"
        break
      end
    end
  end
end

game = Game.new
game.connect_four