pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-1'
        AWS_ACCOUNT_ID = '071785597559'
        AWS_PAGER = ''

        BACKEND_REPOSITORY = 'notesapp-dev-backend'
        FRONTEND_REPOSITORY = 'notesapp-dev-frontend'

        IMAGE_TAG = "${BUILD_NUMBER}"

        ECR_REGISTRY = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

        BACKEND_IMAGE = "${ECR_REGISTRY}/${BACKEND_REPOSITORY}:${IMAGE_TAG}"
        FRONTEND_IMAGE = "${ECR_REGISTRY}/${FRONTEND_REPOSITORY}:${IMAGE_TAG}"

        BACKEND_LATEST = "${ECR_REGISTRY}/${BACKEND_REPOSITORY}:latest"
        FRONTEND_LATEST = "${ECR_REGISTRY}/${FRONTEND_REPOSITORY}:latest"

        EKS_CLUSTER_NAME = 'notesapp-dev-eks-cluster'
        NAMESPACE = 'django-notes'
    }

    stages {

        stage('Clean Workspace') {
            steps {
                deleteDir()
            }
        }

        stage('Checkout Source') {
            steps {
                checkout scm
            }
        }

        stage('Build Backend Image') {
            steps {
                sh '''
                docker build \
                  --pull \
                  --no-cache \
                  -t ${BACKEND_REPOSITORY}:${IMAGE_TAG} \
                  -f Dockerfile .
                '''
            }
        }

        stage('Build Frontend Image') {
            steps {
                sh '''
                docker build \
                  --pull \
                  --no-cache \
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
                  ${ECR_REGISTRY}
                '''
            }
        }

        stage('Push Backend Image') {
            steps {
                sh '''
                docker tag ${BACKEND_REPOSITORY}:${IMAGE_TAG} ${BACKEND_IMAGE}
                docker tag ${BACKEND_REPOSITORY}:${IMAGE_TAG} ${BACKEND_LATEST}

                docker push ${BACKEND_IMAGE}
                docker push ${BACKEND_LATEST}
                '''
            }
        }

        stage('Push Frontend Image') {
            steps {
                sh '''
                docker tag ${FRONTEND_REPOSITORY}:${IMAGE_TAG} ${FRONTEND_IMAGE}
                docker tag ${FRONTEND_REPOSITORY}:${IMAGE_TAG} ${FRONTEND_LATEST}

                docker push ${FRONTEND_IMAGE}
                docker push ${FRONTEND_LATEST}
                '''
            }
        }

        stage('Configure kubectl') {
            steps {
                sh '''
                aws eks update-kubeconfig \
                  --region ${AWS_REGION} \
                  --name ${EKS_CLUSTER_NAME}
                '''
            }
        }

        stage('Deploy Kubernetes Resources') {
            steps {
                sh '''
                kubectl apply -f k8s/dev/namespace.yaml

                kubectl apply -f k8s/dev/configmap.yaml
                kubectl apply -f k8s/dev/secret.yaml

                kubectl apply -f k8s/dev/mysql-pvc.yaml
                kubectl apply -f k8s/dev/mysql-service.yaml
                kubectl apply -f k8s/dev/mysql-deployment.yaml

                kubectl apply -f k8s/dev/service.yaml
                kubectl apply -f k8s/dev/django-deployment.yaml

                kubectl apply -f k8s/dev/ingress.yaml

                kubectl apply -f k8s/dev/hpa.yaml || true
                '''
            }
        }

        stage('Update Backend Image') {
            steps {
                sh '''
                kubectl set image deployment/django-notes \
                  django-notes=${BACKEND_IMAGE} \
                  -n ${NAMESPACE}

                kubectl rollout status deployment/django-notes \
                  -n ${NAMESPACE} \
                  --timeout=300s
                '''
            }
        }

        stage('Update Frontend Image') {
            steps {
                sh '''
                kubectl set image deployment/frontend \
                  frontend=${FRONTEND_IMAGE} \
                  -n ${NAMESPACE} || true
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                echo "================ PODS ================"
                kubectl get pods -n ${NAMESPACE}

                echo "================ SERVICES ================"
                kubectl get svc -n ${NAMESPACE}

                echo "================ DEPLOYMENTS ================"
                kubectl get deployment -n ${NAMESPACE}

                echo "================ INGRESS ================"
                kubectl get ingress -n ${NAMESPACE}

                echo "================ CURRENT IMAGE ================"
                kubectl get deployment django-notes \
                  -n ${NAMESPACE} \
                  -o=jsonpath='{.spec.template.spec.containers[0].image}'

                echo
                '''
            }
        }
    }

    post {

        success {
            echo 'Deployment completed successfully.'
        }

        failure {

            echo 'Deployment failed.'

            sh '''
            echo "===== PODS ====="
            kubectl get pods -n ${NAMESPACE}

            echo "===== DEPLOYMENT ====="
            kubectl describe deployment django-notes -n ${NAMESPACE}

            echo "===== POD LOGS ====="
            kubectl logs deployment/django-notes -n ${NAMESPACE} --tail=100 || true
            '''
        }

        always {
            sh '''
            docker image prune -af || true
            docker builder prune -af || true
            '''
        }
    }
}