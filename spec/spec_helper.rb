require 'simplecov'
SimpleCov.start
require 'pg'
require 'figaro'

Figaro.application = Figaro::Application.new(environment: "test", path: "config/application.yml")
Figaro.load

require 'twitter_cli'
