# 3-Tier DevSecOps Project 
This repository contains a Javascript application featuring a React.js frontend, a Node.js API and MySQL database.  
The application will be deployed as a devsecops project but first, we test-run locally using the steps outlined below:  

## Local setup:  
1. Install Node.js from nodejs.org/en/download. Select version 22 LTS (or any version higher than 18) > Linux > using NVM.  
   Copy & paste provided commands to install.  
2. Clone this repository:    
   ```
   git clone https://github.com/Lily-G1/DevSecOps-Project.git  
   cd DevSecOps-Project/  
   git checkout dev
   ```
3. Install MySQL and set up password and database (see setup instructions in the MySQL_setup file)  
4. Open 2 more terminals & navigate into the /client and /api directories respectively  
5. Update the value of REACT_APP_API variable with machine's ip address. This is found in the ../client/.env file  
6. In the /api terminal, download dependencies first, then start backend:
   ```
    npm install
    npm start
   ```
   <img width="492" height="168" alt="ubuntu@ip-172-31-70-251_ ~_DevSecOps-Project_api 12_8_2025 4_02_20 AM" src="https://github.com/user-attachments/assets/532fb1b9-282f-42c3-9fc4-2c1b48c37697" />

7. In /client terminal, download dependencies and start frontend:
   ```
   npm install
   npm start
   ```
8. Access application on browser using ipaddress:3000  
   <img width="708" height="352" alt="DevOps Shack Dashboard - Brave 12_8_2025 4_40_48 AM-copy" src="https://github.com/user-attachments/assets/9a054b92-7a9a-45f7-af49-b4dc86d67e2f" />

     - Test login with default username: *'admin@example.com'* and default password: *'admin123'*  
     - Test registration by entering new user details  
     (insert screenshot)devopshack..
 9. Confirm data persistence in database:  
    ```
    sudo mysql -u root -p
    
    USE crud_app;
    SHOW tables;
    SELECT * FROM users;
        
  (insert screenshot of database) ubuntu....
 
