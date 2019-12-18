# Application Monitoring Stack for OpenShift
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
 along side with OpenShift monitoring stack without braking our-of-the-box monitoring stack. 
 
   


### Prometheus Operator
```bash
  quay.io/coreos/prometheus-operator:v0.34.0
``` 

### Prometheus Instance
```bash
  quay.io/prometheus/prometheus:v2.7.1
  quay.io/coreos/configmap-reload:v0.0.1
  quay.io/coreos/prometheus-config-reloader:v0.34.0
```

### AlertManager
```bash
  quay.io/prometheus/alertmanager:v0.17.0
```

### Grafana Operator
```bash
  quay.io/pb82/grafana-operator:latest
```
  
### Grafana Instance
```bash
  quay.io/openshift/origin-grafana:4.2
```

### Images for offline installation and whitening process
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


