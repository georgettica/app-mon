# Prometheus and Grafana Operators for OpenShift


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


