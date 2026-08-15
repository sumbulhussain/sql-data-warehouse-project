
-- ============================================
-- LOAD BRONZE DATA
-- ============================================

GO
CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
declare @start_time datetime, @end_time datetime
begin try
print '===================================='
print 'Loading Bronze Layer'
print '===================================='

print '--------------------------------------'
print 'loading CRM Tables'
print '--------------------------------------'

 -- CRM Customer
    set @start_time = getdate();
    print'>>truncating data from table:'
    TRUNCATE TABLE bronze.crm_cust_info;

    print'>>inserting data for table'
    BULK INSERT bronze.crm_cust_info
    FROM 'C:\Users\hp\OneDrive\Documents\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
    set @end_time = getdate();
    print '>>load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';

        -- CRM Product
        set @start_time = getdate();
     print'>>truncating data from table:'
    TRUNCATE TABLE bronze.crm_prod_info;

     print'>>inserting data for table'
    BULK INSERT bronze.crm_prod_info
    FROM 'C:\Users\hp\OneDrive\Documents\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
        set @end_time = getdate();
        print '>>load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';

            -- CRM Sales
        set @start_time = getdate();
     print'>>truncating data from table:'
    TRUNCATE TABLE bronze.crm_sales_details;

     print'>>inserting data for table'
    BULK INSERT bronze.crm_sales_details
    FROM 'C:\Users\hp\OneDrive\Documents\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
        set @end_time = getdate();
                print '>>load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';

print '--------------------------------------'
print 'loading ERP Tables'
print '--------------------------------------'

    -- ERP Location
         set @start_time = getdate();
     print'>>truncating data from table:'
    TRUNCATE TABLE bronze.erp_loc_a101;

     print'>>inserting data for table'
    BULK INSERT bronze.erp_loc_a101
    FROM 'C:\Users\hp\OneDrive\Documents\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
        set @end_time = getdate();
                print '>>load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';

            -- ERP Customer
        set @start_time = getdate();
     print'>>truncating data from table:'
    TRUNCATE TABLE bronze.erp_cust_az12;

     print'>>inserting data for table'
    BULK INSERT bronze.erp_cust_az12
    FROM 'C:\Users\hp\OneDrive\Documents\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
        set @end_time = getdate();
                print '>>load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';

           -- ERP Product Category
        set @start_time = getdate();
     print'>>truncating data from table:'
    TRUNCATE TABLE bronze.erp_px_cat_glv2;

     print'>>inserting data for table'
    BULK INSERT bronze.erp_px_cat_glv2
    FROM 'C:\Users\hp\OneDrive\Documents\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
        set @end_time = getdate();
                print '>>load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';

    end try
    begin catch 
    print '========================'
    print 'error occured during loading bronze layer'
    print 'error message:'
    print '========================'
    end catch
END;
GO

--test procedure-----
exec bronze.load_bronze


