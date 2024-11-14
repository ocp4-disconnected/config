# WORK IN PROGRESS!

## Folder Structure
```
git/
├── defaults/
│   └── main.yml                  # Default variables for Git configuration
├── handlers/
│   └── main.yml                  # Handlers triggered by Git-related tasks
├── meta/
│   └── main.yml                  # Metadata for dependencies and role information
├── tasks/
│   └── main.yml                  # Main entry for tasks in Git configuration
├── tests/
│   └── main.yml                  # Test playbook for validating role functionality
```
---
## Variables that are required

Required variables should be specified in `defaults/main.yml` or `vars/main.yml`. Key variables include:

- **`git_user_repo_dir`**:  

---
## Tasks Overview

1. **`main.yml`**: This task file sets up Git configurations, including:
   - Cloning or updating the specified repository if a URL is provided.
   - Configuring Git access or settings, if specified.
   
## Please don't judge for lack of documentation just yet. We're working on it!
