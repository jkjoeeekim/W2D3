require_relative "./board.rb"
require_relative "./human_player.rb"

class Game
    attr_reader :player1, :player2, :current_player, :board

    def initialize(player1_mark, player2_mark)
        @player1 = HumanPlayer.new(player1_mark)
        @player2 = HumanPlayer.new(player2_mark)
        @current_player = @player1
        @board = Board.new
        
    end

    def player_name
        current_player == player1 ? "Player 1" : "Player 2"
    end

    def switch_turn
        current_player == player1 ? (@current_player = player2) : (@current_player = player1)
    end

    def play
        while board.empty_positions? do
            puts "\n Make a Move #{player_name}\n    Your Sign is #{current_player.mark}"
            board.print

            begin
                position = current_player.get_position
                @board.place_mark(position, current_player.mark)
            rescue => error
                gets
            end

            if board.win?(current_player.mark)
                puts "\n#{" " * 5}GAME OVER! "
                board.print
                puts "  #{player_name} VICTORY!\n "
                return
            elsif board.made_move
                switch_turn
                board.made_move = false
            end
        end
        puts "\n#{" " * 5}GAME OVER! "
        board.print
        puts "#{" " * 5}TIE GAME!\n "
    end
end

new_game = Game.new(:X, :O)
new_game.play