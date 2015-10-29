require_relative 'node'

class CompleteMe
  attr_reader :count, :root

  def initialize
    @root = Node.new
    @count = 0
  end

  def insert(word)
    root.insert(word.downcase)
    @count += 1
  end

  def populate(list)
    word_list = list.split("\n")
    word_list.each { |word| root.insert(word) }
    @count = root.count_valid
  end

  def suggest(string)
    root.suggest(string)
  end

  def select(input, selection)
    root.select(selection)
  end

end
