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

To get to Argo, simply select it from the top right dropdown on the OpenShift web ui.

You can also use the following command to see what will be applied before actually applying:

```bash
helm template test . --debug | less
```

The default [values.yaml](values.yaml) is designed to be give you the basic layout, as well as provide a template for your own custom values file. Simply make a copy of this default, and start filling in your real-world data. You can even run the above template command, adding `--values=/path/to/yourValues.yaml` before the `|` to tell Helm to use your new file, in order to check your work.

## Components overview

### nmstate operator

Relevant templates:

 - [nmstate-instance.yaml](templates/nmstate-instance.yml)
 - [nmstate-namespace.yaml](templates/nmstate-namespace.yaml)
 - [nmstate-operator.yaml](templates/nmstate-operator.yaml)
 - [nmstate-operatorgroup.yaml](templates/nmstate-operatorgroup.yaml)
 - [nncp-bond.yaml](templates/nncp-bond.yaml)
 - [nncps.yaml](templates/nncps.yaml)

The nmstate operator is what brings in the NodeNetworkConfigurationPolicy CRD's , allowing us to further tweak the network setup of the cluster.

### Chrony

Relevant templates:

 - [chrony-configuration.yaml](templates/chrony-configuration.yaml)

### LDAP

Relevant templates:

 - [ldap-accounts](templates/ldap-accounts.yaml)
 - [ldap-bind-secret.yaml](templates/ldap-bind-secret.yaml)
 - [ocp-oauth-sec.yaml](templates/ocp-oauth-sec.yaml)

### Storage

Relevant templates:

 - [ocp-trident.yaml](templates/ocp-trident.yaml)
 - [trident-machineconfig-master.yaml](templates/trident-machineconfig-master.yaml)
 - [trident-machineconfig-worker.yaml](templates/tri)

### Other

#### Proxy

Relevant templates:

 - [custom-ca.yaml](templates/custom-ca.yaml)
 - [proxy.yaml](templates/proxy.yaml)

#### Ingress

Relevant templates:

 - [ingress-certs-secret.yaml](templates/ingress-certs-secret.yaml)
 - [ingress-controller.yaml](templates/ingress-controller.yaml)
