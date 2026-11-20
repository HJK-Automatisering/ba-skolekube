-- =============================================================================
-- dw.fact_student_snapshot
-- =============================================================================
-- Daily snapshot of all current students. One row per student.
-- Filled by dw.usp_load_fact_student_snapshot.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[fact_student_snapshot](
	[snapshot_id] [int] IDENTITY(1,1) NOT NULL,
	[date_id] [int] NOT NULL,
	[student_id] [int] NOT NULL,
	[school_code] [int] NOT NULL,
	[municipality_code] [int] NOT NULL,
	[paying_mun_code] [int] NOT NULL,
	[student_type_code] [int] NOT NULL,
	[citizenship_code] [int] NOT NULL,
	[country_code] [int] NOT NULL,
	[language_code] [int] NOT NULL,
	[grade_level] [smallint] NULL,
	[class_track] [nvarchar](2) NULL,
	[student_level] [smallint] NULL,
	[gender] [nvarchar](1) NULL,
	[age] [tinyint] NULL,
	[action_danish_second_lang] [tinyint] NOT NULL,
	[action_reception_class] [tinyint] NOT NULL,
	[action_special_education] [tinyint] NOT NULL,
	[action_supp_danish] [tinyint] NOT NULL,
	[action_junior_master] [tinyint] NOT NULL,
	[action_intermediate] [tinyint] NOT NULL,
 CONSTRAINT [pk_fact_student_snapshot] PRIMARY KEY CLUSTERED 
(
	[snapshot_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dw].[fact_student_snapshot] ADD  DEFAULT ((0)) FOR [action_danish_second_lang]
GO
ALTER TABLE [dw].[fact_student_snapshot] ADD  DEFAULT ((0)) FOR [action_reception_class]
GO
ALTER TABLE [dw].[fact_student_snapshot] ADD  DEFAULT ((0)) FOR [action_special_education]
GO
ALTER TABLE [dw].[fact_student_snapshot] ADD  DEFAULT ((0)) FOR [action_supp_danish]
GO
ALTER TABLE [dw].[fact_student_snapshot] ADD  DEFAULT ((0)) FOR [action_junior_master]
GO
ALTER TABLE [dw].[fact_student_snapshot] ADD  DEFAULT ((0)) FOR [action_intermediate]
GO
ALTER TABLE [dw].[fact_student_snapshot]  WITH CHECK ADD  CONSTRAINT [fk_snapshot_student_type] FOREIGN KEY([student_type_code])
REFERENCES [dw].[dim_student_type] ([student_type_code])
GO
ALTER TABLE [dw].[fact_student_snapshot] CHECK CONSTRAINT [fk_snapshot_student_type]
GO
