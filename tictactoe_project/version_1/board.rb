class Board
    attr_reader :board
    attr_accessor :made_move

    def initialize
        @board = Array.new(3) { Array.new(3, "_") }
        @made_move = false
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
            @made_move = true
        elsif !valid?(position)
            raise StandardError.new("\nEnter a valid position, out of bounds.\nPress Enter to try again\n ")
        else
            begin
                raise StandardError.new("\nEnter a valid position, position is taken.\nPress Enter to try again\n ")
            rescue => error
                puts error.message
                gets
            end
        end
    end

    def print
        puts "\n\n#{" " * 5}TIC-TAC-TOE\n#{" " * 6}VERSION 1\n "
        puts "#{" " * 8}#{(1..board.length).to_a.join(" ")}"
        puts "#{" " * 7}#{"-" * ((board.length * 2) + 1)}"
        board.each_with_index do |row, idx|
            puts "#{" " * 4}#{idx + 1} | " + "#{row.join(" ")}" + " |"
        end
        puts "#{" " * 7}#{"_" * ((board.length * 2) + 1)}\n \n "
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