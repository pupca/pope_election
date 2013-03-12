root = ::File.dirname(__FILE__)
require ::File.join( root, 'pope' )
# run Pope.new

#require 'pope'

run Sinatra::Application
