# 3-Tier DevSecOps Project 
This repository contains a Javascript application featuring a React.js frontend, a Node.js API and MySQL database.  

## Docker compose Deployment with Jenkins CI 
1. Install Node.js from [nodejs.org/en/download](https://nodejs.org/en/download). Select version 22 LTS (or any version higher than 18) > Linux > using NVM.  
   Copy & paste provided commands to install.  
2. Clone this repository:    
   ```
   git clone https://github.com/Lily-G1/DevSecOps-Project.git  
   cd DevSecOps-Project/  
   git checkout dev
   ```
3. In the /api/.env file, update the value of DB_PASSWORD with your MySQL password   
4. In the /api directory, download dependencies for backend:  
   ```
    rm -rf node_modules package-lock.json  (nuke old dependencies first)
    npm install
   ```
5. In the /client/.env file, remove any value of REACT_APP_API (leave it blank)  
6. In the /client directory, download dependencies for the frontend:
   ```
   rm -rf node_modules package-lock.json
   npm install
   ```
7. Push to your repository and run Jenkins CI pipeline to deploy with docker-compose. [See instructions here](https://nodejs.org/en/download)
