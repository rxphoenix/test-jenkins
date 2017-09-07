#!/usr/bin/env groovy
pipeline {
    agent any
    parameters {
        string (name: 'ENV', description: 'Environnement sur lequel on déploie les fonctions allégées')
        string (name: 'CREDENTIELS', description: 'Nom des crédentiels pour le SVN de l\'INSPQ dans Jenkins')
        string (name: 'VERSION', description: 'Version à déployer. Si aucune, on déploie le trunk')
        booleanParam (name: 'EST_BRANCHE', defaultValue: false, description 'Détermine si la version se trouve dans une branche ou un tag')
    }
    stages {
        stage ('Checkout de fonctions allégées') {
            script {
                if (params.VERSION == "") {
                    echo "trunk"
                } else {
                    if (params.EST_BRANCHE) {
                        echo "branche"
                    } else {
                        echo "tag"
                    }
                }
            }
        }
        stage ('Configuration de ansible') {

        }
        stage ('Déploiement des services') {

        }
        stage ('Déploiement de l\'IUS') {

        }
    }
}