require_relative "./board.rb"
require_relative "./human_player.rb"
require_relative "./computer_player.rb"
require 'byebug'

class Game
    attr_reader :players, :current_player, :board

    def initialize(size, marks)
        @players = Hash.new
        
        players = player_marks(marks)
        players.keys.each_with_index do |mark, idx|
            mark = HumanPlayer.new(size, mark)
            @players[mark] = "Player #{idx + 1}"
        end

        computers = computer_marks(marks)
        computers.keys.each_with_index do |mark, idx|
            mark = ComputerPlayer.new(mark)
            @players[mark] = "Computer #{idx + 1}"
        end
        
        @current_player = @players.keys.first
        @board = Board.new(size)
    end

    def computer_marks(marks)
        marks.select { |mark, bool| bool }
    end

    def player_marks(marks)
        marks.select { |mark, bool| !bool }
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
                puts "#{"\n" * 15}"
                board.print
                puts "\n #{" " * 2}#{player_name}'s Turn to Move\n#{" " * 7}Its Sign is #{current_player.mark}\n "
                
                position = current_player.get_position(board.legal_positions)
                @board.place_mark(position, current_player.mark)
                puts "\n#{" " * 3}Press Enter to Continue\n "
                gets
            else
                puts "#{"\n" * 15}"
                board.print
                puts "\n #{" " * 4}Make a Move #{player_name}\n#{" " * 7}Your Sign is #{current_player.mark}\n\n "

                begin
                    position = current_player.get_position
                    @board.place_mark(position, current_player.mark)
                rescue => error
                    gets
                end
            end

            if board.win?(current_player.mark)
                puts "#{"\n" * 30}#{" " * 9}GAME OVER!"
                board.print
                puts "\n#{" " * 6}#{player_name} VICTORY!\n "
                return
            elsif board.made_move
                switch_turn
                board.made_move = false
            end
        end
        puts "#{"\n" * 30}#{" " * 9}GAME OVER!"
        board.print
        puts "#{" " * 9}TIE GAME!\n "
    end
end