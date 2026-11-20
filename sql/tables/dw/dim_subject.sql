-- =============================================================================
-- dw.dim_subject
-- =============================================================================
-- Subject dimension. Static — not filled by any procedure.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[dim_subject](
	[subject_code] [int] NOT NULL,
	[subject_short_name] [nvarchar](10) NOT NULL,
	[subject_name] [nvarchar](100) NOT NULL,
 CONSTRAINT [pk_dim_subject] PRIMARY KEY CLUSTERED 
(
	[subject_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
