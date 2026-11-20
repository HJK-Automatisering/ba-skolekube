-- =============================================================================
-- dw.dim_main_school
-- =============================================================================
-- Main school dimension. include_absence decides absence facts.
-- Filled by dw.usp_load_dim_main_school.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[dim_main_school](
	[main_school_code] [int] NOT NULL,
	[main_school_name] [nvarchar](50) NOT NULL,
	[include_absence] [bit] NOT NULL,
 CONSTRAINT [pk_dim_main_school] PRIMARY KEY CLUSTERED 
(
	[main_school_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dw].[dim_main_school] ADD  DEFAULT ((0)) FOR [include_absence]
GO
