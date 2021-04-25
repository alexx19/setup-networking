pipeline {

    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
    }

    stages
    {
        stage('stage') {
            sh('./integration/stage.sh')
        }
    }
}
