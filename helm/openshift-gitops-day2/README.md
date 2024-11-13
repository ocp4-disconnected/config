# OCP 4 Disconnected Config Day2 Helm Chart

This chart applies the cluster settings and resources necessary for day to day operations in the target environment. It is intended to be deployed via OpenShift GitOps as part of a infrastructure as code process.

In this case, comments have been provided in both the default `values.yaml` and each of the `.yaml` files in the `templates/` directory to help explain each component.

To use, you will simply add an application in Argo, and supply this repo/directory, as well as the values file customized for your environment.

You can use the following command to see what will be applied before actually applying:

```bash
helm template test . --debug | less
```

The default `values.yaml` is designed to be templatable and give you the basic layout, as well as provide a template for your own custom values file.
