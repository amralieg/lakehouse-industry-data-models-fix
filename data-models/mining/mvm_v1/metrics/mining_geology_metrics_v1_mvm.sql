-- Metric views for domain: geology | Business: Mining | Version: 1 | Generated on: 2026-05-05 14:14:10

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`geology_block_model_cell`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over block model cells covering ore tonnage, grade quality, resource classification, and recovery efficiency. Used by mine planners, resource geologists, and executives to steer mining schedules, cut-off grade decisions, and processing plant feed quality."
  source: "`mining_ecm`.`geology`.`block_model_cell`"
  dimensions:
    - name: "ore_waste_classification"
      expr: ore_waste_classification
      comment: "Classifies each block cell as ore or waste, enabling split analysis of tonnage and grade between economic and non-economic material."
    - name: "reserve_category"
      expr: reserve_category
      comment: "JORC/NI43-101 reserve category (Proved, Probable) for regulatory reporting and investor disclosure."
    - name: "resource_category"
      expr: resource_category
      comment: "JORC/NI43-101 resource category (Measured, Indicated, Inferred) used to assess geological confidence and bankability of the resource."
    - name: "mining_method_flag"
      expr: mining_method_flag
      comment: "Indicates the planned mining method (e.g. open pit, underground) for each block, driving cost and schedule assumptions."
    - name: "mining_phase"
      expr: mining_phase
      comment: "Mine development phase (e.g. Phase 1, Phase 2) to track resource depletion and production sequencing over time."
    - name: "oxidation_state"
      expr: oxidation_state
      comment: "Oxidation state of the block (fresh, transitional, oxide) which determines metallurgical processing route and recovery expectations."
    - name: "estimation_method"
      expr: estimation_method
      comment: "Grade estimation technique applied (e.g. Ordinary Kriging, Inverse Distance) indicating geological confidence level."
    - name: "model_version"
      expr: model_version
      comment: "Block model version identifier enabling comparison of resource estimates across model iterations."
  measures:
    - name: "total_ore_tonnage_t"
      expr: SUM(CAST(tonnage AS DOUBLE))
      comment: "Total modelled tonnage across all block cells. The primary volumetric KPI for resource and reserve reporting, directly linked to mine life and revenue potential."
    - name: "avg_fe_grade_pct"
      expr: AVG(CAST(grade_fe_pct AS DOUBLE))
      comment: "Average iron (Fe) grade across block cells. A key quality KPI for iron ore operations; drives product specification compliance and price realisation."
    - name: "avg_cu_grade_ppm"
      expr: AVG(CAST(grade_cu_ppm AS DOUBLE))
      comment: "Average copper (Cu) grade in parts per million. Critical for copper operations to assess ore quality and contained metal estimates."
    - name: "avg_au_grade_g_per_t"
      expr: AVG(CAST(grade_au_g_per_t AS DOUBLE))
      comment: "Average gold (Au) grade in grams per tonne. Primary value driver for gold operations; directly determines revenue per tonne mined."
    - name: "avg_ni_grade_pct"
      expr: AVG(CAST(grade_ni_pct AS DOUBLE))
      comment: "Average nickel (Ni) grade percentage. Key quality metric for nickel operations and battery materials supply chain decisions."
    - name: "avg_li_grade_ppm"
      expr: AVG(CAST(grade_li_ppm AS DOUBLE))
      comment: "Average lithium (Li) grade in parts per million. Strategic KPI for lithium operations serving the battery and EV supply chain."
    - name: "total_block_volume_m3"
      expr: SUM(CAST(block_volume_m3 AS DOUBLE))
      comment: "Total modelled block volume in cubic metres. Used alongside tonnage to validate density assumptions and reconcile with survey volumes."
    - name: "avg_mining_recovery_factor"
      expr: AVG(CAST(mining_recovery_factor AS DOUBLE))
      comment: "Average mining recovery factor across blocks. Measures the proportion of in-situ material expected to be physically extracted; a key input to reserve conversion and mine planning."
    - name: "avg_processing_recovery_factor"
      expr: AVG(CAST(processing_recovery_factor AS DOUBLE))
      comment: "Average processing (metallurgical) recovery factor. Measures the proportion of mined material converted to saleable product; directly impacts revenue and plant efficiency KPIs."
    - name: "avg_dilution_factor"
      expr: AVG(CAST(dilution_factor AS DOUBLE))
      comment: "Average dilution factor applied to block cells. Quantifies the degree of waste contamination in ore extraction; high dilution erodes grade and margin."
    - name: "avg_density_t_per_m3"
      expr: AVG(CAST(density_t_per_m3 AS DOUBLE))
      comment: "Average bulk density of block cells in tonnes per cubic metre. Used to convert volume estimates to tonnage and validate geological domain assumptions."
    - name: "avg_kriging_variance"
      expr: AVG(CAST(kriging_variance AS DOUBLE))
      comment: "Average kriging estimation variance across block cells. A measure of geological uncertainty; high variance signals areas requiring additional drilling to upgrade resource confidence."
    - name: "avg_cut_off_grade_applied"
      expr: AVG(CAST(cut_off_grade_applied AS DOUBLE))
      comment: "Average cut-off grade applied to classify ore vs waste. Tracks the economic threshold used in resource classification; changes here directly affect reported tonnage and grade."
    - name: "total_block_cell_count"
      expr: COUNT(1)
      comment: "Total number of block model cells. Baseline volume metric used to assess model resolution and completeness across the deposit."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`geology_resource_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory and strategic KPIs over published mineral resource and reserve statements. Used by executives, investor relations, and competent persons for JORC/NI43-101 compliance reporting, year-on-year resource movement analysis, and capital allocation decisions."
  source: "`mining_ecm`.`geology`.`resource_statement`"
  dimensions:
    - name: "resource_classification"
      expr: resource_classification
      comment: "JORC/NI43-101 resource classification (Measured, Indicated, Inferred) for regulatory disclosure and investor confidence assessment."
    - name: "reserve_classification"
      expr: reserve_classification
      comment: "JORC/NI43-101 reserve classification (Proved, Probable) used for bankable feasibility studies and debt financing."
    - name: "statement_type"
      expr: statement_type
      comment: "Type of statement (Resource, Reserve, Combined) to segment reporting by regulatory category."
    - name: "statement_status"
      expr: statement_status
      comment: "Current status of the resource statement (Active, Superseded, Draft) to filter to current published estimates."
    - name: "reporting_standard"
      expr: reporting_standard
      comment: "Governing reporting standard applied (JORC 2012, NI43-101, SAMREC) for jurisdiction-specific compliance tracking."
    - name: "estimation_method"
      expr: estimation_method
      comment: "Grade estimation methodology used (e.g. Ordinary Kriging, Multiple Indicator Kriging) to assess technical robustness of the statement."
    - name: "mining_method"
      expr: mining_method
      comment: "Mining method assumed in the resource/reserve statement (open pit, underground) which drives cost and modifying factor assumptions."
    - name: "material_change_flag"
      expr: material_change_flag
      comment: "Boolean flag indicating whether this statement represents a material change from the prior period, triggering ASX/SEC disclosure obligations."
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of the resource statement for time-series trending of resource inventory changes."
    - name: "publication_date"
      expr: publication_date
      comment: "Date the statement was publicly released, used for regulatory timeline compliance tracking."
  measures:
    - name: "total_tonnage_mt"
      expr: SUM(CAST(tonnage_mt AS DOUBLE))
      comment: "Total reported mineral resource or reserve tonnage in million tonnes. The headline KPI for resource inventory; directly drives mine life, capital investment, and market valuation."
    - name: "avg_grade_value"
      expr: AVG(CAST(grade_value AS DOUBLE))
      comment: "Average reported grade value across resource statements. Tracks the quality of the resource inventory over time; grade decline signals ore body depletion or classification downgrade."
    - name: "total_contained_metal_kt"
      expr: SUM(CAST(contained_metal_kt AS DOUBLE))
      comment: "Total contained metal in thousand tonnes across all resource statements. The primary value metric for resource inventory; directly linked to NPV and market capitalisation."
    - name: "avg_cutoff_grade"
      expr: AVG(CAST(cutoff_grade AS DOUBLE))
      comment: "Average cut-off grade applied across resource statements. Tracks the economic threshold used in resource classification; changes signal shifts in commodity price assumptions or cost structure."
    - name: "avg_mining_recovery_factor"
      expr: AVG(CAST(mining_recovery_factor AS DOUBLE))
      comment: "Average mining recovery factor assumed in reserve statements. A key modifying factor; lower recovery reduces bankable reserves and impacts project economics."
    - name: "avg_processing_recovery_factor"
      expr: AVG(CAST(processing_recovery_factor AS DOUBLE))
      comment: "Average processing recovery factor assumed in reserve statements. Directly impacts the quantity of saleable product derivable from the reserve; a key input to revenue forecasting."
    - name: "avg_dilution_factor"
      expr: AVG(CAST(dilution_factor AS DOUBLE))
      comment: "Average dilution factor applied in reserve statements. Quantifies expected ore contamination; high dilution reduces effective grade and erodes project margins."
    - name: "avg_commodity_price_assumption"
      expr: AVG(CAST(commodity_price_assumption AS DOUBLE))
      comment: "Average commodity price assumption used in resource/reserve statements. Tracks the price deck applied to economic cut-off calculations; sensitivity to price changes is a key investor risk metric."
    - name: "total_active_statement_count"
      expr: COUNT(1)
      comment: "Total number of resource/reserve statements. Baseline count for tracking the breadth of the resource portfolio across projects and commodities."
    - name: "material_change_statement_count"
      expr: SUM(CASE WHEN material_change_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of statements flagged as material changes. Tracks the frequency of significant resource movements requiring regulatory disclosure; high counts may signal geological uncertainty or active exploration success."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`geology_grade_control_sample`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational grade control KPIs tracking sample quality, grade variance, and ore classification accuracy at the blast block level. Used by mine geologists, metallurgists, and operations managers to optimise ore/waste discrimination, minimise grade dilution, and maximise mill feed quality."
  source: "`mining_ecm`.`geology`.`grade_control_sample`"
  dimensions:
    - name: "ore_type"
      expr: ore_type
      comment: "Ore type classification of the sample (e.g. oxide, sulphide, transitional) determining processing route and recovery expectations."
    - name: "sample_type"
      expr: sample_type
      comment: "Type of grade control sample (e.g. RC chip, blast hole, channel) indicating sampling method and associated quality confidence."
    - name: "sample_status"
      expr: sample_status
      comment: "Current status of the sample (e.g. submitted, assayed, approved) for workflow tracking and data completeness monitoring."
    - name: "qaqc_status"
      expr: qaqc_status
      comment: "QAQC outcome for the sample (pass, fail, review) used to identify and quarantine unreliable assay data before ore classification decisions."
    - name: "reconciliation_flag"
      expr: reconciliation_flag
      comment: "Boolean flag indicating whether the sample has been included in a grade reconciliation exercise, tracking coverage of the reconciliation programme."
    - name: "assay_completion_date"
      expr: assay_completion_date
      comment: "Date assay results were received, used to track laboratory turnaround time and its impact on blast clearance and ore routing decisions."
  measures:
    - name: "avg_fe_grade_pct"
      expr: AVG(CAST(fe_percent AS DOUBLE))
      comment: "Average iron grade from grade control samples. The primary ore quality KPI for iron ore operations; drives ROM stockpile routing and product blending decisions."
    - name: "avg_au_grade_g_per_t"
      expr: AVG(CAST(au_g_per_t AS DOUBLE))
      comment: "Average gold grade from grade control samples. The primary value driver for gold operations; used to validate block model predictions and optimise ore/waste cuts."
    - name: "avg_cu_grade_ppm"
      expr: AVG(CAST(cu_ppm AS DOUBLE))
      comment: "Average copper grade from grade control samples. Used to validate block model copper estimates and direct ore to appropriate processing streams."
    - name: "avg_grade_variance"
      expr: AVG(CAST(grade_variance AS DOUBLE))
      comment: "Average grade variance between sample assay and block model prediction. The key reconciliation KPI; persistent positive or negative variance signals systematic model bias requiring re-estimation."
    - name: "avg_sample_weight_kg"
      expr: AVG(CAST(sample_weight_kg AS DOUBLE))
      comment: "Average sample weight in kilograms. Monitors sampling protocol compliance; underweight samples increase nugget effect and reduce assay representativeness."
    - name: "avg_interval_length"
      expr: AVG(CAST(interval_length AS DOUBLE))
      comment: "Average sample interval length in metres. Tracks sampling resolution; shorter intervals improve grade control accuracy but increase laboratory costs."
    - name: "total_sample_count"
      expr: COUNT(1)
      comment: "Total number of grade control samples collected. Baseline throughput metric for the grade control programme; low sample density relative to blast block area signals under-sampling risk."
    - name: "qaqc_fail_sample_count"
      expr: SUM(CASE WHEN qaqc_status = 'FAIL' THEN 1 ELSE 0 END)
      comment: "Count of samples that failed QAQC. Tracks data quality risk in the grade control programme; high failure rates may invalidate ore classification decisions and trigger re-sampling."
    - name: "reconciled_sample_count"
      expr: SUM(CASE WHEN reconciliation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of samples included in grade reconciliation. Measures the coverage of the reconciliation programme; low coverage limits the ability to detect and correct systematic grade prediction errors."
    - name: "avg_block_model_grade"
      expr: AVG(CAST(block_model_grade AS DOUBLE))
      comment: "Average predicted block model grade at sample locations. Compared against actual assay grades to quantify model prediction accuracy and drive re-estimation decisions."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`geology_production_drillhole`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for production drilling programmes covering drilling performance, depth achievement, recovery, and survey compliance. Used by drill and blast superintendents, mine planners, and operations managers to optimise drilling productivity and ensure blast design integrity."
  source: "`mining_ecm`.`geology`.`production_drillhole`"
  dimensions:
    - name: "hole_type"
      expr: hole_type
      comment: "Type of production drillhole (e.g. blast hole, grade control, dewatering) to segment drilling KPIs by purpose."
    - name: "hole_purpose"
      expr: hole_purpose
      comment: "Business purpose of the drillhole (e.g. production blasting, geotechnical, infill) for programme-level performance tracking."
    - name: "hole_status"
      expr: hole_status
      comment: "Current status of the drillhole (e.g. completed, abandoned, in-progress) for programme completion monitoring."
    - name: "jorc_category"
      expr: jorc_category
      comment: "JORC confidence category assigned to the drillhole data, used to assess the geological confidence contribution of each hole."
    - name: "is_assayed"
      expr: is_assayed
      comment: "Boolean flag indicating whether the hole has been assayed. Tracks assay programme coverage; unassayed holes represent a gap in grade control data."
    - name: "is_surveyed"
      expr: is_surveyed
      comment: "Boolean flag indicating whether the hole has been downhole surveyed. Unsurveyed holes carry positional uncertainty that can compromise blast design and ore boundary delineation."
    - name: "start_date"
      expr: start_date
      comment: "Drilling start date for time-series analysis of drilling programme progress and productivity trends."
    - name: "completion_date"
      expr: completion_date
      comment: "Drilling completion date used to calculate cycle time and track programme schedule adherence."
  measures:
    - name: "total_metres_drilled"
      expr: SUM(CAST(total_depth AS DOUBLE))
      comment: "Total metres drilled across all production drillholes. The primary drilling productivity KPI; directly linked to drilling contractor costs and blast programme progress."
    - name: "avg_total_depth_m"
      expr: AVG(CAST(total_depth AS DOUBLE))
      comment: "Average total depth per drillhole in metres. Tracks typical hole depth against design specifications; systematic shortfall signals equipment limitations or ground condition issues."
    - name: "avg_planned_depth_m"
      expr: AVG(CAST(planned_depth AS DOUBLE))
      comment: "Average planned depth per drillhole. Used as the denominator benchmark for depth achievement ratio analysis."
    - name: "avg_depth_achievement_ratio"
      expr: ROUND(AVG(total_depth / NULLIF(planned_depth, 0)), 4)
      comment: "Average ratio of actual to planned depth per drillhole. A drilling execution KPI; ratios below 1.0 indicate systematic under-drilling that compromises blast fragmentation and ore recovery."
    - name: "avg_recovery_percent"
      expr: AVG(CAST(recovery_percent AS DOUBLE))
      comment: "Average core or chip recovery percentage across production drillholes. Low recovery indicates ground conditions or drilling technique issues that reduce sample representativeness and grade control reliability."
    - name: "total_drillhole_count"
      expr: COUNT(1)
      comment: "Total number of production drillholes. Baseline programme volume metric used to track drilling campaign progress against the blast schedule."
    - name: "assayed_hole_count"
      expr: SUM(CASE WHEN is_assayed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of drillholes that have been assayed. Tracks assay programme coverage; low coverage relative to total holes drilled signals a bottleneck in the grade control workflow."
    - name: "surveyed_hole_count"
      expr: SUM(CASE WHEN is_surveyed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of drillholes that have been downhole surveyed. Tracks positional quality compliance; unsurveyed holes introduce spatial uncertainty into blast design and ore boundary delineation."
    - name: "avg_sample_interval_m"
      expr: AVG(CAST(sample_interval_m AS DOUBLE))
      comment: "Average sampling interval in metres per drillhole. Tracks sampling resolution across the drilling programme; coarser intervals reduce grade control accuracy and increase ore misclassification risk."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`geology_orebody`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic asset-level KPIs for orebody inventory covering resource size, grade, spatial extent, and geological confidence. Used by executives, resource geologists, and investors to assess the quality and scale of the mineral asset portfolio and prioritise exploration and development capital."
  source: "`mining_ecm`.`geology`.`orebody`"
  dimensions:
    - name: "orebody_status"
      expr: orebody_status
      comment: "Current development status of the orebody (e.g. active, depleted, care and maintenance) for portfolio lifecycle management."
    - name: "reserve_status"
      expr: reserve_status
      comment: "Reserve declaration status (e.g. declared, under review, not declared) indicating bankability and project maturity."
    - name: "mineralisation_type"
      expr: mineralisation_type
      comment: "Type of mineralisation (e.g. porphyry, IOCG, BIF) used to group orebodies by geological style for portfolio diversification analysis."
    - name: "mining_method"
      expr: mining_method
      comment: "Planned or active mining method (open pit, underground, ISR) which drives capital intensity and operating cost assumptions."
    - name: "geological_confidence"
      expr: geological_confidence
      comment: "Overall geological confidence level of the orebody, used to assess data quality and the reliability of resource estimates."
    - name: "oxidation_state"
      expr: oxidation_state
      comment: "Dominant oxidation state of the orebody (fresh, transitional, oxide) determining metallurgical processing route and capital requirements."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the orebody is currently active in the mine plan, used to filter the active resource portfolio."
    - name: "discovery_date"
      expr: discovery_date
      comment: "Date of orebody discovery for portfolio age analysis and exploration programme effectiveness assessment."
  measures:
    - name: "total_tonnage_estimate_mt"
      expr: SUM(CAST(tonnage_estimate_mt AS DOUBLE))
      comment: "Total estimated tonnage across all orebodies in million tonnes. The headline resource inventory KPI; directly drives mine life projections, capital allocation, and market valuation."
    - name: "avg_grade"
      expr: AVG(CAST(average_grade AS DOUBLE))
      comment: "Average grade across orebodies. Tracks the quality of the resource portfolio; grade decline over time signals depletion of high-quality ore and increasing processing costs."
    - name: "total_contained_metal_kt"
      expr: SUM(CAST(contained_metal_kt AS DOUBLE))
      comment: "Total contained metal in thousand tonnes across all orebodies. The primary value metric for the mineral asset portfolio; directly linked to NPV and enterprise value."
    - name: "avg_cutoff_grade"
      expr: AVG(CAST(cutoff_grade AS DOUBLE))
      comment: "Average economic cut-off grade applied across orebodies. Tracks the price and cost assumptions embedded in resource classification; changes signal shifts in project economics."
    - name: "total_spatial_extent_sqm"
      expr: SUM(CAST(spatial_extent_area_sqm AS DOUBLE))
      comment: "Total spatial footprint of all orebodies in square metres. Measures the physical scale of the mineral asset portfolio and informs land tenure and environmental management requirements."
    - name: "avg_vertical_extent_m"
      expr: AVG(CAST(vertical_extent_m AS DOUBLE))
      comment: "Average vertical extent of orebodies in metres. Indicates the depth profile of the portfolio; deeper orebodies carry higher mining cost and geotechnical risk."
    - name: "total_orebody_count"
      expr: COUNT(1)
      comment: "Total number of orebodies in the portfolio. Baseline count for portfolio breadth assessment and diversification analysis."
    - name: "active_orebody_count"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of currently active orebodies. Tracks the productive asset base; declining active count signals depletion risk and the need for exploration success to sustain production."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`geology_geotechnical_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Geotechnical risk and rock mass quality KPIs derived from drillhole geotechnical logging. Used by geotechnical engineers, mine planners, and safety managers to assess slope stability, underground support requirements, and ground condition risk across the operation."
  source: "`mining_ecm`.`geology`.`geotechnical_log`"
  dimensions:
    - name: "geomechanical_domain"
      expr: geomechanical_domain
      comment: "Geomechanical domain classification of the logged interval, used to group rock mass quality metrics by structural zone for slope design and support specification."
    - name: "oxidation_state"
      expr: oxidation_state
      comment: "Oxidation state of the logged interval (fresh, transitional, oxide) which strongly influences rock strength and geotechnical behaviour."
    - name: "qaqc_status"
      expr: qaqc_status
      comment: "QAQC status of the geotechnical log record, used to filter to validated data for geotechnical design inputs."
    - name: "logging_date"
      expr: logging_date
      comment: "Date of geotechnical logging for time-series tracking of data collection progress and campaign coverage."
  measures:
    - name: "avg_rqd_percent"
      expr: AVG(CAST(rqd_percent AS DOUBLE))
      comment: "Average Rock Quality Designation (RQD) percentage. The primary rock mass quality index; low RQD signals highly fractured ground requiring enhanced slope angles or underground support, directly impacting mining cost and safety."
    - name: "avg_core_recovery_percent"
      expr: AVG(CAST(core_recovery_percent AS DOUBLE))
      comment: "Average core recovery percentage. Low recovery indicates poor ground conditions or drilling technique issues; directly affects the reliability of geotechnical data used in slope and support design."
    - name: "avg_ucs_mpa"
      expr: AVG(CAST(ucs_mpa AS DOUBLE))
      comment: "Average Uniaxial Compressive Strength (UCS) in MPa. The primary rock strength parameter for slope stability analysis, underground excavation design, and blast design optimisation."
    - name: "avg_point_load_index_mpa"
      expr: AVG(CAST(point_load_index_mpa AS DOUBLE))
      comment: "Average point load index in MPa. A field-derived rock strength proxy used where UCS testing is unavailable; informs blast design and equipment selection decisions."
    - name: "avg_fracture_frequency"
      expr: AVG(CAST(fracture_frequency AS DOUBLE))
      comment: "Average fracture frequency per metre. High fracture frequency indicates structurally complex ground with elevated slope instability and dilution risk."
    - name: "avg_dry_bulk_density"
      expr: AVG(CAST(dry_bulk_density AS DOUBLE))
      comment: "Average dry bulk density of logged intervals. Used to convert volume estimates to tonnage in resource calculations and to calibrate block model density assignments."
    - name: "avg_q_index"
      expr: AVG(CAST(q_index AS DOUBLE))
      comment: "Average Q-system rock mass quality index. A composite geotechnical rating used for underground excavation support design; low Q values trigger costly ground support interventions."
    - name: "total_logged_interval_m"
      expr: SUM(CAST(interval_length AS DOUBLE))
      comment: "Total length of geotechnically logged intervals in metres. Tracks the coverage of the geotechnical data programme; low coverage relative to total metres drilled signals gaps in the geotechnical model."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`geology_geological_domain`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Geological domain characterisation KPIs covering grade distribution, domain volume, and estimation quality. Used by resource geologists and mine planners to validate domain boundaries, assess grade variability, and prioritise infill drilling to upgrade resource confidence."
  source: "`mining_ecm`.`geology`.`geological_domain`"
  dimensions:
    - name: "domain_type"
      expr: domain_type
      comment: "Type of geological domain (e.g. mineralisation, alteration, lithological) used to segment grade and volume metrics by domain classification."
    - name: "resource_category"
      expr: resource_category
      comment: "JORC/NI43-101 resource category assigned to the domain (Measured, Indicated, Inferred) for confidence-weighted resource reporting."
    - name: "geological_confidence"
      expr: geological_confidence
      comment: "Geological confidence level of the domain, used to prioritise infill drilling programmes and assess upgrade potential."
    - name: "geological_domain_status"
      expr: geological_domain_status
      comment: "Current status of the geological domain (active, superseded, under review) to filter to current valid domain definitions."
    - name: "variogram_model_type"
      expr: variogram_model_type
      comment: "Type of variogram model fitted to the domain (e.g. spherical, exponential, Gaussian) indicating the spatial continuity model used in grade estimation."
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of the geological domain definition for version-controlled tracking of domain boundary changes."
  measures:
    - name: "total_domain_volume_m3"
      expr: SUM(CAST(domain_volume_m3 AS DOUBLE))
      comment: "Total volume of all geological domains in cubic metres. Tracks the spatial scale of the mineralised inventory; changes signal domain boundary revisions that may impact resource tonnage."
    - name: "avg_grade"
      expr: AVG(CAST(average_grade AS DOUBLE))
      comment: "Average grade across geological domains. Tracks the quality of mineralised domains; grade changes between model versions signal re-interpretation of domain boundaries or new drilling data."
    - name: "avg_grade_variance"
      expr: AVG(CAST(grade_variance AS DOUBLE))
      comment: "Average grade variance within geological domains. High variance indicates heterogeneous mineralisation requiring denser sampling or domain subdivision to improve estimation accuracy."
    - name: "avg_bulk_density"
      expr: AVG(CAST(bulk_density AS DOUBLE))
      comment: "Average bulk density across geological domains. Used to convert domain volumes to tonnage estimates; density uncertainty is a key source of resource estimate error."
    - name: "avg_cut_off_grade"
      expr: AVG(CAST(cut_off_grade AS DOUBLE))
      comment: "Average cut-off grade applied across geological domains. Tracks the economic threshold used to define ore domains; changes reflect commodity price movements or cost structure shifts."
    - name: "avg_variogram_nugget_effect"
      expr: AVG(CAST(variogram_nugget_effect AS DOUBLE))
      comment: "Average variogram nugget effect across domains. High nugget effect indicates poor short-range grade continuity, increasing estimation uncertainty and the risk of misclassifying ore and waste."
    - name: "avg_variogram_range_major_m"
      expr: AVG(CAST(variogram_range_major_m AS DOUBLE))
      comment: "Average major axis variogram range in metres. Quantifies the spatial continuity of grade in the principal direction; longer ranges support wider drill spacing and reduce infill drilling costs."
    - name: "total_domain_count"
      expr: COUNT(1)
      comment: "Total number of geological domains. Baseline count for assessing the complexity of the geological model; high domain counts increase estimation complexity and model maintenance cost."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`geology_wireframe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "3D geological wireframe model KPIs covering volume, spatial extent, and model quality. Used by resource geologists and mine planners to track the completeness and quality of the 3D geological model, which underpins all resource estimation and mine design activities."
  source: "`mining_ecm`.`geology`.`wireframe`"
  dimensions:
    - name: "wireframe_type"
      expr: wireframe_type
      comment: "Type of wireframe (e.g. mineralisation solid, fault surface, topography) to segment volume and quality metrics by geological feature type."
    - name: "interpretation_confidence"
      expr: interpretation_confidence
      comment: "Confidence level of the wireframe interpretation (high, medium, low) used to assess the reliability of the 3D geological model."
    - name: "validation_status"
      expr: validation_status
      comment: "Current validation status of the wireframe (validated, pending, failed) for model quality governance tracking."
    - name: "is_closed_solid"
      expr: is_closed_solid
      comment: "Boolean flag indicating whether the wireframe forms a closed solid, which is required for valid volume calculation and resource estimation."
    - name: "quality_check_status"
      expr: quality_check_status
      comment: "Quality check outcome for the wireframe (pass, fail, review) used to identify models requiring remediation before use in resource estimation."
    - name: "validation_date"
      expr: validation_date
      comment: "Date of wireframe validation for tracking model currency and identifying outdated geological interpretations."
  measures:
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volume of all wireframe solids in cubic metres. The primary geometric KPI for the 3D geological model; directly used to calculate in-situ resource tonnage when multiplied by bulk density."
    - name: "avg_volume_m3"
      expr: AVG(CAST(volume_m3 AS DOUBLE))
      comment: "Average wireframe volume in cubic metres. Tracks the typical scale of geological domains modelled; significant changes between model versions signal major geological reinterpretation."
    - name: "total_surface_area_sqm"
      expr: SUM(CAST(surface_area_sqm AS DOUBLE))
      comment: "Total surface area of all wireframes in square metres. Used to assess the spatial extent of the geological model and validate against known deposit dimensions."
    - name: "avg_elevation_range_m"
      expr: AVG(maximum_elevation_rl - minimum_elevation_rl)
      comment: "Average vertical extent of wireframes in metres (max RL minus min RL). Tracks the depth profile of modelled geological features; deeper extents signal higher underground mining potential and geotechnical complexity."
    - name: "total_wireframe_count"
      expr: COUNT(1)
      comment: "Total number of wireframes in the geological model. Baseline count for model completeness assessment; low counts relative to known geological complexity may indicate under-modelling."
    - name: "validated_wireframe_count"
      expr: SUM(CASE WHEN validation_status = 'VALIDATED' THEN 1 ELSE 0 END)
      comment: "Count of wireframes that have passed validation. Tracks the proportion of the geological model that is approved for use in resource estimation; low validated counts signal model quality risk."
    - name: "closed_solid_wireframe_count"
      expr: SUM(CASE WHEN is_closed_solid = TRUE THEN 1 ELSE 0 END)
      comment: "Count of wireframes that form closed solids. Only closed solids can be used for valid volume calculation; low counts indicate model completeness issues that block resource estimation."
$$;