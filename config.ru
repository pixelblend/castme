require 'rubygems'
require 'bundler/setup'

require 'cgi'
require 'mp3info'
require 'sinatra'

require 'web'

set :run, false
set :env, ENV['RACK_ENV']

run Sinatra::Application
