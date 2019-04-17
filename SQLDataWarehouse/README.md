# Batch Analytics

## Batch Analytics with SQL Data Warehouse and Data Factory

SQL Data Warehouse is a cloud-based Enterprise Data Warehouse (EDW) that leverages Massively Parallel Processing (MPP) to quickly run complex queries across petabytes of data. Use SQL Data Warehouse as a key component of a big data solution. Import big data into SQL Data Warehouse with simple PolyBase T-SQL queries, and then use the power of MPP to run high-performance analytics. As you integrate and analyze, the data warehouse will become the single version of truth your business can count on for insights.

Azure Data Factory is a cloud-based data integration service that allows you to create data-driven workflows in the cloud for orchestrating and automating data movement and data transformation. Using Azure Data Factory, you can create and schedule data-driven workflows (called pipelines) that can ingest data from disparate data stores. It can process and transform the data by using compute services such as Azure HDInsight Hadoop, Spark, Azure Data Lake Analytics, and Azure Machine Learning.

In this lab Learn how to 

* automatically export data coming into Azure IoT Hub for archival.
* how to create an ingestion pipeline using Azure Data Factory, and
* how to use Data Warehouse to run big data analysis jobs that scale to massive data sets using familar tools.

## Create Azure SQL Data Warehouse Service

Create Data Lakae Analytics service to mine data stored in Data Lake Store.

Click on **Create a resource**

![Create SQL Warehouse Service](images/create_resource.png)

Click on **Databases**

![Create SQL Warehouse Service](images/dataanalytics.png)

Click on **SQL Data Warehouse**

![Create SQL Warehouse Service](images/01_Create_Data_Lake_Analytics_Service.png)

Create a new logical SQL Server which will act as the front end for your data warehouse

![Create SQL Server](images/02_Create_Data_Lake_Pick_Store.png)

Since our intention is to showcase capabilities rather than performance, choose DW200c as the Performance Level

![Choose Performance](images/03_Create_Data_Lake_Analytics_Performance.png)

Use existing resource group and click on Create button

## Create Sample Data and Install Extensions

Click on Sample scripts 

![Create Sample Data](images/04_Create_Data_Lake_Analytics_Sample_Scripts.png)

Click on sample data missing button to create sample data in Data lake Store 

![Create Sample Data](images/05_Create_Data_Lake_Analytics_Sample_Data.png)

You should see successful message after data is copied

![Create Sample Data](images/06_Create_Data_Lake_Analytics_Sample_Data_Successful.png)

Install Extensions

![Install Extensions](images/07_Create_Data_Lake_Analytics_Install_Extensions.png)

Successful Extension installation

![Install Extensions](images/08_Create_Data_Lake_Analytics_Install_Extensions_Success.png)


## VS Code Integration

Submit Job using VS Code, Try Samples First to Learn through Data Lake Analytics

Install VS Code Extension for Data Lake Analytics

![Install Extensions](images/data-lake-tools-for-vscode-extensions.png)

### Run Samples

Run Samples to learn Data Lake Analytics

![Run Samples](images/09_VSCode_Open_Sample_Script.png)

Compile Script

![Compile Script](images/10_VSCode_Open_Sample_Script_Compile.png)

Click on List more accounts

![Run Samples]images/11_VSCode_Open_Sample_Script_Compile_Select_Account.png)

Select a Data Lake Analytics Account

![Select Account](images/12_VSCode_Open_Sample_Script_Compile_Account.png)

Select master key

![Select master key](images/13_VSCode_Open_Sample_Script_Compile_master.png)

Compile as USQL

![Compile USQL](images/14_VSCode_Open_Sample_Script_Compile_usql.png)

USQL script should be compiled

![Compiled USQL](images/15_VSCode_Open_Sample_Script_Compile_submit.png)

Submit Job To Run

![Submit Job](images/16_VSCode_Open_Sample_Script_Submit_Job.png)

Default priority is 1000 and number default number of nodes to run the script are 5

![Submit Job Success](images/17_VSCode_Open_Sample_Script_Submit_Job_success.png)

Job Success with Job Analytics

![Job Success](images/18_VSCode_Open_Sample_Script_Submit_Job_success_portal.png)

View Input File

![Veiw Input File](images/19_VSCode_Open_Sample_Script_Input_Data.png)

View Output File

![View Output File](images/20_VSCode_Open_Sample_Script_Output_Data.png)

## Create an Analytics Job against MXChip Data to convert JSON to CSV using U-SQL and Data Lake Analytics

### Create a new mxchip_analytics.usql file in the project

```sql
REFERENCE ASSEMBLY [Newtonsoft.Json];
REFERENCE ASSEMBLY [Microsoft.Analytics.Samples.Formats]; 

//Extract the Json string using a default Text extractor. 

@json = 
    EXTRACT jsonString string FROM @"/workshop/streaming/2018/03/{*}/{*}.json" USING Extractors.Tsv(quoting:false);

//Use the JsonTuple function to get the Json Token of the string so it can be parsed later with Json .NET functions

@jsonify = SELECT Microsoft.Analytics.Samples.Formats.Json.JsonFunctions.JsonTuple(jsonString) AS rec FROM @json;

@columnized = SELECT 
            rec["deviceId"] AS deviceId,
            rec["temperature"] AS temperature,
            rec["humidity"] AS humidity,
            rec["time"] AS time
    FROM @jsonify;



//Output the file to a tool of your choice.

OUTPUT @columnized
TO @"/workshop/output/out.csv"
USING Outputters.Csv();

```

Register two assemblies Newtonsoft and Samples.formats. Download the dlls from /libs folder and register

![U-SQL Analytics](images/21_Register_Assembly_Command.png)

Select the dlls from the /libs folder

![U-SQL Analytics](images/22_Register_Sample_Formats.png)

### Submit Job

Submit Job to convert all JSON files to CSV files

![U-SQL Analytics](images/23_SubmitJob.png)

View Jobs

![U-SQL Analytics](images/24_Submitted_Jobs.png)
