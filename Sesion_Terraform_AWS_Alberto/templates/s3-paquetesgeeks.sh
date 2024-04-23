sudo yum install -y amazon-linux-extras
sudo amazon-linux-extras install -y epel
sudo yum -y install s3fs-fuse
sudo mkdir -p /home/ec2-user/.aws
sudo mkdir -p /root/.aws
sudo echo "[default]" | sudo tee -a /root/.aws/credentials > /dev/null
sudo echo "aws_access_key_id=ddfdfdf" | sudo tee -a /root/.aws/credentials > /dev/null
sudo echo "aws_secret_access_key=dfdfdfdC" | sudo tee -a /root/.aws/credentials > /dev/null
sudo echo "[default]" | sudo tee -a /home/ec2-user/.aws/credentials > /dev/null
sudo echo "aws_access_key_id=dddd5" | sudo tee -a /home/ec2-user/.aws/credentials > /dev/null
sudo echo "aws_secret_access_key=ddfdfd" | sudo tee -a /home/ec2-user/.aws/credentials > /dev/null
sudo mkdir -p /mnt/s3
sudo s3fs datos-private-my-geeks /mnt/s3/
