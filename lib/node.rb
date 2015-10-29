class Node
  attr_reader :value, :links
  attr_accessor :valid, :select_score

  def initialize(value = '')
    @value = value
    @valid = false
    @links = {}
    @select_score = 0
  end

  def insert(string, char = 0)
    letter = string[char]
    create_link(string, letter, char)
    mark_word_or_make_new_link(string, letter, char)
  end

  def create_link(string, letter, char)
    if no_link(letter)
      links[letter] = Node.new(string[0..char])
    else
      false
    end
  end

  def mark_word_or_make_new_link(string, letter, char)
    if string.length == char + 1
      links[letter].valid = true
    else
      links[letter].insert(string, char + 1)
    end
  end

  def no_link(letter)
    links[letter].nil?
  end

  def search(string, char = 0)
    letter = string[char]
    if string.length == char + 1
      return links[letter]
    end
    links[letter].search(string, char + 1)
  end

  def real_word?
    @valid
  end

  def suggest_words_and_select_scores
    if no_links_invalid
      nil
    end
    suggestions = []
    if real_word? == true
      suggestions.concat(value_and_select_score_pair)
    end
    suggestions << links.keys.map { |key| links[key].suggest_words_and_select_scores }
    suggestions.flatten
  end

  def select(selection)
    search(selection).select_score += 1
  end

  def value_and_select_score_pair
    [value, select_score]
  end

  def count_valid
    return 0 if no_links_invalid
    count = 0
    count += 1 if valid
    links.each_key { |key| count += links[key].count_valid }
    return count
  end

  def suggest(string)
    suggestions = search(string).suggest_words_and_select_scores
    format_sort(suggestions)
  end

  def format_sort(suggestions)
    suggestions = pair_word_and_score(suggestions)
    format_and_sort_suggested_words(suggestions)
  end

  def pair_word_and_score(arr)
    arr.each_slice(2).to_a
  end

  def format_and_sort_suggested_words(list)
    list = list.sort_by { |key, count| count }.reverse
    list.collect { |index| index[0] }
  end

  def no_links_invalid
    links.empty? && (valid == false)
  end

end
