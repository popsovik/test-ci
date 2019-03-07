#!/bin/bash



`aws lambda list-versions-by-function --function-name test-deploy-first-function-hello --output json | grep Version | tail -1 | grep -o '[0-9]'`
aws s3 cp appspec.yaml s3://test-deploy-bucket-inspo/appspec.yaml
aws deploy register-application-revision --application-name "deploy-testing" --s3-location bucket=test-deploy-bucket-inspo,bundleType=YAML,key=test/appspec.yaml
aws deploy create-deployment --application-name "deploy-testing" --deployment-group test-group --s3-location bucket=test-deploy-bucket-inspo,bundleType=YAML,key=test/appspec.yaml
