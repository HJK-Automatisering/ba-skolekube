-- =============================================================================
-- stg.student_basis
-- =============================================================================
-- Staging table for the student basis extract. One row per student.
-- Filled by utils/load_stg.py — deleted and reloaded every run.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[student_basis](
	[student_id] [int] NULL,
	[uni_login] [nvarchar](20) NULL,
	[cpr_nr] [nvarchar](10) NULL,
	[first_name] [nvarchar](200) NULL,
	[last_name] [nvarchar](200) NULL,
	[birth_date] [nvarchar](10) NULL,
	[gender] [nvarchar](1) NULL,
	[address_line1] [nvarchar](200) NULL,
	[address_line2] [nvarchar](200) NULL,
	[postal_code] [nvarchar](10) NULL,
	[city_name] [nvarchar](200) NULL,
	[municipality_code] [int] NULL,
	[municipality_name] [nvarchar](200) NULL,
	[paying_mun_code] [int] NULL,
	[paying_mun_name] [nvarchar](200) NULL,
	[school_district_code] [int] NULL,
	[student_level] [int] NULL,
	[class_level] [int] NULL,
	[class_track] [nvarchar](2) NULL,
	[class_label] [nvarchar](200) NULL,
	[class_type_code] [int] NULL,
	[class_type_name] [nvarchar](200) NULL,
	[student_type_code] [int] NULL,
	[student_type_name] [nvarchar](200) NULL,
	[nationality_code] [int] NULL,
	[nationality_name] [nvarchar](200) NULL,
	[birth_country_code] [int] NULL,
	[birth_country_name] [nvarchar](200) NULL,
	[mother_tongue_code] [int] NULL,
	[mother_tongue_name] [nvarchar](200) NULL,
	[school_code] [int] NULL,
	[school_name] [nvarchar](200) NULL,
	[school_type_code] [int] NULL,
	[school_type_name] [nvarchar](200) NULL,
	[school_owner_type] [nvarchar](200) NULL,
	[father_cpr] [nvarchar](10) NULL,
	[father_last_name] [nvarchar](200) NULL,
	[father_first_name] [nvarchar](200) NULL,
	[father_birth_country] [nvarchar](200) NULL,
	[father_nationality] [nvarchar](200) NULL,
	[father_custody] [nvarchar](3) NULL,
	[mother_cpr] [nvarchar](10) NULL,
	[mother_last_name] [nvarchar](200) NULL,
	[mother_first_name] [nvarchar](200) NULL,
	[mother_birth_country] [nvarchar](200) NULL,
	[mother_nationality] [nvarchar](200) NULL,
	[mother_custody] [nvarchar](3) NULL,
	[photo_permission] [nvarchar](3) NULL,
	[transport_permission] [nvarchar](3) NULL,
	[action_danish_second_lang] [int] NULL,
	[action_reception_class] [int] NULL,
	[action_special_education] [int] NULL,
	[action_supp_danish] [int] NULL,
	[action_junior_master] [int] NULL,
	[action_intermediate] [int] NULL,
	[main_school_code] [int] NULL,
	[main_school_name] [nvarchar](200) NULL,
	[secret_address] [nvarchar](3) NULL,
	[stg_load_date] [datetime] NULL
) ON [PRIMARY]
GO
