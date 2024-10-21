Openshift 4.15+ on RHEL 9 Stigged + fips enabled (either durring [install](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/security_hardening/switching-rhel-to-fips-mode_security-hardening#proc_installing-the-system-with-fips-mode-enabled_switching-rhel-to-fips-mode) or [enabled](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/security_hardening/switching-rhel-to-fips-mode_security-hardening#switching-the-system-to-fips-mode_using-the-system-wide-cryptographic-policies) post install)

Allow regular user to run ansbile-playbooks, create a new file /etc/fapolicyd/rules.d/22-ansible.rules:
```
allow perm=any uid=1000 : dir=/home/user/.ansible
allow perm=any uid=1000 : dir=/home/user/.cache/agent
allow perm=any uid=1000 : dir=/usr/share/git-core/templates/hooks
allow perm=any uid=1000 : dir=/pods
allow perm=any uid=1000 : dir=/usr/bin
allow perm=any uid=0,1000 : dir=/tmp
```

Increase the number of namespaces, to allow registry pod to run as user. Modify /etc/sysctl.conf

Need to test smaller number than 10
```
# Per CCE-83956-3: Set user.max_user_namespaces = 0 in /etc/sysctl.conf
user.max_user_namespaces = 0
```
to
```
# Per CCE-83956-3: Set user.max_user_namespaces = 0 in /etc/sysctl.conf
user.max_user_namespaces = 10
```

Need to figure out how to get content to Disconnected machine. I was testing with mass storage device and had the following on my test kickstart in `%post` portion:
```
systemctl disable usbguard
sed -i 's/black/\#black/g' /etc/modprobe.d/usb-storage.conf
sed -i 's/install/\#install/g' /etc/modprobe.d/usb-storage.conf
```

This allowed me to access the USB device after 1st boot. 