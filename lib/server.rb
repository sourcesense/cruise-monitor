class Server
  
  def initialize(feed, storage)
    @feed = feed
    @storage = storage
    
    start_from(BuildInfo.new(storage.read))
  end
  
  def check_build
    checkpoint_with(@current_info)
    update_current_info_from(@feed)
    update_storage
  end
  
  def build_info
    @current_info
  end
  
  def status
    as_symbol(@current_info.status)
  end
  
  def new_build_performed?
    @current_info.number != @previous_info.number
  end
  
  def was_failed
    :failed == as_symbol(@previous_info.status)
  end
  
private

  def start_from(from)
    @previous_info = from
    @current_info = @previous_info.dup
  end
  
  def update_storage
    @storage.write(@current_info.to_s) if new_build_performed?
  end
  
  def update_current_info_from(feed)
    @current_info.update_from(feed.latest_info)
  end
  
  def checkpoint_with(info)
    @previous_info = info.dup
  end
  
  def as_symbol(string)
    string.intern
  end
  
end