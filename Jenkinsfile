pipeline{
    agent any
    tools {
    maven 'maven'
  }
    stages{
        stage('Pull Source Code from GitHub') {
            steps {
                git branch: 'main',
                credentialsId: 'fe290462-2160-4f89-9460-e79911564bb2', 
                url: 'https://github.com/CloudHight/Pet-Adoption-Containerisation-Project-Application-Team_1.git'
            }
        }
        stage('Code Analysis') {
            steps {
                withSonarQubeEnv('sonarQube') {
                   sh "mvn sonar:sonar"
                }
            }   
        }
        stage('Build Code') {
            steps {
               sh 'mvn package -Dmaven.test.skip'
            }
        }
           stage('Send Artifacts') {
                steps {
                    sshagent(['jenkinskey']) {
                        sh 'scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/petadoption/target/spring-petclinic-2.4.2.war  ec2-user@35.178.59.2:/opt/docker'
                    }
                }

            }
        }
}
