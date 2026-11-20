-- =============================================================================
-- dw.dim_exam_type
-- =============================================================================
-- Exam type dimension for grades. Static — not filled by any procedure.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[dim_exam_type](
	[exam_type_code] [nvarchar](2) NOT NULL,
	[exam_type_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [pk_dim_exam_type] PRIMARY KEY CLUSTERED 
(
	[exam_type_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
