# 3-Tier DevSecOps Capstone Project  
## Kubernetes Deployment with AWS EKS  
This repository contains a full-stack application featuring a React.js frontend, a Node.js API and MySQL database. This particular branch contains all files required to build the app's docker images, set up an AWS EKS cluster and run the entire application in this cluster. The deployment is done within a Jenkins CI/CD pipeline with security operations which include Sonarqube, Gitleaks & Trivy scans.    
Clone this repository using the steps below and follow this comprehensive step-by-step tutorial provided [HERE](https://medium.com/@liliangaladima_/devsecops-project-deployment-a-jenkins-sonarqube-pipeline-f1654d9ee379?postPublishedType=repub) to recreate this deployment.  

1. Clone this repository:    
   ```bash
   git clone https://github.com/Lily-G1/DevSecOps-Project.git  
   cd DevSecOps-Project/  
   git checkout dev-k8-deploy
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
7. set up the required Jenkins & Sonarqube infrastructure:
   - Follow these detailed [instructions](https://medium.com/@liliangaladima_/devsecops-project-deployment-a-jenkins-sonarqube-pipeline-f1654d9ee379?postPublishedType=repub) to set up the required  for deployment. We will be deploying with kubernetes rather than docker-compose in this environment.  
   - Jenkins plugins to install: Stageview, sonarqube scanner,  nodejs, docker pipeline, kubernetes, kubernetes credentials, kubernetes CLI  
   - Set up AWS EKS Cluster:  
     - Create a seperate installer instance (t2.medium or higher) or use your local machine to run this [bash script](https://github.com/Lily-G1/eks-setup). It contains instructions on how to easily automate the creation of an EKS cluster suitable for running this application.
     - Go to eks-setup/eks-terraform/main.tf to change or update instance types, config.env values & node types as required
     - Create a directory in same installer instance called 'rbac' and create rbac files:   
     - ```bash
        mkdir rbac && cd rbac/
        kubectl create ns dev        
        touch sa.yaml role.yaml rb.yaml cr.yaml crb.yaml secret.yaml
       ```
     - Go to this rbac [file](https://github.com/Lily-G1/DevSecOps-Project/blob/dev-k8-deploy/RBAC/rbac.md) and copy the contents of the following files into the corresponding files created above:
       - from 'ServiceAccount' and paste into sa.yaml (change namespace to 'dev')  
       - from 'Role' and paste into role.yaml (change namespace to 'dev')  
       - from 'RoleBinding' and paste into rb.yaml (change namespace to 'dev')  
       - from 'ClusterRole' and paste into cr.yaml (change namespace to 'dev')  
       - from 'ClusterRoleBinding' and paste into crb.yaml (change namespace to 'dev')
       - Click on 'Create Token' from same [file](https://github.com/Lily-G1/DevSecOps-Project/blob/dev-k8-deploy/RBAC/rbac.md) & copy content of 'secret/serviceaccount/mysecretname.yaml'. Paste into secret.yaml and change value of 'kubernetes.io/service-account.name: myserviceaccount' to 'jenkins'. Save.
       - ```bash
         kubectl apply -f sa.yaml role.yaml rb.yaml cr.yaml crb.yaml
         kubectl apply -f secret.yaml -n dev
         kubectl describe secret mysecretname -n dev  (to display secret token)
         ```
       - Copy secret token above. Go jenkins console -> credentials -> global -> add -> secret text -> paste token -> ID + descr = 'k8-token'. Create.  
       - Go to AWS console -> EKS cluster to copy cluster's ARN/url. Go to 'k8-deploy' snd 'verify-K8-deploy' stages and update the value of 'serverURL' with this url.
      - Build your pipeline. The application will be accessible via the created loadbalancer’s IP.  
