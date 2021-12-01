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
                        currentBuild.result = 'FAILURE'
                        //unstable('AUnit test failed!')
                        echo 'AUnit tests failed!'
                        checks_failed = true
                    } // try
                } // script
            } // steps
        } //stage

        stage ('Run ATC Checks') {
            steps {
                script {
                        abapEnvironmentRunATCCheck script: this
                        def checkstyle = scanForIssues tool: checkStyle(pattern: 'ATCResults.xml')
                        publishIssues issues: [checkstyle], failedTotalAll: 1 //, failOnError: true
                        echo 'Current Build result: ' + currentBuild.result
                        if ( currentBuild.result == 'FAILURE' ) {
                            //currentBuild.result = 'UNSTABLE'
                            echo 'ATC check failed!'
                            checks_failed = true
                        }
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
