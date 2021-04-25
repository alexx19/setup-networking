# archivo de configuracion despliegue en stage
#!/usr/bin/env bash
export AWS_REGION=us-east-1
export ENTERPRISE_NAME=rex
export APPLICATION_NAME=networking
export  ENVIRONMENT=stage

AWS_INFRA_CLOUDFORMATION_STACK_NAME=${ENTERPRISE_NAME}-${ENVIRONMENT}-${APPLICATION_NAME}

configure_aws_cli() {
    echo -e "\033[7;92m configure AWS CLI"
    aws --version
    aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
    aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}
    aws configure set region ${AWS_REGION}
    aws configure set defaul.output json
}

deploy_project() {

    echo "Creating stack"
    aws cloudformation create-stack --stack-name ${AWS_INFRA_CLOUDFORMATION_STACK_NAME} --template-body file://setup-networking.yml
    
    echo "Finishing Deploying"
}

echo "\033[42m INFO ------> CONFIGURE AWS CLI... \033[m"

configure_aws_cli

echo "\033[42m INFO ------> DEPLOYING NETWORKING...  \033[m"
deploy_project
