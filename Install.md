Here are the install instructions I follow when testing out the automation, same set of instructions for both STIG/Non-stig systems.

# Engineering level install docs

## RHEL9 With FIPS/Stig configurations
Install Red Hat Enterprise linux 9 and register with your account

<ol>

<li> Openshift 4.15+ on RHEL 9 Stigged + fips enabled 

(either durring [install](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/security_hardening/switching-rhel-to-fips-mode_security-hardening#proc_installing-the-system-with-fips-mode-enabled_switching-rhel-to-fips-mode) or [enabled](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/security_hardening/switching-rhel-to-fips-mode_security-hardening#switching-the-system-to-fips-mode_using-the-system-wide-cryptographic-policies) post install)

<li> Allow regular user to run ansbile-playbooks, create a new file /etc/fapolicyd/rules.d/22-ansible.rules:

```
allow perm=any uid=1000 : dir=/home/user/.ansible
allow perm=any uid=1000 : dir=/home/user/.cache/agent
allow perm=any uid=1000 : dir=/usr/share/git-core/templates/hooks
allow perm=any uid=1000 : dir=/pods
allow perm=any uid=1000 : dir=/usr/bin
allow perm=any uid=0,1000 : dir=/tmp
```

<li>Increase the number of namespaces, to allow registry pod to run as user. Modify /etc/sysctl.conf

Need to test smaller number than 5
```
# Per CCE-83956-3: Set user.max_user_namespaces = 0 in /etc/sysctl.conf
user.max_user_namespaces = 0
```
to
```
# Per CCE-83956-3: Set user.max_user_namespaces = 0 in /etc/sysctl.conf
user.max_user_namespaces = 5
```

<li>Need to figure out how to get content to Disconnected machine. I was testing with mass storage device and had the following on my test kickstart in `%post` portion:

```
systemctl disable usbguard
sed -i 's/black/\#black/g' /etc/modprobe.d/usb-storage.conf
sed -i 's/install/\#install/g' /etc/modprobe.d/usb-storage.conf
```

This allowed me to access the USB device after 1st boot. 

These configurations can be done post install, changes to usbguard/sysctl.conf will require a reboot, while fapolicyd will only require restart on the service
</ol>

## Running the automation

Note: content is assumed to be in /pods/content (definable in group_vars/all/cluster-deployment.yml)

Note: It is assumed this is the transferable media when running connected side for a disconnected cluster and disconnected config is /pods/content/ansible
<ol>

<li>pull this repo, 

`git pull https://github.com/cjnovak98/ocp4-disconnected-config`

<li>move into that directory /playbooks

`cd ocp4-disconnected-config/playbooks`

<li> install ansible

`sudo dnf install ansible-core`

<li>run the collection

`ansible-playbook ansible-galaxy.yml` or `./ansible-galaxy.yml`

<li>This play will install the disconnected collection

<li>modify group_vars/all/cluster-deployment.yml for your environment
<ol> 
<li>most likely the following items:
<ol>
<li>common_openshift_dir (where to pulled content will live)

<li>common_connected_cluster ( is the cluster itself connected)

<li>mirror_content_pull_mirror (youll want to set this to true, to pull. And false on disconnected side

<li>common_fips_enabled ( true if stiged/fips )

<li>common_cluster_domain ( Top Level Domain of where cluster will live )

<li>common_ip_space (1st 3 octects of ip space both bastion/cluster will be on)

<li>common_nodes (name, last octect of the nodes ips, and mac of IP )

<li>idracs_user/password

<li>idrac (node name and ip of idrac of the node)
</ol>
</ol>
<li>run the next step (connected or disconnected) either will prompt for Become Password

<ol>
<li>for connected run:

`ansbile-playbook -K gather-content.yml ` or `./gather-content.yml` (connected side of disconnected only)

* make sure you have a valid pull-secret in ~/.docker/config (we have fast fail if this doesn’t exist, can add post-install, just re-run automation)
</ol>

<li>for disconnected/connected clusters run: 

`ansible-playbook -K deploy-cluster` or .`/deploy-cluster`

</ol>

