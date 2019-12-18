# Application Monitoring Stack for OpenShift
### Description
This repo stores all required manifests and instructions for deploying `Application Monitoring Stack` in disconnected environments. The stack based on [Prometheus](https://github.com/coreos/prometheus-operator) and [Grafana](https://github.com/integr8ly/grafana-operator) operators and can be safely deployed  along side with default OpenShift Monitoring stack (which is based on the same operators).

### Motivation 
As for today OpenShift does not provides any tooling for application monitoring.
As a result OpenShift users required to deploy their own monitoring stacks. 
Nowadays [Prometheus](https://prometheus.io) and [Grafna](https://grafana.com) 
are de-facto a standards tooling for cloud native monitoring. 
Usually thous tools are deployed and managed with concept of 
`Custom Resource Definitions` and `Custom Resource` instances
 by [K8S Operators](https://coreos.com/operators).
 By default OpenShift includes out-of-the-box Prometheus Operator 
 which is deploys Prometheus instance, but this instance is limited to scarp only 
 OpenShift/K8S related endpoints and end user 
 [is not allowed](https://docs.openshift.com/container-platform/3.11/install_config/prometheus_cluster_monitoring.html#supported-configuration) 
 to edit this Prometheus instance. 
 This repo explain how Prometheus and Grafana Operators could be installed  
 along side with OpenShift monitoring stack without braking our-of-the-box monitoring stack in disconnected environments. 
 
 
 ### Getting started 
 
If you are running disconnected installation import the following images 

1. quay.io/coreos/configmap-reload:v0.0.1
2. quay.io/coreos/prometheus-config-reloader:v0.34.0
3. quay.io/coreos/prometheus-operator:v0.34.0
4. quay.io/prometheus/prometheus:v2.7.1
5. quay.io/prometheus/alertmanager:v0.17.0
6. quay.io/pb82/grafana-operator:latest
7. quay.io/openshift/origin-grafana:4.2
8. quay.io/integreatly/grafana_plugins_init:0.0.2


### In case of the disconnected deployment, update the following files with your own images 
1. Update `--config-reloader-image=docker.io/dimssss/configmap-reload:v0.0.1` in file: `prometheus-operator/1.1-prom-operator-bundle.yaml`
2. Update `--prometheus-config-reloader=docker.io/dimssss/prometheus-config-reloader:v0.34.0` in file: `prometheus-operator/1.1-prom-operator-bundle.yaml`  
3. Update `image: docker.io/dimssss/prometheus-operator:v0.34.0` in file: `prometheus-operator/1.1-prom-operator-bundle.yaml`  
4. Update `image: "docker.io/dimssss/prometheus:v2.7.1"` in file  `prometheus-operator/2.2-prometheus.yaml`
5. Update `docker.io/dimssss/alertmanager:v0.17.0` in file  `prometheus-operator/3.2-alertmanager.yaml`
6. Update `image: docker.io/dimssss/grafana-operator:latest` in file `grafana-operator/4.1-operator.yaml` 
7. Update `--grafana-image=docker.io/dimssss/origin-grafana` and `--grafana-image-tag=4.2` in file `grafana-operator/4.1-operator.yaml`
8. Update `--grafana-plugins-init-container-image=docker.io/dimssss/grafana_plugins_init` and `'--grafana-plugins-init-container-tag=0.0.2` in file `grafana-operator/4.1-operator.yaml`

All manifests in that repo have hard-coded values. 
None of the manifest are parameterized.
And it's done by purpose. If you deciding to use this 
repo for installing your Monitoring stack, please make sure you understand 
each manifest and all related manifest values, 
such as namespaces, roles, service accounts, role bindings, cluster role bindings, etc...

By default the application monitoring stack will be deployed with the following 
- Namespace: `appmon`
- Service account for Prometheus operator: `appmon-prometheus-operator`
- Service account for Prometheus instance: `appmon-prometheus`
- For extra Prometheus operator flags check the operator's `Deployment` manifest here: `prometheus-operator/1.1-prom-operator-bundle.yaml`
- The Prometheus Operator deploying persistence Prometheus instance, as a result you've to make sure you've available 6 PVs in total. 3 PVs for Prometheus instance with `storageClassName: prom-storage` and 3 PVs for AlertManager with `storageClassName: alertmanager-storage`
- Selectors 
  ```yaml
    serviceMonitorNamespaceSelector:
      matchExpressions:
        - key: appmon
          operator: In
          values:
          - "yes"
    ruleNamespaceSelector:
      matchExpressions:
        - key: appmon
          operator: In
          values:
          - "yes"
    alerting:
      alertmanagers:
      - namespace: appmon
        name: appmon-alertmanager
        port: web
    serviceMonitorSelector:
      matchLabels:
        appmon: "service-yes"
    podMonitorSelector:
      matchLabels:
        appmon: "pod-yes"
    ruleSelector:
      matchLabels:
        role: alert-rules
        prometheus: appmon-prometheus
  ```
  
### Prometheus  - Operator, Prometheus and AlertManager deployment

#### 0.0 Create two OCP project 
```yaml
# Application monitoring project
oc new-project appmon
# Demo app project 
oc new-project chuck
```

#### 0.1 Edit the `appmon` and `chuck` namespaces and add `appmon: yes` label
```yaml
...
  labels:
    appmon: "yes"
...
```  

#### 1.1 Deploy Prometheus Operator
```bash
oc create -f prometheus-operator/1.1-prom-operator-bundle.yaml
```

#### 2.1 Optional - Create PV if required 
```bash
oc create -f prometheus-operator/2.1-pv.yaml
```

#### 2.2 Deploy Prometheus cluster  
```bash
oc create -f prometheus-operator/2.2-prometheus.yaml
```

#### 2.3 Create `service` and `route` for prometheus
```bash
oc create -f prometheus-operator/2.3-prom-service-route.yaml
```

#### 3.1 Optional - Create AlertManager Secret. **Note, if you creating your own AlertManager secret, make sure to update `prometheus-operator/3.2-alertmanager.yaml` file and remove the `appmon-alertmanager` secret from there** 
```bash
# Create the AlertManager secret
oc create -f prometheus-operator/3.1-alertmanager-secret.yaml
```
Edit the `prometheus-operator/3.2-alertmanager.yaml` and remove the following secret 
```yaml
kind: Secret
metadata:
  name: appmon-alertmanager
  namespace: appmon
apiVersion: v1
data:
  alertmanager.yaml: Z2xvYmFsOgogIHJlc29sdmVfdGltZW91dDogNW0Kcm91dGU6CiAgZ3JvdXBfYnk6IFsnam9iJ10KICBncm91cF93YWl0OiAzMHMKICBncm91cF9pbnRlcnZhbDogNW0KICByZXBlYXRfaW50ZXJ2YWw6IDEyaAogIHJlY2VpdmVyOiAnd2ViaG9vaycKcmVjZWl2ZXJzOgotIG5hbWU6ICd3ZWJob29rJwogIHdlYmhvb2tfY29uZmlnczoKICAtIHVybDogJ2h0dHA6Ly9hbGVydG1hbmFnZXJ3aDozMDUwMC8nCg==
type: Opaque
```

#### 3.2 Deploy AlertManager Cluster
```bash
oc create -f prometheus-operator/3.2-alertmanager.yaml
```

#### 4.1 Create `ServiceMonitor`
```bash
oc create -f prometheus-operator/4.1-service-monitor.yaml
```

#### 5.1 Create `Rule`
```bash
oc create -f prometheus-operator/5.1-rule.yaml
```

### Grafana  - Operator and Grafana instance deployment 

#### Grafana CRDs  
```bash
oc create -f grafana-operator/1.1-grafana-crd.yaml
oc create -f grafana-operator/1.2-grafana-dashboard-crd.yaml
oc create -f grafana-operator/1.3-grafana-datasource-crd.yaml
```

#### Grafana Operator prerequisite
```bash
oc create -f grafana-operator/2.1-service_account.yaml
oc create -f grafana-operator/2.2-role.yaml
oc create -f grafana-operator/2.3-role_binding.yaml
oc create -f grafana-operator/3.1-cluster_role.yaml
oc create -f grafana-operator/3.2-cluster_role_binding.yaml
```   

#### Grafana Operator deployment
```bash
oc create -f grafana-operator/4.1-operator.yaml
```

#### Grafana instance deployment
```bash
oc create -f grafana-operator/5.1-grafana.yaml
``` 

#### Grafana DataSource
```bash
oc create -f /Users/dima/code/prom/grafana-operator/6.1-ds.yaml
```

#### Grafana Dashboard
```bash
oc create -f grafana-operator/7.1-dashboard.yaml
```

### Demo app 
```bash
oc create -f deom-app/app.yaml
``` 

