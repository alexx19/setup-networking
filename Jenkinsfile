pipeline {
    agent any
    
    stages
    {
        stage('stage') {
            steps {
                sh 'chmod +x ./integration/stage.sh'
                sh './integration/stage.sh'
            }
        }
    }
}
