require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'ukulele_boy/ukulele_boy'

describe UkuleleBoy::UkuleleBoy do

  it "should be instantiable with no paramters" do
    lambda { UkuleleBoy::UkuleleBoy.new }.should_not raise_error
  end

  it "should reset between games" do
    player = UkuleleBoy::UkuleleBoy.new
    player.word_list = ["man", "boy"]
    player.new_game(6)
    player.guess("____", 6)
    player.new_game(6)
    player.remaining_words.size.should == 2
    player.unguessed_letters.size.should == 6
  end

  it "should know the set of possible letters" do
    player = UkuleleBoy::UkuleleBoy.new
    player.word_list = ["word"]
    "word".scan(/./).each do |letter|
      player.all_letters_in_word_list.should include(letter)
    end
  end

  it "should order the letters by frequency" do
    player = UkuleleBoy::UkuleleBoy.new
    player.word_list = ["word"]
    ordered_letters = player.order_by_frequency(['w', 'o', 'r', 'd'])
    ordered_letters.should == ['o', 'r', 'd', 'w']
  end

  it "should preserve used letters when recomputing letters" do
    player = UkuleleBoy::UkuleleBoy.new
    player.word_list = ["word"]
    player.new_game(6)
    player.guess("____", 6)
    player.recompute_possible_letters
    player.unguessed_letters.size.should == 3
  end


  it "selecting a correctly should make boy impossible" do
    player = UkuleleBoy::UkuleleBoy.new
    player.word_list = ["man", "boy"]
    player.correct_guess("a")
    "boy".scan(/./).each do |letter|
      player.unguessed_letters.should_not include(letter)
    end
  end

  it "selecting o correctly should make man impossible" do
    player = UkuleleBoy::UkuleleBoy.new
    player.word_list = ["man", "boy"]
    player.correct_guess("o")
    "man".scan(/./).each do |letter|
      player.unguessed_letters.should_not include(letter)
    end
  end

  it "selecting a incorrectly should make man impossible" do
    player = UkuleleBoy::UkuleleBoy.new
    player.word_list = ["man", "boy"]
    player.incorrect_guess("a")
    "boy".scan(/./).each do |letter|
      player.unguessed_letters.should include(letter)
    end
  end

  it "selecting o incorrectly should make man impossible" do
    player = UkuleleBoy::UkuleleBoy.new
    player.word_list = ["man", "boy"]
    player.incorrect_guess("o")
    "man".scan(/./).each do |letter|
      player.unguessed_letters.should include(letter)
    end
  end

end
