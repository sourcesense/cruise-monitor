require 'gserver'

class FeedServer < GServer

    TEMPLATE =  
"HTTP/1.1 200 OK
Date: Mon, 23 May 2005 22:38:34 GMT
Server: Apache/1.3.3.7 (Unix)  (Red-Hat/Linux)
Last-Modified: Wed, 08 Jan 2003 23:11:55 GMT
Accept-Ranges: bytes
Content-Length: 438
Connection: close
Content-Type: text/html; charset=UTF-8


"

    def initialize(port)
      super(port)
      @feed_path = '/tmp/'
    end
    
    def prepare(path)
      @feed_path = path
    end

    def serve(io)
      content = Utils.read_from(@feed_path)
      io.puts("#{TEMPLATE}#{content}")
    end
end
