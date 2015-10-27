require_relative '../lib/node'

class CompleteMe
attr_accessor :head, :word

  def initialize
    head = Node.new
    @count = 0
    @dictionary = []
  end

  def insert(input)
    @dictionary = []
    @dictionary << "#{input.downcase}"
  end

  def select
    #more magic here
    counter += 1
  end

  def suggest
  end

  #don't know if i need a score - but might
  def score
  end

  def populate(file)
    file = file.split("\n")
    @dictionary = []
    @dictionary << file
  end

  def count
    @dictionary.size
  end



end
