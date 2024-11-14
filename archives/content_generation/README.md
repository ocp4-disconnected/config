# WORK IN PROGRESS!
## Folder Structure
content_generation/
├── defaults/
│   └── main.yml                  # Default variables for content generation
├── handlers/
│   └── main.yml                  # Handlers triggered by content-related tasks
├── meta/
│   └── main.yml                  # Metadata for dependencies and role information
├── tasks/
│   ├── main.yml                  # Main entry for tasks in content generation
│   └── pull_images.yml           # Specific task to pull required images
├── templates/
│   ├── cluster-images.yml.j2     # Template for defining cluster images
│   └── operators.yml.j2          # Template for defining operators
├── tests/
│   └── main.yml                  # Test playbook for validating role functionality
└── vars/
    └── main.yml                  # Variables specific to content generation

## Variables that are required.
Required variables: Ensure variables exist in defaults/main.yml and vars/main.yml
Key Variables include 
- **`common_openshift_download_base_url`**: Base URL for downloading OpenShift resources.
- **`image_pull_list`**: List of container images required for OpenShift that should be mirrored and cached.

## Tasks Overview
1. **`main.yml`**: This task file orchestrates the setup environment for OpenShift installation.
    - creating essential directories
    - verifying the availability of the OpenShift installer.
    - ensuring all binaries and dependencies are accessible 
    - checking and configuring container registry
    - downloading required OpenShift and related binaries.
2. **`pull_images.yml`**: This file manages image mirroring and setup.
    - creates image mirror
    - Generating and organizing image sets based on `image_pull_list`.
    - Setting correct permissions for mirrored images.
    - Cleaning up temporary files from the `oc-mirror` process.

## Templates
## `cluster-images.yml.j2`
This template is responsible for defining the core container images required for the OpenShift cluster. It specifies the images for critical OpenShift components and allows these images to be mirrored locally to support installation and operation in a disconnected setup.
## `operators.yml.j2`
This template defines the operators needed in the OpenShift cluster, managed by the Operator Lifecycle Manager (OLM). Operators in OpenShift extend the cluster’s functionality by managing applications, storage solutions, and monitoring tools.

## Please don't judge for lack of documentation just yet. We're working on it!