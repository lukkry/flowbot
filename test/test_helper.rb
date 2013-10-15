$:.unshift File.dirname(File.expand_path("./lib/flowbot"))

require 'minitest/autorun'
require 'webmock/minitest'
require "mocha/setup"

require "minitest/reporters"
Minitest::Reporters.use!
