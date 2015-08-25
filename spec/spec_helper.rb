require 'twitter_cli'
require 'pg'
require 'figaro'

Figaro.application = Figaro::Application.new(environment: "test", path: "config/application.yml")
Figaro.load