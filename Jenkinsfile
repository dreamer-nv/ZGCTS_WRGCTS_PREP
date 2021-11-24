@Library('piper-lib-os') _


pipeline {
    agent any
//    stages {
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
        try      {   
            stage ('Run Unit Tests') {
                steps {
                    gctsExecuteABAPUnitTests script: this
                } //steps
            } //stage
        } catch (Throwable err) { // catch all exceptions       
            stage ('Rollback Commit') {
                steps {
                    gctsRollback script: this
                } //steps
            } //stage
        } // try-catch
//    } //stages
}//pipeline
