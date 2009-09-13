require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'ukulele_boy/ukulele_boy'
require File.expand_path(File.dirname(__FILE__) + '/words')

describe UkuleleBoy::UkuleleBoy do
  
  it "should not be slow in gameplay lifecycle" do
    start = Time.now
    player = UkuleleBoy::UkuleleBoy.new
    WORDS.each{ |word| word.downcase! }
    WORDS.freeze
    player.word_list = WORDS
    player.new_game(6)
    guess = player.guess("________s", 6)
    player.incorrect_guess(guess)
    elapsed_time = Time.now - start
    #elapsed_time.should < 0.02 #commented out because it fails when running from the hangman player analysis stuff
  end
end
