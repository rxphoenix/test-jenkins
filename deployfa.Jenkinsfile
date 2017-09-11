#!/usr/bin/env groovy
@Library('ansible-reader')
import ca.qc.inspq.jenkins.AnsibleReader

pipeline {
    agent any
    tools {
        jdk 'jdk8'
        maven 'M3'
    }
    parameters {
        string (name: 'ENV', description: 'Environnement sur lequel on déploie les fonctions allégées')
        //string (name: 'CREDENTIELS', description: 'Nom des crédentiels pour le SVN de l\'INSPQ dans Jenkins')
        string (name: 'CREDENTIELS', defaultValue: 'inspqcoumat01', description: 'Nom des crédentiels pour le SVN de l\'INSPQ dans Jenkins')
        //string (name: 'VERSION', description: 'Version à déployer. Si aucune, on déploie le trunk')
        string (name: 'VERSION', defaultValue: 'Keycloak', description: 'Version à déployer. Si aucune, on déploie le trunk')
        //booleanParam (name: 'EST_BRANCHE', defaultValue: false, description: 'Détermine si la version se trouve dans une branche ou un tag')
        booleanParam (name: 'EST_BRANCHE', defaultValue: true, description: 'Détermine si la version se trouve dans une branche ou un tag')
        booleanParam (name: 'LANCEMENT_TESTS', defaultValue: true, description: 'Détermine si on lance les tests')
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
                    cheminTests = cheminSVNbase + "/test"
                }
                /*checkout([$class: 'SubversionSCM', 
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
                    workspaceUpdater: [$class: 'UpdateUpdater']])*/
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
        /*stage ('Configuration de ansible') {
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
                        locations: [[credentialsId: "${params.CREDENTIELS}",
                                    depthOption: 'infinity',
                                    ignoreExternalsOption: true,
                                    local: 'rolesansible',
                                    remote: "http://svn.inspq.qc.ca/svn/inspq/infrastructure/ansible/trunk"]],
                        workspaceUpdater: [$class: 'UpdateUpdater']])
                    sh "if [ ! -d ansible ]; then git clone https://github.com/Inspq/ansible.git && cd ansible; else cd ansible && git pull; fi; git checkout inspq"
                    sh "touch ansible.cfg"
                    sh "printf '[defaults]\nroles_path=${WORKSPACE}/rolesansible/roles\nlibrary=${WORKSPACE}/ansible/lib/ansible/modules:library\nmodule_utils=${WORKSPACE}/ansible/lib/ansible/module_utils:module_utils\n' >> ansible.cfg"
            }
        }*/
        stage ('Checkout des inventaires locaux') {
            when {
                expression { !(env.ENV != null && env.ENV.length() > 0 && env.ENV != 'LOCAL') }
            }
            steps {
                // Checkouter inventaire services
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
                                local: 'FonctionsAllegeesServices/LOCAL', 
                                remote: "${cheminSVNServices}/LOCAL"]], 
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
                                depthOption: 'infinity', 
                                ignoreExternalsOption: true, 
                                local: 'FonctionsAllegeesIUS/LOCAL', 
                                remote: "${cheminSVNIUS}/LOCAL"]], 
                    workspaceUpdater: [$class: 'UpdateUpdater']])
            }
        }
        /*stage ('Déploiement des services') {
            steps {
                script {
                    if (env.ENV != null && env.ENV.length() > 0 && env.ENV != 'LOCAL') {
                        sh "ansible-playbook FonctionsAllegeesServices/deploy.yml -i /SIPMI/FonctionsAllegees/properties/${env.ENV}/${env.ENV}.hosts"
                    } else {
                        // Déploiement avec l'inventaire local
                    }
                }
            }
        }
        stage ('Déploiement de l\'IUS') {
            steps {
                script {
                    if (env.ENV != null && env.ENV.length() > 0 && env.ENV != 'LOCAL') {
                        sh "ansible-playbook FonctionsAllegeesIUS/deploy.yml -i /SIPMI/FonctionsAllegees/properties/${env.ENV}/${env.ENV}.hosts"
                    } else {
                        sh "ansible-playbook FonctionsAllegeesIUS/deploy.yml -i ${WORKSPACE}/FonctionsAllegeesIUS/LOCAL/LOCAL.hosts"
                    }
                }
            }
        }
        stage ('Checkout des projets de tests') {
            when {
                expression { env.LANCEMENT_TESTS }
            }
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
                    locations: [[credentialsId: "${params.CREDENTIELS}", 
                                depthOption: 'infinity', 
                                ignoreExternalsOption: true, 
                                local: 'test', 
                                remote: "${cheminTests}"]], 
                    workspaceUpdater: [$class: 'UpdateUpdater']])
            }
        }*/
        stage ('Préparation des données de test') {
            when {
                expression { env.LANCEMENT_TESTS }
            }
            steps {
                script {
                    String inventaireServices
                    String hostnameServices
                    
                    if (env.ENV != null && env.ENV.length() > 0 && env.ENV != 'LOCAL') {
                        //props = readProperties file: "/SIPMI/FonctionsAllegees/properties/${env.ENV}.properties"
                    } else {
                        inventaireServices = "${WORKSPACE}/FonctionsAllegeesServices/LOCAL/group_vars/app"
                        hostnameServices = "localhost"
                    }
                    AnsibleReader readerServices = new AnsibleReader(inventaireServices)
                    urlDatasource = readerServices.getValueFromKey('faservices_jdbc_url')
                    username = readerServices.getValueFromKey('faservices_jdbc_username')
                    password = readerServices.getValueFromKey('faservices_jdbc_password')
                    def protocol = readerServices.getValueFromKey('faservices_protocol')
                    def port = readerServices.getValueFromKey('faservices_external_port')

                    urlServices = "${protocol}://${hostnameServices}:${port}/fa-services"
                    echo "$urlServices"
                }
                // services.endpoint.url = http://faservices.dev3.inspq.qc.ca:14001/fa-services/    
                // pant.datasource.url = jdbc:oracle:thin:@saora03d.inspq.qc.ca:1523:pantd          faservices_jdbc_url
                // pant.datasource.username = system                                                faservices_jdbc_username
                // pant.datasource.password = Pan0rama                                              faservices_jdbc_password

                sh "cd test/FonctionsAllegeesTestsIntegration/init && mvn clean install exec:java \"-Dservices.url=${urlServices}\" \"-Djdbc.url=${urlDatasource}\" \"-Djdbc.username=${username}\" \"-Djdbc.password=${password}\""
            }
        }
        /*stage ('Lancement des tests de conformité') {
            when {
                expression { env.LANCEMENT_TESTS }
            }
            steps {
                echo "lancement des tests de conformité"
            }
        }
        stage ('Lancement des tests SOAPUI') {
            when {
                expression { env.LANCEMENT_TESTS }
            }
            steps {
                echo "lancement des tests SOAPUI"
            }
        }
        stage ('Ouverture du serveur Selenium') {
            when {
                expression { env.LANCEMENT_TESTS }
            }
            steps {
                echo "ouverture du serveur Selenium"
            }
        }
        stage ('Lancement des tests Selenium sur l\'IUS des fonctions allégées') {
            when {
                expression { env.LANCEMENT_TESTS }
            }
            steps {
                echo "lancement des tests selenium sur IUS"
            }
        }
        stage ('Lancement des tests Selenium sur Panorama') {
            when {
                expression { env.LANCEMENT_TESTS }
            }
            steps {
                echo "lancement des tests sur Panorama"
            }
        }*/
    }
}