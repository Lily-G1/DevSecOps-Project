# 3-Tier DevSecOps Project  
## Docker Compose Deployment with Jenkins  
This repository contains a full-stack application featuring a React.js frontend, a Node.js API and MySQL database. This particular branch contains all the files required to build its docker images and run the entire application with docker-compose within a Jenkins CI/CD pipeline with security operations which include Sonarqube, Gitleaks & Trivy scans.    
Clone this repository using the steps below and follow this comprehensive step-by-step tutorial provided [HERE](https://medium.com/@liliangaladima_/devsecops-project-deployment-a-jenkins-sonarqube-pipeline-f1654d9ee379?postPublishedType=repub) to recreate this deployment.  

1. Clone this repository:    
   ```bash
   git clone https://github.com/Lily-G1/DevSecOps-Project.git  
   cd DevSecOps-Project/  
   git checkout dev-dockerDeploy
   ```
3. In the /api/.env file, update the value of DB_PASSWORD with your MySQL password   
4. In the /api directory, download dependencies for backend:  
   ```bash
    rm -rf node_modules package-lock.json  (nuke old dependencies first)
    npm install
   ```
5. In the /client/.env file, remove any value of REACT_APP_API (leave it blank)  
6. In the /client directory, download dependencies for the frontend:
   ```bash
   rm -rf node_modules package-lock.json
   npm install
   ```
7. Push to your repository and run Jenkins pipeline to deploy with docker-compose. See detailed [instructions here.](https://medium.com/@liliangaladima_/devsecops-project-deployment-a-jenkins-sonarqube-pipeline-f1654d9ee379?postPublishedType=repub)

