pipeline {
    agent any
    
    triggers {
        githubPush()
    }
    
    tools {
        nodejs 'nodejs23'
    }
    
    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Lily-G1/DevSecOps-Project.git'
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
                            sh 'docker build -t liliangaladima/backend:5.0 .'
                            sh 'trivy image --format table -o backend-image-report.html liliangaladima/backend:5.0'
                            sh 'docker push liliangaladima/backend:5.0'
                           
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
                            sh 'docker build -t liliangaladima/frontend:5.0 .'
                            sh 'trivy image --format table -o frontend-image-report.html liliangaladima/frontend:5.0'
                            sh 'docker push liliangaladima/frontend:5.0'
                        }
                    }
                }
            }
        }  

        stage('Manual Approval for Production') {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    input message: 'Approve deployment to PRODUCTION?', ok: 'Deploy'
                }
            }
        }
        
        stage('Deploy to PROD') {
            steps {
                script {
                    withKubeConfig(caCertificate: '', clusterName: 'devopsshack-cluster', contextName: '', credentialsId: 'k8-token', namespace: 'prod', restrictKubeConfigAccess: false, serverUrl: 'https://AD4D1158D82F1B3C740BC069FF3390AB.gr7.us-east-1.eks.amazonaws.com') {
                            sh 'kubectl apply -f k8s-files/sc.yaml'
                            sleep 20
                            sh 'kubectl apply -f k8s-files/mysql.yaml -n prod'
                            sh 'kubectl apply -f k8s-files/backend.yaml -n prod'
                            sh 'kubectl apply -f k8s-files/frontend.yaml -n prod'
                            sh 'kubectl apply -f k8s-files/ci.yaml'
                            sh 'kubectl apply -f k8s-files/ingress.yaml'
                            sleep 30
                    }
                }
            }
        }
        
        stage('Verify deployment to PROD') {
            steps {
                script {
                    withKubeConfig(caCertificate: '', clusterName: 'devopsshack-cluster', contextName: '', credentialsId: 'k8-token', namespace: 'prod', restrictKubeConfigAccess: false, serverUrl: 'https://AD4D1158D82F1B3C740BC069FF3390AB.gr7.us-east-1.eks.amazonaws.com') {
                            sh 'kubectl get pods -n prod'
                            sleep 20
                            sh 'kubectl get ingress -n prod'
                            
                    }
                }
            }
        }
    }
}
