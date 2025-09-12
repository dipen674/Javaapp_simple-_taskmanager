pipeline {
    agent any

    environment {
        image = "deependrabhatta/java_app"
    }

    stages {
        stage('Compile the code') {
            agent {label "production"}
            steps {
                echo 'packaging the code'
                sh 'mvn clean package'
            }
            post {
                success {
                    echo "Archiving the Artifacts...."
                    archiveArtifacts artifacts: '**/*.war'
                }
            }
        }
        
         stage('Build docker image') {
            agent {label "production"}
            steps {
                echo "Building docker images'"
                sh 'docker image build -t ${image}:${BUILD_NUMBER} .'
            }
        }
         stage('Image scanning with trivy') {
            agent {label "production"}
            steps {
                echo "Scanning image vulneriblity"
                sh 'trivy image ${image}:${BUILD_NUMBER}'
        }
        }
         stage('Pushing docker image to dockerhub') {
            agent {label "production"}
            steps {
                echo "pushing image"
                withDockerRegistry ([credentialsId: 'jenkinsdockercred',
                  usernameVariable: 'DOCKER_USER',
                  passwordVariable: 'DOCKER_PASS'
                  url: '']) {
                    sh '''
                    docker push $image:$BUILD_NUMBER
                    '''
                }
            }
        }
        stage('Deploy via Ansible Node') {
            agent { label 'master' }
            steps {
                withCredentials([sshUserPrivateKey(
                    credentialsId: 'ansible-ssh-key',
                    keyFileVariable: 'ANSIBLE_KEY'
                )]) {
                        sh """
                        ssh -i "/var/lib/jenkins/keys/id_rsa" -o StrictHostKeyChecking=no vagrant@192.168.56.210 '
                            # Indentation inside single quotes is for readability only
                            rm -rf /home/vagrant/java
                            mkdir -p /home/vagrant/java
                            git clone --single-branch --branch develop \\
                                https://github.com/dipen674/Simple_Java_TM.git /home/vagrant/java
                            source /home/vagrant/myenv/bin/activate
                            cd /home/vagrant/java/ansible &&
                            ansible-galaxy collection install community.docker
                            ansible-playbook playbook.yaml  -e "build_number=${BUILD_NUMBER}" \
                                -e "docker_username=$DOCKER_USER" \
                                -e "docker_password=$DOCKER_PASS"
                        '
                        """
                }
            }
        }
        
    }
//     post {
//          always { 
//             mail to: 'animeislove1657@gmail.com',
//             subject: "Job '${JOB_NAME}' (${BUILD_NUMBER}) is waiting for input",
//             body: "Please go to ${BUILD_URL} and verify the build"
//             cleanWs()
//         }
//         success {
//             mail bcc: 'dipakbhatt363@gmail.com', 
//             body: """Hi Team,
//             Build #$BUILD_NUMBER is successful, please go through the url
//             $BUILD_URL
//             and verify the details.
//             Regards,
//             DevOps Team""",
//             cc: 'bhattad625@gmail.com', 
//             from: 'bhattad625@gmail.com', 
//             replyTo: '', 
//             subject: 'BUILD SUCCESS NOTIFICATION', 
//             to: 'bhattadeependra05@gmail.com'
//         }
//         failure {
//             mail bcc: '', 
//             body: """Hi Team,
//             Build #$BUILD_NUMBER is unsuccessful, please go through the url
//             $BUILD_URL
//             and verify the details.
//             Regards,
//             DevOps Team""", 
//             cc: 'dipakbhatt363@gmail.com', 
//             from: 'bhattad625@gmail.com', 
//             replyTo: 'bhattadeependra05@gmail.com', 
//             subject: 'BUILD FAILED NOTIFICATION', 
//             to: 'bhattadeependra05@gmail.com'
//         }
//     }
}