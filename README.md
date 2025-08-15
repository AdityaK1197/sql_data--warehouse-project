# sql_data--warehouse-project
Building a modern data warehouse with SQL server, including ETL processes, data modeling, and analytics

step 1 - As diffined in data warehouse structrue design, we will create Bronze, Silver, Gold schemas

Find datawarehouse structrue here > https://drive.google.com/file/d/1JrcRmgOqJPLmMOpDALb1c_RN-GNuw2P0/view?usp=sharing


USE Master;

CREATE DATABASE Datawarehouse;

USE Datawarehouse; 
GO

CREATE Schema bronze;
GO

CREATE Schema silver;
Go

CREATE Schema gold;


