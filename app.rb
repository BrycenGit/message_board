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
  @boards = Board.all
  erb(:boards)
end

get('/boards/:id') do
  @board = Board.find(params[:id].to_i)
  erb(:board)
end

post('/boards') do
  @title = params[:board_name]
  @board = Board.new({:title => "#{@title}", :date => nil, :id => nil})
  @board.save
  @boards = Board.all
  erb(:boards)
end

post('/boards/:id/messages') do
  @board = Board.find(params[:id].to_i)
  @title = params[:message_name]
  @body = params[:message_body]
  @message = Message.new({:title => "#{@title}", :body => "#{@body}", :board_id => ("#{@board.id}").to_i, :time => nil, :id => nil})
  @message.save
  @messages = Message.all
  erb(:board)
end