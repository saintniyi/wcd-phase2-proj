CREATE DATABASE MyDB 		-- MyDB is created under serverless sql pool
Use MyDB;
GO;



Create EXTERNAL DATA SOURCE MyExternalDS		 
WITH (
		LOCATION = 'abfss://bd-project@sa4adf1.dfs.core.windows.net' 
);

-- Create a file format
CREATE EXTERNAL FILE FORMAT CSVFormat
WITH (
    FORMAT_TYPE = DELIMITEDTEXT,
    FORMAT_OPTIONS (
        FIELD_TERMINATOR = ',',
        USE_TYPE_DEFAULT = FALSE,
        STRING_DELIMITER = '"',
        FIRST_ROW = 2  
    )
);

CREATE EXTERNAL TABLE dbo.reviews (
	[business_id] NVARCHAR(70),
	[cool] TINYINT,
	[funny] TINYINT,
	[review_id] NVARCHAR(70),
	[text] nvarchar(3500),
	[useful] TINYINT,
	[user_id] nvarchar(50),
	[date] DATETIME2(7),
	[prediction] float,
	[stars] float
	)
	WITH (
	LOCATION = 'final-ratings/',
	DATA_SOURCE = MyExternalDS,
	FILE_FORMAT = [CSVFormat]
	)
GO
SELECT TOP 5 * FROM dbo.reviews
GO




CREATE EXTERNAL TABLE dbo.businesses (
	[business_id] [varchar](50) NULL,
	[name] [varchar](1500) NULL,
	[city] [varchar](50) NULL,
	[state] [varchar](50) NULL,
	[postal_code] [varchar](50) NULL,
	[latitude] [varchar](50) NULL,
	[longitude] [varchar](50) NULL,
	[stars] [varchar](50) NULL,
	[review_count] [varchar](50) NULL,
	[is_open] [varchar](50) NULL
	)
	WITH (
	LOCATION = 'businesses/',
	DATA_SOURCE = MyExternalDS,
	FILE_FORMAT = [CSVFormat]
	)
GO
SELECT TOP 5 * FROM dbo.businesses;




CREATE EXTERNAL TABLE dbo.users (
  user_id varchar(1200) NULL,
  name varchar(1200) NULL,
  review_count int NULL,
  yelping_since varchar(1200) NULL,
  useful int NULL,
  funny int NULL,
  cool int NULL,
  fans int NULL,
  average_stars float NULL
)
WITH (
	LOCATION = 'users/',
	DATA_SOURCE = MyExternalDS,
	FILE_FORMAT = [CSVFormat]
	)
GO
SELECT TOP 5 * FROM dbo.users;
GO;




