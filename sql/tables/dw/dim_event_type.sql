-- =============================================================================
-- dw.dim_event_type
-- =============================================================================
-- Event type dimension. Static — not filled by any procedure.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[dim_event_type](
	[event_type_code] [int] NOT NULL,
	[event_type_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [pk_dim_event_type] PRIMARY KEY CLUSTERED 
(
	[event_type_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
