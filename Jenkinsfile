#!/usr/bin/env groovy
@Library('piper-lib-os') _


pipeline {
    agent any
    parameters {
        booleanParam(name: 'checks_failed', defaultValue: false)
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
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE')
                        gctsExecuteABAPUnitTests script: this
                        ${params.checks_failed} = true
                        } // try
                    } // script
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
