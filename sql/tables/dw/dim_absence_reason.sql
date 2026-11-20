-- =============================================================================
-- dw.dim_absence_reason
-- =============================================================================
-- Absence reason dimension. Referenced by foreign keys from
-- fact_absence_daily and fact_absence_lesson. Not filled by any procedure.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[dim_absence_reason](
	[absence_reason_code] [nvarchar](2) NOT NULL,
	[absence_reason_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [pk_dim_absence_reason] PRIMARY KEY CLUSTERED 
(
	[absence_reason_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
