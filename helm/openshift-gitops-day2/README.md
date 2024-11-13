# OCP 4 Disconnected Config Day2 Helm Chart

This chart applies the cluster settings and resources necessary for day to day operations in the target environment. It is intended to be deployed via OpenShift GitOps as part of a infrastructure as code process.

In this case, comments have been provided in both the default `values.yaml` and each of the `.yaml` files in the `templates/` directory to help explain each component.

## Deployment

To use, you will simply add an application in Argo, and supply this repo/directory, as well as the values file customized for your environment:

* Application Name: cluster-day2
* Project Name: default
* Sync Policy: Automatic
* Source:
  * Repository URL: Select the ocp4-disconnected-config repo running on the bastion host
  * Revision: HEAD (or override to your desired branch)
  * Path: ./helm/openshift-gitops-day2
* Destination:
  * Cluster URL: https://kubernetes.default.svc # Use this value to target the same cluster that Argo is running on.
  * Namespace: leave blank or set to default if required
* Values:
  * Override the values as needed. If Argo was able to successfully connect to the source repo configuration, then you should see a list of optional values to override. You can also upload your own `values.yaml` file.

You can use the following command to see what will be applied before actually applying:

```bash
helm template test . --debug | less
```

The default `values.yaml` is designed to be give you the basic layout, as well as provide a template for your own custom values file.

## Components overview

### nmstate operator

TODO: are NodeNetworkConfigurationPolicy part of this operator?

### Chrony

### LDAP

### Other

#### Proxy


