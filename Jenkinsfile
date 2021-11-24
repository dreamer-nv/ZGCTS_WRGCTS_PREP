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
        stage ('Rollback Commit') {
            when { expression { checks_failed == true } }
            steps {
                gctsRollback script: this
            } // steps
        } //stage
    } //stages
} //pipeline
