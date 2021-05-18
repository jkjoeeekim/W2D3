require_relative "./board.rb"

class HumanPlayer
    attr_reader :player_mark, :board

    def initialize(mark_value)
        @player_mark = mark_value
        @board = Board.new
    end

    def get_position
        puts "Enter a row between 1 and #{board.board.length}."
        row = gets.chomp.to_i
        puts "Enter a column between 1 and #{board.board.length}."
        col = gets.chomp.to_i
        pos = [row - 1, col - 1]
        
    end
end

p1 = HumanPlayer.new(:X)
p p1
p p1.get_position
