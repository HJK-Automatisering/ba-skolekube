-- =============================================================================
-- dw.dim_municipality
-- =============================================================================
-- Municipality dimension (residence and paying municipality).
-- Filled by dw.usp_load_dim_municipality.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[dim_municipality](
	[municipality_code] [int] NOT NULL,
	[municipality_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [pk_dim_municipality] PRIMARY KEY CLUSTERED 
(
	[municipality_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
