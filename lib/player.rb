# frozen_string_literal: true

# class that holds the name and symbol of each player
class Player
  attr_accessor :name, :symbol

  def initialize(name,symbol)
    @name = name
    @symbol = symbol
  end
end