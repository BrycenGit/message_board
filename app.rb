require('sinatra')
require('sinatra/reloader')
require('./lib/board')
require('./lib/message')
also_reload('lib/**/*.rb')

get('/') do
  @boards = Board.all
  erb(:boards)
end


get('/boards') do
  if params[:newest]
    @boards = Board.sort_date
  elsif params[:oldest]
    @boards = Board.sort_date.reverse
  else
    @boards = Board.all
  end
  erb(:boards)
end


get('/boards/:id') do
  if params[:newest]
    @board = Board.find(params[:id].to_i)
    @messages = Message.sort_date
  elsif params[:oldest]
    @board = Board.find(params[:id].to_i)
    @messages = Message.sort_date.reverse
  else
    @board = Board.find(params[:id].to_i)
    @messages = Message.all
  end
  erb(:board)
end

post('/boards') do
  @title = params[:board_name]
  @board = Board.new({:title => "#{@title}", :date => nil, :id => nil})
  @board.save
  @boards = Board.all
  erb(:boards)
end

post('/boards/:id') do
  @board = Board.find(params[:id].to_i)
  @title = params[:message_name]
  @body = params[:message_body]
  @message = Message.new({:title => @title, :body => "#{@body}", :board_id => ("#{@board.id}").to_i, :time => nil, :id => nil})
  @message.save
  @messages = Message.all
  erb(:board)
end

get('/boards/:id/messages/:message_id') do
  @message = Message.find(params[:message_id].to_i)
  @board_id = params[:id]
  erb(:message)
end