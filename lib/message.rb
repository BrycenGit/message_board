
class Message
  attr_accessor :title, :body, :time, :id, :board_id 

  @@messages = {}
  @@total_rows = 0
  
  def initialize(attributes)
    @title = attributes.fetch(:title)
    @body = attributes.fetch(:body)
    @board_id = attributes.fetch(:board_id)
    @time = attributes.fetch(:time) || Time.new
    @id = attributes.fetch(:id) || @@total_rows += 1
  end

  def self.all
    @@messages.values()
  end

  def time_stamp
    "#{self.time.month}/#{self.time.day}/#{self.time.year}"
  end

  def save
    @@messages[self.id] = Message.new({:title => self.title, :body => self.body, :board_id => self.board_id, :time => self.time, :id => self.id})
  end

  def ==(message_to_compare)
    self.title == message_to_compare.title() && self.id == message_to_compare.id && self.body == message_to_compare.body
  end

  def self.clear
    @@messages = {}
    @@total_rows = 0
  end

  def self.find (id)
    @@messages[id]
  end

  def update_title(new_title)
    @title = new_title
  end

  def delete
    @@messages.delete(self.id)
  end

  def self.search(title)
    results = []
    @@messages.values.each do |message|
      if message.title.match?(/#{title}/i)
        results << message 
      end
    end
    results
  end

  def self.sort_date
    @@messages.values.sort_by(&:time)
  end

  def Board
    Board.find(self.board_id)
  end

  def self.find_by_board(id)
    messages = []
    @@messages.values.each do |message|
      if message.board_id == id
        messages.push(message)
      end
    end
    messages
  end
end
