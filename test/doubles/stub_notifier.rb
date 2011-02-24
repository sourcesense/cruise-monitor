class StubNotifier
  attr_reader :has_warned, :has_notified_success, :notified_build_info
    
  def warn(build_info)
    @notified_build_info = build_info
    @has_warned = true
  end
  
  def success(build_info)
    @notified_build_info = build_info
    @has_notified_success = true
  end
  
  def any_notification_sent
    @has_notified_success or @has_warned
  end
end