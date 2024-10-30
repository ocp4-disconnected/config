# WORK IN PROGRESS!
## Folder Structure
media_share/
├── defaults/
│   └── main.yml                  # Default variables for media share configuration
├── meta/
│   └── main.yml                  # Metadata for dependencies and role information
├── tasks/
│   ├── main.yml                  # Main entry for tasks in media share configuration
│   └── idrac.yml                 # Specific task for configuring iDRAC settings
├── tests/
│   └── main.yml                  # Test playbook for validating role functionality
└── vars/
    └── main.yml                  # Variables specific to media share configuration

---

## Variables that are required

Required variables should be specified in `defaults/main.yml` or `vars/main.yml`. Key variables include:

- **`media_share_idrac`**: 
- **`media_share_idrac_user`**: 
- **`media_share_idrac_password`**: 

---

## Tasks Overview

1. **`main.yml`**: Configures the main media sharing setup, including:
   - Creating and setting up the media sharing directory with correct permissions.
   - Configuring access for shared resources.

2. **`idrac.yml`**: Manages iDRAC (Integrated Dell Remote Access Controller) configuration, including:
   - Setting up iDRAC credentials and network settings.
   - Inserting ISO images via HTTP for iDRAC management.

## Please don't judge for lack of documentation just yet. We're working on it!