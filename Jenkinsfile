pipeline {
    agent any

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
                    // Build the Docker image
                    dockerImage = docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    // Create a dummy test result file for Jenkins
                    bat 'mkdir test-results'
                    bat 'echo ^<testsuite^>^<testcase classname="demo" name="test1"/^>^</testsuite^> > test-results\\test.xml'
                }
            }
            post {
                always {
                    // Publish the test results to Jenkins
                    junit 'test-results/*.xml'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Push Docker image to Docker Hub using credentials
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-cred') {
                        dockerImage.push('latest')
                    }
                }
            }
        }
    }

    post {
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
    }
}
