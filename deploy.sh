#!/bin/bash
docker push dolittle/shipos
kubectl patch deployment shipos --namespace dolittle -p "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"date\":\"`date +'%s'`\"}}}}}"