#!/usr/bin/env groovy
pipeline {
    agent any
    tools {
        jdk 'jdk8'
        maven 'M3'
    }
    stages {
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
                sh "printf '[defaults]\nroles_path=/var/lib/ansible/trunk/roles\nlibrary=${WORKSPACE}/ansible/lib/ansible/module:library\nmodule_utils=${WORKSPACE}/ansible/lib/ansible/module_utils:module_utils'"
            }
        }
        stage ('Déploiement des services') {
            steps {
                sh "ansible-playbook --version"
            }
        }
        stage ('Déploiement du UI') {
            steps {
                sh "ansible-playbook --version"
            }
        }
    }
}