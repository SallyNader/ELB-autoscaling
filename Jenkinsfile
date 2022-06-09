pipeline {
    agent 'any'
    stages {
        stage('initiate terraform') {
            steps {
                sh """
                    terraform init
                """
            }
        }

        stage('create resources') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws', passwordVariable: 'aws_secret_key', usernameVariable: 'aws_access_key')]) {
                    sh """
                        terraform apply -auto-approve -var='aws_access_key=${aws_access_key}' -var='aws_secret_key=${aws_secret_key}'
                    """
                }
            }
        }
    }
}
