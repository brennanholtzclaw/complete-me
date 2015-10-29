# require 'minitest/autorun'
# require 'minitest/pride'
require_relative "../lib/complete_me"

class CompleteMeTest < MiniTest::Test

  def test_it_exists
    assert CompleteMe.new
  end

  def test_it_starts_empty
    completion = CompleteMe.new
    assert_equal 0, completion.count
  end

  def test_you_can_insert_a_word
    completion = CompleteMe.new
    completion.insert("pizza")
    assert_equal 1, completion.count
  end

  def test_you_can_insert_two_words
    completion = CompleteMe.new
    completion.insert("pizza")
    completion.insert("calzone")
    assert_equal 2, completion.count
  end

  def test_inserts_multiple_words
    completion = CompleteMe.new
    completion.populate("pizza\ncalzone\nhotpocket")
    assert_equal 3, completion.count
  end

  def test_it_populates_the_dictionary
    skip
    completion = CompleteMe.new
    dictionary = File.read("/usr/share/dict/words")
    completion.populate(dictionary)
    assert_equal 235886, completion.count
  end

  def test_it_suggests_a_full_word_in_small_set
    completion = CompleteMe.new
    completion.populate("pizza\ncalzone\nhotpocket")
    assert_equal ["pizza"], completion.suggest("pi")
    refute_equal ["calzone"], completion.suggest("pi")
  end

  def test_select_boosts_word
    completion = CompleteMe.new
    completion.populate("pizza\npet\ncalzone\nhotpocket")
    assert_equal ["pizza"], completion.suggest("pi")
    completion.select("p", "pizza")
    assert_equal ["pizza", "pet"], completion.suggest("p")
    refute_equal ["calzone"], completion.suggest("pi")
  end

end
