build_server='www.cruise-monitor.tk'
ec2_key="$HOME/.ec2/build.pem"

if [ ! -e $ec2_key ]; then
	echo "Please, verify EC2 credentials are stored as $ec2_key file."
	echo "Exiting."
	exit 1
fi

ssh -i "$ec2_key" "ubuntu@$build_server" 'bash -s' < $1
