require 'set'
module UkuleleBoy
  class UkuleleBoy
    attr_reader :word_list
    
    def initialize
    end

    def word_list=(list)
      @original_word_list = Array.new(list)
    end

    def new_game(guesses_left)
      @word_list = Array.new(@original_word_list)
      @previous_guesses = []
      @pruned_for_size = false
    end

    def guess(word, guesses_left)
      prune_word_list(word)
      guess = letters.shift
      @previous_guesses << guess
      return guess
    end

    def incorrect_guess(guess)
      @word_list.delete_if{ |word| word.include? guess }
    end

    def correct_guess(guess)
      @word_list.delete_if{ |word| !word.include? guess }
    end

    def fail(reason)
    end

    def game_result(result, word)
    end

    def all_letters_in_word_list
      letter_set = Set.new
      @word_list.each{ |word| letter_set.merge(word.scan(/./)) }
      return letter_set.to_a
    end

    def unguessed_letters
      remaining_letters = all_letters_in_word_list
      @previous_guesses.each{ |letter| remaining_letters.delete(letter) }
      return remaining_letters
    end

    def order_by_frequency(letters)
      most_frequent_letters = ['e', 't', 'a', 'o', 'i', 'n', 's', 'r', 'h', 'l', 'd', 'c']
      most_frequent_letters.delete_if { |letter| !letters.include?(letter) }
      letters.delete_if { |letter| most_frequent_letters.include?(letter) }
      return most_frequent_letters + letters
    end

    def letters
      return order_by_frequency unguessed_letters
    end
    
    def prune_for_size(size)
      @word_list.delete_if{ |word| word.size != size }
    end

    def prune_for_structure(word)
      word.scan(/./).each_with_index do |letter, index|
        next if letter == "_"
        exclude_words_with_wrong_letter_structure(letter, index)
      end
    end

    def prune_word_list(word)
      prune_for_size(word.size) unless @pruned_for_size
      prune_for_structure(word)
    end

    def exclude_words_with_wrong_letter_structure(letter, index)
      @word_list.delete_if{ |word| letter != word[index, 1]}
    end
  end
end
