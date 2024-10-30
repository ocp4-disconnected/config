# WORK IN PROGRESS!

## Folder Structure
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

---

## Variables that are required

Required variables should be specified in `defaults/main.yml` or `vars/main.yml`. Key variables include:

- **`common_openshift_download_base_url`**: Base URL for downloading OpenShift resources.
- **`common_registry_volume`**: Path to local storage volume for container registry.
- **`common_fips_enabled`**: Toggle for enabling FIPS mode on the cluster.

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