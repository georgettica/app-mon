#!/bin/bash

oc create -f grafana-operator/1.1-grafana-crd.yaml
oc create -f grafana-operator/1.2-grafana-dashboard-crd.yaml
oc create -f grafana-operator/1.3-grafana-datasource-crd.yaml

oc create -f grafana-operator/2.1-service_account.yaml
oc create -f grafana-operator/2.2-role.yaml
oc create -f grafana-operator/2.3-role_binding.yaml
oc create -f grafana-operator/3.1-cluster_role.yaml
oc create -f grafana-operator/3.2-cluster_role_binding.yaml

oc create -f grafana-operator/4.1-operator.yaml

oc create -f grafana-operator/5.1-grafana.yaml

oc create -f grafana-operator/6.1-ds.yaml

oc create -f grafana-operator/7.1-dashboard.yaml
