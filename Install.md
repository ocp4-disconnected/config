# Red Hat OpenShift Installation Guide

This guide covers the process for installing Red Hat OpenShift 4.15+ on Red Hat Enterprise Linux 9 with options for FIPS and STIG configurations. The instructions support deployment on both connected and disconnected environments.

## Prerequisites

- **RHEL 9 Installation**: Install Red Hat Enterprise Linux 9 and register it with your Red Hat account.
- **Environment Configurations**:

  > **NOTE:** These configurations can be done post install. Changes to usbguard/sysctl.conf will require a reboot, while fapolicyd will only require restart on the service.

  1. Ensure **FIPS** mode is enabled for RHEL 9.
      - [Enable FIPS during installation](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/security_hardening/switching-rhel-to-fips-mode_security-hardening#proc_installing-the-system-with-fips-mode-enabled_switching-rhel-to-fips-mode); or
     - [Enable FIPS post-installation](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/security_hardening/switching-rhel-to-fips-mode_security-hardening#switching-the-system-to-fips-mode_using-the-system-wide-cryptographic-policies)
  2. Configure **STIG** compliance as needed
  3. Configure **fapolicyd** for Ansible Playbooks:
      - Allow regular users to run Ansible playbooks by creating a new file at `/etc/fapolicyd/rules.d/22-ansible.rules` with the following contents:
        ```plaintext
        allow perm=any uid=1000 : dir=/home/user/.ansible
        allow perm=any uid=1000 : dir=/home/user/.cache/agent
        allow perm=any uid=1000 : dir=/usr/share/git-core/templates/hooks
        allow perm=any uid=1000 : dir=/pods
        allow perm=any uid=1000 : dir=/usr/bin
        allow perm=any uid=0,1000 : dir=/tmp
        ```

  4. Adjust User Namespace Limits for Registry Pod:
     - Increase the `user.max_user_namespaces` setting to enable the registry pod to run as a non-root user. Update `/etc/sysctl.conf` as follows:
        ```plaintext
        # Per CCE-83956-3: Set user.max_user_namespaces = 0 in /etc/sysctl.conf
        user.max_user_namespaces = 5
        ```

  5. Enable Access to External USB Devices (for Disconnected Environments):
     - Add the following commands to the `%post` section in your kickstart file:
       ```plaintext
       systemctl disable usbguard
       sed -i 's/black/\#black/g' /etc/modprobe.d/usb-storage.conf
       sed -i 's/install/\#install/g' /etc/modprobe.d/usb-storage.conf
       ```

  6. Install Ansible/Podman:
      ```shell
      sudo dnf install ansible-core
      sudo dnf install container-tools
      ```

      to verify they are installed correctly you can run:
      ```shell
      ansible --version
      podman -v
      ```
  
  7. Clone the Repository:
      ```shell
      git clone https://github.com/cjnovak98/ocp4-disconnected-config
      ```

  8. Navigate to the Playbooks Directory:
      ```shell
      cd ocp4-disconnected-config/playbooks
      ```

  9. Install Required Ansible Collections: 
      ```shell
      ansible-playbook ansible-galaxy.yml
      ```
---

## Running the Automation

### Directory Structure Assumptions

- **Content Path**: Ensure that the content resides in `/pods/content` (definable in `playbooks/group_vars/all/cluster-deployment.yml`). It is assumed this is the transferable media when running connected side for a disconnected cluster and disconnected config is /pods/content/ansible

### Update Environment Variables

- Modify `group_vars/all/cluster-deployment.yml` to customize it for your environment. Key variables include:
   - `common_openshift_dir`: Directory for pulled content to live.
   - `common_connected_cluster`: Set to `true` if the cluster itself is connected.
   - `mirror_content_pull_mirror`: Set to `true` to pull content (set to `false` for disconnected environments).
   - `common_fips_enabled`: `true` if the host is stigged and FIPS is enabled.
   - `common_cluster_domain`: Top-Level Domain (TLD) for the cluster.
   - `common_ip_space`: First three octets of the IP address range for both the bastion and cluster.
   - `common_nodes`: Details of nodes, including name, last octet of the node IP, and MAC addresses.
   - `idracs_user` and `idracs_password`: iDRAC credentials.
   - `idracs`: Node name and IP of the node’s iDRAC.

```yaml
# Example playbooks/group_vars/all/cluster-deployment.yml

common_git_repos:
  - "https://github.com/cjnovak98/ocp4-disconnected-collection.git"
  - "https://github.com/cjnovak98/ocp4-disconnected-config"

common_openshift_dir: /pods/content
common_connected_cluster: false
mirror_content_pull_mirror: false

common_openshift_interface: ens1
common_fips_enabled: true
common_cluster_domain: example.com

common_ip_space: 192.168.122
common_nodes:
  - name: master-0
    ip: '42'
    mac: 52:54:00:8d:13:77
  - name: worker-0
    ip: '43'
    mac: 52:54:00:8d:13:78

# iDRAC
#idrac_user: test
#idrac_password: tester

#media_share_idracs:
#  - name: master-0
#    ip: '{{ ip_space }}.5'
#  - name: master-1
#    ip: '{{ ip_space }}.6'
#  - name: master-2
#    ip: '{{ ip_space }}.7'
#  - name: worker-0
#    ip: '{{ ip_space }}.8'

```

### Run Content Gathering Playbook to Prepare Disconnected Environments:
If you are deploying on a disconnected system then you will first need to gather all of the openshift content on a machine that has internet connection and transfer it over. There is a playbook that you can run whcih will gather the appropriate content: 

```shell
ansible-playbook -K gather-content.yml
```
or 
```shell
./gather-content.yml
```

Once you have the content downloaded, transfer it to your disconnected machine and put in the content directory (i.e. /pods/content)

### Ensure A Valid Pull-Secret Exists: 

You can get your pull secret from [https://console.redhat.com/openshift/create/local](https://console.redhat.com/openshift/create/local) and store it in `~/.docker/config` of the host where you're running the automation. 

> NOTE: If the pull-secret is absent, it will cause the automation to fail but you can simply add it and rerun the playbook.

### Run the Deployment Playbook:

For both connected and disconnected clusters, deploy the cluster by running:

```shell
ansible-playbook -K deploy-cluster.yml
```
or

```shell
./deploy-cluster.yml
```
