class Board
    def self.print_grid(array)
        array.each do |row|
            print row.join(" ") + "\n"
        end
    end

    attr_reader :size

    def initialize(n)
        @grid = Array.new(n) { Array.new(n, :N) }
        @size = n * n
    end

    def [](position)
        @grid[position[0]][position[1]]
    end

    def []=(position, value)
        @grid[position[0]][position[1]] = value
    end

    def num_ships
        @grid.sum { |row| row.count { |ele| ele == :S } }
    end

    def attack(position)
        if self[position] == :S
            self[position] = :H
            puts "you sunk my battleship!"
            return true
        else
            self[position] = :X
            return false
        end
    end

    def place_random_ships
        ships = @grid.flatten.length / 4
        until ships == 0
            position = []
            2.times { position << rand(@grid.length) }
            if self[position] == :N
                self[position] = :S
                ships -= 1
            end
        end
    end

    def hidden_ships_grid
        @grid.map do |row|
            row.map { |ele| ele == :X ? :X : :N }
        end
    end

    def cheat
        Board.print_grid(@grid)
    end

    def print
        Board.print_grid(hidden_ships_grid)
    end
end
