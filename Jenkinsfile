pipeline {
    agent any
    stages{
            stage('Checkout') {
                steps {
                    script {
                        git url: 'https://github.com/adiparwira/devops-test', credentialsId: 'github'
                    }
                }
            }

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

            stage('Docker Push') {
                steps {
                    withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                        sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                        sh 'docker push aryadi/devops-test:latest'
                    }
                }
            }

            stage('Deploy to k8s'){
            steps{
                script{
                    kubernetesDeploy (configs: 'deploy.yaml',kubeconfigId: 'k8sconfig')
                }
            }
        }

    }
}