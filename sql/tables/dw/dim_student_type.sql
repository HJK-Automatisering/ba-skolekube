-- =============================================================================
-- dw.dim_student_type
-- =============================================================================
-- Student type dimension. student_type_code is IDENTITY.
-- Filled by dw.usp_load_dim_student_type.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[dim_student_type](
	[student_type_code] [int] IDENTITY(1,1) NOT NULL,
	[student_type_name] [nvarchar](100) NULL,
 CONSTRAINT [pk_dim_student_type] PRIMARY KEY CLUSTERED 
(
	[student_type_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
