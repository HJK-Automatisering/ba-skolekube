-- =============================================================================
-- stg.student_absence
-- =============================================================================
-- Staging table for the absence extract (multitype, row_type 5-7).
-- Filled by utils/load_stg.py — deleted and reloaded every run.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[student_absence](
	[row_type] [int] NULL,
	[cpr_nr] [nvarchar](10) NULL,
	[absence_reason] [nvarchar](1) NULL,
	[absence_date] [nvarchar](8) NULL,
	[lesson_number] [int] NULL,
	[half_day_part] [nvarchar](10) NULL,
	[subject_code] [int] NULL,
	[school_code] [int] NULL,
	[class_level] [int] NULL,
	[class_track] [nvarchar](2) NULL,
	[stg_load_date] [datetime] NULL
) ON [PRIMARY]
GO
