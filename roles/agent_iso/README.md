# WORK IN PROGRESS!
## Folder Structure
```
agent_iso/
├── defaults/
│   └── main.yml                  # Default variables for agent ISO creation
├── handlers/
│   └── main.yml                  # Handlers triggered by agent ISO tasks
├── meta/
│   └── main.yml                  # Metadata for dependencies and role information
├── tasks/
│   ├── main.yml                  # Main entry for agent ISO tasks
│   └── network_checks.yml        # Task for validating network configurations
├── templates/
│   ├── agent-config.yaml.j2      # Template for generating agent configuration
│   └── install-config.yaml.j2    # Template for OpenShift installation config
├── tests/
│   └── main.yml                  # Test playbook for validating role functionality
└── vars/
    └── main.yml                  # Variables specific to agent ISO creation
```
---

## Variables that are required

Required variables should be specified in `defaults/main.yml` or `vars/main.yml`. Key variables include:

- **`agent_iso_cluster_fqdn`**: Fully Qualified Domain Name for the cluster. Constructed by combining `agent_iso_cluster_name` and `common_cluster_domain`, it represents the main domain path for accessing the cluster.
- **`agent_iso_connected`**: Boolean flag indicating if the installation is connected to the internet (true) or disconnected (false).
- **`agent_iso_openshift_cluster_config_dir`**: Directory path where OpenShift cluster configuration files are stored. This path is derived by appending `/configs` to `common_openshift_cluster_install_dir`.
- **`agent_iso_network_checks`**: Boolean that controls whether network checks are performed during the ISO configuration or installation. Set to false to bypass these checks.
- **`agent_iso_cluster_name`**: Name identifier for the OpenShift cluster, used in naming conventions and as part of the FQDN.
- **`agent_iso_dns_resolver`**: IP address of the DNS resolver for the agent ISO installation, typically set to the gateway or primary DNS within the IP space.
- **`agent_iso_table_id`**: Routing table ID used in network configuration, often employed in environments with multiple network interfaces to manage specific routing requirements.
- **`agent_iso_cluster_cidr`**: CIDR notation for the cluster network range, constructed using `common_ip_space` and `common_subnet_mask`, defining the subnet used by the cluster's services and nodes.

---

## Tasks Overview

1. **`main.yml`**: This task file prepares the environment and configurations for generating an agent ISO, including:
   - Creating necessary directories.
   - Validating OpenShift installation availability.
   - Checking if required binaries and dependencies (like `butane` and `helm`) are accessible.
   - Configuring the network settings for the agents.
   - Downloading all required components for the ISO.

2. **`network_checks.yml`**: Validates network configuration, ensuring:
   - Connectivity to required endpoints.
   - DNS resolution and other network dependencies are properly set up.
   - Compliance with configuration standards necessary for a disconnected installation.

---

## Templates

### `agent-config.yaml.j2`
This template defines the agent-specific configuration, detailing network interfaces, storage, and system requirements tailored to each agent’s specifications. It is dynamically populated based on the `agent_network_config` and other agent-specific variables.

### `install-config.yaml.j2`
This template defines the initial setup and installation parameters for OpenShift, covering essential parameters like cluster networking, base domain, and pull secrets. It is customized according to the disconnected environment’s requirements.

## Please don't judge for lack of documentation just yet. We're working on it!
