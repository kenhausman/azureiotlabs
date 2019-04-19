CREATE TABLE [dbo].[fact_Telemetry]
(
	[messageId] int NULL,
	[deviceId] varchar(50) NULL,
	[temperature] numeric(10,5) NULL,
	[humidity] numeric(10,5) NULL,
	[EventProcessedUtcTime] varchar(50) NULL,
	[PartitionId] int NULL,
	[EventEnqueuedUtcTime] varchar(50) NULL,
	[time] varchar(50) NULL,
	[IoTHub.MessageId] varchar(50) NULL,
	[IoTHub.CorrelationId] varchar(50) NULL,
	[IoTHub.ConnectionDeviceId] varchar(50) NULL,
	[IoTHub.ConnectionDeviceGenerationId] varchar(50) NULL,
	[IoTHub.EnqueuedTime] varchar(50) NULL,
	[IoTHub.StreamId] varchar(50) NULL
)
WITH
(
	DISTRIBUTION = HASH ( [deviceId] ),
	CLUSTERED COLUMNSTORE INDEX
)


