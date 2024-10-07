# OpenShift Configuration as Code

worker_iso:

    - Pull config from SNO
    - Generate worker ISO
    - Puts in ~/worker by default
    - Approves worker CSR's on SNO cluster.

agent_iso:

    - Create directories
    - Generate SSH keys if needed
    - Generate templates for install-config and agent-config for both 2 node and 3+ node
    - Do sanity checks on DNS/Networking before cluster install
    - Generate agent ISO
    - Copy kube-config from newly generated ISO content to ~/.kube/config

common:

    - Determines if network connected or disconnected
    - Ensures required pre-req packages are installed
    - Ensures /usr/bin exists
    - Creates pre-req directories for oc tools
    - Checks if all required binaries are present and notifies handlers if not for downloading.
    - Ensures correct RHCOS image is available on the system and notifies handler for download if necessary.

mirror_content:

    - Creates oc-mirror content directory
    - Pull Images from internet if pull_mirror is true
    - Push Images to registry if already download/disconnected
    - Generates imageset-config for later pulling with oc-mirror

registry:

    - Ensures all required directories for registry are created
    - Generates HTPASSWD File
    - Generates self-signed CA
    - Generates registry certs signed by said CA
    - Create podman service and resulting pod for registry as rootless user
    - Allow service to start without user logged in
    - Apply firewall rule to allow registry port
    - Verify registry is up and accessible
    - Generate and configure docker pull secret.

media_share:

    - Detect or use variable to determine iDRAC vs SAMBA
    - Moves generated ISO from agent_install to web root (/var/www/html)
    - Communicates with iDRAC or other (if available) to load images otherwise tell where located.
    - Sets One time boot for all iDRAC's and resets servers to begin installation

switch_config:

    - Configure bastion to switch via serial
    - Update switch config via respective Ansible networking modules

netapp_config:

    - Configure initial IP of netapp
    - Configure/deploy netapp/ontap with official netapp modules

git:

    - Generates SSH key for Git
    - Create Git user and any required directories