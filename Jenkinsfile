pipeline{
    agent any
    tools {
     maven 'maven'
    }
    environment {
      DOCKER_TAG = getVersion()
    }
    stages{
        stage('SCM'){
            steps{
                git credentialsId: 'github',
                url: 'https://github.com/DevopsvivekS/dockeransiblejenkins.git'
            }
        }
        stage('Maven Build'){
            steps{
              sh "mvn clean package"
            }
        }
                 stage('Docker Build'){
            steps{
                sh "docker build . -t docvivek3/vivapp:${DOCKER_TAG}"
            }
        }
        stage('DockerHub Push'){
            steps{
                withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                    sh "docker login -u docvivek3 -p ${dockerHubPwd}"
                }
                
                sh "docker push docvivek3/vivapp:${DOCKER_TAG} "
            }
        }
        stage('Docker Deploy'){
            steps{
              ansiblePlaybook credentialsId: 'linux-slave', disableHostKeyChecking: true, extras: "-e DOCKER_TAG=${DOCKER_TAG}", installation: 'ansible', inventory: 'dev.inv', playbook: 'deploy-docker.yml'
            }
        }
    }
}

def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}
