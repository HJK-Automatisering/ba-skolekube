-- =============================================================================
-- dw.dim_discipline
-- =============================================================================
-- Discipline dimension for grades. Static — not filled by any procedure.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[dim_discipline](
	[discipline_code] [int] NOT NULL,
	[uvm_code] [nvarchar](3) NULL,
	[short_name] [nvarchar](10) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
 CONSTRAINT [pk_dim_discipline] PRIMARY KEY CLUSTERED 
(
	[discipline_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
