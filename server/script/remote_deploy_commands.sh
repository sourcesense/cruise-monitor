#!/bin/bash

apache='/etc/init.d/apache2'
sites_available='/etc/apache2/sites-available'
home='/home/ubuntu'
cruise_home="$home/cruise-monitor"

echo "Stopping Apache.."
sudo $apache stop

echo "Updating sources.."
rm -rf $cruise_home
cd
git clone https://github.com/sourcesense/cruise-monitor.git

echo "Removing old configuration.."
sudo rm -f $sites_available

echo "Setting new configuration.."
sudo ln -s $cruise_home/server/config$sites_available $sites_available

echo "Starting Apache.."
sudo $apache start

echo "Done."
