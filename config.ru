require 'sinatra'
 
set :environment, :production
disable :run
 
require File.join(File.dirname(__FILE__), 'pope')
run Sinatra::Application