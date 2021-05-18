require_relative "./board.rb"
require_relative "./human_player.rb"

class Game
    attr_reader :players, :current_player, :board

    def initialize(size, *players_marks)
        @players = Hash.new

        players_marks.each_with_index do |mark, idx|
            mark = HumanPlayer.new(size, mark)
            @players[mark] = "Player #{idx + 1}"
        end
        
        @current_player = @players.keys.first
        @board = Board.new(size)
        
    end

    def player_name
        players[current_player]
    end

    def switch_turn
        @players.keys.each_with_index do |player, idx|
            if current_player.mark == player.mark
                @current_player = @players.keys[(idx + 1) % players.keys.length]
                return true
            end
        end
    end

    def play
        while board.empty_positions? do
            puts "\n#{" " * 3}Make a Move #{player_name}\n#{" " * 6}Your Sign is #{current_player.mark}"
            board.print

            begin
                position = current_player.get_position
                @board.place_mark(position, current_player.mark)
            rescue => error
                gets
            end

            if board.win?(current_player.mark)
                puts "\n#{" " * 8}GAME OVER!"
                board.print
                puts "\n#{" " * 5}#{player_name} VICTORY!\n "
                return
            elsif board.made_move
                switch_turn
                board.made_move = false
            end
        end
        puts "\n#{" " * 8}GAME OVER!"
        board.print
        puts "#{" " * 5}Tie Game\n "
    end
end

new_game = Game.new(5, :X, :O, :K, :J)
new_game.play