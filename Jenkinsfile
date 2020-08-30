pipeline {

  agent any

  environment {
    
    PEM_FINGERPRINT = credentials('fingerprint')
    

  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
        sh 'mkdir -p creds' 
        sh 'echo $PEM_PRIVATE_KEY | base64 -d > ./creds/oci_api_key.pem'
        
        
        sh 'echo $PEM_FINGERPRINT >> vars.tf'
        
        
      }
    }

    stage('TF Plan') {
      steps {
        container('terraform') {
          sh 'terraform init'
          sh 'terraform plan -out myplan'
        }
      }      
    }

    stage('Approval') {
      steps {
        script {
          def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
        }
      }
    }

    stage('TF Apply') {
      steps {
        container('terraform') {
          sh 'terraform apply -input=false myplan'
        }
      }
    }

  } 

}