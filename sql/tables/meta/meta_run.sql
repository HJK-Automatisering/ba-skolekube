-- =============================================================================
-- meta.meta_run
-- =============================================================================
-- Run log. One row per ETL run.
-- Filled by meta.usp_meta_start_run and meta.usp_meta_finish_run.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [meta].[meta_run](
	[run_id] [int] IDENTITY(1,1) NOT NULL,
	[started_at] [datetime2](7) NOT NULL,
	[finished_at] [datetime2](7) NULL,
	[status] [nvarchar](10) NOT NULL,
	[triggered_by] [nvarchar](100) NOT NULL,
	[server_name] [nvarchar](100) NOT NULL,
	[database_name] [nvarchar](100) NOT NULL,
	[error_message] [nvarchar](2000) NULL,
 CONSTRAINT [pk_meta_run] PRIMARY KEY CLUSTERED 
(
	[run_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [meta].[meta_run] ADD  DEFAULT (sysutcdatetime()) FOR [started_at]
GO
ALTER TABLE [meta].[meta_run] ADD  DEFAULT ('running') FOR [status]
GO
ALTER TABLE [meta].[meta_run] ADD  DEFAULT (suser_sname()) FOR [triggered_by]
GO
ALTER TABLE [meta].[meta_run] ADD  DEFAULT (@@servername) FOR [server_name]
GO
ALTER TABLE [meta].[meta_run] ADD  DEFAULT (db_name()) FOR [database_name]
GO
ALTER TABLE [meta].[meta_run]  WITH CHECK ADD  CONSTRAINT [ck_meta_run_status] CHECK  (([status]='failed' OR [status]='success' OR [status]='running'))
GO
ALTER TABLE [meta].[meta_run] CHECK CONSTRAINT [ck_meta_run_status]
GO
