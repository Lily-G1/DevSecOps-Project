
pipeline {
    agent any
    
    tools {
        nodejs 'nodejs23'
    }

    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }
    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'dev-dockerDeploy', url: 'https://github.com/Lily-G1/DevSecOps-Project.git'
            }
        }
        
        stage('Frontend Compilation') {
            steps {
                dir('client') {
                    sh 'find . -name "*.js" -exec node --check {} +'
                }
            }
        }
        
        stage('Backend Compilation') {
            steps {
                dir('api') {
                    sh 'find . -name "*.js" -exec node --check {} +'
                }
            }
        }
        
        stage('GitLeaks Scan') {
            steps {
                sh 'gitleaks detect --source ./client --exit-code 1'
                sh 'gitleaks detect --source ./api --exit-code 1'
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar') {
                    sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=NodeJS-Project \
                            -Dsonar.projectKey=NodeJS-Project '''
                }
            }
        }
        stage('Quality Gate Check') {
            steps {
                timeout(time: 2, unit: 'MINUTES') {
                }
            }
        }
        stage('Trivy FS Scan') {
            steps {
                sh 'trivy fs --format table -o fs-report.html .'
            }
        }
        
        stage('Build, Tag & Push Backend Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'dockerhub-cred') {
                        dir('api') {
                            sh 'docker build -t liliangaladima/backend:latest .'
                            sh 'trivy image --format table -o backend-image-report.html liliangaladima/backend:latest '
                            sh 'docker push liliangaladima/backend:latest'
                           
                        }
                    }
                }
            }
        }  
            
        stage('Build, Tag & Push Frontend Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'dockerhub-cred') {
                        dir('client') {
                            sh 'docker build -t liliangaladima/frontend:latest .'
                            sh 'trivy image --format table -o frontend-image-report.html liliangaladima/frontend:latest '
                            sh 'docker push liliangaladima/frontend:latest'
                        }
                    }
                }
            }
        }  
        
        stage('Deploy with Docker Compose') {
            steps {
                script {
                    sh 'docker-compose up -d'
                } 
            }
        } 
    }
}
