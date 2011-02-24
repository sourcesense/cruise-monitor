class StubServer
  attr_accessor :status, :new_build_performed, :was_failed
  attr_accessor :has_checked_for_build, :build_info
  
  def initialize
    @new_build_performed = true
  end
  
  def status
    @status
  end
  
  def check_build
    @has_checked_for_build = true
  end
  
  def new_build_performed?
    @new_build_performed
  end
    
end