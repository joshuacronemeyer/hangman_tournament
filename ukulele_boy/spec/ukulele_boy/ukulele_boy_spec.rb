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
    player.word_list.size.should == 2
    player.unguessed_letters.size.should == 26
  end

  it "should know the set of possible letters" do
    player = UkuleleBoy::UkuleleBoy.new
    player.word_list = ["word"]
    player.new_game(6)
    player.guess("____", 6)
    player.unguessed_letters.should == ["r", "d", "w"]
  end

  it "should make unguessed letters list smaller with each guess" do
    player = UkuleleBoy::UkuleleBoy.new
    player.word_list = ["word"]
    player.new_game(6)
    player.guess("____", 6)
    player.unguessed_letters.size.should == 3
  end

  it "guessing o should make man impossible" do
    player = UkuleleBoy::UkuleleBoy.new
    player.word_list = ["man", "boy"]
    player.new_game(6)
    player.guess("_o_", 5)
    player.word_list.should == ["boy"]
  end

  it "guessing a incorrectly should make man impossible" do
    player = UkuleleBoy::UkuleleBoy.new
    player.word_list = ["man", "boy"]
    player.new_game(6)
    guess = player.guess("___", 5)
    guess.should == "a"
    player.incorrect_guess(guess)
    player.word_list.should == ["boy"]
  end

  it "should guess letters according to frequency used" do
    player = UkuleleBoy::UkuleleBoy.new
    player.word_list = ["et", "qz"]
    player.new_game(6)
    guess = player.guess("__", 5)
    guess.should == "e"
    player.incorrect_guess(guess)
    guess = player.guess("__", 4)
    guess.should == "q"
    player.correct_guess(guess)
    guess = player.guess("q_", 4)
    guess.should == "z"
  end

  it "should prune all words when all wrong size" do
    player = UkuleleBoy::UkuleleBoy.new
    player.word_list = ["man", "boy", "finally"]
    player.new_game(6)
    player.guess("____", 4)
    player.word_list.should == []
  end

  it "should prune words for word size when some are right" do
    player = UkuleleBoy::UkuleleBoy.new
    player.word_list = ["man", "boy", "finally"]
    player.new_game(6)
    player.guess("___", 4)
    player.word_list.should == ["man", "boy"]
  end

  it "should prune all words when none match letter position" do
    player = UkuleleBoy::UkuleleBoy.new
    player.word_list = ["man", "boy", "sim"]
    player.new_game(6)
    player.guess("__x", 4)
    player.word_list.should == []
  end

  it "should prune no words when all match letter position" do
    player = UkuleleBoy::UkuleleBoy.new
    player.word_list = ["man", "can", "tan"]
    player.new_game(6)
    player.guess("_an", 4)
    player.word_list.should == ["man", "can", "tan"]
  end

  it "should prune some words when some match letter position" do
    player = UkuleleBoy::UkuleleBoy.new
    player.word_list = ["man", "foo", "tan"]
    player.new_game(6)
    player.guess("f__", 4)
    player.word_list.should == ["foo"]
  end

end
