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

 # it "should order the letters by frequency" do
 #   player = UkuleleBoy::UkuleleBoy.new
 #   player.word_list = ["word"]
 #   ordered_letters = player.order_by_frequency(['w', 'o', 'r', 'd'])
 #   ordered_letters.should == ['o', 'r', 'd', 'w']
 # end

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

  it "should prune words for word when all wrong size" do
    player = UkuleleBoy::UkuleleBoy.new
    player.word_list = ["man", "boy", "finally"]
    player.new_game(6)
    player.guess("____", 4)
    player.remaining_words.should == []
  end

  it "should prune words for word size when some are right" do
    player = UkuleleBoy::UkuleleBoy.new
    player.word_list = ["man", "boy", "finally"]
    player.new_game(6)
    player.guess("___", 4)
    player.remaining_words.should == ["boy", "man"]
  end

  it "should prune all words when none match letter position" do
    player = UkuleleBoy::UkuleleBoy.new
    player.word_list = ["man", "boy", "sim"]
    player.new_game(6)
    player.guess("__x", 4)
    player.remaining_words.should == []
  end

  it "should prune no words when all match letter position" do
    player = UkuleleBoy::UkuleleBoy.new
    player.word_list = ["man", "can", "tan"]
    player.new_game(6)
    player.guess("_an", 4)
    player.remaining_words.should == ["tan", "man", "can"]
  end

  it "should prune some words when some match letter position" do
    player = UkuleleBoy::UkuleleBoy.new
    player.word_list = ["man", "foo", "tan"]
    player.new_game(6)
    player.guess("f__", 4)
    player.remaining_words.should == ["foo"]
  end

end
