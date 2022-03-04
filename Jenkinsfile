pipeline{
    agent any
    tools {
    maven 'maven'
  }
    stages{
        stage('Pull Source Code from GitHub') {
            steps {
                git branch: 'main',
                credentialsId: '629a664c-7f17-4e0e-8b6a-b24f9a12b5cf', 
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
                        sh 'scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/petadoption/target/spring-petclinic-2.4.2.war  ec2-user@18.132.42.28:/opt/docker'
                    }
                }

            }
        }
}
