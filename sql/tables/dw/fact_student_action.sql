-- =============================================================================
-- dw.fact_student_action
-- =============================================================================
-- Student action (tiltag) fact.
-- Filled by dw.usp_load_fact_student_action.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[fact_student_action](
	[action_id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NOT NULL,
	[action_type_code] [int] NOT NULL,
	[referral_reason_code] [int] NOT NULL,
	[from_date_id] [int] NOT NULL,
	[to_date_id] [int] NULL,
	[hours] [decimal](10, 2) NULL,
	[hours_outside_teaching] [decimal](10, 2) NULL,
 CONSTRAINT [pk_fact_student_action] PRIMARY KEY CLUSTERED 
(
	[action_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dw].[fact_student_action]  WITH CHECK ADD  CONSTRAINT [fk_fact_action_type] FOREIGN KEY([action_type_code])
REFERENCES [dw].[dim_action_type] ([action_type_code])
GO
ALTER TABLE [dw].[fact_student_action] CHECK CONSTRAINT [fk_fact_action_type]
GO
