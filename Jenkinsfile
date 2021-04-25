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
                sh 'pip3 install --upgrade --user awscli'
                sh 'aws --version'
                sh 'chmod +x ./integration/stage.sh'
                sh './integration/stage.sh'
            }
        }
    }
}
