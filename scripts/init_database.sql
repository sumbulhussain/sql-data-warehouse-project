======================================
  Create Database and Schemas
======================================
use master;
go 
  --drop and recreate DB
  if exists(select 1 from sys.databases where name = 'DataWarehouse')
  begin
  alter database DataWarehouse set single_user with rollback immediate;
drop database DataWarehouse;
end;
go 
  ---create DB
create database DataWarehouse;
use DataWarehouse;
--create schema
create schema bronze;
go
create schema silver;
go
create schema gold;
