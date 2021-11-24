#!/usr/bin/env groovy
@Library('piper-lib-os') _


node {
    stage ('Setup') {
        setupCommonPipelineEnvironment script: this
    } //stage
    stage ('Deploy Commit') {
        gctsDeploy script: this
    } //stage
    stage ('Run Unit Tests') {
        try      {
            aunit_fails = false
            gctsExecuteABAPUnitTests script: this
        } catch (Throwable err) { // catch all exceptions    
            aunit_fails = true
        } // try-catch
    } //stage
    echo aunit_fails
    if (aunit_fails == true) {
        stage ('Rollback Commit') {
            gctsRollback script: this
        } //stage
    } //if
} //node
