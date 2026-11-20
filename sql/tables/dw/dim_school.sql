-- =============================================================================
-- dw.dim_school
-- =============================================================================
-- School dimension.
-- Filled by dw.usp_load_dim_school.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[dim_school](
	[school_code] [int] NOT NULL,
	[school_name] [nvarchar](50) NOT NULL,
	[school_owner] [nvarchar](100) NULL,
	[school_type_code] [int] NOT NULL,
	[main_school_code] [int] NOT NULL,
 CONSTRAINT [pk_dim_school] PRIMARY KEY CLUSTERED 
(
	[school_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
