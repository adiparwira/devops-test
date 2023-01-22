pipeline {
    agent any
    stages{
            stage('Maven Build'){
                steps {
                    sh 'mvn clean package'
                }
                post {
                    success {
                        echo 'Now Archiving...'
                        archiveArtifacts artifacts: '**/target/*.jar'
                    }
                }
            }

            stage('Docker Build') {
            steps {
                sh 'docker build -t aryadi/devops-test:latest .'
            }

        }
    }
}