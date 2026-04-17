// vars/platformBuild.groovy — Jenkins Shared Library
// Called from application Jenkinsfiles as: platformBuild(imageName: 'payments-service')
def call(Map config) {
    pipeline {
        agent {
            kubernetes {
                yaml """
                    apiVersion: v1
                    kind: Pod
                    spec:
                      containers:
                        - name: maven
                          image: maven:3.9-eclipse-temurin-21
                          command: ['sleep', 'infinity']
                        - name: kaniko
                          image: gcr.io/kaniko-project/executor:debug
                          command: ['sleep', 'infinity']
                """
            }
        }
        stages {
            stage('Test') {
                steps {
                    container('maven') {
                        sh 'mvn -B test'
                    }
                }
            }
            stage('Build Image') {
                steps {
                    container('kaniko') {
                        sh """
                            /kaniko/executor \
                              --dockerfile=Dockerfile \
                              --context=. \
                              --destination=${config.imageName}:${env.GIT_COMMIT}
                        """
                    }
                }
            }
            stage('Security Scan') {
                steps {
                    sh "trivy image --exit-code 1 --severity CRITICAL,HIGH ${config.imageName}:${env.GIT_COMMIT}"
                }
            }
        }
    }
}
