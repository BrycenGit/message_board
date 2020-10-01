require 'rspec'
require 'board'

describe '#Board' do
  before(:each) do
    Board.clear()
  end

  describe ('.all') do
    it ("returns an empty array when there are no boards") do
      expect(Board.all).to(eq([1]))
    end
  end
end