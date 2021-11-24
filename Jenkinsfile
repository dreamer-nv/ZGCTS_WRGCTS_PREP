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
                    gctsExecuteABAPUnitTests script: this
                } // steps
            } //stage
            stage ('Rollback Commit') {
                when { changelog 'execution of unit tests failed' }
                steps {
                    gctsRollback script: this
                } // steps
            } //stage
        } //stages
} //pipeline
