# Demo app project 
oc new-project chuck
# Application monitoring project
oc new-project appmon

# add monitoring
oc patch ns appmon -p '{"metadata":{"labels":{"appmon":"yes"}}}'
oc patch ns chuck -p '{"metadata":{"labels":{"appmon":"yes"}}}'

oc create -f prometheus-operator/1.1-prom-operator-bundle.yaml

./prometheus-operator/2.1-pv.sh

oc create -f prometheus-operator/2.2-prometheus.yaml
oc create -f prometheus-operator/2.3-prom-service-route.yaml
oc create -f prometheus-operator/3.2-alertmanager.yaml
oc create -f prometheus-operator/4.1-service-monitor.yaml
oc create -f prometheus-operator/5.1-rule.yaml

oc create -f demo-app/app.yaml
