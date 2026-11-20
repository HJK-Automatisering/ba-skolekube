-- =============================================================================
-- dw.dim_country
-- =============================================================================
-- Country/birth country dimension.
-- Filled by dw.usp_load_dim_country.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[dim_country](
	[country_code] [int] NOT NULL,
	[country_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [pk_dim_country] PRIMARY KEY CLUSTERED 
(
	[country_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
