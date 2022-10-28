// This Jenkinsfile is dedicated to the jenkins job: MEP Shaun
// cf: https://jenkins.toucantoco.guru/job/Build%20Gotenberg/
//
// The aim of this job is to build a toucan image of the gotenberg project
//

@Library('toucan-jenkins-lib')_
import com.toucantoco.ToucanVars

pipeline {
    agent any

    options {
      // Keep 30 builds
      buildDiscarder(logRotator(numToKeepStr: '30'))
      // Stop pipeline if any stage is unstable
      skipStagesAfterUnstable()
      // Avoid concurrent job
      disableConcurrentBuilds()
      // Enable color in logs
      ansiColor('gnome-terminal')
    }

    parameters {
      string(
        defaultValue: "7.7.0",
        description: 'choose image version',
        name: 'GOTENBERG_VERSION'
      )
    }

    stages {
      stage('Build and push image') {
        steps {
          storeStage()
          sh """
            source ${ToucanVars.JENKINS_SOURCE_SCRIPT}
            make build GOTENBERG_VERSION=${params.GOTENBERG_VERSION}
            make toucan-docker-tag GOTENBERG_VERSION=${params.GOTENBERG_VERSION}
            make toucan-docker-push GOTENBERG_VERSION=${params.GOTENBERG_VERSION}
          """
        }
      }
    }

    post {
        failure {
          postSlackNotif(channel: 'jenkins')
        }

        cleanup {
          deleteDir()
        }

        always {
          // Store build result in a format parsable for our Elastic stack
          logKibana()
        }
    }
}
