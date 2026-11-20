-- =============================================================================
-- dw.fact_absence_lesson
-- =============================================================================
-- Lesson-level absence fact.
-- Filled by dw.usp_load_fact_absence_lesson.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[fact_absence_lesson](
	[absence_id] [bigint] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NOT NULL,
	[absence_reason_code] [nvarchar](2) NOT NULL,
	[date_id] [int] NOT NULL,
	[lesson_number] [tinyint] NULL,
	[subject_code] [int] NOT NULL,
	[school_code] [int] NOT NULL,
	[grade_level] [smallint] NULL,
	[track] [nvarchar](2) NULL,
	[absence_value] [tinyint] NOT NULL,
 CONSTRAINT [pk_fact_absence_lesson] PRIMARY KEY CLUSTERED 
(
	[absence_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dw].[fact_absence_lesson] ADD  DEFAULT ((1)) FOR [absence_value]
GO
ALTER TABLE [dw].[fact_absence_lesson]  WITH CHECK ADD  CONSTRAINT [fk_fact_absence_lesson_reason] FOREIGN KEY([absence_reason_code])
REFERENCES [dw].[dim_absence_reason] ([absence_reason_code])
GO
ALTER TABLE [dw].[fact_absence_lesson] CHECK CONSTRAINT [fk_fact_absence_lesson_reason]
GO
