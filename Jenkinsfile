#!/usr/bin/env groovy
@Library('piper-lib-os') _


pipeline {
    agent any
    parameters {
        booleanParam(name: 'CHECKS_FAILED', defaultValue: false, description: '')
    }
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
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    gctsExecuteABAPUnitTests script: this
                    ${params.CHECKS_FAILED} = true
                } // catchError
            } // steps
        } //stage
        stage ('Rollback Commit') {
            when { expression { ${params.checks_failed} == true } }
            steps {
                gctsRollback script: this
            } // steps
        } //stage
    } //stages
} //pipeline
