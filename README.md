# 3-Tier DevSecOps Project 
This repository contains a Javascript application featuring a React.js frontend, a Node.js API and MySQL database.  
The application will be deployed as a devsecops project but first, we test-run locally using the steps outlined below:  

## Local setup:  
1. Install Node.js from [nodejs.org/en/download](nodejs.org/en/download). Select version 22 LTS (or any version higher than 18) > Linux > using NVM.  
   Copy & paste provided commands to install.  
2. Clone this repository:    
   ```
   git clone https://github.com/Lily-G1/DevSecOps-Project.git  
   cd DevSecOps-Project/  
   git checkout dev
   ```
3. Install MySQL and set up password and database (see setup instructions in the MySQL_setup file)  
4. Open two seperate terminals & navigate into the /client and /api directories respectively  
5. Update the value of REACT_APP_API variable with machine's ip address. This is found in the /client/.env file  
6. In the /api terminal, download dependencies first, then start backend:
   ```
    rm -rf node_modules package-lock.json  (nuke dependencies)
    npm install
    npm start
   ```  
7. In /client terminal, download dependencies and start frontend:
   ```
   rm -rf node_modules package-lock.json
   npm install
   npm start
   ```
8. Access application on browser using *ipaddress*:3000  
     - Test login with default username: *'admin@example.com'* and default password: *'admin123'*  
     - Test registration by entering new user details  
      
9. Confirm data persistence in database:  
    ```
    sudo mysql -u root -p
    
    USE crud_app;
    SHOW tables;
    SELECT * FROM users;
    ```
 
