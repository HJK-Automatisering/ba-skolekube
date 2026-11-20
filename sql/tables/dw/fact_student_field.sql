-- =============================================================================
-- dw.fact_student_field
-- =============================================================================
-- Student field/value fact.
-- Filled by dw.usp_load_fact_student_field.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[fact_student_field](
	[field_id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NOT NULL,
	[field_name] [nvarchar](50) NOT NULL,
	[field_value] [nvarchar](55) NULL,
 CONSTRAINT [pk_fact_student_field] PRIMARY KEY CLUSTERED 
(
	[field_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
