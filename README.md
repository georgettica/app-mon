# Application Monitoring Stack for OpenShift
This repo stores all required manifests and instructions for deploying `Application Monitoring Stack` in disconnected environments. The stack based on [Prometheus](https://github.com/coreos/prometheus-operator) and [Grafana](https://github.com/integr8ly/grafana-operator) operators and can be safely deployed  along side with default OpenShift Monitoring stack (which is based on the same operators).



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


