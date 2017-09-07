#!/usr/bin/env groovy
pipeline {
    agent any
    parameters {
        string (name: 'ENV', description: 'Environnement sur lequel on déploie les fonctions allégées')
        //string (name: 'CREDENTIELS', description: 'Nom des crédentiels pour le SVN de l\'INSPQ dans Jenkins')
        string (name: 'CREDENTIELS', defaultValue: 'inspqcoumat01', description: 'Nom des crédentiels pour le SVN de l\'INSPQ dans Jenkins')
        string (name: 'VERSION', description: 'Version à déployer. Si aucune, on déploie le trunk')
        booleanParam (name: 'EST_BRANCHE', defaultValue: false, description: 'Détermine si la version se trouve dans une branche ou un tag')
    }
    stages {
        stage ('Checkout de fonctions allégées') {
            steps {
                script {
                    cheminSVN = 'http://svn.inspq.qc.ca/svn/inspq/dev/FA/'
                    if (params.VERSION != null && params.VERSION.length() > 0) {
                        if (params.EST_BRANCHE) {
                            cheminSVN = cheminSVN + "branches/" + params.VERSION
                        } else {
                            cheminSVN = cheminSVN + "tags/" + params.VERSION
                        }
                    } else {
                        cheminSVN = cheminSVN + "trunk"
                    }
                    echo cheminSVN
                }
                checkout([$class: 'SubversionSCM', 
                    additionalCredentials: [], 
                    excludedCommitMessages: '', 
                    excludedRegions: '', 
                    excludedRevprop: '', 
                    excludedUsers: '', 
                    filterChangelog: false, 
                    ignoreDirPropChanges: false, 
                    includedRegions: '', 
                    locations: [[credentialsId: "${params.CREDENTIELS}", 
                                depthOption: 'infinity', 
                                ignoreExternalsOption: true, 
                                local: '.', 
                                remote: "${cheminSVN}"]], 
                    workspaceUpdater: [$class: 'UpdateUpdater']])
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