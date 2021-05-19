require_relative "./game.rb"

class GameSetup
    attr_reader :win_count, :lose_count, :new_game

    def initialize(win_count=0, lose_count=0)
        @win_count = win_count
        @lose_count = lose_count
    end

    def get_size
        begin
            puts "#{"\n" * 30}  What is the Board Size?\n  (Choose between 3 and 9)\n "
            size = gets.chomp.to_i
            if size < 3
                raise StandardError.new("Invalid Size, must be at least 3")
            end
            if size > 9
                raise StandardError.new("Invalid Size, must be less than 10")
            end
            size
        rescue => error
            puts "\n  #{error.message}"
            puts "  Press Enter to Try Again\n "
            gets
            retry
        end
    end

    def get_players_and_computers(size)
        begin
            puts "\n\n  How many players?\n "
            num_players = gets.chomp.to_i
            if num_players < 1
                raise StandardError.new("Invalid numbers of players, must be at least 1")
            end
            
            puts "\n\n  How many computers?\n "
            num_computers = gets.chomp.to_i
            if num_computers > 5
                raise StandardError.new("Invalid number of computers, must be less than 5")
            end

            puts "#{"\n" * 30} GAME SETUP:"
            puts "\n\n  Board Size: #{size}\n "
            puts "  Total Players: #{num_players}\n "
            puts "  Total Computers: #{num_computers}\n "

            puts "\n  Press Enter to Continue...\n "
            gets
            [num_players, num_computers]
        rescue => error
            puts "\n  #{error.message}"
            puts "  Press Enter to Try Again\n "
            gets
            retry
        end
    end

    def choose_symbol_player(num_players, size)
        symbols_hash = Hash.new
        available_symbols = ("A".."Z").to_a
        num_players.times do |player|
            begin
                puts "#{"\n" * 30}  Choose your symbol Player #{player + 1}\n  (Any character from A ~ Z)\n "
                symbol_string = gets.chomp
                sym = symbol_string.upcase.to_sym
                if symbols_hash.keys.include?(sym)
                    raise StandardError.new("Symbol is Already Taken")
                end
                if !available_symbols.include?(symbol_string.upcase)
                    raise StandardError.new("Invalid Character")
                end
                available_symbols.delete(symbol_string.upcase)
                symbols_hash[sym] = false
            rescue => error
                puts "\n  #{error.message}"
                puts "  Press Enter to Try Again\n "
                gets
                retry
            end
        end
        settings(size)
        puts "\n  PLAYER SYMBOLS:"
        symbols_hash.keys.each_with_index do |sym, idx|
            puts "   Player #{idx + 1}: #{sym}"
        end
        symbols_hash
    end

    def settings(size)
        puts "#{"\n" * 30} GAME SETTINGS:\n "
        puts "  BOARD SIZE:\n   #{size} x #{size}"
    end

    def choose_symbol_computer(computer, symbols_hash)
        available_symbols = ("A".."Z").to_a
        symbols_hash.keys.each { |key| available_symbols.delete(key.to_s) }
        computer.times do |computer|
            symbol_string = available_symbols.delete(available_symbols.sample)
            sym = symbol_string.to_sym
            symbols_hash[sym] = true
        end

        computers = symbols_hash.select { |sym, bool| bool }
        puts "\n  COMPUTER SYMBOLS:"
        computers.keys.each_with_index do |sym, idx|
            puts "   Computer #{idx + 1}: #{sym}"
        end
        symbols_hash
    end

    def setup
        puts "#{"\n" * 30}#{" " * 6}PLAY TIC-TAC-TOE\n#{" " * 9}VERSION 4\n\n\n\n  Press Enter to Setup Game Parameters...\n "
        gets

        puts "#{"\n" * 2}#{" " * 2}ENTERING GAME SETUP\n\n\n\n  Press Enter to Continue...\n "
        gets
        
        size = get_size
        total = get_players_and_computers(size)

        puts "#{"\n" * 30}#{" " * 2}ENTERING PLAYER SETUP\n\n\n\n  Press Enter to Continue...\n "
        gets

        symbols_hash = choose_symbol_player(total[0], size)
        if total[1] == 0
            marks = symbols_hash
        else
            marks = choose_symbol_computer(total[1], symbols_hash)
        end

        puts "\n\n Press Enter to Start Game!!\n "
        gets

        run_game(size, marks)

        players = marks.select { |mark, bool| !bool }
        players.keys.each do |mark|
            @new_game.board.win?(mark) ? @win_count += 1 : @lose_count += 1
        end

        puts "\n\n  Play Again? (y/n)\n "
        answer = gets.chomp.downcase
        if answer == "y"
            new_game = GameSetup.new(win_count, lose_count)
            new_game.setup
        else
            puts "#{"\n" * 30}  Player(s) record was: #{win_count} Wins and #{lose_count} Losses!\n\n  Thanks for Playing~\n "
        end
    end

    def run_game(size, marks)
        @new_game = Game.new(size, marks)
        new_game.play
    end
end

new_game = GameSetup.new
new_game.setup