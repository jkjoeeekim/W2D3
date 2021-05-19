require_relative "./game.rb"

class GameSetup
    attr_reader :win_count, :lose_count, :new_game

    def initialize(win_count=0, lose_count=0)
        @win_count = win_count
        @lose_count = lose_count
    end

    def get_size
        begin
            puts "\n\n  What is the Board Size?\n "
            size = gets.chomp.to_i
        rescue => exception
            
        end
        size
    end

    def get_players_and_computers(size)
        begin
            puts "\n\n  How many players?\n "
            num_players = gets.chomp.to_i
            
            puts "\n\n  How many computers?\n "
            num_computers = gets.chomp.to_i

            puts "#{"\n" * 30} GAME SETUP:"
            puts "\n\n Board Size: #{size}\n "
            puts " Total Players: #{num_players}\n "
            puts " Total Computers: #{num_computers}\n "

            puts "\n  Press Enter to Continue...\n "
            gets
            [num_players, num_computers]
        rescue => exception
            
        end
        [num_players, num_computers]
    end

    def choose_symbol_player(num_players)
        symbols_hash = Hash.new
        available_symbols = ("A".."Z").to_a
        num_players.times do |player|
            begin
                puts "\n\n  Choose your symbol Player #{player + 1}\n  (Any character from A ~ Z)\n "
                symbol_string = gets.chomp
                if !available_symbols.include?(symbol_string.upcase)
                    raise Error.new("\n\n  Invalid character, choose from A ~ Z\n\n ")
                end
                available_symbols.delete(symbol_string.upcase)
                sym = symbol_string.upcase.to_sym
                if symbols_hash.keys.include?(sym)
                    raise Error.new("\n\n  Symbol is already taken, choose again\n\n ")
                end
                symbols_hash[sym] = false
            rescue => error
                # puts error.message
                puts "  Press Enter to Try Again\n"
                gets
            end
        end
        puts "#{"\n" * 30} PLAYER SYMBOLS:\n\n "
        symbols_hash.keys.each_with_index do |sym, idx|
            puts "  Player #{idx + 1}: #{sym}\n "
        end
        symbols_hash
    end

    def choose_symbol_computer(computer, symbols_hash)
        available_symbols = ("A".."Z").to_a
        symbols_hash.keys.each { |key| available_symbols.delete(key.to_s) }
        computer.times do |computer|
            symbol_string = available_symbols.delete(available_symbols.sample)
            sym = symbol_string.to_sym
            symbols_hash[sym] = true
        end
        # p available_symbols
        computers = symbols_hash.select { |sym, bool| bool }
        puts "\n COMPUTER SYMBOLS:\n\n "
        computers.keys.each_with_index do |sym, idx|
            puts "  Computer #{idx + 1}: #{sym}\n "
        end
        symbols_hash
    end

    def setup
        puts "#{"\n" * 30}#{" " * 6}PLAY TIC-TAC-TOE\n#{" " * 9}VERSION 4\n\n\n\n  Press Enter to Setup Game Parameters...\n "
        gets
        puts "#{"\n" * 2}#{" " * 5}ENTERING GAME SETUP\n\n\n\n  Press Enter to Continue...\n "
        gets
        begin
            size = get_size
            total = get_players_and_computers(size)
            symbols_hash = choose_symbol_player(total[0])
            marks = choose_symbol_computer(total[1], symbols_hash) unless total[1] == 0

            puts "\n\n  Press Enter to Start Game!!\n "
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
        # rescue => exception
            # puts "tryagain"
        end
    end

    def run_game(size, marks)
        @new_game = Game.new(size, marks)
        new_game.play
    end
end

new_game = GameSetup.new
new_game.setup