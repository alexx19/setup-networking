# archivo de configuracion despliegue en stage
#!/usr/bin/env bash
JQ="jq --raw-output --exit-status"

set -e

source ./integration/config.sh

export VERSION=$1
export AWS_INFRA_CLOUDFORMATION_STACK_NAME=${ENTERPRISE_NAME}-${ENVIRONMENT}-${APPLICATION_NAME}

configure_aws_cli() {
    echo -e "configure AWS CLI"
    aws --version
    aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
    aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}
    aws configure set defaul.region ${AWS_REGION}
    aws configure set profile stage
    aws configure set defaul.output json
    echo -e "ALL env jenkins"
    env
}

deploy_project() {
    echo "Creating stack"

    aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE UPDATE_ROLLBACK_COMPLETE | $JQ '.StackSummaries' | grep --quiet \"${AWS_INFRA_CLOUDFORMATION_STACK_NAME}

    if [[ $? = 1 ]]; then
        aws cloudformation create-stack --stack-name ${AWS_INFRA_CLOUDFORMATION_STACK_NAME} --template-body file://setup-networking.yml  
    else
        echo "Update stack"
        aws cloudformation update-stack --stack-name ${AWS_INFRA_CLOUDFORMATION_STACK_NAME} --template-body file://setup-networking.yml 
        stop_stack
    fi
    echo "Finishing Deploying"
}

echo "INFO ------> CONFIGURE AWS CLI... "
configure_aws_cli
echo "INFO ------> DEPLOYING NETWORKING... "
deploy_project
