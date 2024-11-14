# WORK IN PROGRESS!

## Folder Structure
```
registry/
├── defaults/
│   └── main.yml                  # Default variables for registry configuration
├── files/
│   └── generateCert.sh           # Script to generate a self-signed certificate
├── handlers/
│   └── main.yml                  # Handlers to update system CA trust
├── meta/
│   └── main.yml                  # Metadata for dependencies and role information
├── tasks/
│   ├── main.yml                  # Main entry for setting up the local registry
│   └── moved_volume_mount.yml    # Task for handling registry data when moving volumes
├── tests/
│   └── main.yml                  # Test playbook for validating registry role functionality
└── vars/
    └── main.yml                  # Variables specific to registry configuration
```
---

## Variables that are required

- **`registry_pod_name`**: Name of the pod running the container registry.
- **`registry_username`**: Username for authenticating to the container registry.
- **`registry_password`**: Password for authenticating to the container registry.


---

## Tasks Overview

1. **`main.yml`**: Sets up a local container registry with the following steps:
   - Creates necessary directories for registry data, authentication, and certificates.
   - Configures a persistent fact file to store registry volume information and manages changes to the registry volume path.
   - Generates registry authentication credentials using `htpasswd`.
   - Creates self-signed TLS certificates for secure registry access.
   - Sets up and starts a registry container using `podman`, with environment variables for authentication and certificate paths.
   - Configures firewall rules to allow access on the registry port.
   - Performs a login to the registry to confirm accessibility.

2. **`moved_volume_mount.yml`**: Manages data migration when the registry volume path is changed:
   - Stops the registry container.
   - Moves registry data from the previous volume path to the new one.
   - Removes the old volume directory once the data is moved.

---

## Handlers

1. **`update_system_trust`**:
   - **Purpose**: Updates the system’s CA trust with the registry’s certificate.
   - **Tasks**:
     - Copies the CA certificate to the system-wide trusted CA directory.
     - Runs `update-ca-trust` to refresh the system CA trust, ensuring that the registry’s certificate is trusted.

---

## Files

### `generateCert.sh`
This script generates a self-signed TLS certificate for the registry. It takes parameters for the fully qualified domain name (FQDN), hostname, and IP address, and creates `domain.key` and `domain.crt` files, ensuring secure access to the registry.

## Please don't judge for lack of documentation just yet. We're working on it!
