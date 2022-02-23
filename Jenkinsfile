pipeline{
    agent any
    tools {
    maven 'maven'
  }
    stages{
        stage('Pull Source Code from GitHub') {
            steps {
                git branch: ‘main’, credentialsId: ‘Git’, url: ‘https://github.com/CloudHight/Pet-Adoption-End-To-End-Project-Application-Team_US.git’
            }
        }

        stage('Build Code') {
            steps {
               sh 'mvn package -Dmaven.test.skip'
            }
        }
           stage('Send Artifacts') {
                steps {
                    sshagent(['docker_host']) {
                        sh 'scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/test/target/spring-petclinic-2.4.2.war  ec2-user@54.161.12.171:/opt/docker'
                    }
                }

            }
        }
}
