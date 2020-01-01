#!/bin/bash

for volume_name in vol{1..3}; do
  oc patch pv $volume_name -p '{"spec":{"accessModes":["ReadWriteOnce","ReadWriteMany"],"capacity":{"storage":"100Gi"},"storageClassName":"prom-storage"}}'
done
for volume_name in vol{4..6}; do
  oc patch pv $volume_name -p '{"spec":{"accessModes":["ReadWriteOnce","ReadWriteMany"],"capacity":{"storage":"100Gi"},"storageClassName":"alertmanager-storage"}}'
done
