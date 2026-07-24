pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-1'
        AWS_ACCOUNT_ID = '071785597559'
        AWS_PAGER = ''

        BACKEND_REPOSITORY = 'notesapp-dev-backend'
        FRONTEND_REPOSITORY = 'notesapp-dev-frontend'

        IMAGE_TAG = "${BUILD_NUMBER}"

        BACKEND_IMAGE = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${BACKEND_REPOSITORY}:${IMAGE_TAG}"
        FRONTEND_IMAGE = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${FRONTEND_REPOSITORY}:${IMAGE_TAG}"

        EKS_CLUSTER_NAME = 'notesapp-dev-eks-cluster'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Backend Image') {
            steps {
                sh '''
                docker build \
                    -t ${BACKEND_REPOSITORY}:${IMAGE_TAG} \
                    -f Dockerfile .
                '''
            }
        }

        stage('Build Frontend Image') {
            steps {
                sh '''
                docker build \
                    -t ${FRONTEND_REPOSITORY}:${IMAGE_TAG} \
                    -f mynotes/Dockerfile mynotes
                '''
            }
        }

        stage('Login to Amazon ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region ${AWS_REGION} | docker login \
                --username AWS \
                --password-stdin \
                ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                '''
            }
        }

        stage('Push Backend Image') {
            steps {
                sh '''
                docker tag ${BACKEND_REPOSITORY}:${IMAGE_TAG} ${BACKEND_IMAGE}
                docker push ${BACKEND_IMAGE}
                '''
            }
        }

        stage('Push Frontend Image') {
            steps {
                sh '''
                docker tag ${FRONTEND_REPOSITORY}:${IMAGE_TAG} ${FRONTEND_IMAGE}
                docker push ${FRONTEND_IMAGE}
                '''
            }
        }

        stage('Configure EKS') {
            steps {
                sh '''
                chmod +x scripts/configure-eks.sh
                ./scripts/configure-eks.sh
                '''
            }
        }

        stage('Deploy Kubernetes Resources') {
            steps {
                sh '''
                chmod +x scripts/deploy.sh
                ./scripts/deploy.sh
                '''
            }
        }

        stage('Update Backend Image') {
            steps {
                sh '''
                chmod +x scripts/update-image.sh
                ./scripts/update-image.sh ${BACKEND_IMAGE}
                '''
            }
        }

        /*stage('Update Frontend Image') {
            steps {
                sh '''
                chmod +x scripts/update-image.sh
                ./scripts/update-image.sh frontend ${FRONTEND_IMAGE}
                '''
            }
        }*/

        stage('Verify Deployment') {
            steps {
                sh '''
                chmod +x scripts/verify.sh
                ./scripts/verify.sh
                '''
            }
        }
    }

    post {

        success {
            echo 'Application deployed successfully.'
        }

        failure {
            echo 'Deployment failed. Rolling back...'

            sh '''
            chmod +x scripts/rollback.sh
            ./scripts/rollback.sh
            '''
        }

        always {
            sh 'docker image prune -f || true'
        }
    }
}