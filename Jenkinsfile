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
                        aunit_passed = true
                        try {
                            gctsExecuteABAPUnitTests script: this
                        } catch (err) { // catch all exceptions
                            aunit_passed = false
                            currentBuild.result = 'FAILURE'
                            //stageResult.result = 'FAILURE'
                        } // try
                    } // script
                } // steps
            } //stage
            stage ('Rollback Commit') {
                when { expression { aunit_passed == false } }
                steps {
                    gctsRollback script: this
                } // steps
            } //stage
        } //stages
} //pipeline
