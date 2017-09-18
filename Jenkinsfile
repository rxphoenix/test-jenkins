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
                    locations: [[credentialsId: '30020735-8a8a-4209-bcb1-35b991e3b7ba', 
                                depthOption: 'infinity', 
                                ignoreExternalsOption: true, 
                                local: '.', 
                                remote: "http://svn.inspq.qc.ca/svn/inspq/dev/Inspq.SX5/trunk"]], 
                    workspaceUpdater: [$class: 'UpdateUpdater']])
            }
        }
        stage ('Construire SX5-services') {
            steps {
                sh "cd sx5-services && mvn clean package -Pprod"
                sh "cd sx5-services && docker build -t sx5-services:ci ."
            }
        }
        stage ('Construire SX5-ui') {
            steps {
                sh "cd sx5-ui && npm install"
                sh "cd sx5-ui && docker run -u root --rm -v ${WORKSPACE}/sx5-ui:/app trion/ng-cli-karma ng test --watch=false"
                sh "cd sx5-ui && docker build -t sx5-ui:ci ."
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