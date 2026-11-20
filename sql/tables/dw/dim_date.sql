-- =============================================================================
-- dw.dim_date
-- =============================================================================
-- Date dimension. One row per date, date_id = yyyyMMdd.
-- Static — school_year_label is updated by
-- dw.usp_refresh_dim_date_school_year_label.
-- =============================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[dim_date](
	[date_id] [int] NOT NULL,
	[full_date] [date] NOT NULL,
	[day_of_month] [tinyint] NOT NULL,
	[weekday_number] [tinyint] NOT NULL,
	[weekday_name] [nvarchar](10) NOT NULL,
	[week_number] [tinyint] NOT NULL,
	[month_number] [tinyint] NOT NULL,
	[month_name] [nvarchar](10) NOT NULL,
	[quarter] [tinyint] NOT NULL,
	[half_year] [tinyint] NOT NULL,
	[year] [smallint] NOT NULL,
	[school_year] [nvarchar](9) NOT NULL,
	[is_weekend] [bit] NOT NULL,
	[is_vacation_day] [bit] NOT NULL,
	[school_year_label] [nvarchar](15) NULL,
 CONSTRAINT [pk_dim_date] PRIMARY KEY CLUSTERED 
(
	[date_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
