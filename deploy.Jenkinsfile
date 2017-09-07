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
                sh "if [ ! -d ansible ]; then git clone https://github.com/Inspq/ansible.git && cd ansible; else cd ansible && git pull; fi; git checkout inspq"
                sh "touch ansible.cfg"
                sh "printf '[defaults]\nroles_path=${WORKSPACE}/rolesansible/roles\nlibrary=${WORKSPACE}/ansible/lib/ansible/modules:library\nmodule_utils=${WORKSPACE}/ansible/lib/ansible/module_utils:module_utils\n' >> ansible.cfg"
            }
        }
        stage ('Déploiement des services') {
            steps {
                sh "cd sx5-services && docker login -u admin -p admin123 nexus3.inspq.qc.ca:5000"
                sh "ansible-playbook sx5-services/deploy.yml -i ${WORKSPACE}/sx5-services/LOCAL/LOCAL.hosts"
            }
        }
        stage ('Déploiement du UI') {
            steps {
                sh "cd sx5-ui && docker login -u admin -p admin123 nexus3.inspq.qc.ca:5000"
                sh "ansible-playbook sx5-ui/deploy.yml -i ${WORKSPACE}/sx5-ui/LOCAL/LOCAL.hosts"
            }
        }
    }
}