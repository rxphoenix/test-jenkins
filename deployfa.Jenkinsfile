#!/usr/bin/env groovy
pipeline {
    agent any
    parameters {
        string (name: 'ENV', description: 'Environnement sur lequel on déploie les fonctions allégées')
        string (name: 'CREDENTIELS', description: 'Nom des crédentiels pour le SVN de l\'INSPQ dans Jenkins')
        string (name: 'VERSION', description: 'Version à déployer. Si aucune, on déploie le trunk')
        booleanParam (name: 'EST_BRANCHE', defaultValue: false, description: 'Détermine si la version se trouve dans une branche ou un tag')
    }
    stages {
        stage ('Checkout de fonctions allégées') {
            environment {
                CHEMIN_SVN = 'http://svn.inspq.qc.ca/svn/inspq/dev/FA/'
            }
            steps {
                script {
                    if (params.VERSION != null && params.VERSION.length() > 0) {
                        if (params.EST_BRANCHE) {
                            env.CHEMIN_SVN = env.CHEMIN_SVN + "branches/" + params.VERSION
                        } else {
                            env.CHEMIN_SVN = env.CHEMIN_SVN + "tags/" + params.VERSION
                        }
                    } else {
                        env.CHEMIN_SVN = "trunk"
                    }
                    echo env.CHEMIN_SVN
                }
                echo ${env.CHEMIN_SVN}
            }
        }
        //stage ('Configuration de ansible') {

        //}
        //stage ('Déploiement des services') {

        //}
        //stage ('Déploiement de l\'IUS') {

        //}
    }
}