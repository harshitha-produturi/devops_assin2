pipeline {
  agent any
  environment {
    DOCKERHUB_REPO = credentials('devops-assingment2') // or set via Jenkins credentials or environment
    DOCKERHUB_CRED = 'Devops' // Jenkins credential ID for Docker Hub
    IMAGE_NAME = "${DOCKERHUB_REPO}/ticket-app"
    IMAGE_TAG = "${env.BUILD_NUMBER ?: 'local'}"
  }
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Build Docker Image') {
      steps {
        script {
          docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
        }
      }
    }
    stage('Run Basic Smoke Test') {
      steps {
        script {
          // quick smoke test by running the container and curling the app
          sh '''
          docker run -d --name ticket-test -p 8080:3000 ${IMAGE_NAME}:${IMAGE_TAG}
          sleep 2
          curl -f http://localhost:8080 || (docker logs ticket-test && exit 1)
          docker rm -f ticket-test || true
          '''
        }
      }
    }
    stage('Push to Docker Hub') {
      steps {
        withCredentials([usernamePassword(credentialsId: env.DOCKERHUB_CRED, usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_PASS')]) {
          sh "echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin"
          sh "docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest"
          sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
          sh "docker push ${IMAGE_NAME}:latest"
        }
      }
    }
  }
  post {
    always {
      echo "Cleaning up"
      sh 'docker system prune -af || true'
    }
  }
}
i