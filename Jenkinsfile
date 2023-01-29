pipeline {
    agent any
  environment {
    DOCKERHUB_REPOSITORY = "kyontoki/ng"
    DOCKERHUB_CREDENTIALS = credentials('kyontoki')
    dockerImage = ''
  }

  
  stages {
    stage('Checkout Application Git Branch') {
        steps {
            git credentialsId: 'dduddu00',
                url: 'https://github.com/dduddu00/CICD.git', /* URL변경에 따른 수정 필요 */
                branch: 'main'
        }
        post {
                failure {
                  echo 'Repository clone failure !'
                }
                success {
                  echo 'Repository clone success !'
                }
        }
    }
    stage('git scm update') {
      steps {
        git url: 'https://github.com/dduddu00/CICD.git', branch: 'main'
      }
    }
    stage('docker login') {
      steps {
        sh '''
        echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
        '''
      }
    }
    stage('docker build') {
      steps {
        sh '''
        docker build . -t ${DOCKERHUB_REPOSITORY}:${BUILD_NUMBER}
        '''
      }
    }
     stage('Docker Image Push') {
       steps {
         sh '''     
         docker push ${DOCKERHUB_REPOSITORY}:${BUILD_NUMBER}
        
         '''         
            }     
    }

     stage('K8S Manifest Update') {
       steps {
            git credentialsId: 'dduddu00',
                url: 'https://github.com/dduddu00/CICD.git', /* URL변경에 따른 수정 필요 */
                branch: 'main'
            sh "git config --global user.email 'tndusdlsms@nate.com'"
            sh "git config --global user.name 'dduddu00'"
            sh "sed -i 's|ng:.*|ng:${BUILD_NUMBER}|g' kyo.yml "  
            sh "git add kyo.yml"
            sh "git commit -m '[UPDATE] POD ${BUILD_NUMBER} image versioning'" 
            sshagent (credentials: ['jenkey2']) {
                sh "git remote set-url origin git@github.com:dduddu00/CICD.git"
                sh "git push origin main"
            }  
        }
    }
  }
}
