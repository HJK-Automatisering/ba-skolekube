-- =============================================================================
-- dw.dim_student_sensitive
-- =============================================================================
-- Student dimension, sensitive part (CPR, names, address, parents).
-- student_id is created here. Filled by dw.usp_load_dim_student_sensitive.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[dim_student_sensitive](
	[student_id] [int] IDENTITY(1,1) NOT NULL,
	[cpr_nr] [nvarchar](10) NOT NULL,
	[first_name] [nvarchar](100) NULL,
	[last_name] [nvarchar](100) NULL,
	[birth_date] [date] NULL,
	[gender] [nvarchar](2) NULL,
	[uni_login] [nvarchar](50) NULL,
	[father_cpr] [nvarchar](10) NULL,
	[mother_cpr] [nvarchar](10) NULL,
	[address_line1] [nvarchar](50) NULL,
	[address_line2] [nvarchar](50) NULL,
	[postal_code] [nvarchar](4) NULL,
	[city_name] [nvarchar](50) NULL,
	[secret_address] [nvarchar](3) NULL,
	[father_first_name] [nvarchar](50) NULL,
	[father_last_name] [nvarchar](50) NULL,
	[mother_first_name] [nvarchar](50) NULL,
	[mother_last_name] [nvarchar](50) NULL,
	[father_nationality] [nvarchar](50) NULL,
	[father_birth_country] [nvarchar](50) NULL,
	[father_custody] [nvarchar](3) NULL,
	[mother_nationality] [nvarchar](50) NULL,
	[mother_birth_country] [nvarchar](50) NULL,
	[mother_custody] [nvarchar](3) NULL,
	[last_seen] [nvarchar](9) NULL,
 CONSTRAINT [pk_dim_student_sensitive] PRIMARY KEY CLUSTERED 
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dim_student_sensitive_cprnr] UNIQUE NONCLUSTERED 
(
	[cpr_nr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
