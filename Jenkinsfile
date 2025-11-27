pipeline {
    agent any

    environment {
        // Références aux credentials Jenkins (IDs à créer dans Jenkins)
        ARM_CLIENT_ID       = credentials('azure-client-id')
        ARM_CLIENT_SECRET   = credentials('azure-client-secret')
        ARM_SUBSCRIPTION_ID = credentials('azure-subscription-id')
        ARM_TENANT_ID       = credentials('azure-tenant-id')
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timestamps()
        timeout(time: 1, unit: 'HOURS')
    }

    stages {
        stage('Checkout') {
            steps {
                echo '=== Récupération du code source ==='
                checkout scm
            }
        }

        stage('Azure Login') {
            steps {
                echo '=== Connexion à Azure ==='
                bat '''
                    az login --service-principal -u %ARM_CLIENT_ID% -p %ARM_CLIENT_SECRET% --tenant %ARM_TENANT_ID%
                    az account set --subscription %ARM_SUBSCRIPTION_ID%
                    az account show
                '''
            }
        }

        stage('Terraform Init') {
            steps {
                echo '=== Initialisation de Terraform ==='
                dir('terraform') {
                    bat 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                echo '=== Validation de la configuration Terraform ==='
                dir('terraform') {
                    bat 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                echo '=== Génération du plan Terraform ==='
                dir('terraform') {
                    bat 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Approval') {
            steps {
                echo '=== Attente de validation manuelle ==='
                input message: 'Voulez-vous déployer cette infrastructure ?', ok: 'Déployer'
            }
        }

        stage('Terraform Apply') {
            steps {
                echo '=== Déploiement de l\'infrastructure ==='
                dir('terraform') {
                    bat 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Get Cluster Info') {
            steps {
                echo '=== Informations du cluster déployé ==='
                dir('terraform') {
                    bat 'terraform output'
                }
            }
        }
    }

    post {
        always {
            echo '=== Déconnexion Azure ==='
            bat 'az logout || exit 0'
        }
        success {
            echo '=== Pipeline terminé avec succès ==='
        }
        failure {
            echo '=== Pipeline en échec ==='
        }
    }
}