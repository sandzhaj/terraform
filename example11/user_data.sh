#!/bin/bash
apt update
apt -y install apache2

myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`

cat <<EOF > /var/www/html/index.html
<html>
<h2>Build by Terraform</h2><br>
Server PrivateIP: $myip<br>

</html>
EOF

service apache2 start