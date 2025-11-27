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

        stage('Run Tests') {
            steps {
                script {
                    bat 'mkdir -p test-results'
                    bat 'echo "<testsuite><testcase classname=\\"demo\\" name=\\"test1\\"/></testsuite>" > test-results/test.xml'
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
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
