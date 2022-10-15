pipeline{
    agent any
    tools {
    maven 'maven'
  }
    stages{
        stage('Pull Source Code from GitHub') {
            steps {
                git branch: 'main',
                credentialsId: 'a7300453-dcb7-4d3a-ab2e-3f28b1d1e50f', 
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
                        sh 'scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/petadoption/target/spring-petclinic-2.4.2.war  ec2-user@18.170.32.208:/opt/docker'
                    }
                }
           }
            stage('Deploy Application') {
                steps {
                    sshagent(['jenkinskey']) {
                        sh 'ssh -o strictHostKeyChecking=no ec2-user@18.170.226.3 "cd /opt/docker && ansible-playbook docker-image.yml && ansible-playbook docker-container.yml && ansible-playbook newrelic.yml"'
                    }
                }
            }
            
        }
}
