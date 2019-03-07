#!/bin/bash
CURRENT_VERSION=`aws lambda get-alias --function-name test-deploy-first-function-hello --name testAlias | awk '{print $2}'`
LATEST_UPLOADED_VERSION=`aws lambda list-versions-by-function --function-name test-deploy-first-function-hello --output json | grep Version | tail -1 | grep -o '[0-9]'`
S3BUCKET="test-deploy-bucket-inspo"

let "TARGET_VERSION =  $LATEST_UPLOADED_VERSION + 1"
sed 's/##CURRENTVERSION##/'$CURRENT_VERSION'/; s/##TARGETVERSION##/'$LATEST_UPLOADED_VERSION'/' appspec-default.yml > appspec.yaml
aws s3 cp appspec.yaml s3://$S3BUCKET/test/appspec-$LATEST_UPLOADED_VERSION.yaml
aws deploy create-deployment --application-name "deploy-testing" --deployment-group test-group --s3-location bucket=$S3BUCKET,bundleType=YAML,key=test/appspec-$LATEST_UPLOADED_VERSION.yaml

#aws deploy register-application-revision --application-name "deploy-testing" --s3-location bucket=$S3BUCKET,bundleType=YAML,key=test/appspec-$TARGET_VERSION.yaml
