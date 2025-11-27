# Jenkins AKS Pipeline

Projet de déploiement automatique d'un cluster Kubernetes (AKS) sur Azure avec Jenkins et Terraform.

## C'est quoi ce projet ?

Un pipeline Jenkins qui déploie automatiquement :
- Un cluster Kubernetes sur Azure (AKS)
- Un réseau virtuel sécurisé
- Un Key Vault pour les secrets
- Du monitoring avec Log Analytics

## Structure du projet
```
jenkins-aks-pipeline/
├── Jenkinsfile          # Pipeline CI/CD
├── .gitignore           # Fichiers à ne pas commiter
├── README.md            # Ce fichier
└── terraform/
    ├── provider.tf      # Config Terraform
    ├── variables.tf     # Variables
    ├── main.tf          # Ressources Azure
    ├── outputs.tf       # Sorties
    └── terraform.tfvars # Valeurs (non commité)
```

## Prérequis

- Jenkins avec les plugins Azure Credentials et Terraform
- Terraform installé
- Azure CLI installé
- Un compte Azure avec un Service Principal

## Comment ça marche ?

1. Jenkins récupère le code depuis GitHub
2. Terraform initialise le projet
3. Terraform valide la configuration
4. Terraform génère un plan
5. Validation manuelle
6. Terraform déploie sur Azure

## Sécurité

- Aucun credential dans le code
- Les secrets sont dans Jenkins Credentials Store
- Le fichier terraform.tfvars est dans .gitignore

## Auteur

Pierre - Étudiant DevOps Bachelor RNCP36061