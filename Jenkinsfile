#!/usr/bin/env groovy
@Library('piper-lib-os') _


pipeline {
    agent any
    stages {
        stage ('Setup') {
            steps {
                setupCommonPipelineEnvironment script: this
            } // steps
        } //stage
        stage ('Deploy Commit') {
            steps {
                gctsDeploy script: this
            } // steps
        } //stage
        stage ('Run Unit Tests') {
            steps {
                script {
                    checks_failed = false
                    try {
                        gctsExecuteABAPUnitTests script: this
                    } catch (err) {
                        unstable('AUnit test failed!')
                        checks_failed = true
                    } // try
                } // script
            } // steps
        } //stage

        stage ('Run ATC Checks') {
            steps {
                script {
                    try {
                        def atcresult = abapEnvironmentRunATCCheck script: this
                        echo 'ATC resul: ' + atcresult
                        def checkstyle = scanForIssues tool: checkStyle(pattern: 'ATCResults.xml')
                        publishIssues issues: [checkstyle]//, failOnError: true
                    } catch (err) {
                        echo 'Exception occurred: ' + err.toString()
                        unstable('ATC check failed!')
                        checks_failed = true
                    } // try
                } // script
            } // steps
        } // stage
        
        stage ('Rollback Commit') {
            when { expression { checks_failed == true } }
            steps {
                gctsRollback script: this
            } // steps
        } //stage
        stage ('Success build') {
            when { expression { checks_failed == false } }
            steps {
                echo 'Build success!'
            } // steps
        } //stage        
    } //stages
} //pipeline
