require 'test/unit'

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require File.expand_path(file) }
Dir[File.dirname(__FILE__) + '/doubles/*.rb'].each { |double| require File.expand_path(double) }

def assert_false(value)
  assert !value, 'expected to be false'
end

def assert_contains(what, into)
  assert into.include?(what), "cannot find #{what} in #{into}"
end

def feed_file(name)
  File.expand_path(File.dirname(__FILE__) + "/data/#{name}")
end