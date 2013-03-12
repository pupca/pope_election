# encoding: utf-8
class Vote
  include DataMapper::Resource
  property :id, Serial
  property :pope_id, Integer, :required => true
  property :email, Text, :required => true
  belongs_to :pope
end