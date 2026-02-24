#!/bin/bash

while true; do
  students=$(kubectl get students -o jsonpath='{.items[*].metadata.name}')

  for student in $students; do
    podname="${student}-pod"

    if ! kubectl get pod $podname &> /dev/null; then
      echo "Creating pod for student: $student"

      kubectl run $podname --image=nginx --restart=Never
    fi
  done

  sleep 10
done

