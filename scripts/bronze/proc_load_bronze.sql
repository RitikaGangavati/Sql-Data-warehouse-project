EXEC bronze.load_bronze;

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	BEGIN TRY
			DECLARE @start_time DATETIME , @end_time DATETIME ,@batch_start_time DATETIME,@batch_end_time DATETIME ;
			SET @batch_start_time= GETDATE();
			PRINT('====================================');
			PRINT('Loading data into bronze layer...');
			PRINT('====================================');

			PRINT('------------------------');
			PRINT('Loading CRM Tables.');
			PRINT('------------------------');

			SET @start_time= GETDATE();
			PRINT('>> Truncating Table: bronze.crm_cust_info');
			TRUNCATE TABLE bronze.crm_cust_info;

			PRINT('>> Loading data into Table: bronze.crm_cust_info');
			BULK INSERT bronze.crm_cust_info
			FROM 'C:\Users\ritug\Downloads\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
			WITH(
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			)
			SET @end_time= GETDATE();
			PRINT('>>> LOADING DURATION:'+ CAST(DATEDIFF(SECOND ,@start_time,@end_time) AS NVARCHAR)+'SECONDS');
			PRINT('------------------------');


			SET @start_time= GETDATE();
			PRINT('>> Truncating Table: bronze.crm_prd_info');
			TRUNCATE TABLE bronze.crm_prd_info;

			PRINT('>> Loading data into Table: bronze.crm_prd_info');
			BULK INSERT bronze.crm_prd_info
			FROM 'C:\Users\ritug\Downloads\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
			WITH(
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			)
			SET @end_time= GETDATE();
			PRINT('>>> LOADING DURATION:'+ CAST(DATEDIFF(SECOND ,@start_time,@end_time) AS NVARCHAR)+'SECONDS');
			PRINT('------------------------');


			SET @start_time= GETDATE();
			PRINT('>> Truncating Table: bronze.crm_sales_details');
			TRUNCATE TABLE bronze.crm_sales_details;

			PRINT('>> Loading data into Table: bronze.crm_sales_details');
			BULK INSERT bronze.crm_sales_details
			FROM 'C:\Users\ritug\Downloads\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
			WITH(
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			)
			SET @end_time= GETDATE();
			PRINT('>>> LOADING DURATION:'+ CAST(DATEDIFF(SECOND ,@start_time,@end_time) AS NVARCHAR)+'SECONDS');
			PRINT('------------------------');


			PRINT('------------------------');
			PRINT('Loading ERP Tables.');
			PRINT('------------------------');

			SET @start_time= GETDATE();
			PRINT('>> Truncating Table: bronze.erp_cust_az12');
			TRUNCATE TABLE bronze.erp_cust_az12;

			PRINT('>> Loading data into Table: bronze.erp_cust_az12');
			BULK INSERT bronze.erp_cust_az12
			FROM 'C:\Users\ritug\Downloads\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
			WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			)
			SET @end_time= GETDATE();
			PRINT('>>> LOADING DURATION:'+ CAST(DATEDIFF(SECOND ,@start_time,@end_time) AS NVARCHAR)+'SECONDS');
			PRINT('------------------------');

			SET @start_time= GETDATE();
			PRINT('>> Truncating Table: bronze.erp_loc_a101');
			TRUNCATE TABLE bronze.erp_loc_a101;

			PRINT('>> Loading data into Table: bronze.erp_loc_a101');
			BULK INSERT bronze.erp_loc_a101
			FROM 'C:\Users\ritug\Downloads\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
			WITH(
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			)
			SET @end_time= GETDATE();
			PRINT('>>> LOADING DURATION:'+ CAST(DATEDIFF(SECOND ,@start_time,@end_time) AS NVARCHAR)+'SECONDS');
			PRINT('------------------------');

			SET @start_time= GETDATE();
			PRINT('>> Truncating Table: bronze.erp_px_cat_g1v2');
			TRUNCATE TABLE bronze.erp_px_cat_g1v2;

			PRINT('>> Loading data into Table: bronze.erp_px_cat_g1v2');
			BULK INSERT bronze.erp_px_cat_g1v2
			FROM 'C:\Users\ritug\Downloads\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
			WITH(
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			)
			SET @end_time= GETDATE();
			PRINT('>>> LOADING DURATION:'+ CAST(DATEDIFF(SECOND ,@start_time,@end_time) AS NVARCHAR)+'SECONDS');
			PRINT('------------------------');

			SET @batch_end_time= GETDATE();
			PRINT('BATCH LOAD DURATION: '+ CAST(DATEDIFF(SECOND ,@batch_start_time,@batch_end_time) AS NVARCHAR)+ 'SECONDS');
			PRINT('====================================');

	END TRY

	BEGIN CATCH
			PRINT('====================================');
			PRINT('ERROR OCCURED DURING LOADING BRONZE LAYER');
			PRINT('ERROR MESSAGE:'+ CAST( ERROR_MESSAGE() AS NVARCHAR));
			PRINT('ERROR MESSAGE:'+ CAST( ERROR_NUMBER() AS NVARCHAR));
			PRINT('ERROR MESSAGE:'+ CAST( ERROR_STATE() AS NVARCHAR));

			PRINT('====================================');
	END CATCH
END
