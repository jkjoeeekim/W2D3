require_relative "code"

class Mastermind
    def initialize(length)
        @secret_code = Code.random(length)
    end

    def print_matches(instance)
        puts @secret_code.num_exact_matches(instance)
        puts @secret_code.num_near_matches(instance)
    end

    def ask_user_for_guess
        puts "Enter a code"
        guess = gets.chomp
        new_instance = Code.from_string(guess)
        self.print_matches(new_instance)
        @secret_code == new_instance # they are both instances! compare them
    #      print "Enter a code"
    # guessed_code = Code.from_string(gets.chomp)
    # self.print_matches(guessed_code)
    # @secret_code == guessed_code
    end
end
