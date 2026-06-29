/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
create or alter procedure bronze.load_bronze as
begin
	declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
	begin try
	set @batch_start_time=GETDATE();
		PRINT'=======================';
		PRINT'LOADING BRONZE LAYER...';
		PRINT'=======================';

		PRINT'-----------------------';
		PRINT'LOADING CRM TABLES...';
		PRINT'-----------------------';
		PRINT'>>TRUNCATING TABLE:bronze.crm_cust_info';
		set @start_time=GETDATE();
		truncate table bronze.crm_cust_info;
		PRINT'>>INSERTING DATA INTO:bronze.crm_cust_info';
		bulk insert bronze.crm_cust_info
		from 'D:\SQL\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
		with(
			firstrow=2,
			fieldterminator=',',
			tablock
			);
		set @end_time=GETDATE();
		print'>>load duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + ' seconds';
		print'>>------------------------------'
		--select count(*) from bronze.crm_cust_info

		PRINT'>>TRUNCATING TABLE:bronze.crm_prd_info';
		set @start_time=GETDATE();
		truncate table bronze.crm_prd_info;
		PRINT'INSERTING DATA INTO:bronze.crm_prd_info';
		bulk insert bronze.crm_prd_info
		from 'D:\SQL\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
		with(
			firstrow=2,
			fieldterminator=',',
			tablock
			);
		set @end_time=GETDATE();
		print'>>load duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + ' seconds';
		print'>>------------------------------'
		--select count(*) from bronze.crm_prd_info

		PRINT'>>TRUNCATING TABLE:bronze.crm_sales_details';
		set @start_time=GETDATE();
		truncate table bronze.crm_sales_details;
		PRINT'INSERTING DATA INTO:bronze.crm_sales_details';
		bulk insert bronze.crm_sales_details
		from 'D:\SQL\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
		with(
			firstrow=2,
			fieldterminator=',',
			tablock
			);
		set @end_time=GETDATE();
		print'>>load duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + ' seconds';
		print'>>------------------------------'
		--select count(*) from bronze.crm_sales_details

		PRINT'-----------------------';
		PRINT'LOADING ERP TABLES...';
		PRINT'-----------------------';
		PRINT'>>TRUNCATING TABLE:bronze.erp_cust_az12';
		set @start_time=GETDATE();
		truncate table bronze.erp_cust_az12;
		PRINT'INSERTING DATA INTO:bronze.erp_cust_az12';
		bulk insert bronze.erp_cust_az12
		from 'D:\SQL\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\cust_az12.csv'
		with(
			firstrow=2,
			fieldterminator=',',
			tablock
			);
		set @end_time=GETDATE();
		print'>>load duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + ' seconds';
		print'>>------------------------------'
		--select count(*) from bronze.erp_cust_az12

		PRINT'>>TRUNCATING TABLE:bronze.erp_cust_az12';
		set @start_time=GETDATE();
		truncate table bronze.erp_loc_a101;
		PRINT'INSERTING DATA INTO:bronze.erp_cust_az12';
		bulk insert bronze.erp_loc_a101
		from 'D:\SQL\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\loc_a101.csv'
		with(
			firstrow=2,
			fieldterminator=',',
			tablock
			);
		set @end_time=GETDATE();
		print'>>load duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + ' seconds';
		print'>>------------------------------'
		--select count(*) from bronze.erp_loc_a101

		PRINT'>>TRUNCATING TABLE:bronze.erp_px_cat_g1v2'
		set @start_time=GETDATE();
		truncate table bronze.erp_px_cat_g1v2;
		PRINT'INSERTING DATA INTO:bronze.erp_px_cat_g1v2'
		bulk insert bronze.erp_px_cat_g1v2
		from 'D:\SQL\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\px_cat_g1v2.csv'
		with(
			firstrow=2,
			fieldterminator=',',
			tablock
			);
		set @end_time=GETDATE();
		print'>>load duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + ' seconds';
		print'>>------------------------------'
		--select count(*) from bronze.erp_px_cat_g1v2
		set @batch_end_time=GETDATE();
		print'>>total load duration: '+ cast(datediff(second,@batch_start_time,@batch_end_time) as nvarchar) + ' seconds';
	end try
	begin catch
		print'==============================';
		print'error occured during loading bronze layer';
		print'==============================';
		print'error message: '+ error_message();
		print'error message: '+ cast(error_number() as nvarchar);
		print'error message: '+ cast(error_state() as nvarchar);
	end catch
end
