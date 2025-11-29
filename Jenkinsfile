@Library('shared') _

pipeline {
    agent { label "jenkins-slave" }

    stages {

        stage("Hello") {
            steps {
                script {
                    hello()
                }
            }
        }

        stage("code") {
            steps {
                script {
                    clone("https://github.com/anup-wade/django-notes-app", "main")
                }
            }
        }

        stage("build") {
            steps {
                script {
                    docker_build("notes-app", "latest", "anupwade")
                }
            }
        }

        stage("test") {
            steps {
                echo "this test step"
            }
        }

        stage("push to dockerhub") {
            steps {
                script {
                    docker_push("notes-app", "latest", "anupwade")
                }
            }
        }

        stage("deploy") {
            steps {
                echo "this is deploy step"
                sh "docker compose down && docker compose up -d"
            }
        }

    }
}
