require 'set'

module UkuleleBoy
  class UkuleleBoy
    # You may initialize you player but the the initialize method must take NO paramters.
    # The player will only be instantiated once, and will play many games.
    def initialize
      @previous_guesses = []
      @excluded_words = [] #trying to delete words causes error
      @pruned_for_size = false
    end

    # Before starting a game, this method will be called to inform the player of all the possible words that may be
    # played.
    def word_list=(list)
      @word_list = list
    end

    # a new game has started.  The number of guesses the player has left is passed in (default 6),
    # in case you want to keep track of it.
    def new_game(guesses_left)
      @previous_guesses = []
      @excluded_words = []
      recompute_possible_letters
    end

    # Each turn your player must make a guess.  The word will be a bunch of underscores, one for each letter in the word.
    # after your first turn, correct guesses will appear in the word parameter.  If the word was "shoes" and you guessed "s",
    # the word parameter would be "s___s", if you then guess 'o', the next turn it would be "s_o_s", and so on.
    # guesses_left is how many guesses you have left before your player is hung.
    def guess(word, guesses_left)
      prune_for_size(word.size) unless @pruned_for_size
      guess = @letters.shift
      @previous_guesses << guess
      return guess
    end

    # notifies you that your last guess was incorrect, and passes your guess back to the method
    def incorrect_guess(guess)
      @word_list.each{ |word| @excluded_words << word if word.include? guess }
      recompute_possible_letters
    end

    # notifies you that your last guess was correct, and passes your guess back to the method
    def correct_guess(guess)
      @word_list.each{ |word| @excluded_words << word unless word.include? guess }
      recompute_possible_letters
    end

    # you lost the game.  The reason is in the reason parameter
    def fail(reason)
    end

    # The result of the game, it'll be one of 'win', 'loss', or 'fail'.
    # The spelled out word will be provided regardless of the result.
    def game_result(result, word)
    end

    def all_letters_in_word_list
      letter_set = Set.new
      remaining_words.each do |word|
        word.scan(/./).each { |a| letter_set << a }
      end
      return letter_set.to_a
    end

    def unguessed_letters
      remaining_letters = all_letters_in_word_list
      @previous_guesses.each{ |letter| remaining_letters.delete(letter) }
      return remaining_letters
    end

    def remaining_words
      return Set.new(@word_list).subtract(@excluded_words).to_a
    end

    def order_by_frequency(letters)
      most_frequent_letters = ['e', 't', 'a', 'o', 'i', 'n', 's', 'r', 'h', 'l', 'd', 'c']
  
      unordered = letters
      ordered = []
      most_frequent_letters.each do |letter|
        if unordered.include?(letter)
          unordered.delete(letter)
          ordered << letter
        end
      end
      return ordered + unordered
    end

    def recompute_possible_letters
      @letters = order_by_frequency unguessed_letters
    end
    
    def prune_for_size(size)
      @word_list.each{ |word| @excluded_words << word unless word.size == size }
    end

  end
end
