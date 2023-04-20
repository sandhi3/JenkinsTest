pipeline {
    agent any
    tools{
        maven 'maven_3_8_7'
    }
    stages{
        stage('Build Maven'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/sandhi3/JenkinsTest.git']]])
                sh 'mvn clean install'
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t sandhi3/JenkinsTest .'
                }
            }
        }
        stage('Push image to Hub'){
            steps{
                script{
                   withCredentials([string(credentialsId: 'Sandhi@0606', variable: 'dockerhubpwd')]) {
                   sh 'docker login -u sandhi3 -p ${dockerhubpwd}'

					}
                   sh 'docker push sandhi3/JenkinsTest'
                }
            }
        }
        stage('Deploy to k8s'){
            steps{
                script{
                    kubernetesDeploy (configs: 'deploymentservice.yaml',kubeconfigId: 'k8sconfigpwd')
                }
            }
        }
    }
}