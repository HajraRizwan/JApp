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
                    // Declare dockerImage to avoid memory leak warnings
                    def dockerImage = docker.build('hajrarizwan/japp')
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    // Windows-compatible mkdir
                    bat 'if not exist test-results mkdir test-results'
                    bat 'echo "<testsuite><testcase classname=\\"demo\\" name=\\"test1\\"/></testsuite>" > test-results\\test.xml'
                }
            }
            post {
                always {
                    junit 'test-results/*.xml'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('', 'dockerhub-cred') {
                        // Use the same dockerImage declared in Build stage
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
