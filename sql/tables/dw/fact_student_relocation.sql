-- =============================================================================
-- dw.fact_student_relocation
-- =============================================================================
-- Student relocation fact (moved to another municipality).
-- Filled by dw.usp_load_fact_student_relocation.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[fact_student_relocation](
	[relocation_id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NOT NULL,
	[municipality_code] [int] NOT NULL,
	[relocation_date_id] [int] NOT NULL,
 CONSTRAINT [pk_fact_student_relocation] PRIMARY KEY CLUSTERED 
(
	[relocation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
