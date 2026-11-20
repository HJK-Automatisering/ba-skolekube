-- =============================================================================
-- dw.dim_school_type
-- =============================================================================
-- School type dimension.
-- Filled by dw.usp_load_dim_school_type.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[dim_school_type](
	[school_type_code] [int] NOT NULL,
	[school_type_name] [nvarchar](100) NOT NULL,
 CONSTRAINT [pk_dim_school_type] PRIMARY KEY CLUSTERED 
(
	[school_type_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
