Here are the install instructions I follow when testing out the automation, same set of instructions for both STIG/Non-stig systems.


Install Red Hat Enterprise linux 9 and register with your account

content is assumed to be in /pods/content

* this is assumed to me transferable media when running connected side for a disconnected cluster


and disconnected config is /pods/content/ansible
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

