require 'pry'
class Board
  attr_reader :title, :date, :id
  attr_accessor :title

  @@boards = {}
  @@total_rows = 0

  def initialize (title, date, id)
    @title = title
    @date = date || Time.now
    @id = id || @total_rows += 1
  end

  def self.all
    @@boards.values()
  end

  def save
    @@boards[self.id] = Board.new(self.title, self.date, self.id)
  end

  def ==(board_to_compare)
    self.title == board_to_compare.title() && self.id == board_to_compare.id()
  end

  def self.clear
    @@boards = {}
    @@total_rows = 0
  end

  def self.find (id)
    @@boards[id]
  end

  def update_title(new_title)
    @title = new_title
  end

  def delete
    @@boards.delete(self.id)
  end

  def self.search(title)
    results = []
    @@boards.values.each do |board|
      if board.title.match?(/#{title}/i)
        results << board 
      end
    end
    results
  end


  def self.sort_date
    @@boards.values.sort_by(&:date)
  end
end


