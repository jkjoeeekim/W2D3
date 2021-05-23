class Code
  attr_reader :pegs

  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }
  def self.valid_pegs?(arr)
    arr.all? { |char| POSSIBLE_PEGS.has_key?(char.upcase) }
  end

  def initialize(chars)
    if Code.valid_pegs?(chars)
      @pegs = []
      chars.each { |char| @pegs << char.upcase }
    else
      raise "not a valid peg"
    end
  end

  def self.random(length)
    keys = POSSIBLE_PEGS.keys
    Code.new(Array.new(length, keys.sample))
  end

  def self.from_string(str)
    arr = str.chars
    Code.new(arr)
  end

  def [](pos)
    pegs[pos]
  end

  def length
    pegs.length
  end

  def num_exact_matches(instance)
    count = 0
    instance.pegs.each_with_index { |ele, i| count += 1 if ele == pegs[i] }
    count
  end

  def num_near_matches(instance)
    count = 0
    instance.pegs.each_with_index { |ele, i| count += 1 if pegs.include?(ele)}
    count - num_exact_matches(instance)
  end

  def ==(instance)
    pegs == instance.pegs
  end
end
