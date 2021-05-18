class Board
    attr_reader :board

    def initialize
        @board = Array.new(3) { Array.new(3, "_") }
    end

    def [](position)
        board[position[0]][position[1]]
    end

    def []=(position, value)
        board[position[0]][position[1]] = value
    end

    def valid?(position)
        position.all? { |ele| (0...board.length).to_a.include?(ele) }
    end

    def empty?(position)
        self[position] == "_"
    end

    def place_mark(position, mark)
        if valid?(position) && empty?(position)
            self[position] = mark
        elsif !valid?(position)
            raise "Enter a valid position, out of bounds."
        else
            raise "Enter a valid position, position is taken."
        end
    end

    def print
        puts "\n\n  TICTACTOE\n  VERSION 1\n "
        puts "    #{(1..board.length).to_a.join(" ")}"
        puts "   -------"
        board.each_with_index do |row, idx|
            puts "#{idx + 1} | " + "#{row.join(" ")}" + " |"
        end
        puts "   _______\n \n "
        true
    end

    def win_row?(mark)
        board.any? do |row|
            row.all? { |ele| ele == mark }
        end
    end

    def win_col?(mark)
        board.transpose.any? do |col|
            col.all? { |ele| ele == mark }
        end
    end
 
    def win_diagonal?(mark)
        diag = []
        reverse_diag = []
        board.each_with_index { |row, idx| diag << board[idx][idx] }
        board.reverse.each_with_index { |row, idx| reverse_diag << row[idx] }
        diag.all?(mark) || reverse_diag.all?(mark)
    end

    def win?(mark)
        win_row?(mark) || win_col?(mark) || win_diagonal?(mark)
    end

    def empty_positions?
        board.any? { |row| row.include?("_") }
    end
end

b = Board.new
b.print