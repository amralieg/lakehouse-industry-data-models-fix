-- Metric views for domain: product | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 21:06:11

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`product_drug_product`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the drug product master. Tracks portfolio composition, lifecycle health, patent cliff exposure, and commercial readiness across the drug product portfolio."
  source: "`pharmaceuticals_ecm`.`product`.`drug_product`"
  dimensions:
    - name: "product_type"
      expr: product_type
      comment: "Classifies the drug product as small molecule, biologic, biosimilar, etc. — used to segment portfolio strategy."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the drug product (e.g. Development, Approved, Discontinued) — key filter for active portfolio analysis."
    - name: "dosage_form"
      expr: dosage_form
      comment: "Physical form of the drug product (tablet, injection, etc.) — used to analyze manufacturing and commercial complexity."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "How the drug is administered (oral, IV, subcutaneous, etc.) — relevant for patient access and commercial strategy."
    - name: "formulation_type"
      expr: formulation_type
      comment: "Type of formulation (immediate release, extended release, etc.) — used to assess differentiation and IP strategy."
    - name: "prescription_status"
      expr: prescription_status
      comment: "Rx or OTC classification — drives commercial channel and regulatory strategy segmentation."
    - name: "controlled_substance_schedule"
      expr: controlled_substance_schedule
      comment: "DEA schedule classification — used for compliance and risk segmentation."
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year the drug product was commercially launched — used for cohort and vintage analysis."
    - name: "patent_expiry_year"
      expr: YEAR(patent_expiry_date)
      comment: "Year the primary patent expires — critical for patent cliff and lifecycle management planning."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year of regulatory approval — used to measure time-to-market and approval cohort analysis."
  measures:
    - name: "total_drug_products"
      expr: COUNT(DISTINCT drug_product_id)
      comment: "Total number of distinct drug products in the portfolio. Baseline KPI for portfolio size tracking."
    - name: "active_drug_products"
      expr: COUNT(DISTINCT CASE WHEN lifecycle_status = 'Active' THEN drug_product_id END)
      comment: "Number of drug products currently in active commercial or development status. Measures the live portfolio breadth."
    - name: "discontinued_drug_products"
      expr: COUNT(DISTINCT CASE WHEN lifecycle_status = 'Discontinued' THEN drug_product_id END)
      comment: "Number of discontinued drug products. Tracks portfolio attrition and informs lifecycle management decisions."
    - name: "products_with_black_box_warning"
      expr: COUNT(DISTINCT CASE WHEN black_box_warning_flag = TRUE THEN drug_product_id END)
      comment: "Number of drug products carrying an FDA black box warning. Directly informs risk management, pharmacovigilance prioritization, and commercial strategy."
    - name: "products_with_rems"
      expr: COUNT(DISTINCT CASE WHEN rems_flag = TRUE THEN drug_product_id END)
      comment: "Number of products requiring a Risk Evaluation and Mitigation Strategy (REMS). Drives compliance resource allocation and commercial complexity assessment."
    - name: "products_with_qbd"
      expr: COUNT(DISTINCT CASE WHEN qbd_flag = TRUE THEN drug_product_id END)
      comment: "Number of products developed using Quality by Design (QbD) principles. Indicates manufacturing quality maturity and regulatory submission strength."
    - name: "avg_strength_value"
      expr: AVG(CAST(strength_value AS DOUBLE))
      comment: "Average drug strength value across the portfolio. Used in formulation benchmarking and dose optimization analysis."
    - name: "products_near_patent_expiry"
      expr: COUNT(DISTINCT CASE WHEN patent_expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 730) THEN drug_product_id END)
      comment: "Number of products whose patent expires within the next 24 months. Critical patent cliff KPI for lifecycle management and generic defense strategy."
    - name: "products_rld_designated"
      expr: COUNT(DISTINCT CASE WHEN rld_flag = TRUE THEN drug_product_id END)
      comment: "Number of products designated as Reference Listed Drugs (RLD). Indicates market leadership position and biosimilar/generic entry risk exposure."
    - name: "black_box_warning_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN black_box_warning_flag = TRUE THEN drug_product_id END) / NULLIF(COUNT(DISTINCT drug_product_id), 0), 2)
      comment: "Percentage of drug products carrying a black box warning. Tracks portfolio-level safety risk concentration for executive risk reviews."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`product_drug_substance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the drug substance (API) master. Tracks active ingredient portfolio health, regulatory status, orphan and NCE designations, and molecular weight distribution for R&D and supply chain decisions."
  source: "`pharmaceuticals_ecm`.`product`.`drug_substance`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the drug substance (Active, Discontinued, etc.) — primary filter for active API portfolio."
    - name: "regulatory_status"
      expr: regulatory_status
      comment: "Regulatory approval status of the drug substance — used to track compliance and market readiness."
    - name: "bcs_classification"
      expr: bcs_classification
      comment: "Biopharmaceutics Classification System class (I–IV) — drives formulation strategy and bioavailability risk assessment."
    - name: "physical_form"
      expr: physical_form
      comment: "Physical state of the API (crystalline, amorphous, etc.) — relevant for manufacturing process design and stability."
    - name: "controlled_substance_schedule"
      expr: controlled_substance_schedule
      comment: "DEA schedule for the substance — used for compliance segmentation and supply chain risk."
    - name: "nce_designation"
      expr: nce_designation
      comment: "Whether the substance is a New Chemical Entity — key flag for exclusivity period and IP strategy."
    - name: "orphan_drug_designation"
      expr: orphan_drug_designation
      comment: "Whether the substance carries orphan drug designation — drives rare disease strategy and incentive tracking."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the drug substance record became effective — used for cohort and vintage analysis."
  measures:
    - name: "total_drug_substances"
      expr: COUNT(DISTINCT drug_substance_id)
      comment: "Total number of distinct drug substances (APIs) in the portfolio. Baseline measure for API portfolio breadth."
    - name: "active_drug_substances"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN drug_substance_id END)
      comment: "Number of currently active drug substances. Measures the live API pipeline depth for supply and R&D planning."
    - name: "nce_designated_substances"
      expr: COUNT(DISTINCT CASE WHEN nce_designation = TRUE THEN drug_substance_id END)
      comment: "Number of New Chemical Entity designated substances. Tracks innovation pipeline strength and exclusivity period exposure."
    - name: "orphan_designated_substances"
      expr: COUNT(DISTINCT CASE WHEN orphan_drug_designation = TRUE THEN drug_substance_id END)
      comment: "Number of substances with orphan drug designation. Informs rare disease strategy, regulatory incentive utilization, and portfolio differentiation."
    - name: "avg_molecular_weight"
      expr: AVG(CAST(molecular_weight AS DOUBLE))
      comment: "Average molecular weight of drug substances in the portfolio. Indicates portfolio complexity (small molecule vs. large molecule) and manufacturing process implications."
    - name: "max_molecular_weight"
      expr: MAX(CAST(molecular_weight AS DOUBLE))
      comment: "Maximum molecular weight in the portfolio. Flags large-molecule biologics that require specialized manufacturing and cold-chain logistics."
    - name: "orphan_designation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN orphan_drug_designation = TRUE THEN drug_substance_id END) / NULLIF(COUNT(DISTINCT drug_substance_id), 0), 2)
      comment: "Percentage of drug substances with orphan drug designation. Tracks rare disease portfolio concentration for strategic franchise decisions."
    - name: "nce_designation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN nce_designation = TRUE THEN drug_substance_id END) / NULLIF(COUNT(DISTINCT drug_substance_id), 0), 2)
      comment: "Percentage of drug substances that are New Chemical Entities. Measures innovation intensity of the API portfolio for R&D investment decisions."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`product_therapeutic_area`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over therapeutic areas. Tracks market opportunity sizing, R&D priority alignment, regulatory complexity, and patient population coverage across the therapeutic franchise portfolio."
  source: "`pharmaceuticals_ecm`.`product`.`therapeutic_area`"
  dimensions:
    - name: "therapeutic_class"
      expr: therapeutic_class
      comment: "Broad therapeutic class (e.g. Oncology, Immunology) — primary segmentation for portfolio strategy."
    - name: "disease_category"
      expr: disease_category
      comment: "Disease category within the therapeutic area — used for disease-level portfolio analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current status of the therapeutic area focus (Active, Exited, etc.) — filters active franchise investments."
    - name: "research_priority_level"
      expr: research_priority_level
      comment: "Internal R&D priority level assigned to the therapeutic area — used to align resource allocation decisions."
    - name: "commercial_priority_level"
      expr: commercial_priority_level
      comment: "Commercial priority level — used to segment high-investment therapeutic areas for revenue planning."
    - name: "unmet_medical_need_level"
      expr: unmet_medical_need_level
      comment: "Level of unmet medical need in the area — key input for portfolio prioritization and regulatory strategy."
    - name: "regulatory_complexity_level"
      expr: regulatory_complexity_level
      comment: "Regulatory complexity classification — used to estimate approval timelines and resource requirements."
    - name: "strategic_franchise"
      expr: strategic_franchise
      comment: "Whether the therapeutic area is a designated strategic franchise — used to filter core vs. non-core portfolio."
    - name: "orphan_designation_eligible"
      expr: orphan_designation_eligible
      comment: "Whether the area is eligible for orphan drug designation — drives rare disease strategy and incentive planning."
    - name: "pediatric_focus"
      expr: pediatric_focus
      comment: "Whether the therapeutic area has a pediatric development focus — relevant for regulatory exclusivity and patient access strategy."
  measures:
    - name: "total_therapeutic_areas"
      expr: COUNT(DISTINCT therapeutic_area_id)
      comment: "Total number of distinct therapeutic areas in the portfolio. Baseline measure for franchise breadth."
    - name: "active_therapeutic_areas"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN therapeutic_area_id END)
      comment: "Number of currently active therapeutic areas. Measures the live franchise footprint for strategic planning."
    - name: "total_global_market_size_usd_millions"
      expr: SUM(CAST(global_market_size_usd_millions AS DOUBLE))
      comment: "Total addressable market size in USD millions across all therapeutic areas. Primary KPI for portfolio opportunity sizing and investment prioritization."
    - name: "avg_global_market_size_usd_millions"
      expr: AVG(CAST(global_market_size_usd_millions AS DOUBLE))
      comment: "Average addressable market size per therapeutic area. Used to benchmark franchise scale and identify under-invested high-opportunity areas."
    - name: "total_patient_population_estimate"
      expr: SUM(CAST(patient_population_estimate AS DOUBLE))
      comment: "Total estimated patient population across all therapeutic areas. Drives patient access strategy and commercial sizing."
    - name: "avg_projected_cagr_percent"
      expr: AVG(CAST(projected_cagr_percent AS DOUBLE))
      comment: "Average projected market CAGR across therapeutic areas. Key growth indicator for portfolio investment and franchise prioritization decisions."
    - name: "max_projected_cagr_percent"
      expr: MAX(CAST(projected_cagr_percent AS DOUBLE))
      comment: "Highest projected CAGR among therapeutic areas. Identifies the fastest-growing franchise opportunity for strategic investment focus."
    - name: "strategic_franchise_count"
      expr: COUNT(DISTINCT CASE WHEN strategic_franchise = TRUE THEN therapeutic_area_id END)
      comment: "Number of therapeutic areas designated as strategic franchises. Tracks core portfolio concentration for executive portfolio reviews."
    - name: "high_unmet_need_area_count"
      expr: COUNT(DISTINCT CASE WHEN unmet_medical_need_level = 'High' THEN therapeutic_area_id END)
      comment: "Number of therapeutic areas with high unmet medical need. Informs R&D prioritization, regulatory strategy, and pricing justification."
    - name: "breakthrough_eligible_area_count"
      expr: COUNT(DISTINCT CASE WHEN breakthrough_therapy_eligible = TRUE THEN therapeutic_area_id END)
      comment: "Number of therapeutic areas eligible for Breakthrough Therapy designation. Tracks potential for accelerated regulatory pathways and competitive differentiation."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`product_lifecycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over product lifecycle events. Tracks pipeline progression, investment-to-date, probability of success, projected peak sales, and milestone achievement across the product development portfolio."
  source: "`pharmaceuticals_ecm`.`product`.`lifecycle`"
  dimensions:
    - name: "stage"
      expr: stage
      comment: "Current development stage of the product (e.g. Discovery, Phase I, Phase II, Phase III, Approved, Launched) — primary dimension for pipeline funnel analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Operational status of the lifecycle record (Active, Discontinued, On Hold) — used to filter active pipeline."
    - name: "regulatory_pathway"
      expr: regulatory_pathway
      comment: "Regulatory approval pathway (NDA, BLA, 505(b)(2), etc.) — used to segment pipeline by regulatory strategy."
    - name: "strategic_priority"
      expr: strategic_priority
      comment: "Strategic priority classification assigned to the product — used to focus executive attention on high-priority pipeline assets."
    - name: "indication"
      expr: indication
      comment: "Target indication for the lifecycle stage — enables indication-level pipeline and investment analysis."
    - name: "gate_decision"
      expr: gate_decision
      comment: "Decision outcome at the most recent stage gate review (Go, No-Go, Hold) — tracks pipeline governance health."
    - name: "milestone_event"
      expr: milestone_event
      comment: "Type of milestone event (e.g. IND Filing, Phase Start, NDA Submission) — used for milestone tracking dashboards."
    - name: "milestone_year"
      expr: YEAR(milestone_date)
      comment: "Year of the milestone event — used for timeline and cohort analysis of pipeline progression."
    - name: "target_launch_year"
      expr: YEAR(target_launch_date)
      comment: "Planned launch year — used for revenue forecasting and commercial readiness planning."
  measures:
    - name: "total_pipeline_assets"
      expr: COUNT(DISTINCT lifecycle_id)
      comment: "Total number of distinct pipeline lifecycle records. Baseline measure for pipeline depth and breadth."
    - name: "active_pipeline_assets"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN lifecycle_id END)
      comment: "Number of currently active pipeline assets. Measures the live development portfolio for R&D capacity planning."
    - name: "total_investment_to_date"
      expr: SUM(CAST(investment_to_date AS DOUBLE))
      comment: "Total cumulative R&D investment across all pipeline assets. Primary financial KPI for R&D spend tracking and portfolio ROI analysis."
    - name: "avg_investment_to_date"
      expr: AVG(CAST(investment_to_date AS DOUBLE))
      comment: "Average R&D investment per pipeline asset. Used to benchmark investment intensity and identify over- or under-funded programs."
    - name: "avg_probability_of_success"
      expr: AVG(CAST(probability_of_success AS DOUBLE))
      comment: "Average probability of technical and regulatory success across pipeline assets. Key risk-adjusted portfolio health indicator for R&D leadership."
    - name: "total_projected_peak_sales"
      expr: SUM(CAST(projected_peak_sales AS DOUBLE))
      comment: "Total projected peak annual sales across all pipeline assets. Primary revenue potential KPI for portfolio valuation and investment prioritization."
    - name: "avg_projected_peak_sales"
      expr: AVG(CAST(projected_peak_sales AS DOUBLE))
      comment: "Average projected peak sales per pipeline asset. Used to identify blockbuster candidates and prioritize development resources."
    - name: "gate_criteria_met_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN gate_criteria_met = TRUE THEN lifecycle_id END) / NULLIF(COUNT(DISTINCT lifecycle_id), 0), 2)
      comment: "Percentage of pipeline assets that have met their stage gate criteria. Tracks pipeline governance quality and development execution health."
    - name: "discontinued_asset_count"
      expr: COUNT(DISTINCT CASE WHEN lifecycle_status = 'Discontinued' THEN lifecycle_id END)
      comment: "Number of discontinued pipeline assets. Tracks pipeline attrition rate and informs go/no-go decision quality reviews."
    - name: "assets_near_target_launch"
      expr: COUNT(DISTINCT CASE WHEN target_launch_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 730) THEN lifecycle_id END)
      comment: "Number of pipeline assets targeting launch within the next 24 months. Critical near-term revenue pipeline KPI for commercial readiness planning."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`product_indication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over product indications. Tracks approval status, breakthrough and orphan designations, exclusivity expiry, and REMS requirements across the indication portfolio."
  source: "`pharmaceuticals_ecm`.`product`.`indication`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Regulatory approval status of the indication (Approved, Pending, Withdrawn) — primary filter for commercial indication portfolio."
    - name: "indication_type"
      expr: indication_type
      comment: "Type of indication (e.g. First-line, Second-line, Adjuvant) — used to segment competitive positioning and label strategy."
    - name: "line_of_therapy"
      expr: line_of_therapy
      comment: "Line of therapy (1L, 2L, 3L+) — critical for commercial strategy and market access negotiations."
    - name: "disease_severity"
      expr: disease_severity
      comment: "Severity of the target disease — used to prioritize unmet need and pricing strategy."
    - name: "combination_therapy_flag"
      expr: combination_therapy_flag
      comment: "Whether the indication is for combination therapy — informs co-promotion and partnership strategy."
    - name: "breakthrough_designation_flag"
      expr: breakthrough_designation_flag
      comment: "Whether the indication has Breakthrough Therapy designation — tracks accelerated pathway assets."
    - name: "orphan_designation_flag"
      expr: orphan_designation_flag
      comment: "Whether the indication has orphan drug designation — drives rare disease strategy and exclusivity tracking."
    - name: "rems_required_flag"
      expr: rems_required_flag
      comment: "Whether a REMS program is required for this indication — drives compliance resource planning."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year of indication approval — used for cohort analysis and time-to-approval benchmarking."
    - name: "exclusivity_expiry_year"
      expr: YEAR(exclusivity_expiry_date)
      comment: "Year exclusivity expires for the indication — critical for lifecycle management and generic entry planning."
  measures:
    - name: "total_indications"
      expr: COUNT(DISTINCT indication_id)
      comment: "Total number of distinct indications in the portfolio. Baseline measure for label breadth and commercial opportunity scope."
    - name: "approved_indications"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN indication_id END)
      comment: "Number of approved indications. Measures the commercially active label portfolio and revenue-generating indication count."
    - name: "breakthrough_designated_indications"
      expr: COUNT(DISTINCT CASE WHEN breakthrough_designation_flag = TRUE THEN indication_id END)
      comment: "Number of indications with Breakthrough Therapy designation. Tracks accelerated regulatory pathway assets for pipeline velocity analysis."
    - name: "orphan_designated_indications"
      expr: COUNT(DISTINCT CASE WHEN orphan_designation_flag = TRUE THEN indication_id END)
      comment: "Number of indications with orphan drug designation. Informs rare disease franchise strategy and exclusivity period management."
    - name: "rems_required_indications"
      expr: COUNT(DISTINCT CASE WHEN rems_required_flag = TRUE THEN indication_id END)
      comment: "Number of indications requiring a REMS program. Drives compliance resource allocation and commercial complexity assessment."
    - name: "indications_near_exclusivity_expiry"
      expr: COUNT(DISTINCT CASE WHEN exclusivity_expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 730) THEN indication_id END)
      comment: "Number of indications whose exclusivity expires within 24 months. Critical lifecycle management KPI for generic/biosimilar defense strategy."
    - name: "black_box_warning_indications"
      expr: COUNT(DISTINCT CASE WHEN black_box_warning_flag = TRUE THEN indication_id END)
      comment: "Number of indications carrying a black box warning. Tracks safety risk concentration across the label portfolio for pharmacovigilance prioritization."
    - name: "breakthrough_designation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN breakthrough_designation_flag = TRUE THEN indication_id END) / NULLIF(COUNT(DISTINCT indication_id), 0), 2)
      comment: "Percentage of indications with Breakthrough Therapy designation. Measures innovation quality and regulatory acceleration potential of the pipeline."
    - name: "combination_therapy_indication_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN combination_therapy_flag = TRUE THEN indication_id END) / NULLIF(COUNT(DISTINCT indication_id), 0), 2)
      comment: "Percentage of indications approved or pursued as combination therapies. Informs partnership strategy and competitive differentiation analysis."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the commercial SKU master. Tracks active commercial portfolio, pricing, launch readiness, and market access across SKUs by therapeutic area, country, and channel."
  source: "`pharmaceuticals_ecm`.`product`.`sku`"
  dimensions:
    - name: "commercial_status"
      expr: commercial_status
      comment: "Commercial availability status of the SKU (Active, Discontinued, Pre-Launch) — primary filter for revenue-generating portfolio."
    - name: "product_type"
      expr: product_type
      comment: "Type of product (Rx, OTC, Biologic, etc.) — used to segment commercial strategy and channel planning."
    - name: "dosage_form"
      expr: dosage_form
      comment: "Physical dosage form of the SKU — used for manufacturing and commercial complexity segmentation."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Administration route — relevant for patient access, HCP targeting, and market access strategy."
    - name: "prescription_status"
      expr: prescription_status
      comment: "Rx or OTC status — drives channel strategy and regulatory compliance segmentation."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Commercial distribution channel (Retail, Specialty, Hospital, etc.) — key dimension for channel performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the list price — used for multi-currency portfolio pricing analysis."
    - name: "controlled_substance_schedule"
      expr: controlled_substance_schedule
      comment: "DEA schedule classification — used for compliance and supply chain risk segmentation."
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year the SKU was commercially launched — used for vintage and cohort analysis."
  measures:
    - name: "total_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Total number of distinct commercial SKUs. Baseline measure for commercial portfolio breadth."
    - name: "active_skus"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN sku_id END)
      comment: "Number of currently active SKUs. Measures the live commercial portfolio for revenue and supply planning."
    - name: "avg_list_price"
      expr: AVG(CAST(list_price AS DOUBLE))
      comment: "Average list price across SKUs. Key pricing benchmark for market access negotiations and competitive pricing analysis."
    - name: "max_list_price"
      expr: MAX(CAST(list_price AS DOUBLE))
      comment: "Maximum list price in the portfolio. Identifies premium-priced assets for pricing strategy and payer negotiation focus."
    - name: "min_list_price"
      expr: MIN(CAST(list_price AS DOUBLE))
      comment: "Minimum list price in the portfolio. Identifies entry-level or generic-competing SKUs for margin management."
    - name: "total_list_price_value"
      expr: SUM(CAST(list_price AS DOUBLE))
      comment: "Sum of list prices across all active SKUs. Proxy for total portfolio price exposure used in gross-to-net and revenue planning models."
    - name: "rems_program_skus"
      expr: COUNT(DISTINCT CASE WHEN rems_program IS NOT NULL AND rems_program <> '' THEN sku_id END)
      comment: "Number of SKUs enrolled in a REMS program. Tracks compliance complexity and associated commercial overhead."
    - name: "serialization_required_skus"
      expr: COUNT(DISTINCT CASE WHEN serialization_required = TRUE THEN sku_id END)
      comment: "Number of SKUs requiring serialization. Drives supply chain compliance investment and track-and-trace readiness assessment."
    - name: "discontinued_sku_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_active = FALSE THEN sku_id END) / NULLIF(COUNT(DISTINCT sku_id), 0), 2)
      comment: "Percentage of SKUs that are no longer active. Tracks portfolio rationalization progress and commercial lifecycle management effectiveness."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`product_regulatory_identifier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over regulatory identifiers. Tracks approval portfolio health, designation rates (Breakthrough, Fast Track, Orphan, Priority Review), exclusivity expiry exposure, and REMS requirements across markets."
  source: "`pharmaceuticals_ecm`.`product`.`regulatory_identifier`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current regulatory approval status (Approved, Pending, Withdrawn) — primary filter for active regulatory portfolio."
    - name: "identifier_type"
      expr: identifier_type
      comment: "Type of regulatory identifier (NDA, BLA, MAA, IND, etc.) — used to segment by regulatory pathway and jurisdiction."
    - name: "marketing_category"
      expr: marketing_category
      comment: "FDA marketing category (Prescription, OTC, Biologic, etc.) — used for commercial and regulatory strategy segmentation."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Regulatory authority that issued the identifier (FDA, EMA, PMDA, etc.) — enables multi-market regulatory portfolio analysis."
    - name: "listing_status"
      expr: listing_status
      comment: "Current listing status of the regulatory identifier — used to track active vs. lapsed registrations."
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form associated with the regulatory identifier — used for formulation-level regulatory analysis."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration on the regulatory filing — used for label and clinical strategy segmentation."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year of regulatory approval — used for approval cohort and time-to-approval benchmarking."
    - name: "exclusivity_expiration_year"
      expr: YEAR(exclusivity_expiration_date)
      comment: "Year exclusivity expires — critical for patent cliff and generic entry planning."
  measures:
    - name: "total_regulatory_identifiers"
      expr: COUNT(DISTINCT regulatory_identifier_id)
      comment: "Total number of distinct regulatory identifiers. Baseline measure for global regulatory portfolio breadth."
    - name: "approved_identifiers"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN regulatory_identifier_id END)
      comment: "Number of approved regulatory identifiers. Measures the active approved product portfolio across all markets."
    - name: "breakthrough_therapy_designations"
      expr: COUNT(DISTINCT CASE WHEN breakthrough_therapy_designation = TRUE THEN regulatory_identifier_id END)
      comment: "Number of regulatory identifiers with Breakthrough Therapy designation. Tracks accelerated approval pathway assets for pipeline velocity and competitive advantage analysis."
    - name: "fast_track_designations"
      expr: COUNT(DISTINCT CASE WHEN fast_track_designation = TRUE THEN regulatory_identifier_id END)
      comment: "Number of regulatory identifiers with Fast Track designation. Measures the portfolio's access to expedited FDA review pathways."
    - name: "priority_review_designations"
      expr: COUNT(DISTINCT CASE WHEN priority_review_designation = TRUE THEN regulatory_identifier_id END)
      comment: "Number of regulatory identifiers with Priority Review designation. Tracks the portfolio's share of high-priority regulatory submissions."
    - name: "orphan_drug_designations"
      expr: COUNT(DISTINCT CASE WHEN orphan_drug_designation = TRUE THEN regulatory_identifier_id END)
      comment: "Number of regulatory identifiers with orphan drug designation. Informs rare disease franchise strategy and exclusivity incentive utilization."
    - name: "rems_required_identifiers"
      expr: COUNT(DISTINCT CASE WHEN rems_required = TRUE THEN regulatory_identifier_id END)
      comment: "Number of regulatory identifiers requiring a REMS program. Drives compliance resource allocation and commercial risk assessment."
    - name: "identifiers_near_exclusivity_expiry"
      expr: COUNT(DISTINCT CASE WHEN exclusivity_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 730) THEN regulatory_identifier_id END)
      comment: "Number of regulatory identifiers whose exclusivity expires within 24 months. Critical patent cliff KPI for lifecycle management and generic/biosimilar defense strategy."
    - name: "withdrawn_identifiers"
      expr: COUNT(DISTINCT CASE WHEN withdrawal_date IS NOT NULL THEN regulatory_identifier_id END)
      comment: "Number of regulatory identifiers that have been withdrawn. Tracks regulatory risk events and portfolio attrition for compliance and safety reporting."
    - name: "accelerated_pathway_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN breakthrough_therapy_designation = TRUE OR fast_track_designation = TRUE OR priority_review_designation = TRUE THEN regulatory_identifier_id END) / NULLIF(COUNT(DISTINCT regulatory_identifier_id), 0), 2)
      comment: "Percentage of regulatory identifiers benefiting from at least one accelerated approval pathway. Measures the portfolio's regulatory acceleration intensity — a key indicator of pipeline innovation quality."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`product_formulation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over pharmaceutical formulations. Tracks formulation portfolio health, QbD adoption, technology transfer readiness, batch size targets, and scale-up efficiency for CMC and manufacturing strategy decisions."
  source: "`pharmaceuticals_ecm`.`product`.`formulation`"
  dimensions:
    - name: "formulation_status"
      expr: formulation_status
      comment: "Current status of the formulation (Active, Obsolete, Under Development) — primary filter for active CMC portfolio."
    - name: "formulation_type"
      expr: formulation_type
      comment: "Type of formulation (immediate release, modified release, lyophilized, etc.) — used for manufacturing complexity and IP strategy segmentation."
    - name: "dosage_form"
      expr: dosage_form
      comment: "Physical dosage form — used to segment manufacturing process requirements and commercial packaging strategy."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration — used for clinical and commercial strategy segmentation."
    - name: "manufacturing_process_type"
      expr: manufacturing_process_type
      comment: "Manufacturing process type (wet granulation, direct compression, aseptic fill, etc.) — used for capacity planning and technology transfer analysis."
    - name: "technology_transfer_status"
      expr: technology_transfer_status
      comment: "Status of technology transfer to manufacturing site — tracks CMC readiness for commercial launch."
    - name: "qbd_design_space_defined"
      expr: qbd_design_space_defined
      comment: "Whether a QbD design space has been defined — measures regulatory submission quality and manufacturing robustness."
    - name: "patent_protected"
      expr: patent_protected
      comment: "Whether the formulation is patent protected — used for IP strategy and lifecycle management segmentation."
    - name: "approved_year"
      expr: YEAR(approved_date)
      comment: "Year the formulation was approved — used for cohort and vintage analysis."
  measures:
    - name: "total_formulations"
      expr: COUNT(DISTINCT formulation_id)
      comment: "Total number of distinct formulations in the portfolio. Baseline measure for CMC portfolio breadth."
    - name: "active_formulations"
      expr: COUNT(DISTINCT CASE WHEN formulation_status = 'Active' THEN formulation_id END)
      comment: "Number of currently active formulations. Measures the live CMC portfolio for manufacturing and regulatory planning."
    - name: "qbd_formulation_count"
      expr: COUNT(DISTINCT CASE WHEN qbd_design_space_defined = TRUE THEN formulation_id END)
      comment: "Number of formulations with a defined QbD design space. Tracks manufacturing quality maturity and regulatory submission strength."
    - name: "qbd_adoption_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN qbd_design_space_defined = TRUE THEN formulation_id END) / NULLIF(COUNT(DISTINCT formulation_id), 0), 2)
      comment: "Percentage of formulations developed using QbD principles. Key CMC quality KPI for regulatory strategy and manufacturing robustness assessment."
    - name: "patent_protected_formulation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN patent_protected = TRUE THEN formulation_id END) / NULLIF(COUNT(DISTINCT formulation_id), 0), 2)
      comment: "Percentage of formulations that are patent protected. Measures IP coverage of the CMC portfolio for lifecycle management and generic defense strategy."
    - name: "avg_batch_size_target"
      expr: AVG(CAST(batch_size_target AS DOUBLE))
      comment: "Average target batch size across formulations. Used for manufacturing capacity planning and scale-up efficiency benchmarking."
    - name: "avg_scale_up_factor"
      expr: AVG(CAST(scale_up_factor AS DOUBLE))
      comment: "Average scale-up factor from development to commercial batch size. Measures manufacturing scalability and technology transfer efficiency."
    - name: "avg_unit_dose_strength"
      expr: AVG(CAST(unit_dose_strength AS DOUBLE))
      comment: "Average unit dose strength across formulations. Used for dose optimization analysis and clinical/commercial strategy benchmarking."
    - name: "technology_transfer_ready_count"
      expr: COUNT(DISTINCT CASE WHEN technology_transfer_status = 'Complete' THEN formulation_id END)
      comment: "Number of formulations with completed technology transfer. Tracks CMC readiness for commercial manufacturing launch."
$$;