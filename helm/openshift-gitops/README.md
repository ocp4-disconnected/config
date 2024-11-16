# OCP GitOps Day 1

This helm chart is in charge of some basic setup after the initial deployment of OpenShft.

The idea behind this is that without OpenShift Git Ops, working with an easily observable and maintainable infrastructure as code setup becomes hard. This template essentially just sets up that GitOps installation to where is is useful for the next, day 2, steps where the bulk of the cluster configuration is performed.

## Usage

To apply this template to your cluster, simply run the helm install command:

```bash
helm install gitops-day1 . --values=./your/values.yaml
```

This applies the yaml to the cluster, and will perform the day 1 operations. Note that it might take a few minutes for everything to come up and be ready, so be patient. You can tell the installation has finished and was successful by navigating to ArgoCD (top right apps menu in OCP web ui -> ArgoCD), logging in via OpenShift, and seeing the blank ArgoCD page. From there, you can verify the git repository was successfully added by navigating to Settings (on the left) -> Repositories. You should see your gitOps git repo in the list, with a green checkmark indicating success.

You can also use the following command to output the finished product without actually applying it to OpenShift, in order to debug and check:

```bash
helm template test . --debug | less
```

### Values

In order to properly run this chart, you will need to create your own values file specifying the values relevant to your setup.

This can be built by copying the existing [values.yaml](values.yaml), and adjusting accordingly.

Mainly, you will need the IP of the system you ran the Ansible from, which is where resources are hosted for the disconnected install, as well as for continued GitOps work. You will also need the ssh private key of the user that was used to run the Ansible, as that is in turn used to access the Git repository for the aforementioned GitOps.
