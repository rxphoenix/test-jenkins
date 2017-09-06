#!/usr/bin/env groovy
pipeline {
    agent any
    tools {
        jdk 'jdk8'
        maven 'M3'
    }
    stages {
        stage('Checkout') {
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
                                local: '.', 
                                remote: "http://svn.inspq.qc.ca/svn/inspq/dev/Inspq.SX5/trunk"]], 
                    workspaceUpdater: [$class: 'UpdateUpdater']])
            }
        }
        stage ('Configuration de ansible') {
            steps {
                sh '''
                    if [ ! -d ansible ]; then
                        git clone https://github.com/Inspq/ansible.git && cd ansible
                    else
                        cd ansible && git pull
                    fi
                    git checkout inspq
                '''
                sh "touch ansible.cfg"
                sh "printf '[defaults]\nroles_path=/var/lib/ansible/trunk/roles\nlibrary=${WORKSPACE}/ansible/lib/ansible/module:library\nmodule_utils=${WORKSPACE}/ansible/lib/ansible/module_utils:module_utils\n' >> ansible.cfg"
            }
        }
        stage ('Déploiement des services') {
            steps {
                sh "ansible-playbook sx5-services/deploy.yml -i /SIPMI/Sx5/properties/DEV3/DEV3.hosts"
            }
        }
        stage ('Déploiement du UI') {
            steps {
                sh "ansible-playbook sx5-ui/deploy.yml -i /SIPMI/Sx5/properties/DEV3/DEV3.hosts"
            }
        }
    }
}