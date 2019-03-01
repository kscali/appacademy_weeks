require_relative 'board.rb'
require_relative 'card.rb'
require 'byebug'

class Game 

  def initialize 
    puts 'Enter a size for the board'
    size = gets.chomp.to_i
    @board = Board.new(size)
    @board.populate
  end 

  def game_over?

    if @board.won?
      puts "Hey, you won!"
      return true
    else
      self.play
    end 

  end 

  def play 

    @board.render
    puts "Please enter a position as a 2-digit number, plz!"
    input = gets.chomp
    pos1 = to_num(input)
       
    card1 = self.make_guess(pos1) 

    puts "Please enter a position as a 2-digit number, plz!"
    input = gets.chomp
    pos2 = to_num(input)
    
    card2 = self.make_guess(pos2) 
    
    compare_cards(pos1, pos2)

    self.game_over?

  end 

  def to_num(str)

    input_array = str.split("")
    input_array.map! do |ele|
        ele.to_i
    end

  end

  def make_guess(pos)

    return @board.reveal_card(pos)

  end

  def compare_cards(pos1, pos2)

    if pos1 != pos2
        @board[pos1].hide 
        @board[pos2].hide
    end

  end

end 

game = Game.new
game.play