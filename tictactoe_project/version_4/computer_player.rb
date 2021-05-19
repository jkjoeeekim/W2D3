require_relative "./board.rb"

class ComputerPlayer
    attr_reader :mark

    def initialize(mark_value)
        @mark = mark_value
    end

    def get_position(legal_positions)
        move = legal_positions.sample
    end
end