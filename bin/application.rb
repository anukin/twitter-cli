#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), "..", "lib")))
require "twitter_cli"

cli = TwitterCli::Cli.new
cli.infinite_input
