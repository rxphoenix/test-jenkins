#!/usr/bin/env groovy
pipeline {
    agent any
    tools {
        maven 'M3'
    }
    stages {
        stage('Preparation') {
            steps {
                //git 'https://github.com/jglick/simple-maven-project-with-tests.git'
                svn 'http://svn.inspq.qc.ca/svn/inspq/dev/Inspq.SX5/trunk'
            }
        }
        stage ('Build') {
            steps {
                sh "mvn -Dmaven.test.failure.ignore clean package"
            }
        }
        stage ('Ansible') {
            steps {
                sh "ansible --version"
            }
        }
        stage('Docker') {
            steps {
                sh "docker --version"
            }
        }
        stage('Results') {
            steps {
                junit '**/target/surefire-reports/TEST-*.xml'
                archive 'target/*.jar'
            }
        }
    }
}