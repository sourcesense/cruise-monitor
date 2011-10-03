=== What's this?

Cruise-monitor is, well, a monitor to CruiseControl.rb build status, via RSS feed. It uses
MacOS 'say' command for notifications.

It then turned out to be quite good to integrate with other build servers: CruiseControl.rb, 
CruiseControl.NET and Jenkins (formerly known as Hudson) are supported, plans are to support CruiseControl as well (see TODO).

For any additional info and documentation, please refer to:
	https://github.com/sourcesense/cruise-monitor/wiki

=== How to use it:

Cruise-monitor is a ruby script. It requires gem and rake.

First install required gems:
	sudo gem install httpclient nokogiri net-ssh

Please, note that nokogiri requires libxml2 XML library. Refer to this page 
for installation info:
	http://nokogiri.org/tutorials/installing_nokogiri.html

Then, run all tests with:
	rake

Cruise-monitor is shipped with a sample configure script. To init the configuration, run:
	rake init

Then, simply edit SERVER and MONITOR into 'script/config.rb'.

Try to run it:
	rake monitor

Finally, you can schedule a cron job (with crontab -e), like this:

	*/5 * * * * $path_to_cruise_monitor/bin/monitor.sh

where $path_to_cruise_monitor links to the folder you have copied Cruise-monitor into. Don't forget to set
monitor.sh as an executable file, with:

	chmod +x bin/monitor.sh

That's it. Have fun, and keep the build clean!

=== How to deploy:

Cruise-monitor build services currently available are:

	http://cruise.cruise-monitor.tk
	http://jenkins.cruise-monitor.tk

In order to deploy on EC2 instance (update configuration from GitHub sources and restart 
Apache), verify EC2 credential are stored into ~/.ec2/build.pem file. Then run:

	rake deploy

This should be enough.

=== License:

Licensed under the Apache License, Version 2.0. See LICENSE for details.

Copyright 2009 Sourcesense http://www.sourcesense.com

