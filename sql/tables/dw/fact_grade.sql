-- =============================================================================
-- dw.fact_grade
-- =============================================================================
-- Grade fact.
-- Filled by dw.usp_load_fact_grade.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[fact_grade](
	[grade_id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NOT NULL,
	[subject_code] [int] NOT NULL,
	[discipline_code] [int] NOT NULL,
	[grade_level] [smallint] NULL,
	[school_year] [smallint] NULL,
	[fs10] [bit] NULL,
	[sp1_grade] [nvarchar](2) NULL,
	[sp2_grade] [nvarchar](2) NULL,
	[sps_grade] [nvarchar](2) NULL,
	[arb1_grade] [nvarchar](2) NULL,
	[arb2_grade] [nvarchar](2) NULL,
	[arbs_grade] [nvarchar](2) NULL,
	[prv_grade] [nvarchar](2) NULL,
	[school_code] [int] NOT NULL,
	[exam_type_code] [nvarchar](2) NOT NULL,
 CONSTRAINT [pk_fact_grade] PRIMARY KEY CLUSTERED 
(
	[grade_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
