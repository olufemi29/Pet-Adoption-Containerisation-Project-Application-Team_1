pipeline{
    agent any
    tools {
    maven 'maven'
  }
    stages{
        stage('Pull Source Code from GitHub') {
            steps {
                git branch: 'main',
                credentialsId: 'ab3ffd2c-bc9a-4224-9bb6-042b7475cee3', 
                url: 'https://github.com/CloudHight/Pet-Adoption-Containerisation-Project-Application-Team_1.git'
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
                        sh 'scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/petadoption/target/spring-petclinic-2.4.2.war  ec2-user@3.10.234.88:/opt/docker'
                    }
                }

            }
        }
}
