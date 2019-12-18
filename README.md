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
```bash
# Prometheus operator 
quay.io/coreos/configmap-reload:v0.0.1
quay.io/coreos/prometheus-config-reloader:v0.34.0
quay.io/coreos/prometheus-operator:v0.34.0
# Prometheus instance
quay.io/prometheus/prometheus:v2.7.1
# AlertManager instance
quay.io/prometheus/alertmanager:v0.17.0
# Grafana operator 
quay.io/pb82/grafana-operator:latest
quay.io/openshift/origin-grafana:4.2
# Grafana instance 
quay.io/integreatly/grafana_plugins_init:0.0.2
```

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
  ```bash
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
  

