
--USE Master; ---For declaring use of master database where warehouse data base will be created

--IF OBJECT_ID ('Datawarehouse','U') IS NOT NULL
--DROP DATABASE Datawarehouse

--CREATE DATABASE Datawarehouse;
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

--USE Datawarehouse; 
--GO
--CREATE Schema bronze;
--GO
--CREATE Schema silver;
--Go
--CREATE Schema gold;

----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE bronze.load_bronze AS  

BEGIN
	DECLARE @start_time DATETIME , @end_time DATETIME, @bronze_start_time DATETIME, @bronze_end_time DATETIME

	set @bronze_start_time = GETDATE()

	BEGIN TRY

		PRINT '=====================================================================================================================';
		PRINT 'LOADING BRONZE LAYER';
		PRINT '=====================================================================================================================';
	
		PRINT '---------------------------------------------------------------------------------------------------------------------';
		PRINT 'LOADING CRM TABLES';
		PRINT '---------------------------------------------------------------------------------------------------------------------';

		IF OBJECT_ID ('bronze.crm_cust_info','U') IS NOT NULL
		DROP TABLE bronze.crm_cust_info;

		CREATE TABLE bronze.crm_cust_info
		( 
		cst_id INT,
		cst_key	NVARCHAR (10),
		cst_firstname NVARCHAR(50),
		cst_lastname NVARCHAR (50),
		cst_marital_status	NVARCHAR(1),
		cst_gndr NVARCHAR(1),
		cst_create_date DATE
		);

		SET @start_time = GETDATE()

		PRINT '>>Truncating Table:bronze.crm_cust_info'
		TRUNCATE TABLE bronze.crm_cust_info

		PRINT '>>Inserting Data Into:bronze.crm_cust_info'

		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\adityakadam\OneDrive - PRABHUDAS LILLADHER PVT. LTD\Documents\Data Warehousing Project\Source_CRM\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
			);

		SET @end_time = GETDATE()

		PRINT '================================';
		PRINT '>> Load Duration' + ' ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' ' + 'Seconds';
		PRINT '================================';	
		----------------------------------------------------------------------------------------------------------------------
		----------------------------------------------------------------------------------------------------------------------

		IF OBJECT_ID ('bronze.crm_prd_info','U') IS NOT NULL
		DROP TABLE bronze.crm_prd_info;

		CREATE TABLE bronze.crm_prd_info
		(
		prd_id	INT,
		prd_key	NVARCHAR (50),
		prd_nm	NVARCHAR (50),
		prd_cost INT,
		prd_line VARCHAR (5),
		prd_start_dt DATE,
		prd_end_dt DATE
		)

		set @start_time = GETDATE()
		PRINT '>>Truncating Table:bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>>Inserting Data Into:bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\adityakadam\OneDrive - PRABHUDAS LILLADHER PVT. LTD\Documents\Data Warehousing Project\Source_CRM\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
			);

		set @end_time = GETDATE()

		PRINT '================================';
		PRINT '>> Load Duration' + ' ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' ' + 'Seconds';
		PRINT '================================';	
		----------------------------------------------------------------------------------------------------------------------
		----------------------------------------------------------------------------------------------------------------------

		IF OBJECT_ID ('bronze.crm_sales_details','U') IS NOT NULL
		DROP TABLE bronze.crm_sales_details;

		CREATE TABLE bronze.crm_sales_details
		(
		sls_ord_num	NVARCHAR(50),
		sls_prd_key	NVARCHAR(50),
		sls_cust_id	INT,
		sls_order_dt INT,
		sls_ship_dt	INT,
		sls_due_dt	INT,
		sls_sales	INT,
		sls_quantity	INT,
		sls_price INT
		);
	
		set @start_time = GETDATE()
		PRINT '>>Truncating Table:bronze.crm_sales_details'
		TRUNCATE TABLE bronze.crm_sales_details

		PRINT '>>Inserting Data Into:bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\adityakadam\OneDrive - PRABHUDAS LILLADHER PVT. LTD\Documents\Data Warehousing Project\Source_CRM\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
			);
		
		set @end_time = GETDATE()

		PRINT '================================';
		PRINT '>> Load Duration' + ' ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' ' + 'Seconds';
		PRINT '================================';	

		----------------------------------------------------------------------------------------------------------------------
		----------------------------------------------------------------------------------------------------------------------
		PRINT '---------------------------------------------------------------------------------------------------------------------';
		PRINT 'LOADING ERP TABLES';
		PRINT '---------------------------------------------------------------------------------------------------------------------';

		IF OBJECT_ID ('bronze.erp_cust_az12','U') IS NOT NULL
		DROP TABLE bronze.erp_cust_az12;

		CREATE TABLE bronze.erp_cust_az12
		(
		cid NVARCHAR(50),
		bdate DATE,
		gen NVARCHAR(50)
		);

		set @start_time = GETDATE()

		PRINT '>>Truncating Table:bronze.erp_cust_az12'
		TRUNCATE TABLE bronze.erp_cust_az12

		PRINT '>>Inserting Data Into:bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\adityakadam\OneDrive - PRABHUDAS LILLADHER PVT. LTD\Documents\Data Warehousing Project\Source_ERP\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
			);

		set @end_time = GETDATE()

		PRINT '================================';
		PRINT '>> Load Duration' + ' ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' ' + 'Seconds';
		PRINT '================================';	

		----------------------------------------------------------------------------------------------------------------------
		----------------------------------------------------------------------------------------------------------------------

		IF OBJECT_ID ('bronze.erp_loc_a101','U') IS NOT NULL
		DROP TABLE bronze.erp_loc_a101;

		CREATE TABLE bronze.erp_loc_a101
		(
		cid NVARCHAR(50),
		cntry VARCHAR(50)
		);

		set @start_time = GETDATE()

		PRINT '>>Truncating Table:bronze.erp_loc_a101'
		TRUNCATE TABLE bronze.erp_loc_a101

		PRINT '>>Inserting Data Into:bronze.erp_loc_a101'

		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\adityakadam\OneDrive - PRABHUDAS LILLADHER PVT. LTD\Documents\Data Warehousing Project\Source_ERP\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
			);

		set @end_time = GETDATE()

		PRINT '================================';
		PRINT '>> Load Duration' + ' ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' ' + 'Seconds';
		PRINT '================================';	
		----------------------------------------------------------------------------------------------------------------------
		----------------------------------------------------------------------------------------------------------------------

		IF OBJECT_ID ('bronze.erp_px_cat_g1v2','U') IS NOT NULL
		DROP TABLE bronze.erp_px_cat_g1v2;

		CREATE TABLE bronze.erp_px_cat_g1v2
		( id NVARCHAR (50),
		cat NVARCHAR (50),
		subcat NVARCHAR (50),
		maintenance VARCHAR (50)
		);

		set @start_time = GETDATE()

		PRINT '>>Truncating Table:bronze.erp_px_cat_g1v2'
		TRUNCATE TABLE bronze.erp_px_cat_g1v2

		PRINT '>>Inserting Data Into:bronze.erp_px_cat_g1v2'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\adityakadam\OneDrive - PRABHUDAS LILLADHER PVT. LTD\Documents\Data Warehousing Project\Source_ERP\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
			);

		set @end_time = GETDATE()

		PRINT '================================';
		PRINT '>> Load Duration' + ' ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' ' + 'Seconds';
		PRINT '================================';	


	END TRY
	BEGIN CATCH
		PRINT '=============================================================================='
		PRINT 'Error Occured During Loading Bronze Layer'
		PRINT 'Error Message' + ERROR_MESSAGE()
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR)
		PRINT 'Error State' + CAST(ERROR_STATE() AS NVARCHAR)
		PRINT '=============================================================================='
	END CATCH

	set @bronze_end_time = GETDATE()

	PRINT '======================================================'
	PRINT 'Bronze Layer Load Time' + ' ' + CAST(DATEDIFF(SECOND, @bronze_start_time, @bronze_end_time) AS NVARCHAR) + ' ' + 'Second'
	PRINT '======================================================'

END

