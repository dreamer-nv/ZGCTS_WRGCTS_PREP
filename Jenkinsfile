#!/usr/bin/env groovy
@Library('piper-lib-os') _


pipeline {
    //agent any
    stages {
        stage ('Setup') {
            steps {
                setupCommonPipelineEnvironment script: this
            } //steps
        } //stage
        stage ('Deploy Commit') {
            steps {
                gctsDeploy script: this
            } //steps
        } //stage

            stage ('Run Unit Tests') {
                steps {
                    try      {   
                        gctsExecuteABAPUnitTests script: this
                    } catch (Throwable err) { // catch all exceptions    
                        aunit_fails = true
                    } // try-catch
                } //steps
            } //stage

            if (aunit_fails == true) {
                stage ('Rollback Commit') {
                    steps {
                        gctsRollback script: this
                    } //steps
                } //stage
            } // if
    } //stages

}//pipeline
