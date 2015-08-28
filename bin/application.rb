#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), "..", "lib")))
require "twitter_cli"
require 'figaro'

Figaro.application = Figaro::Application.new(environment: "development", path: "config/application.yml")
Figaro.load

cli = TwitterCli::Cli.new
cli.run
