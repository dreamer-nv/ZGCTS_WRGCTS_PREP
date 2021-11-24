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
                        try {
                            gctsExecuteABAPUnitTests script: this
                        } catch (Exception e) { // catch all exceptions
                            echo 'AUnit fails!'
                        } // try
                    } // script
                } // steps
            } //stage
            stage ('Rollback Commit') {
                when { changelog 'AUnit fails!' }
                steps {
                    gctsRollback script: this
                } // steps
            } //stage
        } //stages
} //pipeline
