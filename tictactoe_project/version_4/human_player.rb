require_relative "./board.rb"

class HumanPlayer
    attr_reader :mark

    def initialize(size, mark_value)
        @mark = mark_value
        @board = Board.new(size)
    end

    def get_position
        begin
            puts "  Enter a row between 1 and #{@board.board.length}.\n "
            row = gets.chomp.to_i
            if !(1..@board.board.length).to_a.include?(row)
                raise StandardError.new("\n#{" " * 3}Invalid row, does not exist.\n#{" " * 3}Press Enter to try again\n ")
            end
            puts "  Enter a column between 1 and #{@board.board.length}.\n "
            col = gets.chomp.to_i
            if !(1..@board.board.length).to_a.include?(col)
                raise StandardError.new("\n#{" " * 3}Invalid column, does not exist.\n#{" " * 3}Press Enter to try again\n ")
            end
            [row - 1, col - 1]
        rescue => error
            puts error.message
        end
    end
end