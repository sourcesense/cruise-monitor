require 'gserver'
require 'tmpdir'

module CruiseMonitor
  class FeedServer < GServer

      TEMPLATE =  
"HTTP/1.1 200 OK
Date: Mon, 23 May 2005 22:38:34 GMT
Server: Apache/1.3.3.7 (Unix)  (Red-Hat/Linux)
Last-Modified: Wed, 08 Jan 2003 23:11:55 GMT
Accept-Ranges: bytes
Content-Length: @CONTENT-LENGTH@
Connection: close
Content-Type: text/html; charset=UTF-8


"

      def initialize(port)
        super(port)
        @feed_path = Dir.tmpdir
      end
    
      def prepare(path)
        @feed_path = path
      end

      def serve(io)
       loop do
        content = Utils.read_from(@feed_path)
        headers = TEMPLATE.gsub("@CONTENT-LENGTH@", "#{content.size}")

        io.puts("#{headers}#{content}")
       end
      end
  end
end