sudo dnf install bind bind-utils
firewall-cmd --permanent --add-service=dns
sudo systemctl enable --now named


chown named:named /var/named/named.zone
chmod 640 /var/named/named.zone
systemctl restart named