# WORK IN PROGRESS!

## Folder Structure

worker_iso/
├── defaults/
│   └── main.yml                  # Default variables for worker ISO configuration
├── handlers/
│   └── main.yml                  # Handlers triggered by worker ISO tasks
├── meta/
│   └── main.yml                  # Metadata for dependencies and role information
├── tasks/
│   ├── approve_csr.yml           # Task for approving CSRs for worker nodes
│   └── main.yml                  # Main entry for tasks in worker ISO configuration
├── templates/
│   ├── custom-config.nmconnection.j2 # Template for network configuration
│   └── init-worker.ign.j2             # Template for worker Ignition configuration
├── tests/
│   └── main.yml                  # Test playbook for validating worker ISO role functionality
└── vars/
    └── main.yml                  # Variables specific to worker ISO configuration

---

## Variables that are required

- **`worker_iso_openshift_worker_dir`**: Directory path for storing worker ISO files.
- **`worker_iso_disk_type`**: Specifies the disk type for worker nodes (e.g., `vda`).
- **`worker_iso_openshift_worker_iso`**: Path for the generated CoreOS worker ISO.

---

## Tasks Overview

1. **`main.yml`**: Sets up and configures the worker ISO environment, including:
   - Configuring the directory structure for ISO storage.
   - Applying necessary configurations for worker nodes.

2. **`approve_csr.yml`**: Approves Certificate Signing Requests (CSRs) for worker nodes.

---

## Templates

- **`custom-config.nmconnection.j2`**: Template for network configuration specific to worker nodes.
- **`init-worker.ign.j2`**: Ignition configuration template for initializing worker nodes.
