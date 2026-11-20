-- =============================================================================
-- stg.student_history
-- =============================================================================
-- Staging table for the student history extract (multitype, row_type 4-8).
-- Filled by utils/load_stg.py — deleted and reloaded every run.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[student_history](
	[row_type] [int] NULL,
	[cpr_nr] [nvarchar](10) NULL,
	[school_code] [int] NULL,
	[school_name] [nvarchar](200) NULL,
	[school_type_code] [int] NULL,
	[class_label] [nvarchar](200) NULL,
	[class_type_code] [int] NULL,
	[student_level] [int] NULL,
	[class_level] [int] NULL,
	[class_track] [nvarchar](2) NULL,
	[valid_from] [nvarchar](8) NULL,
	[valid_to] [nvarchar](8) NULL,
	[action_type_code] [nvarchar](50) NULL,
	[referral_reason_code] [nvarchar](50) NULL,
	[hours] [decimal](8, 2) NULL,
	[hours_outside] [decimal](8, 2) NULL,
	[event_type_code] [int] NULL,
	[event_date] [nvarchar](8) NULL,
	[field_name] [nvarchar](200) NULL,
	[field_value] [nvarchar](200) NULL,
	[moved_to_mun_code] [int] NULL,
	[moved_date] [nvarchar](8) NULL,
	[stg_load_date] [datetime] NULL
) ON [PRIMARY]
GO
