# OpenShift Configuration as Code

add_worker:

    - Pull config from SNO
    - Generate worker ISO
    - Puts in ~/worker by default
    - Approves worker CSR's on SNO cluster.

agent_install:

    - Create necessary OpenShift install directories.
    - Generate SSH keys if needed
    - Generate templates for install-config and agent-config for both 2 node and 3+ node
    - Do sanity checks on DNS/Networking before cluster install
    - Generate agent ISO
    - Copy kube-config from newly generated ISO content to ~/.kube/config

common:

    Entrypoints:

        main.yml:
            - Ensures required pre-req packages are installed
            - Ensures /usr/bin exists and downladed binaries are installed
            - Creates oc-mirror content directory ### Can remove
            - includes pull_images.yml if pull_mirror is set to true

        gather-content.yml:
            - Creates pre-req directories for oc tools
            - Checks if all required binaries are present and notifies handlers if not for downloading.
            - Ensures correct RHCOS image is available on the system and notifies handler for download if necessary.

        pull_images.yml:
            - Generates imageset-config for later pulling with oc-mirror
            - Pulls content per imageset-config and removes "pull" workspace when finished.

git:

    - Generates SSH key for Git
    - Create Git user and any required directories

idrac:

    - Moves generated ISO from agent_install to web root (/var/www/html)
    - Communicates with iDRAC's to load images
    - Sets One time boot for all iDRAC's and resets servers to begin installation

push_images:

    - Pushes images with oc-mirror from output of common/pull_images.yml entrypoint

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



====== NEW =======


worker-iso:

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

common: <--- Need to add logic for disconnected/connected

    - Ensures required pre-req packages are installed
    - Ensures /usr/bin exists and downladed binaries are installed
    - Creates oc-mirror content directory ### Can remove
    - includes pull_images.yml if pull_mirror is set to true
    - Creates pre-req directories for oc tools
    - Checks if all required binaries are present and notifies handlers if not for downloading.
    - Ensures correct RHCOS image is available on the system and notifies handler for download if necessary.



mirror_content:

    - Pushes images with oc-mirror from output of common/pull_images.yml entrypoint
    - Generates imageset-config for later pulling with oc-mirror
    - Downloads content per imageset-config and removes "pull" workspace when finished.

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

git:

    - Generates SSH key for Git
    - Create Git user and any required directories






connected_samba:
    

disconnected_samba:

    connected side:
        - pull_images

    Disconnected side:
        - registry
        - push_images (push cluster-images only)
        - agent_iso
        - SAMBA
        - push_images (push operators)
        - git
        - add_worker (once cluster is up)
        - day_2

connected_idrac:


disconnected_idrac:

    connected side:
        - pull_images


        - registry
        - push_images (push cluster-images only)
        - agent_iso
        - iDRAC
        - push_images (push operators)
        - git
        - add_worker (once cluster is up)
        - day_2


orchestrate_install: Determine connected/disconnected and execute the roles in the correct order

        EX: Disconnected
            - pull_images
            - registry
            - push_images (push cluster-images only)
            - agent_iso
            - iDRAC/SAMBA
            - push_images (push operators)
            - git
            - add_worker (once cluster is up)
            - day_2
        EX: Connected
            - agent_iso
            - iDRAC/SAMBA/whatever provider orchestration
            - add_worker
            - day_2
