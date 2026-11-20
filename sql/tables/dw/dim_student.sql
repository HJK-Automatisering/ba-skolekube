-- =============================================================================
-- dw.dim_student
-- =============================================================================
-- Student dimension, non-sensitive part (class, school, actions, age).
-- Filled by dw.usp_load_dim_student.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[dim_student](
	[student_id] [int] NOT NULL,
	[age] [tinyint] NULL,
	[student_level] [smallint] NULL,
	[grade_level] [smallint] NULL,
	[class_track] [nvarchar](2) NULL,
	[class_label] [nvarchar](100) NULL,
	[school_district_code] [int] NULL,
	[photo_permission] [nvarchar](3) NULL,
	[transport_permission] [nvarchar](3) NULL,
	[action_danish_second_lang] [bit] NOT NULL,
	[action_reception_class] [bit] NOT NULL,
	[action_special_education] [bit] NOT NULL,
	[action_supp_danish] [bit] NOT NULL,
	[action_junior_master] [bit] NOT NULL,
	[action_intermediate] [bit] NOT NULL,
	[municipality_code] [int] NOT NULL,
	[paying_mun_code] [int] NOT NULL,
	[school_code] [int] NOT NULL,
	[student_type_code] [int] NOT NULL,
	[citizenship_code] [int] NOT NULL,
	[country_code] [int] NOT NULL,
	[language_code] [int] NOT NULL,
	[previous_main_school_code] [int] NULL,
	[allow_access_from_prev_school] [bit] NOT NULL,
 CONSTRAINT [pk_dim_student] PRIMARY KEY CLUSTERED 
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dw].[dim_student] ADD  DEFAULT ((0)) FOR [action_danish_second_lang]
GO
ALTER TABLE [dw].[dim_student] ADD  DEFAULT ((0)) FOR [action_reception_class]
GO
ALTER TABLE [dw].[dim_student] ADD  DEFAULT ((0)) FOR [action_special_education]
GO
ALTER TABLE [dw].[dim_student] ADD  DEFAULT ((0)) FOR [action_supp_danish]
GO
ALTER TABLE [dw].[dim_student] ADD  DEFAULT ((0)) FOR [action_junior_master]
GO
ALTER TABLE [dw].[dim_student] ADD  DEFAULT ((0)) FOR [action_intermediate]
GO
ALTER TABLE [dw].[dim_student] ADD  DEFAULT ((0)) FOR [allow_access_from_prev_school]
GO
ALTER TABLE [dw].[dim_student]  WITH CHECK ADD  CONSTRAINT [FK_dim_student_school_district] FOREIGN KEY([school_district_code])
REFERENCES [dw].[dim_school_district] ([school_district_code])
GO
ALTER TABLE [dw].[dim_student] CHECK CONSTRAINT [FK_dim_student_school_district]
GO
ALTER TABLE [dw].[dim_student]  WITH CHECK ADD  CONSTRAINT [fk_dim_student_type] FOREIGN KEY([student_type_code])
REFERENCES [dw].[dim_student_type] ([student_type_code])
GO
ALTER TABLE [dw].[dim_student] CHECK CONSTRAINT [fk_dim_student_type]
GO
