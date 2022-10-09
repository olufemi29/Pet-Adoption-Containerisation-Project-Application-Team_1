pipeline{
    agent any
    tools {
    maven 'maven'
  }
    stages{
        stage('Pull Source Code from GitHub') {
            steps {
                git branch: 'main',
                credentialsId: '81062219-b6b9-452f-ae0c-c0a082efa8e2', 
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
                        sh 'scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/petadoption/target/spring-petclinic-2.4.2.war  ec2-user@35.178.167.103:/opt/docker'
                    }
                }
           }
            stage('Deploy Application') {
                steps {
                    sshagent(['jenkinskey']) {
                        sh 'ssh -o strictHostKeyChecking=no ec2-user@3.145.111.202 "cd /opt/docker && ansible-playbook docker-image.yml && ansible-playbook docker-container.yml && ansible-playbook newrelic.yml"'
                    }
                }
            }
        }
}
