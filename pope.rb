# encoding: utf-8

require 'sinatra'

require_relative 'models/init'

get '/' do  
  # @popes = Pope.all
  # erb :home
  erb :frantisek
end

post '/' do
  @pope = Pope.get(params[:id])
  if @pope
    @vote = Vote.create(:email => params[:email], :pope_id => @pope.id)
  end
  erb :voted
end

get '/results' do
  @votes = Vote.all
  erb :results
end

