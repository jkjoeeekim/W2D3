begin
    puts "Enter a row between 1 and #{board.board.length}."
    row = gets.chomp.to_i
    if !(1..board.board.length).to_a.include?(row)
        raise StandardError.new("Invalid row, does not exist.")
    end
    puts "Enter a column between 1 and #{board.board.length}."
    col = gets.chomp.to_i
    if !(1..board.board.length).to_a.include?(col)
        raise StandardError.new("Invalid column, does not exist.")
    end
rescue => error
    puts error.message
end