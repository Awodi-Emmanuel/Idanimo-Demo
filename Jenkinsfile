pipeline {
    agent {
        docker {
            image 'python:3.8'
            tools {
                // add Docker client to the pipeline environment
                docker 'docker'
            }
        }
    }
    environment {
        DOCKER_HUB = credentials('docker-hub')
    }
    stages {
        stage('Build') {
            steps {
//                 sh 'pip install -r requirements.txt'
                // sh 'python manage.py collectstatic --noinput'
                sh 'docker build -t demo-app .'
            }
        }
        stage('Deploy to Staging') {
            when {
                branch 'staging'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'staging-server', usernameVariable: 'SSH_USER', passwordVariable: 'SSH_PASS')]) {
                    sh 'sshpass -p $SSH_PASS ssh -o StrictHostKeyChecking=no $SSH_USER@staging-server "docker pull my-docker-username/my-django-app:latest && docker-compose -f docker-compose.staging.yml up -d"'
                }
            }
        }
        stage('Deploy to Dev') {
            when {
                branch 'dev'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'dev-server', usernameVariable: 'SSH_USER', passwordVariable: 'SSH_PASS')]) {
                    sh 'sshpass -p $SSH_PASS ssh -o StrictHostKeyChecking=no $SSH_USER@dev-server "docker pull my-docker-username/my-django-app:latest && docker-compose -f docker-compose.dev.yml up -d"'
                }
            }
        }
        stage('Deploy to Production') {
            when {
                branch 'master'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'production-server', usernameVariable: 'SSH_USER', passwordVariable: 'SSH_PASS')]) {
                    sh 'sshpass -p $SSH_PASS ssh -o StrictHostKeyChecking=no $SSH_USER@production-server "docker pull my-docker-username/my-django-app:latest && docker-compose -f docker-compose.production.yml up -d"'
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                    sh 'docker push awodi2525/idmo-demo:tagname'
                }
            }
        }

    }
}
