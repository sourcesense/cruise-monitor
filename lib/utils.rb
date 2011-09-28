require 'fileutils'

module CruiseMonitor
  module Utils

    def Utils.read_from(path)
      File.open(path){ |f| f.read }
    end
  
    def Utils.write_to(file, content)
      File.open(file, 'w') {|f| f.write(content) }
    end
  
    def Utils.delete_if_exists(path)
      File.delete(path) if File.exists?(path)
    end
  
    def Utils.create_if_missing(path)
      FileUtils.touch(path) unless File.exists?(path)
    end
  
    def Utils.write_content(path, content)
      File.open(path, 'w') {|f| f.write(content) }
    end
  end
end