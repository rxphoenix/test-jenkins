#!/usr/bin/env groovy
pipeline {
    agent any
    tools {
        maven 'Maven 3.5.0'
    }
    stages {
        stage('Preparation') {
            steps {
                git 'https://github.com/jglick/simple-maven-project-with-tests.git'
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