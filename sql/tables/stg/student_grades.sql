-- =============================================================================
-- stg.student_grades
-- =============================================================================
-- Staging table for the grades extract (multitype).
-- Filled by utils/load_stg.py — deleted and reloaded every run.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[student_grades](
	[cpr_nr] [nvarchar](10) NULL,
	[subject_code] [nvarchar](50) NULL,
	[discipline_code] [nvarchar](50) NULL,
	[class_level] [int] NULL,
	[school_year_int] [int] NULL,
	[is_fs10] [bit] NULL,
	[grade_sp1] [nvarchar](2) NULL,
	[grade_sp2] [nvarchar](2) NULL,
	[grade_sp_final] [nvarchar](2) NULL,
	[grade_work1] [nvarchar](2) NULL,
	[grade_work2] [nvarchar](2) NULL,
	[grade_work_final] [nvarchar](2) NULL,
	[grade_exam] [nvarchar](2) NULL,
	[school_code] [int] NULL,
	[uvm_discipline_code] [nvarchar](50) NULL,
	[exam_type_code] [nvarchar](1) NULL,
	[stg_load_date] [datetime] NULL
) ON [PRIMARY]
GO
