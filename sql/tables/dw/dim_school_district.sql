-- =============================================================================
-- dw.dim_school_district
-- =============================================================================
-- School district dimension. Static — dw.usp_load_dim_school_district
-- runs as a step but inserts nothing.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[dim_school_district](
	[school_district_code] [int] NOT NULL,
	[school_district_main_school_code] [int] NOT NULL,
 CONSTRAINT [PK_dim_school_district] PRIMARY KEY CLUSTERED 
(
	[school_district_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
