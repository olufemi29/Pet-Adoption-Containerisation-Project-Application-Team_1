pipeline{
    agent any
    tools {
    maven 'maven'
  }
    stages{
        stage('Pull Source Code from GitHub') {
            steps {
                git branch: 'main',
                credentialsId: 'fd6e7394-8000-433c-b617-6a9af38dd512', 
                url: 'https://github.com/CloudHight/Pet-Adoption-Containerisation-Project-Application-Team_1.git'
            }
        }

        stage('Build Code') {
            steps {
               sh 'mvn package -Dmaven.test.skip'
            }
        }

        stage('Deploy') {
             steps {
               sshagent (['ansible_creds']) {
                   sh 'ssh -t -t ec2-user@10.0.2.177 -o strictHostKeyChecking=no "cd /etc/ansible && ansible-playbook MyPlaybook.yaml"'

           stage('Send Artifacts') {
                steps {
                    sshagent(['jenkinskey']) {
                        sh 'scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/petadoption/target/spring-petclinic-2.4.2.war ec2-user@3.9.135.64:/opt/docker'
                    }

                }

            }
        }
}
