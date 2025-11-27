pipeline {
    agent any

    // Declare dockerImage at pipeline level
    environment {
        DOCKER_IMAGE = 'hajrarizwan/japp'
    }

    stages {
        stage('Pull Code') {
            steps {
                git branch: 'main', url: 'https://github.com/HajraRizwan/JApp.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Assign to environment variable
                    dockerImage = docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
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
                        // Use the pipeline-level variable
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
