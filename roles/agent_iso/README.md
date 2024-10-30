# WORK IN PROGRESS!
## Folder Structure
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

---

## Variables that are required

Required variables should be specified in `defaults/main.yml` or `vars/main.yml`. Key variables include:

- **`agent_iso_base_url`**: Base URL for downloading agent ISO components.
- **`agent_network_config`**: Configuration details for network settings applied to the ISO.
- **`agent_installation_vars`**: Key variables required for configuring installation parameters for agents.

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