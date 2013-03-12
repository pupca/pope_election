# encoding: utf-8
class Pope  
  include DataMapper::Resource  
  property :id, Serial  
  property :name, Text, :required => true  
  property :title, Text, :required => true
  property :born, Text, :required => true
end