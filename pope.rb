require 'rubygems' 
require 'sinatra'  
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/pope.db") 

class Pope  
  include DataMapper::Resource  
  property :id, Serial  
  property :name, Text, :required => true  
  property :title, Text, :required => true
  property :born, Text, :required => true
end

class Vote
  include DataMapper::Resource
  property :id, Serial
  property :pope_id, Integer, :required => true
  property :email, Text, :required => true
  belongs_to :pope
end
  
DataMapper.finalize.auto_upgrade!

get '/' do  
  @popes = Pope.all
  erb :home
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