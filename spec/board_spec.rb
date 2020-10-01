require 'rspec'
require 'board'

describe '#Board' do
  before(:each) do
    Board.clear()
    @attribute = {:title => "Groceries", :date => nil, :id => nil, :new => 'hello'}
  end

  describe ('.all') do
    it ("returns an empty array when there are no boards") do
      expect(Board.all).to(eq([]))
    end
  end

  describe ('#save') do
    it("saves a board") do
      board = Board.new({:title => "Groceries", :date => nil, :id => nil})
      board.save()
      expect(Board.all).to(eq([board]))
    end
  end

  describe ('#clear') do
    it("clears a board") do
      board = Board.new(@attribute)
      board.save()
      Board.clear()
      expect(Board.all).to(eq([]))
    end
  end

  describe ('#find') do
    it("finds a board by id") do
      board1 = Board.new({:title => "Groceries", :date => nil, :id => nil})
      board1.save()
      board2 = Board.new({:title => "Blog Post", :date => 'some date', :id => nil})
      board2.save()
      expect(Board.find(2)).to(eq(board2))
    end
  end

  describe ('#==') do
    it("is the same board if it has the same attributes as another board") do
    board1 = Board.new({:title => "Groceries", :date => nil, :id => 1})
    board2 = Board.new({:title => "Groceries", :date => nil, :id => 1})
    expect(board1).to(eq(board1))
    end
  end
end