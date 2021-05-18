require_relative "board"
require_relative "player"

class Battleship
    attr_reader :board, :player

    def initialize(length)
        @player = Player.new
        @board = Board.new(length)
        @remaining_misses = (length * length) / 2
    end

    def start_game
        board.place_random_ships
        puts board.num_ships
        board.print
    end

    def lose?
        if @remaining_misses < 1
            puts "you lose"
            return true
        end
        false
    end

    def win?
        if board.num_ships == 0
            puts "you win"
            return true
        end
        false
    end

    def game_over?
        lose? || win?
    end

    def turn
        position = player.get_move
        if board.attack(position)
            puts @remaining_misses
        else
            @remaining_misses -= 1
            puts @remaining_misses
        end
        board.print
    end
end
