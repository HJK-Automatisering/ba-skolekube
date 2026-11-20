-- =============================================================================
-- dw.dim_citizenship
-- =============================================================================
-- Citizenship dimension.
-- Filled by dw.usp_load_dim_citizenship.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[dim_citizenship](
	[citizenship_code] [int] NOT NULL,
	[citizenship_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [pk_dim_citizenship] PRIMARY KEY CLUSTERED 
(
	[citizenship_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
