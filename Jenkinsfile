pipeline {
    agent any
    tools{
        maven 'Maven3.8.7'
    }
    stages{
        stage('Build Maven'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/sandhi3/JenkinsTest.git']]])
                bat 'mvn clean install'
            }
        }
		stage('Build docker image'){
            steps{
                script{
                    bat 'docker build -t sandhi3/jenkinstest .'
                }
            }
        }
        stage('Push image to Hub'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'dockerhubcred', variable: 'dockerhubpwd')]) {
                        bat "docker login -u sandhi3 -p $dockerhubpwd"
                    }
					bat 'docker push sandhi3/jenkinstest'
                }
            }
        }
        stage('Deploy to K8S'){
            steps{
                script{
                    kubernetesDeploy configs: 'deploymentservice.yaml', kubeConfig: [path: ''], kubeconfigId: 'kubeconfig', secretName: '', ssh: [sshCredentialsId: '*', sshServer: ''], textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']
                }
            }
        }
	}
}