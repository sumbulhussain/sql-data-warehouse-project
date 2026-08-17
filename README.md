# sql-data-warehouse-project
Building a modern data warehouse SQL Server, including ETL processes, data modelling, and analytics  

## 📊 Data Warehouse & Analytics Project

A SQL Server-based **Data Warehouse and Analytics project** that integrates CRM and ERP data using a **Bronze–Silver–Gold Medallion Architecture**.

####  🏗️ Architecture

```text
CRM ─────┐
         ├──> Bronze ──> Silver ──> Gold ──> Analytics
ERP ─────┘

Bronze Layer: Stores raw CRM and ERP data loaded from CSV files.
Silver Layer: Cleans, standardizes, validates, and transforms the raw data.
Gold Layer: Contains business-ready fact and dimension tables using a Star Schema.

#### 🔄 ETL Process

The project implements an end-to-end ETL pipeline:

Extract – Load CRM and ERP CSV files into SQL Server.
Transform – Clean, standardize, validate, and integrate the data.
Load – Populate Silver and Gold analytical structures.

Stored procedures are used to automate the Bronze and Silver layer loading processes.

#### ⭐ Data Model
The Gold layer follows a Star Schema containing:

gold.fact_sales
gold.dim_customers
gold.dim_products

The model supports analysis of:

Customer behavior
Product performance
Sales trends
Sales quantity and revenue

#### 🧹 Data Quality
The project includes validation for:

Duplicate records
Missing values
Invalid dates
Incorrect sales calculations
Invalid customer/product records
Data standardization

#### 🛠️ Technologies
SQL Server
T-SQL
SSMS
Stored Procedures
BULK INSERT
Draw.io
Git & GitHub

#### 📂 Repository Structure
data-warehouse-project/
│
├── datasets/
│   ├── source_crm/
│   └── source_erp/
│
├── docs/
│   ├── data_architecture.drawio
│   ├── data_flow.drawio
│   ├── data_models.drawio
│   └── etl.drawio
│
├── scripts/
│   ├── bronze/
│   ├── silver/
│   └── gold/
│
├── tests/
│
├── README.md
└── .gitignore

Key Skills Demonstrated

Data Engineering | SQL | ETL | Data Warehousing | Data Modeling | Data Quality | Data Transformation | Stored Procedures | Star Schema | Analytical SQL

🚀 Future Enhancements
Incremental loading
SCD implementation
Automated data-quality testing
Airflow orchestration
Cloud migration
Power BI reporting
CI/CD integration

