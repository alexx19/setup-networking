import groovy.json.JsonOutput
pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
    }

    stages
    {
        stage('stage') {
            steps {
                sh """
                    #!/usr/bin/env bash
                    JQ="jq --raw-output --exit-status"

                    AWS_REGION=us-east-1
                    ENTERPRISE_NAME=rex
                    APPLICATION_NAME=networking
                    ENVIRONMENT=stage

                    AWS_INFRA_CLOUDFORMATION_STACK_NAME=${ENTERPRISE_NAME}-${ENVIRONMENT}-${APPLICATION_NAME}

                    configure_aws_cli() {
                        echo -e "configure AWS CLI"
                        aws --version
                        aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
                        aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}
                        aws configure set defaul.region ${AWS_REGION}
                        aws configure set defaul.output json

                        echo  ${AWS_INFRA_CLOUDFORMATION_STACK_NAME}
                    }

                    deploy_project() {
                        aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE UPDATE_ROLLBACK_COMPLETE
                        echo "Creating stack"
                        aws cloudformation create-stack --stack-name ${AWS_INFRA_CLOUDFORMATION_STACK_NAME} --template-body file://setup-networking.yml
                        echo "Finishing Deploying"
                    }

                    echo "INFO ------> CONFIGURE AWS CLI... "
                    configure_aws_cli
                    echo "INFO ------> DEPLOYING NETWORKING... "
                    deploy_project

                """
            }
        }
    }
}
