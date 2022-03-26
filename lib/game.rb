# frozen_string_literal: true

require './display_and_board.rb'
require './player.rb'

# class that holds the functionality of the game
class Game
  attr_accessor :grid,:player1, :player2
  
  def initialize 
    @grid = Board.new
    @player1 = create_player(1)
    @player2 = create_player(2)
  end

  def create_player(i)
    puts "Enter a name for player #{i}"
    name = gets.chomp
    puts "What symbol do you want to use?"
    puts "Enter 1 for \u26AA or 2 for \u26AB"
    choice = gets.chomp
    choice == '1' ? symbol = "\u26AA" : symbol = "\u26AB"  
    Player.new(name,symbol)  
  end
end

game = Game.new