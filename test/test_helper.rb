# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'bundler/setup'
Bundler.require

require 'hexlet_code'
require 'minitest/autorun'

def fixture(name)
  File.read("./test/fixtures/#{name}.html").strip
end
