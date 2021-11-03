#!/bin/bash
apt update
apt -y install apache2

cat <<EOF > /var/www/html/index.html
<html>
<h2>Build by Terraform <br>
Owner ${owner}<br>

%{ for x in string_list ~}
this is ${x}<br>
%{ endfor ~}
</html>
EOF

service apache2 start