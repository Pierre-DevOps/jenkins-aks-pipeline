pipeline {
    agent any

    environment {
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
                echo '=== Recuperation du code source ==='
                checkout scm
            }
        }

        stage('Azure Login') {
            steps {
                echo '=== Connexion a Azure ==='
                bat '''
                    az login --service-principal -u %ARM_CLIENT_ID% -p %ARM_CLIENT_SECRET% --tenant %ARM_TENANT_ID%
                    az account set --subscription %ARM_SUBSCRIPTION_ID%
                    az account show
                '''
            }
        }

        stage('Create tfvars') {
            steps {
                echo '=== Creation du fichier terraform.tfvars ==='
                dir('terraform') {
                    bat '''
                        (
                        echo project_name = "jenkins-aks"
                        echo environment  = "dev"
                        echo location     = "switzerlandnorth"
                        echo.
                        echo tags = {
                        echo   Owner       = "Pierre"
                        echo   Project     = "Jenkins-AKS-Pipeline"
                        echo   Environment = "dev"
                        echo   ManagedBy   = "Terraform"
                        echo }
                        echo.
                        echo vnet_address_space  = ["10.0.0.0/16"]
                        echo subnet_nodes_prefix = "10.0.1.0/24"
                        echo subnet_pods_prefix  = "10.0.2.0/24"
                        echo authorized_ip_ranges = ["88.172.4.67/32"]
                        echo.
                        echo kubernetes_version   = "1.31"
                        echo node_count           = 2
                        echo node_vm_size         = "Standard_B2s"
                        echo node_min_count       = 1
                        echo node_max_count       = 5
                        echo node_os_disk_size_gb = 50
                        echo.
                        echo key_vault_sku              = "standard"
                        echo soft_delete_retention_days = 30
                        echo.
                        echo log_analytics_sku  = "PerGB2018"
                        echo log_retention_days = 30
                        ) > terraform.tfvars
                    '''
                }
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
                echo '=== Generation du plan Terraform ==='
                dir('terraform') {
                    bat 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Approval') {
            steps {
                echo '=== Attente de validation manuelle ==='
                input message: 'Voulez-vous deployer cette infrastructure ?', ok: 'Deployer'
            }
        }

        stage('Terraform Apply') {
            steps {
                echo '=== Deploiement de infrastructure ==='
                dir('terraform') {
                    bat 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Get Cluster Info') {
            steps {
                echo '=== Informations du cluster deploye ==='
                dir('terraform') {
                    bat 'terraform output'
                }
            }
        }
    }

    post {
        always {
            echo '=== Deconnexion Azure ==='
            bat 'az logout || exit 0'
        }
        success {
            echo '=== Pipeline termine avec succes ==='
        }
        failure {
            echo '=== Pipeline en echec ==='
        }
    }
}