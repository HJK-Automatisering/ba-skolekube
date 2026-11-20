-- =============================================================================
-- meta.meta_run_step
-- =============================================================================
-- Step log. One row per step in an ETL run.
-- Filled by meta.usp_meta_start_step and meta.usp_meta_finish_step.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [meta].[meta_run_step](
	[step_id] [int] IDENTITY(1,1) NOT NULL,
	[run_id] [int] NOT NULL,
	[procedure_name] [nvarchar](200) NOT NULL,
	[step_name] [nvarchar](200) NOT NULL,
	[started_at] [datetime2](7) NOT NULL,
	[finished_at] [datetime2](7) NULL,
	[status] [nvarchar](10) NOT NULL,
	[rows_read] [int] NULL,
	[rows_inserted] [int] NULL,
	[rows_updated] [int] NULL,
	[rows_deleted] [int] NULL,
	[error_message] [nvarchar](2000) NULL,
 CONSTRAINT [pk_meta_run_step] PRIMARY KEY CLUSTERED 
(
	[step_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [meta].[meta_run_step] ADD  DEFAULT (sysutcdatetime()) FOR [started_at]
GO
ALTER TABLE [meta].[meta_run_step] ADD  DEFAULT ('running') FOR [status]
GO
ALTER TABLE [meta].[meta_run_step]  WITH CHECK ADD  CONSTRAINT [fk_meta_run_step_run] FOREIGN KEY([run_id])
REFERENCES [meta].[meta_run] ([run_id])
GO
ALTER TABLE [meta].[meta_run_step] CHECK CONSTRAINT [fk_meta_run_step_run]
GO
ALTER TABLE [meta].[meta_run_step]  WITH CHECK ADD  CONSTRAINT [ck_meta_run_step_status] CHECK  (([status]='skipped' OR [status]='failed' OR [status]='success' OR [status]='running'))
GO
ALTER TABLE [meta].[meta_run_step] CHECK CONSTRAINT [ck_meta_run_step_status]
GO
