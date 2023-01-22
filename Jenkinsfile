pipeline {
    agent any
    stages{
            stage('Maven Build'){
                steps {
                    checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/adiparwira/devops-test']]])
                    sh 'mvn clean install'
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