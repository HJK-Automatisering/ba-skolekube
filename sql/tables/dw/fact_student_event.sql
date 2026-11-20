-- =============================================================================
-- dw.fact_student_event
-- =============================================================================
-- Student event fact.
-- Filled by dw.usp_load_fact_student_event.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[fact_student_event](
	[event_id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NOT NULL,
	[event_type_code] [int] NOT NULL,
	[date_id] [int] NOT NULL,
 CONSTRAINT [pk_fact_student_event] PRIMARY KEY CLUSTERED 
(
	[event_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
