# sql-analytics-portfolio

# Creating a New Database

## Description

This document describes step by step how a new database was created and launched using GitHub, Docker, and Visual Studio Code.

---

## Step 1: Create a New GitHub Repository

In the first step, we created a new GitHub repository by logging into our GitHub account.

Actions performed:
1. Log in to GitHub  
2. Click New Repository  
3. Repository name: sql-analytics-portfolio  
4. Check Add a README file  
5. Check Add .gitignore and choose None  
6. Click Create Repository  

---

## Step 2: Clone the Repository and Open in VS Code

We created a folder named aca on the Desktop.  
Inside this folder, we opened the Terminal in order to clone the repository.

After cloning the repository, we typed the command `code .` in the Terminal to open the project in Visual Studio Code.  
The project was then saved using the Project Manager extension.

---

## Step 3: Create Data Folder and Add CSV Files

Inside the project, we created a new folder named data.  
Then, we added the following CSV files into the data folder:

1. customers.csv  
2. employees.csv  
3. orders.csv  
4. products.csv  
5. sales.csv  

After adding the files, we saved the changes using git add and git commit commands.

---

## Step 4: Configure .gitignore

We opened the .gitignore file and added the following entries:

pgadmin_data/  
postgres_data/  

After that, we ran git add and git commit again to save the changes.

---

## Step 5: Create Initialization SQL Files

We created a new folder named init.  
Inside this folder, we created two SQL files:
- 01_schema.sql  
- 02_etl.sql  

We added the appropriate SQL code to these files and saved the changes using git add and git commit.

---

## Step 6: Configure Environment Variables

We opened the .env file, which is used to configure database parameters.  
The following variables were added:

PORT=5432  
DB_USER=admin  
DB_PASSWORD=password  
DB_NAME=aca  
PGADMIN_EMAIL=admin@admin.com  
PGADMIN_PASSWORD=admin  

After configuring the environment variables, we ran git add and git commit.

---

## Step 7: Create Docker Compose File

We created a new file named docker-compose.yaml.  
The required Docker configuration code was added to the file, and the changes were saved using git add and git commit.

---

## Step 8: Start Docker Containers

We opened the Terminal in Visual Studio Code and started Docker Desktop on the system.  
Then, we ran the docker compose up command to start the containers.

---

## Step 9: Access pgAdmin

While the database was starting, we accessed pgAdmin using the following address:

http://localhost:5050/

We logged in, connected to the server, and completed the necessary setup steps before executing the SQL code.

---

## Step 10: Execute SQL Code and Stop the Server

We copied and pasted our SQL code into the Query Tool in pgAdmin and executed it.  
As a result, the database appeared successfully.

Finally, to stop the server and containers, we ran the docker compose down command.

---

## Result

The database was successfully created, configured, and launched using Docker and pgAdmin.
