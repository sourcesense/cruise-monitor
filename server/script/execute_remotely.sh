build_server='ec2-79-125-72-159.eu-west-1.compute.amazonaws.com'
ec2_key="$HOME/.ec2/build.pem"

if [ ! -e $ec2_key ]; then
	echo "Please, verify EC2 credentials are stored as $ec2_key file."
	echo "Exiting."
	exit 1
fi

ssh -i "$ec2_key" "ubuntu@$build_server" 'bash -s' < $1
