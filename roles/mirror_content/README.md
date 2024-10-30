# WORK IN PROGRESS!

## Folder Structure
mirror_content/
├── defaults/
│   └── main.yml                  # Default variables for content mirroring
├── meta/
│   └── main.yml                  # Metadata for dependencies and role information
├── tasks/
│   ├── main.yml                  # Main entry for coordinating mirroring tasks
│   ├── push_images.yml           # Task for pushing mirrored images to a local registry
│   └── pull_images.yml           # Task for generating and pulling images to mirror
├── templates/
│   ├── cluster-images.yml.j2     # Template for defining core cluster images
│   └── operators.yml.j2          # Template for defining required operators
├── tests/
│   └── main.yml                  # Test playbook for validating role functionality
└── vars/
    └── main.yml                  # Variables specific to content mirroring

---

## Variables that are required

*No specific variables are required at this time.*

---

## Tasks Overview

1. **`main.yml`**: Coordinates the mirroring process based on the specified direction:
   - Creates necessary directories for mirroring.
   - Includes `pull_images.yml` when mirroring images from an external source.
   - Includes `push_images.yml` when pushing mirrored images to a local registry.

2. **`pull_images.yml`**: Manages the generation and pulling of images for mirroring:
   - Generates `oc-mirror` image set configurations for each item (cluster images and operators).
   - Runs `oc-mirror` commands to pull images to a local directory.
   - Cleans up temporary files created during the pull process.

3. **`push_images.yml`**: Handles pushing mirrored images to a local registry:
   - Sets up local IP configuration using `common_ip_space` and `ansible_all_ipv4_addresses`.
   - Pushes each image source to the specified local registry.
   - Retries the push command if it fails, to ensure successful completion.

---

## Templates

- **`cluster-images.yml.j2`**: Defines core container images required for the OpenShift cluster in a disconnected environment.
- **`operators.yml.j2`**: Specifies required operators for OpenShift’s Operator Lifecycle Manager (OLM).


## Please don't judge for lack of documentation just yet. We're working on it!