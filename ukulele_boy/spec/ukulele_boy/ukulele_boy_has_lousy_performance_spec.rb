require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'ukulele_boy/ukulele_boy'

describe UkuleleBoy::UkuleleBoy do
  
  WORDS = ["SHAKESPEARE", "WAS", "BORN", "RAISED", "MARRIED", "ANNE", "HATHAWAY", "THREE", "CHILDREN", "SUSANNA", "TWINS", "HAMNET", "JUDITH", "BETWEEN", "BEGAN", "SUCCESSFUL", "CAREER", "LONDON", "WRITER", "PART", "OWNER", "PLAYING", "COMPANY", "CALLED", "LORD", "CHAMBERLAIN", "LATER", "KNOWN", "THE", "KING", "HAVE", "RETIRED", "STRATFORD", "AROUND", "PRIVATE", "CONSIDERABLE", "SPECULATION", "ABOUT", "SUCH", "MATTERS", "APPEARANCE", "SEXUALITY", "RELIGIOUS", "BELIEFS", "PRODUCED", "EARLY", "PLAYS", "WERE", "MAINLY", "COMEDIES", "HISTORIES", "GENRES", "RAISED", "SOPHISTICATION", "ARTISTRY", "SIXTEENTH", "CENTURY", "TRAGEDIES", "INCLUDING", "HAMLET", "KING", "LEAR", "MACBETH", "CONSIDERED", "TRAGICOMEDIES", "KNOWN", "ROMANCES", "COLLABORATED", "WITH", "OTHER", "PLAYWRIGHTS", "RESPECTED", "PLAYWRIGHT", "NINETEENTH", "ROMANTICS", "PARTICULAR", "ACCLAIMED", "GENIUS", "VICTORIANS", "WORSHIPPED", "REVERENCE", "GEORGE", "BERNARD", "SHAW", "CALLED,TWENTIETH", "CENTURY", "REPEATEDLY", "ADOPTED", "REDISCOVERED", "MOVEMENTS", "SCHOLARSHIP", "PERFORMANCE", "CONSTANTLY", "STUDIED", "PERFORMED", "REINTERPRETED", "DIVERSE", "CULTURAL", "POLITICAL", "CONTEXTS", "THROUGHOUT"]
 
 WORDS_WORDS_WORDS = WORDS + WORDS + WORDS + WORDS + WORDS + WORDS 

  it "should not be slow in gameplay lifecycle" do
    start = Time.now
    player = UkuleleBoy::UkuleleBoy.new
    player.word_list = WORDS_WORDS_WORDS
    player.new_game(6)
    guess = player.guess("________S", 6)
    player.incorrect_guess(guess)
    elapsed_time = Time.now - start
    elapsed_time.should < 0.002
  end
end
