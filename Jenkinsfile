pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
    }

    stages
    {
        stage('awscli') {
            steps {
                sh 'curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"'
                sh './awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws --update'
            }
        }

        stage('stage') {
            steps {
                sh 'chmod +x ./integration/stage.sh'
                sh './integration/stage.sh'
            }
        }
    }
}
