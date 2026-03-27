
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
                git branch: 'dev-k8-deploy', url: 'https://github.com/Lily-G1/DevSecOps-Project.git'
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
                            sh 'docker build -t liliangaladima/backend:4.0 .'
                            sh 'trivy image --format table -o backend-image-report.html liliangaladima/backend:4.0'
                            sh 'docker push liliangaladima/backend:4.0'
                           
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
                            sh 'docker build -t liliangaladima/frontend:4.0 .'
                            sh 'trivy image --format table -o frontend-image-report.html liliangaladima/frontend:4.0'
                            sh 'docker push liliangaladima/frontend:4.0'
                        }
                    }
                }
            }
        }  
        
       stage('K8-deploy') {
            steps {
                script {
                    withKubeConfig(caCertificate: '', clusterName: 'devopsshack-cluster', contextName: '', credentialsId: 'k8-token', namespace: 'dev', restrictKubeConfigAccess: false, serverUrl: 'https://5DAF62FDEA2350DA50B2E89866BA79FB.gr7.us-east-1.eks.amazonaws.com') {
                            sh 'kubectl apply -f k8s-files/sc.yaml -n dev'
                            sh 'kubectl apply -f k8s-files/mysql.yaml -n dev'
                            sh 'kubectl apply -f k8s-files/backend.yaml -n dev'
                            sh 'kubectl apply -f k8s-files/frontend.yaml -n dev'
                            sh 'kubectl apply -f k8s-files/ingress.yaml'
                            sleep 30
                    }
                }
            }
        }
        
        stage('verify-K8-deploy') {
            steps {
                script {
                    withKubeConfig(caCertificate: '', clusterName: 'devopsshack-cluster', contextName: '', credentialsId: 'k8-token', namespace: 'dev', restrictKubeConfigAccess: false, serverUrl: 'https://5DAF62FDEA2350DA50B2E89866BA79FB.gr7.us-east-1.eks.amazonaws.com') {
                            sh 'kubectl get pods -n dev'
                            sh 'kubectl get svc -n dev'
                            sh 'kubectl get ingress -n dev'
                            
                    }
                }
            }
        }
    }
}
