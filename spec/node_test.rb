require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/node'

class NodeTest < Minitest::Test

  def test_node_exists
    assert Node
  end

  def test_node_value_starts_out_empty
    node = Node.new
    assert_equal '', node.value
  end

  def test_node_has_no_links_by_default
    node = Node.new
    expect = {}
    assert_equal expect, node.links
  end

  def test_node_starts_out_invalid
    node = Node.new
    refute node.real_word?
  end

  def test_node_starts_with_score_of_zero
    node = Node.new
    assert_equal 0, node.select_score
  end

  def test_node_can_start_with_single_letter
    node = Node.new("p")
    assert_equal "p", node.value
  end

  def test_node_can_be_recognized_as_real_word
    node = Node.new('hello')
    node.valid = true
    assert node.real_word?
  end

  def test_ignores_empty_string
    skip
    node = Node.new
    node.insert("")
    assert_equal 0, node.links.count
  end

  def test_finds_correct_node
    node = Node.new
    node.insert("pizza")
    assert_equal "pizza", node.search("pizza").value
  end

  def test_returns_only_matches_for_suggestion
    node = Node.new
    node.insert("pizza")
    node.insert("pita")
    node.insert("calzone")
    node.insert("hotpocket")
    assert_equal ["pita", "pizza"], node.suggest("pi")
  end

  def test_search_returns_input_as_match_if_real_word
    node = Node.new
    node.insert("pizza")
    node.insert("calzone")
    node.insert("pizzaria") #misspelled for the test
    assert_equal ["pizzaria", "pizza"], node.suggest("pizza")
  end

  def test_select_score_increases_by_one_when_word_is_selected
    node = Node.new
    node.insert("pizza")
    node.insert("calzone")
    node.insert("hotpocket")
    node.select("pizza")
    assert_equal 1, node.search("pizza").select_score
  end

  def test_suggestions_returned_in_order_of_select_score
    node = Node.new
    node.insert("pizza")
    node.insert("pita")
    node.insert("pizzone")
    node.select("pizza")
    node.select("pizza")
    node.select("pita")
    assert_equal ["pizza", "pita", "pizzone"], node.suggest("pi")
  end

end
