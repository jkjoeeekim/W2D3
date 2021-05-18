require_relative "./board.rb"

class HumanPlayer
    attr_reader :mark

    def initialize(mark_value)
        @mark = mark_value
        @board = Board.new
    end

    def get_position
        # puts "Enter a row between 1 and #{@board.board.length}."
        # row = gets.chomp.to_i
        # if !(1..@board.board.length).to_a.include?(row)
        #     raise StandardError.new("\nInvalid row, does not exist.\nPress Enter to try again\n ")
        # end
        # puts "\nEnter a column between 1 and #{@board.board.length}."
        # col = gets.chomp.to_i
        # if !(1..@board.board.length).to_a.include?(col)
        #     raise StandardError.new("\nInvalid column, does not exist.\nPress Enter to try again\n ")
        # end
        # [row - 1, col - 1]
        begin
            puts "Enter a row between 1 and #{@board.board.length}."
            row = gets.chomp.to_i
            if !(1..@board.board.length).to_a.include?(row)
                raise StandardError.new("\nInvalid row, does not exist.\nPress Enter to try again\n ")
            end
            puts "\nEnter a column between 1 and #{@board.board.length}."
            col = gets.chomp.to_i
            if !(1..@board.board.length).to_a.include?(col)
                raise StandardError.new("\nInvalid column, does not exist.\nPress Enter to try again\n ")
            end
            [row - 1, col - 1]
        rescue => error
            puts error.message
        end
    end
end