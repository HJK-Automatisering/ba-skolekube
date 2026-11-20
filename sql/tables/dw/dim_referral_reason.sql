-- =============================================================================
-- dw.dim_referral_reason
-- =============================================================================
-- Referral reason dimension. Static — not filled by any procedure.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[dim_referral_reason](
	[referral_reason_code] [int] NOT NULL,
	[referral_reason_name] [nvarchar](100) NOT NULL,
 CONSTRAINT [pk_dim_referral_reason] PRIMARY KEY CLUSTERED 
(
	[referral_reason_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
