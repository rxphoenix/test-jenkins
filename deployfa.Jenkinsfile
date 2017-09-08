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
                    cheminSVNbase = 'http://svn.inspq.qc.ca/svn/inspq/dev/FA/'
                    if (params.VERSION != null && params.VERSION.length() > 0) {
                        if (params.EST_BRANCHE) {
                            cheminSVNbase = cheminSVNbase + "branches/" + params.VERSION
                        } else {
                            cheminSVNbase = cheminSVNbase + "tags/" + params.VERSION
                        }
                    } else {
                        cheminSVNbase = cheminSVNbase + "trunk"
                    }
                    cheminSVNServices = cheminSVNbase + "/source/FonctionsAllegeesServices"
                    cheminSVNIUS = cheminSVNbase + "/source/FonctionsAllegeesIUS"
                    echo cheminSVNbase
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
                                depthOption: 'files', 
                                ignoreExternalsOption: true, 
                                local: 'FonctionsAllegeesServices', 
                                remote: "${cheminSVNServices}"]], 
                    workspaceUpdater: [$class: 'UpdateUpdater']])
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
                                depthOption: 'files', 
                                ignoreExternalsOption: true, 
                                local: 'FonctionsAllegeesIUS', 
                                remote: "${cheminSVNIUS}"]], 
                    workspaceUpdater: [$class: 'UpdateUpdater']])
            }
        }
        stage ('Configuration de ansible') {
            steps {
                checkout([$class: 'SubversionSCM',
                        additionalCredentials: [],
                        excludedCommitMessages: '',
                        excludedRegions: '',
                        excludedRevprop: '',
                        excludedUsers: '',
                        filterChangelog: false,
                        ignoreDirPropChanges: false,
                        includedRegions: '',
                        locations: [[credentialsId: 'inspqcoumat01',
                                    depthOption: 'infinity',
                                    ignoreExternalsOption: true,
                                    local: 'rolesansible',
                                    remote: "http://svn.inspq.qc.ca/svn/inspq/infrastructure/ansible/trunk"]],
                        workspaceUpdater: [$class: 'UpdateUpdater']])
                    sh "ls -la"
                    //sh "if [ ! -d ansible ]; then git clone https://github.com/Inspq/ansible.git && cd ansible; else cd ansible && git pull; fi; git checkout inspq"
                    sh "if [ ! -d ansible ]; then echo 'exite pas'; else echo 'existe'; fi"
                    sh "touch ansible.cfg"
                    sh "printf '[defaults]\nroles_path=${WORKSPACE}/rolesansible/roles\nlibrary=${WORKSPACE}/ansible/lib/ansible/modules:library\nmodule_utils=${WORKSPACE}/ansible/lib/ansible/module_utils:module_utils\n' >> ansible.cfg"
            }
        }
        //stage ('Déploiement des services') {

        //}
        //stage ('Déploiement de l\'IUS') {

        //}
    }
}