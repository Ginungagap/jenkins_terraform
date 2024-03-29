#!/bin/bash

sudo yum install git -y 
sudo yum install java-1.8.0-openjdk-devel -y 

sudo sh -c 'cat << EOF >> /usr/lib/systemd/system/carts.service
[Unit]
Description=Start ans Stop jar

[Service]
ExecStart=/usr/bin/java -jar -Ddb:carts-db=mongo-db /home/jenkins/carts.jar
Restart=always
KillMode=control-group
User=jenkins

[Install]
WantedBy=multi-user.target

EOF'

sudo sed -i "s/-Ddb:carts-db=/-Ddb:carts-db=mongo-db/" /usr/lib/systemd/system/carts.service

sudo su <<_EOF_
useradd -m jenkins
mkdir -p /home/jenkins/.ssh
chmod 700 /home/jenkins/.ssh
cat /tmp/jenkins.pub >> /home/jenkins/.ssh/authorized_keys
mv /tmp/jenkins.pub /home/jenkins/.ssh/
chown jenkins:jenkins /home/jenkins/.ssh/ /home/jenkins/.ssh/authorized_keys
chown jenkins:jenkins /usr/lib/systemd/system/carts.service
usermod -a -G adm,video,google-sudoers jenkins
systemctl daemon-reload 
systemctl start carts
systemctl enable carts
exit
_EOF_

echo "Production Server"
echo "All Done"
