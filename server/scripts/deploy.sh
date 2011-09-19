sudo /etc/init.d/apache2 stop
sudo rm -f /etc/apache2/sites-available
cd /home/ubuntu/cruise-monitor
git pull
sudo ln -s /home/ubuntu/cruise-monitor/server/config/etc/apache2/sites-available /etc/apache2/sites-available
sudo /etc/init.d/apache2 start
