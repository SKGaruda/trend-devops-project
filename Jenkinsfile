pipeline {
    agent any

    stages {

        stage('Test Environment') {
            steps {
                sh 'echo Jenkins pipeline is working'
            }
        }

        stage('Check Tools') {
            steps {
                sh 'git --version'
                sh 'docker --version'
                sh 'terraform --version'
                sh 'kubectl version --client'
            }
        }
    }
}