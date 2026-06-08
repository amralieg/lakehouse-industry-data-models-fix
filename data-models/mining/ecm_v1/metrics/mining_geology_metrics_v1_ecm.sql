-- Metric views for domain: geology | Business: Mining | Version: 1 | Generated on: 2026-05-05 10:43:42

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`geology_block_model_cell`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core resource and reserve metrics at block cell level for grade control, mine planning, and resource reconciliation"
  source: "`mining_ecm`.`geology`.`block_model_cell`"
  dimensions:
    - name: "resource_category"
      expr: resource_category
      comment: "JORC/NI 43-101 resource classification (Measured, Indicated, Inferred)"
    - name: "reserve_category"
      expr: reserve_category
      comment: "Reserve classification (Proven, Probable)"
    - name: "ore_waste_classification"
      expr: ore_waste_classification
      comment: "Classification of material as ore or waste based on cut-off grade"
    - name: "oxidation_state"
      expr: oxidation_state
      comment: "Oxidation state of material (oxide, transitional, fresh/sulphide)"
    - name: "mining_phase"
      expr: mining_phase
      comment: "Planned mining phase or stage for extraction sequencing"
    - name: "estimation_method"
      expr: estimation_method
      comment: "Geostatistical method used for grade estimation (OK, ID2, NN)"
    - name: "estimation_pass"
      expr: estimation_pass
      comment: "Search pass number used in grade estimation"
  measures:
    - name: "total_tonnage_mt"
      expr: SUM(CAST(tonnage AS DOUBLE)) / 1000000.0
      comment: "Total tonnage in million tonnes - primary resource/reserve volume metric"
    - name: "total_block_volume_m3"
      expr: SUM(CAST(block_volume_m3 AS DOUBLE))
      comment: "Total block volume in cubic metres for spatial analysis"
    - name: "avg_density_t_per_m3"
      expr: AVG(CAST(density_t_per_m3 AS DOUBLE))
      comment: "Average bulk density in tonnes per cubic metre"
    - name: "avg_grade_fe_pct"
      expr: AVG(CAST(grade_fe_pct AS DOUBLE))
      comment: "Average iron ore grade percentage"
    - name: "avg_grade_cu_ppm"
      expr: AVG(CAST(grade_cu_ppm AS DOUBLE))
      comment: "Average copper grade in parts per million"
    - name: "avg_grade_au_g_per_t"
      expr: AVG(CAST(grade_au_g_per_t AS DOUBLE))
      comment: "Average gold grade in grams per tonne"
    - name: "avg_grade_ni_pct"
      expr: AVG(CAST(grade_ni_pct AS DOUBLE))
      comment: "Average nickel grade percentage"
    - name: "avg_grade_li_ppm"
      expr: AVG(CAST(grade_li_ppm AS DOUBLE))
      comment: "Average lithium grade in parts per million"
    - name: "contained_fe_kt"
      expr: SUM(CAST(tonnage * grade_fe_pct / 100.0 AS DOUBLE)) / 1000.0
      comment: "Contained iron metal in thousand tonnes - key resource value metric"
    - name: "contained_cu_kt"
      expr: SUM(CAST(tonnage * grade_cu_ppm / 1000000.0 AS DOUBLE)) / 1000.0
      comment: "Contained copper metal in thousand tonnes"
    - name: "contained_au_kg"
      expr: SUM(CAST(tonnage * grade_au_g_per_t / 1000.0 AS DOUBLE))
      comment: "Contained gold metal in kilograms"
    - name: "avg_mining_recovery_factor"
      expr: AVG(CAST(mining_recovery_factor AS DOUBLE))
      comment: "Average mining recovery factor for reserve conversion"
    - name: "avg_processing_recovery_factor"
      expr: AVG(CAST(processing_recovery_factor AS DOUBLE))
      comment: "Average metallurgical recovery factor for saleable product"
    - name: "avg_dilution_factor"
      expr: AVG(CAST(dilution_factor AS DOUBLE))
      comment: "Average dilution factor applied in mining modifying factors"
    - name: "avg_kriging_variance"
      expr: AVG(CAST(kriging_variance AS DOUBLE))
      comment: "Average kriging variance indicating estimation confidence"
    - name: "block_count"
      expr: COUNT(1)
      comment: "Number of block model cells for spatial density analysis"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`geology_resource_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Public resource and reserve statement metrics for regulatory reporting, investor relations, and strategic planning"
  source: "`mining_ecm`.`geology`.`resource_statement`"
  dimensions:
    - name: "statement_type"
      expr: statement_type
      comment: "Type of statement (Resource, Reserve, Combined)"
    - name: "resource_classification"
      expr: resource_classification
      comment: "JORC/NI 43-101 resource classification (Measured, Indicated, Inferred)"
    - name: "reserve_classification"
      expr: reserve_classification
      comment: "Reserve classification (Proven, Probable)"
    - name: "reporting_standard"
      expr: reporting_standard
      comment: "Reporting code standard (JORC, NI 43-101, SAMREC)"
    - name: "statement_status"
      expr: statement_status
      comment: "Status of statement (Draft, Approved, Published, Superseded)"
    - name: "mining_method"
      expr: mining_method
      comment: "Planned mining method (Open Pit, Underground, etc.)"
    - name: "estimation_method"
      expr: estimation_method
      comment: "Geostatistical estimation method used"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year of statement effective date for trend analysis"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year of competent person approval"
  measures:
    - name: "total_tonnage_mt"
      expr: SUM(CAST(tonnage_mt AS DOUBLE))
      comment: "Total resource/reserve tonnage in million tonnes - primary public disclosure metric"
    - name: "total_contained_metal_kt"
      expr: SUM(CAST(contained_metal_kt AS DOUBLE))
      comment: "Total contained metal in thousand tonnes - key value metric for investors"
    - name: "avg_grade_value"
      expr: AVG(CAST(grade_value AS DOUBLE))
      comment: "Average grade value across statements"
    - name: "avg_cutoff_grade"
      expr: AVG(CAST(cutoff_grade AS DOUBLE))
      comment: "Average cut-off grade applied for economic viability"
    - name: "avg_mining_recovery_factor"
      expr: AVG(CAST(mining_recovery_factor AS DOUBLE))
      comment: "Average mining recovery factor for reserve modifying"
    - name: "avg_processing_recovery_factor"
      expr: AVG(CAST(processing_recovery_factor AS DOUBLE))
      comment: "Average processing recovery factor for saleable product"
    - name: "avg_dilution_factor"
      expr: AVG(CAST(dilution_factor AS DOUBLE))
      comment: "Average dilution factor applied in reserve conversion"
    - name: "avg_commodity_price_assumption"
      expr: AVG(CAST(commodity_price_assumption AS DOUBLE))
      comment: "Average commodity price assumption used in economic analysis"
    - name: "statement_count"
      expr: COUNT(1)
      comment: "Number of resource/reserve statements for version tracking"
    - name: "material_change_count"
      expr: SUM(CASE WHEN material_change_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of statements with material changes requiring disclosure"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`geology_grade_control_sample`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grade control sampling metrics for short-term mine planning, ore-waste classification, and production reconciliation"
  source: "`mining_ecm`.`geology`.`grade_control_sample`"
  dimensions:
    - name: "sample_status"
      expr: sample_status
      comment: "Status of sample (Collected, Assayed, Validated, Reconciled)"
    - name: "sample_type"
      expr: sample_type
      comment: "Type of grade control sample (Blast hole, RC, Diamond)"
    - name: "ore_type"
      expr: ore_type
      comment: "Ore type classification for processing routing"
    - name: "material_destination"
      expr: material_destination
      comment: "Destination of material (Mill, Stockpile, Waste)"
    - name: "qaqc_status"
      expr: qaqc_status
      comment: "Quality assurance/quality control status"
    - name: "assay_method"
      expr: assay_method
      comment: "Laboratory assay method used"
    - name: "pit_name"
      expr: pit_name
      comment: "Name of pit where sample was collected"
    - name: "bench"
      expr: bench
      comment: "Mining bench identifier"
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_timestamp)
      comment: "Month of sample collection for temporal analysis"
  measures:
    - name: "sample_count"
      expr: COUNT(1)
      comment: "Total number of grade control samples for coverage analysis"
    - name: "avg_fe_percent"
      expr: AVG(CAST(fe_percent AS DOUBLE))
      comment: "Average iron grade percentage from grade control"
    - name: "avg_cu_ppm"
      expr: AVG(CAST(cu_ppm AS DOUBLE))
      comment: "Average copper grade in parts per million"
    - name: "avg_au_g_per_t"
      expr: AVG(CAST(au_g_per_t AS DOUBLE))
      comment: "Average gold grade in grams per tonne"
    - name: "avg_sio2_percent"
      expr: AVG(CAST(sio2_percent AS DOUBLE))
      comment: "Average silica percentage - key contaminant metric"
    - name: "avg_al2o3_percent"
      expr: AVG(CAST(al2o3_percent AS DOUBLE))
      comment: "Average alumina percentage - key contaminant metric"
    - name: "avg_p_percent"
      expr: AVG(CAST(p_percent AS DOUBLE))
      comment: "Average phosphorus percentage - key penalty element"
    - name: "avg_s_percent"
      expr: AVG(CAST(s_percent AS DOUBLE))
      comment: "Average sulfur percentage - key penalty element"
    - name: "avg_sample_weight_kg"
      expr: AVG(CAST(sample_weight_kg AS DOUBLE))
      comment: "Average sample weight for protocol compliance"
    - name: "avg_interval_length"
      expr: AVG(CAST(interval_length AS DOUBLE))
      comment: "Average sample interval length in metres"
    - name: "avg_grade_variance"
      expr: AVG(CAST(grade_variance AS DOUBLE))
      comment: "Average variance between block model and actual grade - reconciliation metric"
    - name: "reconciliation_sample_count"
      expr: SUM(CASE WHEN reconciliation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of samples used in production reconciliation"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`geology_orebody`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Orebody-level strategic metrics for portfolio management, exploration targeting, and asset valuation"
  source: "`mining_ecm`.`geology`.`orebody`"
  dimensions:
    - name: "orebody_status"
      expr: orebody_status
      comment: "Current status of orebody (Exploration, Resource, Reserve, Production, Depleted)"
    - name: "deposit_style"
      expr: deposit_style
      comment: "Geological deposit style classification"
    - name: "mining_method"
      expr: mining_method
      comment: "Planned or current mining method"
    - name: "mineralisation_type"
      expr: mineralisation_type
      comment: "Type of mineralisation"
    - name: "oxidation_state"
      expr: oxidation_state
      comment: "Dominant oxidation state of orebody"
    - name: "geological_confidence"
      expr: geological_confidence
      comment: "Overall geological confidence level"
    - name: "reserve_status"
      expr: reserve_status
      comment: "Reserve status classification"
    - name: "environmental_sensitivity"
      expr: environmental_sensitivity
      comment: "Environmental sensitivity classification for permitting risk"
    - name: "is_active"
      expr: is_active
      comment: "Active status flag"
    - name: "discovery_year"
      expr: YEAR(discovery_date)
      comment: "Year of orebody discovery"
  measures:
    - name: "total_tonnage_estimate_mt"
      expr: SUM(CAST(tonnage_estimate_mt AS DOUBLE))
      comment: "Total estimated tonnage in million tonnes across orebodies"
    - name: "total_contained_metal_kt"
      expr: SUM(CAST(contained_metal_kt AS DOUBLE))
      comment: "Total contained metal in thousand tonnes - portfolio value metric"
    - name: "avg_grade"
      expr: AVG(CAST(average_grade AS DOUBLE))
      comment: "Average grade across orebodies"
    - name: "avg_cutoff_grade"
      expr: AVG(CAST(cutoff_grade AS DOUBLE))
      comment: "Average cut-off grade for economic viability"
    - name: "total_spatial_extent_sqkm"
      expr: SUM(CAST(spatial_extent_area_sqm AS DOUBLE)) / 1000000.0
      comment: "Total spatial extent in square kilometres"
    - name: "avg_vertical_extent_m"
      expr: AVG(CAST(vertical_extent_m AS DOUBLE))
      comment: "Average vertical extent in metres"
    - name: "orebody_count"
      expr: COUNT(1)
      comment: "Number of orebodies in portfolio"
    - name: "active_orebody_count"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of active orebodies"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`geology_production_drillhole`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production drilling performance metrics for grade control efficiency, drilling productivity, and data quality"
  source: "`mining_ecm`.`geology`.`production_drillhole`"
  dimensions:
    - name: "hole_status"
      expr: hole_status
      comment: "Status of drillhole (Planned, Drilling, Complete, Abandoned)"
    - name: "hole_type"
      expr: hole_type
      comment: "Type of drillhole (RC, Diamond, Blast)"
    - name: "hole_purpose"
      expr: hole_purpose
      comment: "Purpose of drilling (Grade Control, Geotechnical, Hydrology)"
    - name: "jorc_category"
      expr: jorc_category
      comment: "JORC resource category targeted"
    - name: "drilling_contractor"
      expr: drilling_contractor
      comment: "Contractor performing drilling"
    - name: "is_assayed"
      expr: is_assayed
      comment: "Flag indicating if hole has been assayed"
    - name: "is_surveyed"
      expr: is_surveyed
      comment: "Flag indicating if hole has been surveyed"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month of drillhole completion"
  measures:
    - name: "total_metres_drilled"
      expr: SUM(CAST(total_depth AS DOUBLE))
      comment: "Total metres drilled - primary drilling productivity metric"
    - name: "total_planned_metres"
      expr: SUM(CAST(planned_depth AS DOUBLE))
      comment: "Total planned metres for target comparison"
    - name: "avg_recovery_percent"
      expr: AVG(CAST(recovery_percent AS DOUBLE))
      comment: "Average core recovery percentage - data quality metric"
    - name: "avg_hole_depth"
      expr: AVG(CAST(total_depth AS DOUBLE))
      comment: "Average drillhole depth in metres"
    - name: "avg_sample_interval_m"
      expr: AVG(CAST(sample_interval_m AS DOUBLE))
      comment: "Average sample interval length"
    - name: "drillhole_count"
      expr: COUNT(1)
      comment: "Number of production drillholes"
    - name: "assayed_hole_count"
      expr: SUM(CASE WHEN is_assayed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of drillholes with assay results"
    - name: "surveyed_hole_count"
      expr: SUM(CASE WHEN is_surveyed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of drillholes with downhole survey"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`geology_geostatistical_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Geostatistical estimation quality metrics for resource confidence, estimation validation, and technical governance"
  source: "`mining_ecm`.`geology`.`geostatistical_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of geostatistical run (In Progress, Complete, Validated, Rejected)"
    - name: "estimation_method"
      expr: estimation_method
      comment: "Geostatistical method used (Ordinary Kriging, ID2, etc.)"
    - name: "resource_classification_method"
      expr: resource_classification_method
      comment: "Method used for resource classification"
    - name: "variogram_model_type"
      expr: variogram_model_type
      comment: "Type of variogram model (Spherical, Exponential, Gaussian)"
    - name: "compositing_method"
      expr: compositing_method
      comment: "Method used for sample compositing"
    - name: "software_name"
      expr: software_name
      comment: "Geostatistical software used"
    - name: "run_year"
      expr: YEAR(run_date)
      comment: "Year of geostatistical run"
  measures:
    - name: "avg_kriging_efficiency"
      expr: AVG(CAST(kriging_efficiency AS DOUBLE))
      comment: "Average kriging efficiency - estimation quality metric (target >0.5)"
    - name: "avg_slope_of_regression"
      expr: AVG(CAST(slope_of_regression AS DOUBLE))
      comment: "Average slope of regression - conditional bias metric (target ~1.0)"
    - name: "avg_conditional_bias"
      expr: AVG(CAST(conditional_bias AS DOUBLE))
      comment: "Average conditional bias - estimation accuracy metric (target ~0)"
    - name: "avg_composite_length_metres"
      expr: AVG(CAST(composite_length_metres AS DOUBLE))
      comment: "Average composite length used in estimation"
    - name: "avg_search_ellipse_major_metres"
      expr: AVG(CAST(search_ellipse_major_metres AS DOUBLE))
      comment: "Average major axis of search ellipse"
    - name: "avg_variogram_range_major_metres"
      expr: AVG(CAST(variogram_range_major_metres AS DOUBLE))
      comment: "Average major range of variogram model"
    - name: "avg_variogram_nugget"
      expr: AVG(CAST(variogram_nugget AS DOUBLE))
      comment: "Average variogram nugget effect"
    - name: "avg_variogram_sill"
      expr: AVG(CAST(variogram_sill AS DOUBLE))
      comment: "Average variogram sill"
    - name: "avg_top_cut_grade"
      expr: AVG(CAST(top_cut_grade AS DOUBLE))
      comment: "Average top cut grade applied for outlier management"
    - name: "geostatistical_run_count"
      expr: COUNT(1)
      comment: "Number of geostatistical runs for version tracking"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`geology_geological_domain`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Geological domain metrics for estimation domain quality, spatial continuity, and resource confidence"
  source: "`mining_ecm`.`geology`.`geological_domain`"
  dimensions:
    - name: "domain_type"
      expr: domain_type
      comment: "Type of geological domain (Ore, Waste, Transition)"
    - name: "geological_confidence"
      expr: geological_confidence
      comment: "Confidence level in domain interpretation"
    - name: "resource_category"
      expr: resource_category
      comment: "Resource category associated with domain"
    - name: "geological_domain_status"
      expr: geological_domain_status
      comment: "Status of domain (Draft, Approved, Superseded)"
    - name: "variogram_model_type"
      expr: variogram_model_type
      comment: "Variogram model type for domain"
    - name: "estimation_constraint_type"
      expr: estimation_constraint_type
      comment: "Type of estimation constraint applied"
    - name: "commodity"
      expr: commodity
      comment: "Primary commodity in domain"
  measures:
    - name: "total_domain_volume_m3"
      expr: SUM(CAST(domain_volume_m3 AS DOUBLE))
      comment: "Total geological domain volume in cubic metres"
    - name: "avg_grade"
      expr: AVG(CAST(average_grade AS DOUBLE))
      comment: "Average grade across geological domains"
    - name: "avg_bulk_density"
      expr: AVG(CAST(bulk_density AS DOUBLE))
      comment: "Average bulk density in tonnes per cubic metre"
    - name: "avg_cutoff_grade"
      expr: AVG(CAST(cut_off_grade AS DOUBLE))
      comment: "Average cut-off grade applied to domains"
    - name: "avg_grade_variance"
      expr: AVG(CAST(grade_variance AS DOUBLE))
      comment: "Average grade variance within domains - continuity metric"
    - name: "avg_variogram_range_major_m"
      expr: AVG(CAST(variogram_range_major_m AS DOUBLE))
      comment: "Average major variogram range - spatial continuity metric"
    - name: "avg_variogram_nugget_effect"
      expr: AVG(CAST(variogram_nugget_effect AS DOUBLE))
      comment: "Average variogram nugget effect - short-range variability"
    - name: "avg_variogram_sill"
      expr: AVG(CAST(variogram_sill AS DOUBLE))
      comment: "Average variogram sill - total variance"
    - name: "domain_count"
      expr: COUNT(1)
      comment: "Number of geological domains"
$$;