class Code
  POSSIBLE_PEGS = {
      "R" => :red,
      "G" => :green,
      "B" => :blue,
      "Y" => :yellow
  }

  def self.valid_pegs?(array)
    array.all? { |ele| POSSIBLE_PEGS.keys.include?(ele.upcase) }
  end

  def self.random(length)
    array = []
    length.times { array << POSSIBLE_PEGS.keys.sample }
    Code.new(array)
  end

  def self.from_string(string)
    Code.new(string.chars)
  end

  attr_reader :pegs

  def initialize(array)
    @pegs = []
    if Code.valid_pegs?(array)
      array.each { |ele| @pegs << ele.upcase }
    else
      raise 'Invalid Pegs'
    end
  end

  def [](index)
    pegs[index]
  end

  def length
    pegs.length
  end

  def num_exact_matches(guess)
    count = 0
    guess.pegs.each_with_index { |peg, idx| count += 1 if guess[idx] == pegs[idx] }
    count
  end

  def num_near_matches(guess)
    count_hash = Hash.new { |hash, key| hash[key] = 0 }

    guess_without_matches = []
    
    without_exact_matches = self.pegs.map.with_index do |peg, idx|
      if peg == guess.pegs[idx]
        guess_without_matches << "--"
        "-"
      else
        guess_without_matches << guess.pegs[idx]
        peg
      end
    end

    without_exact_matches.each_with_index do |peg, idx|
      if guess_without_matches.include?(peg) && without_exact_matches[idx] != guess_without_matches[idx]
        count_hash[peg] += 1
      end
    end

    count_hash.keys.count
  end

  def ==(arg)
    arg.pegs == pegs
  end
end