module CruiseMonitor
  class Notifier
  
    def warn(build_info)
      say("build broken for #{build_info.project}!")
    end
  
    def success(build_info)
      say("#{build_info.server} is happy with #{build_info.project}!")
    end
  
  protected

    def say(message)
      system "say \"#{message}\""
    end
  
  end
end