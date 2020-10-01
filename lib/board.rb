require 'pry'
class Board
  attr_reader :title, :date, :id
  attr_accessor :title

  @@boards = {}
  @@total_rows = 0

  def initialize (attributes)
    @title = attributes.fetch(:title)
    @date = attributes.fetch(:date) || Time.now
    @id = attributes.fetch(:id) || @@total_rows += 1
  end

  def self.all
    @@boards.values()
  end

  def save
    @@boards[self.id] = Board.new({:title => self.title, :date => self.date, :id => self.id})
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

  def message
    Message.find_by_board(self.id)
  end  
end


