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


```bash
# pull 
docker pull quay.io/coreos/configmap-reload:v0.0.1
docker pull quay.io/coreos/prometheus-config-reloader:v0.34.0
docker pull quay.io/coreos/prometheus-operator:v0.34.0
docker pull quay.io/prometheus/prometheus:v2.7.1
docker pull quay.io/prometheus/alertmanager:v0.17.0
docker pull quay.io/pb82/grafana-operator:latest
docker pull quay.io/openshift/origin-grafana:4.2

# tag  
docker tag quay.io/coreos/prometheus-operator:v0.34.0 docker.io/dimssss/prometheus-operator:v0.34.0
docker tag quay.io/coreos/configmap-reload:v0.0.1 docker.io/dimssss/configmap-reload:v0.0.1
docker tag quay.io/coreos/prometheus-config-reloader:v0.34.0 docker.io/dimssss/prometheus-config-reloader:v0.34.0
docker tag quay.io/prometheus/prometheus:v2.7.1 docker.io/dimssss/prometheus:v2.7.1
docker tag quay.io/prometheus/alertmanager:v0.17.0 docker.io/dimssss/alertmanager:v0.17.0
docker tag quay.io/pb82/grafana-operator:latest docker.io/dimssss/grafana-operator:latest
docker tag quay.io/openshift/origin-grafana:4.2 docker.io/dimssss/origin-grafana:4.2

# push 
docker push docker.io/dimssss/configmap-reload:v0.0.1
docker push docker.io/dimssss/prometheus-config-reloader:v0.34.0
docker push docker.io/dimssss/prometheus-operator:v0.34.0
docker push docker.io/dimssss/prometheus:v2.7.1
docker push docker.io/dimssss/alertmanager:v0.17.0
docker push docker.io/dimssss/grafana-operator:latest
docker push docker.io/dimssss/origin-grafana:4.2
```


