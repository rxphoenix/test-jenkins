#!/usr/bin/env groovy
pipeline {
    agent any
    tools {
        jdk 'jdk8'
        maven 'M3'
    }
    stages {
        stage ('Déploiement des services') {
            steps {
                sh '''
                    if [ ! -d ansible ]; then
                        git clone https://github.com/Inspq/ansible.git && cd ansible
                    else
                        cd ansible && git pull
                    fi
                    git checkout inspq
                '''
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