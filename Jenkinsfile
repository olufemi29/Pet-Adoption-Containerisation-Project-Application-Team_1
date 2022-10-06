pipeline{
    agent any
    tools {
    maven 'maven'
  }
    stages{
        stage('Pull Source Code from GitHub') {
            steps {
                git branch: 'main',
                credentialsId: '2277488b-620a-4941-97a6-38178c57f9ea', 
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
                        sh 'scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/petadoption/target/spring-petclinic-2.4.2.war  ec2-user@13.40.164.130:/opt/docker'
                    }
                }
           }
            stage('Deploy Application') {
                steps {
                    sshagent(['jenkinskey']) {
                        sh 'ssh -o strictHostKeyChecking=no ec2-user@13.40.164.130 "cd /opt/docker && ansible-playbook docker-image.yml && ansible-playbook docker-container.yml && ansible-playbook newrelic.yml"'
                    }
                }
            }
        }
}
