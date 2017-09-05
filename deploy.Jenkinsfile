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
                sh "ansible-playbook --version"
            }
        }
    }
}