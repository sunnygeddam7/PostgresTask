pipeline {
    agent {
        labels: 'ansible'
    }
    
    stages {
        stage(' git Checkout') {
            steps {
                git 'https://github.com/sunnygeddam7/PostgresTask.git'
            }
        }
        stage('postgres install and db creation') {
            steps {
                sh 'ansible-playbook -i hosts postgresql.yml'
            }
        }
    }
}            