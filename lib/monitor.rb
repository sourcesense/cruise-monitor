module CruiseMonitor
  class Monitor
    attr_accessor :enthusiast
  
    def Monitor.all_builds_on(server, notifier = Notifier.new)
      Monitor.new(server, notifier, true)
    end
  
    def Monitor.failures_on(server, notifier = Notifier.new)
      Monitor.new(server, notifier)
    end
  
    def initialize(server, notifier, enthusiast = false)
      @server = server
      @notifier = notifier
      @enthusiast = enthusiast
    end
  
    def sync
      @server.check_build
    
      if :failed == @server.status
        @notifier.warn(@server.build_info)
      else
        @notifier.success(@server.build_info) if should_notify_success?
      end
    end
    
    def storage_path
      @server.storage_path
    end
  
  private

    def should_notify_success?
      build_is_back_to_clean? or a_new_success_to_notify?
    end
  
    def build_is_back_to_clean?
      @server.new_build_performed? and @server.was_failed
    end
  
    def a_new_success_to_notify?
      @server.new_build_performed? and @enthusiast
    end
  
  end
end