pipeline {

  agent any

  environment {
    
    COMP_ID = credentials('comp_id')
    TENANCY_OCID = credentials('tenancy_id')
    OCI_USER_OCID = credentials('user_ocid')
    PEM_FINGERPRINT = credentials('fingerprint')
    PEM_PRIVATE_KEY = credentials('private_key')
    SSH_KEY = credentials('nodepool_ssh_key')
    REGION = credentials('oci_region')
    
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
        sh 'mkdir -p creds' 
        sh 'echo $PEM_PRIVATE_KEY | base64 -d > ./creds/oci_api_key.pem'
        sh 'echo $COMP_ID >> vars.tf'
        sh 'echo $TENANCY_OCID >> vars.tf'
        sh 'echo $OCI_USER_OCID >> vars.tf'
        sh 'echo $PEM_FINGERPRINT >> vars.tf'
        sh 'echo $SSH_KEY >> vars.tf'
        sh 'echo $REGION >> vars.tf'
      }
    }

    stage('TF Plan') {
      steps {
        container('jenkins-slave-terraform') {
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
        container('jenkins-slave-terraform') {
          sh 'terraform apply -input=false myplan'
        }
      }
    }

  } 

}