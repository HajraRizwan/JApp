pipeline {
    agent any

    stages {
        stage('Pull Code') {
            steps {
                
                git branch: 'main', url: 'https://github.com/HajraRizwan/JApp.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    
                    dockerImage = docker.build('hajrarizwan/japp')
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    
                    docker.withRegistry('', 'dockerhub-cred') {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
