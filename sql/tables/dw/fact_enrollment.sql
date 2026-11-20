-- =============================================================================
-- dw.fact_enrollment
-- =============================================================================
-- Enrollment history fact.
-- Filled by dw.usp_load_fact_enrollment.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[fact_enrollment](
	[enrollment_id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NOT NULL,
	[school_code] [int] NOT NULL,
	[school_name] [nvarchar](50) NULL,
	[school_type_code] [int] NOT NULL,
	[class_name] [nvarchar](100) NULL,
	[class_type_code] [int] NOT NULL,
	[student_grade_level] [smallint] NULL,
	[home_grade_level] [smallint] NULL,
	[track] [nvarchar](2) NULL,
	[from_date_id] [int] NOT NULL,
	[to_date_id] [int] NULL,
 CONSTRAINT [pk_fact_enrollment] PRIMARY KEY CLUSTERED 
(
	[enrollment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
