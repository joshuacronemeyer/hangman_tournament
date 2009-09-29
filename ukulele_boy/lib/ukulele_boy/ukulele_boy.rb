require 'set'
module UkuleleBoy
  class UkuleleBoy
    attr_reader :word_list
    attr_reader :unguessed_letters

    def word_list=(list)
      @original_word_list = Array.new(list)
    end

    def new_game(guesses_left)
      @word_list = Array.new(@original_word_list)
      @unguessed_letters = ['e', 't', 'a', 'o', 'i', 'n', 's', 'r', 'h', 'l', 'd', 'c', 'u', 'm', 'w', 'f', 'g', 'y', 'p', 'b', 'v', 'k', 'j', 'x', 'q', 'z']
      @pruned_for_size = false
    end

    def guess(word, guesses_left)
      prune_word_list(word)
      prune_letters_not_in_word_list
      return @unguessed_letters.shift
    end

    def incorrect_guess(guess)
      @word_list.delete_if{ |word| word.include? guess }
    end

    def correct_guess(guess)
    end

    def fail(reason)
    end

    def game_result(result, word)
    end

    def prune_letters_not_in_word_list
      (Set.new(@unguessed_letters) - all_letters_in_word_list).each{ |letter| @unguessed_letters.delete(letter) }
    end

    def all_letters_in_word_list
      letter_set = Set.new
      @word_list.each{ |word| letter_set.merge(word.scan(/./)) }
      return letter_set
    end

    def prune_for_size(size)
      @word_list.delete_if{ |word| word.size != size }
    end

    def prune_for_structure(word)
      word.scan(/./).each_with_index do |letter, index|
        exclude_words_with_wrong_letter_structure(letter, index)
      end
    end

    def prune_word_list(word)
      prune_for_size(word.size) unless @pruned_for_size
      prune_for_structure(word)
    end

    def exclude_words_with_wrong_letter_structure(letter, index)
      @word_list.delete_if{ |word| letter != "_" && letter != word[index, 1]}
    end
  end
end
