
require_relative "card.rb"

class Board

    def initialize(size)

      if size.odd?# == true
        size += 1 
      end 

      @board_size = size
        
      @board = Array.new(size) { Array.new(size) { Card.new(nil) } }

    end

    def populate

        values = [1,1,2,2,3,3,4,4].shuffle

        @board.each do |sub_arr|
            sub_arr.each do |card|
                card.value = values.unshift
            end
        end

        
    end 

    def won?

        @board.all? do |sub_arr|
            sub_arr.all? { |card|  card.face_up?      }
        end

    end

    def render

        p @board

    end

    def reveal_card(pos)

       if !self[pos].face_up?
         self[pos].reveal
        return self[pos].value
       end

    end

    def [](pos)

        @board[pos[0]][pos[1]]

    end

end



