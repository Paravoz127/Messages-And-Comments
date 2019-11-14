require 'sinatra'
require 'pg'
require "./models/message.rb"
require "./models/comment.rb"
require 'pry'

get '/messages' do
  @messages = Message.all

  erb :index
end

get '/message/:id' do
  id = params[:id]

  @message = Message.by_id(id)
  @comments = Comment.all_by_message(id)
  erb :message
end

get '/message/:mes/delete/:id' do
  id = params[:id]
  message = params[:mes]

  Comment.delete(id)

  redirect to("/message/#{message}")
end

post '/messages' do
  Message.new(params)
  redirect to("/messages")
end

post '/message' do
  id = params[:message]
  Comment.new(params)
  redirect to("/message/#{id}")
end

get '/message/delete/:id' do
  id = params[:id]

  Message.delete(id)

  redirect to("/messages")
end