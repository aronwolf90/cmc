# CMC

[Cost Manager Controller](https://about.cost-manager.com/) is a platform for manage small to medium bussines.

## TL;DR;

```console
$ git clone git@gitlab.com:cmc_system/cmc.git
$ cd cmc
$ helm install ticktensio
```

## Introduction

This chart bootstraps a [CMC](https://about.cost-manager.com/) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Git to clone the project
- Kubernetes 1.5+ with Beta APIs enabled
- helm >= v2.3.0 to run "weighted" hooks in right order.
- PV provisioner support in the underlying infrastructure (with persistence storage enabled)

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ git clone git@gitlab.com:cmc_system/cmc.git
$ cd cmc
$ helm install --name my-release ticktensio
```

The command deploys CMC on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete --purge ticktensio
```

The command removes all the Kubernetes components associated with the chart and deletes the release.


## Configuration

The following table lists the configurable parameters of the CMC chart and their default values.

| Parameter                              | Description                                 | Default                                                    |
| -------------------------------        | -------------------------------             | ---------------------------------------------------------- |
| `image.repository`                     | CMC image                                   | `registry.gitlab.com/cmc_system/cmc`                       |
| `image.tag`                            | CMC image tag                               | `latest`                                                   |
| `multiTenant`                          | multiple organizations                      | `false`                                                    |
| `ingress.enabled`                      | enable ingress                              | `false`                                                    |
| `ingress.url`                          | domain of the app                           |                                                            |
| `ingress.annotations`                  | ingress annotations                         | `{}`                                                       |
| `ingress.tls`                          | ingress ssl configuration                   | `{}`                                                       |
| `postgresql.postgresqlPassword`        | database password                           |                                                            |
| `databaseService.externalIp`           | externalIp for the database                 |                                                            |
| `databasePersistence.storageClassName` | database storageClassName                   |                                                            |
| `webPersistence.storageClassName`      | web storageClassName                        |                                                            |


```console
$ git clone git@gitlab.com:cmc_system/cmc.git
$ cd cmc
$ helm install cmc --name my-release \
    --set ingress.enabled=true
    --set ingress.url="your-domain.com" \
    --set ingress.annotations."certmanager\.k8s\.io/cluster-issuer"=letsencrypt-production \
    --set ingress.annotations."kubernetes\.io/ingress\.class"=nginx \
    --set ingress.annotations."kubernetes\.io/tls-acme"="true" \
    --set ingress.tls[0].secretName=your-domain-tls \
    --set ingress.tls[0].hosts[1]="your-domain.com" \
    --set databasePersistence.storageClassName=cmc-db \
    --set webPersistence.storageClassName=cmc-web \
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
$ git clone git@gitlab.com:cmc_system/cmc.git
$ cd cmc
$ helm install --name ticktensio -f values.yaml cmc
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Persistence

The [CMC](https://gitlab.com/cmc_system/cmc/container_registry) image stores the CMC data  at the `/app/uploads` path of the container.

Persistent Volume Claims are used to keep the data across deployments. This is known to work in GCE, AWS, and minikube.
See the [Configuration](#configuration) section to configure the PVC.

## Ingress

This chart provides support for Ingress resource. If you have an available Ingress Controller such as Nginx or Traefik you maybe want to set `ingress.enabled` to true and choose an `ingress.url` for the URL. Then, you should be able to access the installation using that address.

## Upgrade
```console
$ helm delete jobs --all
$ helm upgrade -f values.yaml ticktensio
```

## Multi tenant on localhost

- Execute: `helm install ticktensio --set multiTenant=true`
- Use the following domain: `<ip>.xip.io`. Use `kubectl get services` to get the ip.
