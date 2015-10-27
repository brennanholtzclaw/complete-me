require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/complete_me'

class CompleteMeTest < MiniTest::Test

  def test_it_exists
    assert CompleteMe.new
  end

  def test_you_can_insert_a_word
    completion = CompleteMe.new

    completion.insert("pizza")

    assert_equal 1, completion.count
  end

  def test_inserts_multiple_words
    completion = CompleteMe.new
    completion.populate("pizza\ndog\ncat")
    assert_equal 3, completion.count
  end

  def test_it_starts_empty
    skip
    completion = CompleteMe.new

    assert_equal 0, completion.count
  end

  # def test_you_can_insert_two_words
  #   skip
  #   completion = CompleteMe.new
  #
  #   completion.insert("pizza")
  #   completion.insert("calzone")
  #
  #   assert_equal 2, completion.count
  # end

  def test_it_populates_the_dictionary
    completion = CompleteMe.new

    dictionary = File.read("/usr/share/dict/words")
    completion.populate(dictionary)

    assert_equal 235886, completion.count
  end

  def test_it_suggests_a_full_word
    skip
  end

  def test_select_boosts_word
    skip
  end

  def test_select_changes_top_suggestion
    skip
  end


end
