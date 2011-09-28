require File.dirname(__FILE__) + '/../test_helper'
require 'tmpdir'

module CruiseMonitor
  class StorageTest < Test::Unit::TestCase
  
    STORAGE_TXT = Dir.tmpdir + '/storage.txt'
  
    def setup
      Utils.delete_if_exists(STORAGE_TXT)
      @storage = Storage.new(STORAGE_TXT)
    end
  
    def teardown
      Utils.delete_if_exists(STORAGE_TXT)
    end
  
    def test_should_write_content
      Utils.write_to(STORAGE_TXT, "something")
    
      assert_equal 'something', @storage.read
    end
  
    def test_should_create_file_on_first_access
      assert_equal '', @storage.read
    end
  
    def test_should_write_content_with_trailing_newline
      @storage.write('done.')
    
      assert_equal "done.\n", Utils.read_from(STORAGE_TXT)
    end
  
  end
end