require File.dirname(__FILE__) + '/../test_helper'

class BuildInfoTest < Test::Unit::TestCase
  
  def test_should_have_0_as_default_number
    assert_equal "0", BuildInfo.new.number
  end
  
  def test_should_have_succes_as_default_status
    assert_equal "success", BuildInfo.new.status
  end
  
  def test_should_get_server
    build_info = BuildInfo.new("Hudson MyApp 10 success")
    assert_equal "Hudson", build_info.server
  end

  def test_should_use_get_info_as_string
    build_info = BuildInfo.new("Cruise MyApp 10 success")
    assert_equal "Cruise MyApp 10 success", build_info.to_s
  end
  
  def test_should_get_project
    build_info = BuildInfo.new("Cruise MyProject 1 success")
    assert_equal 'MyProject', build_info.project
  end
  
  def test_should_get_number
    build_info = BuildInfo.new("Cruise MyProject 5 success")
    assert_equal '5', build_info.number
  end
  
  def test_should_use_defaults_on_invalid_info
    assert_equal BuildInfo.new.to_s, BuildInfo.new('').to_s
  end
  
end