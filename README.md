# 3-Tier DevSecOps Project 
This repository contains a Javascript application featuring a React.js frontend, a Node.js API and MySQL database.  
The application will be deployed as a devsecops project but first, we test-run locally using the steps outlined below:  

## Local setup:  
1. Install Node.js from [nodejs.org/en/download](https://nodejs.org/en/download). Select version 22 LTS (or any version higher than 18) > Linux > using NVM.  
   Copy & paste provided commands to install.  
2. Clone this repository:    
   ```
   git clone https://github.com/Lily-G1/DevSecOps-Project.git  
   cd DevSecOps-Project/  
   git checkout dev
   ```
3. Install MySQL and set up password and database (see setup instructions in the MySQL_setup file)  
4. Open two seperate terminals & navigate into the /client and /api directories respectively
5. In the /client/.env file, update the value of REACT_APP_API with your machine's IP address  
6. In the /api/.env file, update the value of DB_PASSWORD with your MySQL password   
7. In the /api terminal, download dependencies & start backend:  
   ```
    rm -rf node_modules package-lock.json  (nuke dependencies)
    npm install
    npm start
   ```
8. In the /client terminal, download dependencies & start frontend:
   ```
   rm -rf node_modules package-lock.json
   npm install
   npm start
   ```
9. Access application on browser using *ipaddress*:3000  
     - Test login with default username: *'admin@example.com'* and default password: *'admin123'*  
     - Test registration by entering new user details  
      
10. Confirm data persistence in database:  
    ```
    sudo mysql -u root -p
    
    USE crud_app;
    SHOW tables;
    SELECT * FROM users;
    ```
<img width="616" height="309" alt="DevOps Shack Dashboard1" src="https://github.com/user-attachments/assets/568342aa-f14f-4826-8779-677f435bd160" />  
<img width="610" height="287" alt="DevOps Shack Dashboard2" src="https://github.com/user-attachments/assets/c6fd4c8f-61d5-4f9f-81da-a9ea6bc0d389" />  
<img width="1223" height="347" alt="ubuntu@ip-172-31-26-76_ ~_DevSecOps-Project_api 2_16_2026 11_55_46 AM" src="https://github.com/user-attachments/assets/c6a1ace5-1b65-45fd-81d4-3d7e93c0e819" />  

<!--  
(type both commands in local terminal)

SEND FILES/DIRECTORY TO EC2 FROM LOCAL:  
$ scp -i "ann-web-server.pem" -r ~/Desktop/ds_ops/3-Tier-DevSecOps-Mega-Project/ ubuntu@ec2-98-89-19-38.compute-1.amazonaws.com:/home/ubuntu/3-Tier  

SEND FILES/DIRECTORY FROM EC2 TO LOCAL:  
$ scp -i "ann-web-server.pem" -r ubuntu@ec2-54-226-142-103.compute-1.amazonaws.com:/home/ubuntu/project-X ~/Desktop/project-X/  
-->


