require_relative "./board.rb"
require_relative "./human_player.rb"
require_relative "./computer_player.rb"

class Game
    attr_reader :players, :current_player, :board

    def initialize(size, marks)
        @players = Hash.new
        @computers = Hash.new

        marks.keys.each_with_index do |mark, idx|
            if marks[mark]
                mark = ComputerPlayer.new(mark)
                @players[mark] = "Computer #{idx + 1}"
            else
                mark = HumanPlayer.new(size, mark)
                @players[mark] = "Player #{idx + 1}"
            end
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
            if current_player.is_a?(ComputerPlayer)
                puts "\n#{" " * 3}#{player_name}'s Turn to Move\n#{" " * 6}Its Sign is #{current_player.mark}"
                board.print
                position = current_player.get_position(board.legal_positions)
                @board.place_mark(position, current_player.mark)
                puts "\n#{" " * 3}Press Enter to Continue"
                gets
            else
                puts "\n#{" " * 3}Make a Move #{player_name}\n#{" " * 6}Your Sign is #{current_player.mark}"
                board.print
    
                begin
                    position = current_player.get_position
                    @board.place_mark(position, current_player.mark)
                rescue => error
                    gets
                end
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
        puts "#{" " * 8}TIE GAME!\n "
    end
end

new_game = Game.new(5, {X: false, O: false, K: true, J: true})
new_game.play
# p new_game.players