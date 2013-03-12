# encoding: utf-8
require 'data_mapper'
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/pope.db") 

require_relative 'pope'
require_relative 'vote'

DataMapper.finalize.auto_upgrade!