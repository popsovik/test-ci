#!/bin/bash
CURRENT_VERSION=`aws lambda get-alias --function-name deploy-testing-first-function-hello --name testAlias --output text | awk '{print $2}'`
LATEST_UPLOADED_VERSION=`aws lambda list-versions-by-function --function-name deploy-testing-first-function-hello --output json | grep Version | tail -1 | sed s/[^0-9]//g`
S3BUCKET="test-deploy-bucket-inspo"

echo $CURRENT_VERSION
echo $LATEST_UPLOADED_VERSION

let "TARGET_VERSION =  $LATEST_UPLOADED_VERSION + 1"
echo $TARGET_VERSION
sed 's/##CURRENTVERSION##/'$CURRENT_VERSION'/g; s/##TARGETVERSION##/'$LATEST_UPLOADED_VERSION'/' appspec-default.yml > appspec.yaml
#sed 's/##CURRENTVERSION##/'\$CURRENT_VERSION'/g; s/##TARGETVERSION##/'\$LATEST_UPLOADED_VERSION'/g' appspec-default.yml > appspec.yaml
aws s3 cp appspec.yaml s3://$S3BUCKET/test/appspec-$LATEST_UPLOADED_VERSION.yaml
aws deploy create-deployment --application-name "deploy-testing" --deployment-group test-group --s3-location bucket=$S3BUCKET,bundleType=YAML,key=test/appspec-$LATEST_UPLOADED_VERSION.yaml













# #aws deploy register-application-revision --application-name "deploy-testing" --s3-location bucket=$S3BUCKET,bundleType=YAML,key=test/appspec-$TARGET_VERSION.yaml
