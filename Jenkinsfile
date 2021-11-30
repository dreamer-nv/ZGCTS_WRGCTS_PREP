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
        stage ('Run ATC Checks') {
            steps {
                abapEnvironmentRunATCCheck script: this
            } // steps
        } // stage
    } //stages
} //pipeline
