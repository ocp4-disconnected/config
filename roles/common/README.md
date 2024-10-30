# WORK IN PROGRESS!

## Folder Structure
```
common/
├── defaults/
│   └── main.yml                  # Default variables for the common configurations
├── handlers/
│   └── main.yml                  # Handlers triggered by common tasks
├── meta/
│   └── main.yml                  # Metadata for dependencies and role information
├── tasks/
│   ├── main.yml                  # Main entry for common tasks
│   └── generate_ca.yml           # Task to generate a certificate authority
├── tests/
│   └── main.yml                  # Test playbook for validating role functionality
└── vars/
    └── main.yml                  # Variables specific to common configurations
```


---

## Variables that are required

Required variables should be specified in `defaults/main.yml` or `vars/main.yml`. Key variables include:

**`vars/main.yml`**

- **`common_openshift_cluster_install_dir`**: Directory where the OpenShift cluster installation files are stored. This path is dynamically generated using `common_install_dir` and the current date, ensuring unique installation directories per day.
- **`common_openshift_oc_mirror_dir`**: Directory path for storing mirrored OpenShift images, used for disconnected or offline installations. This is created within `common_openshift_dir` under `/images`.
- **`common_openshift_client_bin`**: Directory where the OpenShift client binaries are stored, located within `common_openshift_dir` under `/bin`. This path is typically added to the system’s PATH for easier command access.
- **`common_git_repos_dir`**: Directory for storing cloned Git repositories required for the OpenShift installation or management, located within `common_openshift_download_dir` under `/git`.
- **`common_openshift_download_dir`**: Directory used to store downloaded content, such as installation packages and utilities, located within `common_openshift_dir` under `/downloads`.
- **`common_openshift_bastion_platform`**: Architecture platform for the OpenShift bastion host, which defines the binary format (e.g., x86_64, aarch64) used in installations and updates.
- **`common_openshift_download_base_url`**: Base URL for downloading OpenShift client binaries, dynamically constructed based on the `common_openshift_bastion_platform` and pointing to the official OpenShift mirror site.

---

**`defaults/main.yml`**

- **`common_git_repos`**: List of Git repository URLs for downloading configuration and collection resources for OpenShift.
- **`common_install_dir`**: Base installation directory, set to the user's home directory.
- **`common_trident_version`**: Version identifier for Trident, the NetApp storage orchestrator.
- **`common_fips_enabled`**: Boolean to enable FIPS (Federal Information Processing Standard) compliance.
- **`common_openshift_interface`**: Network interface used for OpenShift connected installations.
- **`common_cluster_domain`**: Domain name for the OpenShift cluster.
- **`commond_connected_cluster`**: Boolean flag indicating a connected cluster installation.
- **`common_openshift_release`**: Version of OpenShift to install.
- **`common_previous_openshift_release`**: Previous OpenShift release version (for upgrades).
- **`common_registry_volume`**: Directory path for storing container registry data.
- **`common_ip_space`**: Base IP address for the cluster network range.
- **`common_subnet_mask`**: Subnet mask for the cluster network.
- **`common_gateway_ip`**: IP address of the gateway within the cluster network.
- **`common_ssh_key`**: Path to the SSH private key file.
- **`common_registry_port`**: Port number for the local container registry.

---

## Tasks Overview

1. **`main.yml`**: This task file sets up common configurations, including:
   - Preparing directory structure for the OpenShift cluster.
   - Configuring the registry volume.
   - Ensuring FIPS mode is enabled if specified.
   - Establishing base system configurations required by other roles.

2. **`generate_ca.yml`**: This task file handles generating a custom certificate authority (CA) for secure communication, including:
   - Creating CA certificates.
   - Distributing CA certificates to required nodes.
   - Ensuring proper permissions on the generated certificates.

---

## Handlers Overview

Handlers in the `common` role are triggered by specific events to ensure configurations and services are applied only when necessary. They manage the updates and configurations critical to maintaining a consistent and secure OpenShift environment.

### Handlers Breakdown

1. **Certificate Authority Generation (`generate_ca.yml`)**:
   - **Trigger**: This handler is triggered when CA certificates are newly created or updated.
   - **Purpose**: Ensures that generated CA certificates are distributed to relevant nodes and services to maintain secure communication within the OpenShift environment.
   - **Actions**:
     - Distributes certificates to all nodes.
     - Restarts services that depend on the CA if changes are detected.

2. **Service Restart**:
   - **Trigger**: Executes when any system configuration is changed that impacts a running service.
   - **Purpose**: Restarts critical services (e.g., container runtime, registry) to apply the latest configurations without requiring a full reboot.
   - **Actions**:
     - Detects changes and restarts services like the OpenShift registry or network-related services.

3. **Registry Setup**:
   - **Trigger**: Activated when registry configuration files or volumes are updated.
   - **Purpose**: Ensures the OpenShift container registry is accessible with the updated configuration, which may include adjustments in storage, networking, or authentication.
   - **Actions**:
     - Restarts the registry container.
     - Revalidates network connectivity for the registry.



## Please don't judge for lack of documentation just yet. We're working on it!
