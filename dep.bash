#!/bin/bash
ALIAS="demo"
LAMBDA_NAME="deploy-testing-CD-demo-hello"
S3BUCKET="test-deploy-bucket-inspo"

##
CURRENT_VERSION=`aws lambda get-alias --function-name $LAMBDA_NAME --name $ALIAS --output text | awk '{print $2}'`
LATEST_UPLOADED_VERSION=`aws lambda list-versions-by-function --function-name $LAMBDA_NAME --output json | grep Version | tail -1 | sed s/[^0-9]//g`
#LATEST_UPLOADED_VERSION="8"

echo Alias $ALIAS
echo Function Name $LAMBDA_NAME
echo Current Version $CURRENT_VERSION
echo Target Version $LATEST_UPLOADED_VERSION

sed 's/##CURRENTVERSION##/'$CURRENT_VERSION'/; s/##ALIAS##/'$ALIAS'/; s/##LAMBDA_NAME##/'$LAMBDA_NAME'/; s/##TARGETVERSION##/'$LATEST_UPLOADED_VERSION'/' appspec-default.yml > appspec.yaml
aws s3 cp appspec.yaml s3://$S3BUCKET/test/appspec-$LAMBDA_NAME-$ALIAS-$LATEST_UPLOADED_VERSION.yaml
aws deploy create-deployment --application-name "deploy-testing" --deployment-group test-group --s3-location bucket=$S3BUCKET,bundleType=YAML,key=test/appspec-$LAMBDA_NAME-$ALIAS-$LATEST_UPLOADED_VERSION.yaml
aws lambda update-alias --name $ALIAS --function-name $LAMBDA_NAME --function-version $LATEST_UPLOADED_VERSION --routing-config AdditionalVersionWeights={}
