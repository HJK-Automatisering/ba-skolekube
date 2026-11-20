-- =============================================================================
-- dw.dim_action_type
-- =============================================================================
-- Action type dimension (tiltag). Static — not filled by any procedure.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[dim_action_type](
	[action_type_code] [int] NOT NULL,
	[action_type_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [pk_dim_action_type] PRIMARY KEY CLUSTERED 
(
	[action_type_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
