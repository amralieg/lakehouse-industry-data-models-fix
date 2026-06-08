-- Metric views for domain: product | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 17:46:18

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`product_medicinal_product`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core product portfolio metrics tracking lifecycle, regulatory status, and strategic positioning of medicinal products"
  source: "`pharmaceuticals_ecm`.`product`.`medicinal_product`"
  dimensions:
    - name: "product_name"
      expr: product_name
      comment: "Commercial name of the medicinal product"
    - name: "product_type"
      expr: product_type
      comment: "Classification of product (e.g., small molecule, biologic, biosimilar)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current stage in product lifecycle (development, marketed, discontinued)"
    - name: "regulatory_designation"
      expr: regulatory_designation
      comment: "Special regulatory status (e.g., orphan drug, breakthrough therapy)"
    - name: "development_stage"
      expr: development_stage
      comment: "Current development phase for pipeline products"
    - name: "orphan_drug_flag"
      expr: orphan_drug_designation
      comment: "Whether product has orphan drug designation for rare diseases"
    - name: "rems_required_flag"
      expr: rems_required
      comment: "Whether Risk Evaluation and Mitigation Strategy is required"
    - name: "qbd_approach_flag"
      expr: qbd_approach
      comment: "Whether Quality by Design principles were applied in development"
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year product was launched to market"
    - name: "launch_month"
      expr: DATE_TRUNC('MONTH', launch_date)
      comment: "Month product was launched to market"
    - name: "approval_year"
      expr: YEAR(first_approval_date)
      comment: "Year of first regulatory approval"
    - name: "patent_expiry_year"
      expr: YEAR(patent_expiry_date)
      comment: "Year when primary patent protection expires"
    - name: "exclusivity_expiry_year"
      expr: YEAR(exclusivity_expiry_date)
      comment: "Year when regulatory exclusivity expires"
    - name: "discontinuation_reason"
      expr: discontinuation_reason
      comment: "Reason for product discontinuation if applicable"
  measures:
    - name: "total_products"
      expr: COUNT(1)
      comment: "Total count of medicinal products in portfolio"
    - name: "active_products"
      expr: COUNT(CASE WHEN lifecycle_status = 'Marketed' THEN 1 END)
      comment: "Count of products currently marketed and generating revenue"
    - name: "pipeline_products"
      expr: COUNT(CASE WHEN lifecycle_status IN ('Development', 'Clinical') THEN 1 END)
      comment: "Count of products in development pipeline"
    - name: "orphan_designated_products"
      expr: COUNT(CASE WHEN orphan_drug_designation = TRUE THEN 1 END)
      comment: "Count of products with orphan drug designation for rare diseases"
    - name: "rems_products"
      expr: COUNT(CASE WHEN rems_required = TRUE THEN 1 END)
      comment: "Count of products requiring Risk Evaluation and Mitigation Strategy"
    - name: "qbd_products"
      expr: COUNT(CASE WHEN qbd_approach = TRUE THEN 1 END)
      comment: "Count of products developed using Quality by Design principles"
    - name: "avg_shelf_life_months"
      expr: AVG(CAST(shelf_life_months AS DOUBLE))
      comment: "Average shelf life in months across products"
    - name: "products_near_patent_expiry"
      expr: COUNT(CASE WHEN patent_expiry_date BETWEEN CURRENT_DATE() AND ADD_MONTHS(CURRENT_DATE(), 24) THEN 1 END)
      comment: "Count of products with patents expiring within next 24 months (loss of exclusivity risk)"
    - name: "products_near_exclusivity_expiry"
      expr: COUNT(CASE WHEN exclusivity_expiry_date BETWEEN CURRENT_DATE() AND ADD_MONTHS(CURRENT_DATE(), 24) THEN 1 END)
      comment: "Count of products with regulatory exclusivity expiring within next 24 months"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`product_drug_product`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug product formulation and manufacturing metrics tracking dosage forms, regulatory compliance, and quality attributes"
  source: "`pharmaceuticals_ecm`.`product`.`drug_product`"
  dimensions:
    - name: "product_name"
      expr: product_name
      comment: "Name of the drug product formulation"
    - name: "product_code"
      expr: product_code
      comment: "Internal product identification code"
    - name: "dosage_form"
      expr: dosage_form
      comment: "Physical form of the drug product (tablet, capsule, injection, etc.)"
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "How the drug is administered (oral, IV, topical, etc.)"
    - name: "formulation_type"
      expr: formulation_type
      comment: "Type of formulation (immediate release, extended release, etc.)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the drug product"
    - name: "product_type"
      expr: product_type
      comment: "Classification of product type"
    - name: "prescription_status"
      expr: prescription_status
      comment: "Whether product is prescription or over-the-counter"
    - name: "controlled_substance_schedule"
      expr: controlled_substance_schedule
      comment: "DEA schedule classification if controlled substance"
    - name: "rld_flag"
      expr: rld_flag
      comment: "Whether product is designated as Reference Listed Drug"
    - name: "rems_flag"
      expr: rems_flag
      comment: "Whether REMS program is required for this product"
    - name: "qbd_flag"
      expr: qbd_flag
      comment: "Whether Quality by Design approach was used"
    - name: "black_box_warning_flag"
      expr: black_box_warning_flag
      comment: "Whether product has FDA black box warning"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year of regulatory approval"
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year product was launched to market"
  measures:
    - name: "total_drug_products"
      expr: COUNT(1)
      comment: "Total count of drug product formulations"
    - name: "active_drug_products"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN 1 END)
      comment: "Count of currently active drug products in portfolio"
    - name: "rld_products"
      expr: COUNT(CASE WHEN rld_flag = TRUE THEN 1 END)
      comment: "Count of Reference Listed Drug products (critical for generic competition)"
    - name: "rems_products"
      expr: COUNT(CASE WHEN rems_flag = TRUE THEN 1 END)
      comment: "Count of products requiring REMS programs (high-risk products)"
    - name: "black_box_warning_products"
      expr: COUNT(CASE WHEN black_box_warning_flag = TRUE THEN 1 END)
      comment: "Count of products with black box warnings (highest safety concern)"
    - name: "controlled_substance_products"
      expr: COUNT(CASE WHEN controlled_substance_schedule IS NOT NULL THEN 1 END)
      comment: "Count of controlled substance products requiring DEA oversight"
    - name: "qbd_products"
      expr: COUNT(CASE WHEN qbd_flag = TRUE THEN 1 END)
      comment: "Count of products developed using Quality by Design principles"
    - name: "avg_strength_value"
      expr: AVG(CAST(strength_value AS DOUBLE))
      comment: "Average strength value across drug products"
    - name: "avg_shelf_life_months"
      expr: AVG(CAST(shelf_life_months AS DOUBLE))
      comment: "Average shelf life in months for drug products"
    - name: "products_near_patent_expiry"
      expr: COUNT(CASE WHEN patent_expiry_date BETWEEN CURRENT_DATE() AND ADD_MONTHS(CURRENT_DATE(), 24) THEN 1 END)
      comment: "Count of products with patents expiring within 24 months (generic entry risk)"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`product_therapeutic_area`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic therapeutic area portfolio metrics tracking market opportunity, regulatory complexity, and research investment priorities"
  source: "`pharmaceuticals_ecm`.`product`.`therapeutic_area`"
  dimensions:
    - name: "area_name"
      expr: area_name
      comment: "Name of the therapeutic area"
    - name: "area_code"
      expr: area_code
      comment: "Code identifier for therapeutic area"
    - name: "therapeutic_class"
      expr: therapeutic_class
      comment: "Therapeutic classification category"
    - name: "disease_category"
      expr: disease_category
      comment: "Category of diseases addressed"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current status of therapeutic area investment"
    - name: "strategic_franchise_flag"
      expr: strategic_franchise
      comment: "Whether this is a strategic franchise for the company"
    - name: "orphan_designation_eligible_flag"
      expr: orphan_designation_eligible
      comment: "Whether area is eligible for orphan drug designations"
    - name: "pediatric_focus_flag"
      expr: pediatric_focus
      comment: "Whether area has pediatric population focus"
    - name: "commercial_priority_level"
      expr: commercial_priority_level
      comment: "Commercial priority ranking for resource allocation"
    - name: "research_priority_level"
      expr: research_priority_level
      comment: "Research and development priority ranking"
    - name: "regulatory_complexity_level"
      expr: regulatory_complexity_level
      comment: "Level of regulatory complexity for this therapeutic area"
    - name: "unmet_medical_need_level"
      expr: unmet_medical_need_level
      comment: "Level of unmet medical need in this therapeutic area"
    - name: "clinical_trial_complexity_level"
      expr: clinical_trial_complexity_level
      comment: "Complexity level of clinical trials in this area"
  measures:
    - name: "total_therapeutic_areas"
      expr: COUNT(1)
      comment: "Total count of therapeutic areas in portfolio"
    - name: "active_therapeutic_areas"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active therapeutic areas"
    - name: "strategic_franchises"
      expr: COUNT(CASE WHEN strategic_franchise = TRUE THEN 1 END)
      comment: "Count of strategic franchise therapeutic areas (core business focus)"
    - name: "orphan_eligible_areas"
      expr: COUNT(CASE WHEN orphan_designation_eligible = TRUE THEN 1 END)
      comment: "Count of areas eligible for orphan drug designation (rare disease opportunity)"
    - name: "pediatric_focus_areas"
      expr: COUNT(CASE WHEN pediatric_focus = TRUE THEN 1 END)
      comment: "Count of therapeutic areas with pediatric population focus"
    - name: "total_global_market_size_usd_millions"
      expr: SUM(CAST(global_market_size_usd_millions AS DOUBLE))
      comment: "Total addressable market size across therapeutic areas in USD millions"
    - name: "avg_global_market_size_usd_millions"
      expr: AVG(CAST(global_market_size_usd_millions AS DOUBLE))
      comment: "Average market size per therapeutic area in USD millions"
    - name: "total_patient_population"
      expr: SUM(CAST(patient_population_estimate AS DOUBLE))
      comment: "Total estimated patient population across therapeutic areas"
    - name: "avg_patient_population"
      expr: AVG(CAST(patient_population_estimate AS DOUBLE))
      comment: "Average patient population per therapeutic area"
    - name: "avg_projected_cagr_percent"
      expr: AVG(CAST(projected_cagr_percent AS DOUBLE))
      comment: "Average projected compound annual growth rate across therapeutic areas"
    - name: "high_unmet_need_areas"
      expr: COUNT(CASE WHEN unmet_medical_need_level = 'High' THEN 1 END)
      comment: "Count of therapeutic areas with high unmet medical need (strategic opportunity)"
    - name: "high_commercial_priority_areas"
      expr: COUNT(CASE WHEN commercial_priority_level = 'High' THEN 1 END)
      comment: "Count of high commercial priority therapeutic areas"
    - name: "high_research_priority_areas"
      expr: COUNT(CASE WHEN research_priority_level = 'High' THEN 1 END)
      comment: "Count of high research priority therapeutic areas"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`product_lifecycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product lifecycle stage progression metrics tracking development milestones, investment, and probability of success"
  source: "`pharmaceuticals_ecm`.`product`.`lifecycle`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the product"
    - name: "stage"
      expr: stage
      comment: "Current development or commercialization stage"
    - name: "previous_stage"
      expr: previous_stage
      comment: "Previous stage in lifecycle progression"
    - name: "next_planned_stage"
      expr: next_planned_stage
      comment: "Next planned stage in development"
    - name: "regulatory_pathway"
      expr: regulatory_pathway
      comment: "Regulatory approval pathway being pursued"
    - name: "strategic_priority"
      expr: strategic_priority
      comment: "Strategic priority level for resource allocation"
    - name: "gate_decision"
      expr: gate_decision
      comment: "Decision at most recent stage gate review"
    - name: "gate_criteria_met_flag"
      expr: gate_criteria_met
      comment: "Whether stage gate criteria were met"
    - name: "is_active_flag"
      expr: is_active
      comment: "Whether lifecycle record is currently active"
    - name: "discontinuation_reason"
      expr: discontinuation_reason
      comment: "Reason for product discontinuation if applicable"
    - name: "stage_entry_year"
      expr: YEAR(stage_entry_date)
      comment: "Year product entered current stage"
    - name: "stage_entry_month"
      expr: DATE_TRUNC('MONTH', stage_entry_date)
      comment: "Month product entered current stage"
    - name: "target_launch_year"
      expr: YEAR(target_launch_date)
      comment: "Target year for product launch"
    - name: "actual_launch_year"
      expr: YEAR(actual_launch_date)
      comment: "Actual year product was launched"
  measures:
    - name: "total_lifecycle_records"
      expr: COUNT(1)
      comment: "Total count of product lifecycle records"
    - name: "active_products"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of products with active lifecycle records"
    - name: "discontinued_products"
      expr: COUNT(CASE WHEN discontinuation_date IS NOT NULL THEN 1 END)
      comment: "Count of discontinued products (portfolio attrition)"
    - name: "gate_criteria_met_count"
      expr: COUNT(CASE WHEN gate_criteria_met = TRUE THEN 1 END)
      comment: "Count of products meeting stage gate criteria (development quality)"
    - name: "total_investment_to_date"
      expr: SUM(CAST(investment_to_date AS DOUBLE))
      comment: "Total investment across all products to date"
    - name: "avg_investment_to_date"
      expr: AVG(CAST(investment_to_date AS DOUBLE))
      comment: "Average investment per product to date"
    - name: "total_projected_peak_sales"
      expr: SUM(CAST(projected_peak_sales AS DOUBLE))
      comment: "Total projected peak sales across portfolio"
    - name: "avg_projected_peak_sales"
      expr: AVG(CAST(projected_peak_sales AS DOUBLE))
      comment: "Average projected peak sales per product"
    - name: "avg_probability_of_success"
      expr: AVG(CAST(probability_of_success AS DOUBLE))
      comment: "Average probability of success across pipeline products"
    - name: "high_priority_products"
      expr: COUNT(CASE WHEN strategic_priority = 'High' THEN 1 END)
      comment: "Count of high strategic priority products"
    - name: "products_launched_on_time"
      expr: COUNT(CASE WHEN actual_launch_date <= target_launch_date THEN 1 END)
      comment: "Count of products launched on or before target date (execution quality)"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`product_indication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product indication and label claim metrics tracking approved uses, regulatory designations, and market exclusivity"
  source: "`pharmaceuticals_ecm`.`product`.`indication`"
  dimensions:
    - name: "indication_name"
      expr: indication_name
      comment: "Name of the approved indication"
    - name: "indication_type"
      expr: indication_type
      comment: "Type of indication (primary, secondary, expanded)"
    - name: "approval_status"
      expr: approval_status
      comment: "Current regulatory approval status"
    - name: "record_status"
      expr: record_status
      comment: "Status of the indication record"
    - name: "disease_severity"
      expr: disease_severity
      comment: "Severity level of disease being treated"
    - name: "line_of_therapy"
      expr: line_of_therapy
      comment: "Line of therapy (first-line, second-line, etc.)"
    - name: "patient_population"
      expr: patient_population
      comment: "Target patient population for this indication"
    - name: "orphan_designation_flag"
      expr: orphan_designation_flag
      comment: "Whether indication has orphan drug designation"
    - name: "breakthrough_designation_flag"
      expr: breakthrough_designation_flag
      comment: "Whether indication has breakthrough therapy designation"
    - name: "black_box_warning_flag"
      expr: black_box_warning_flag
      comment: "Whether indication has black box warning"
    - name: "rems_required_flag"
      expr: rems_required_flag
      comment: "Whether REMS is required for this indication"
    - name: "combination_therapy_flag"
      expr: combination_therapy_flag
      comment: "Whether indication involves combination therapy"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year indication was approved"
    - name: "patent_expiry_year"
      expr: YEAR(patent_expiry_date)
      comment: "Year patent protection expires for this indication"
    - name: "exclusivity_expiry_year"
      expr: YEAR(exclusivity_expiry_date)
      comment: "Year regulatory exclusivity expires"
  measures:
    - name: "total_indications"
      expr: COUNT(1)
      comment: "Total count of approved indications across products"
    - name: "active_indications"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Count of currently approved and active indications"
    - name: "orphan_designated_indications"
      expr: COUNT(CASE WHEN orphan_designation_flag = TRUE THEN 1 END)
      comment: "Count of indications with orphan drug designation (rare disease market)"
    - name: "breakthrough_designated_indications"
      expr: COUNT(CASE WHEN breakthrough_designation_flag = TRUE THEN 1 END)
      comment: "Count of indications with breakthrough therapy designation (expedited review)"
    - name: "black_box_warning_indications"
      expr: COUNT(CASE WHEN black_box_warning_flag = TRUE THEN 1 END)
      comment: "Count of indications with black box warnings (highest safety risk)"
    - name: "rems_required_indications"
      expr: COUNT(CASE WHEN rems_required_flag = TRUE THEN 1 END)
      comment: "Count of indications requiring REMS programs"
    - name: "combination_therapy_indications"
      expr: COUNT(CASE WHEN combination_therapy_flag = TRUE THEN 1 END)
      comment: "Count of indications involving combination therapy"
    - name: "first_line_therapy_indications"
      expr: COUNT(CASE WHEN line_of_therapy = 'First-line' THEN 1 END)
      comment: "Count of first-line therapy indications (primary treatment position)"
    - name: "indications_near_patent_expiry"
      expr: COUNT(CASE WHEN patent_expiry_date BETWEEN CURRENT_DATE() AND ADD_MONTHS(CURRENT_DATE(), 24) THEN 1 END)
      comment: "Count of indications with patents expiring within 24 months (generic competition risk)"
    - name: "indications_near_exclusivity_expiry"
      expr: COUNT(CASE WHEN exclusivity_expiry_date BETWEEN CURRENT_DATE() AND ADD_MONTHS(CURRENT_DATE(), 24) THEN 1 END)
      comment: "Count of indications with exclusivity expiring within 24 months"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`product_bioequivalence_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bioequivalence study metrics tracking generic development, regulatory compliance, and study outcomes"
  source: "`pharmaceuticals_ecm`.`product`.`bioequivalence_study`"
  dimensions:
    - name: "study_protocol_number"
      expr: study_protocol_number
      comment: "Unique protocol number for the bioequivalence study"
    - name: "study_status"
      expr: study_status
      comment: "Current status of the bioequivalence study"
    - name: "study_type"
      expr: study_type
      comment: "Type of bioequivalence study conducted"
    - name: "study_phase"
      expr: study_phase
      comment: "Phase of the bioequivalence study"
    - name: "study_design"
      expr: study_design
      comment: "Design methodology of the study"
    - name: "bioequivalence_conclusion"
      expr: bioequivalence_conclusion
      comment: "Final conclusion on bioequivalence (pass/fail)"
    - name: "fasting_fed_condition"
      expr: fasting_fed_condition
      comment: "Whether study was conducted under fasting or fed conditions"
    - name: "gcp_compliance_flag"
      expr: gcp_compliance_flag
      comment: "Whether study was conducted in compliance with Good Clinical Practice"
    - name: "glp_compliance_flag"
      expr: glp_compliance_flag
      comment: "Whether study was conducted in compliance with Good Laboratory Practice"
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form tested in the study"
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration tested"
    - name: "study_start_year"
      expr: YEAR(study_start_date)
      comment: "Year study was initiated"
    - name: "study_completion_year"
      expr: YEAR(study_completion_date)
      comment: "Year study was completed"
  measures:
    - name: "total_bioequivalence_studies"
      expr: COUNT(1)
      comment: "Total count of bioequivalence studies conducted"
    - name: "completed_studies"
      expr: COUNT(CASE WHEN study_status = 'Completed' THEN 1 END)
      comment: "Count of completed bioequivalence studies"
    - name: "successful_bioequivalence_studies"
      expr: COUNT(CASE WHEN bioequivalence_conclusion = 'Bioequivalent' THEN 1 END)
      comment: "Count of studies demonstrating bioequivalence (generic approval pathway success)"
    - name: "gcp_compliant_studies"
      expr: COUNT(CASE WHEN gcp_compliance_flag = TRUE THEN 1 END)
      comment: "Count of studies compliant with Good Clinical Practice"
    - name: "glp_compliant_studies"
      expr: COUNT(CASE WHEN glp_compliance_flag = TRUE THEN 1 END)
      comment: "Count of studies compliant with Good Laboratory Practice"
    - name: "avg_auc_90_ci_lower"
      expr: AVG(CAST(auc_90_ci_lower AS DOUBLE))
      comment: "Average lower bound of 90% confidence interval for AUC ratio"
    - name: "avg_auc_90_ci_upper"
      expr: AVG(CAST(auc_90_ci_upper AS DOUBLE))
      comment: "Average upper bound of 90% confidence interval for AUC ratio"
    - name: "avg_cmax_90_ci_lower"
      expr: AVG(CAST(cmax_90_ci_lower AS DOUBLE))
      comment: "Average lower bound of 90% confidence interval for Cmax ratio"
    - name: "avg_cmax_90_ci_upper"
      expr: AVG(CAST(cmax_90_ci_upper AS DOUBLE))
      comment: "Average upper bound of 90% confidence interval for Cmax ratio"
    - name: "avg_pk_parameter_auc_ratio"
      expr: AVG(CAST(pk_parameter_auc_ratio AS DOUBLE))
      comment: "Average AUC ratio between test and reference products"
    - name: "avg_pk_parameter_cmax_ratio"
      expr: AVG(CAST(pk_parameter_cmax_ratio AS DOUBLE))
      comment: "Average Cmax ratio between test and reference products"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SKU-level commercial metrics tracking pricing, distribution, and market availability"
  source: "`pharmaceuticals_ecm`.`product`.`sku`"
  dimensions:
    - name: "trade_name"
      expr: trade_name
      comment: "Commercial trade name of the SKU"
    - name: "generic_name"
      expr: generic_name
      comment: "Generic name of the product"
    - name: "material_number"
      expr: material_number
      comment: "Material number for inventory and ordering"
    - name: "gtin"
      expr: gtin
      comment: "Global Trade Item Number for supply chain tracking"
    - name: "commercial_status"
      expr: commercial_status
      comment: "Current commercial status of the SKU"
    - name: "product_type"
      expr: product_type
      comment: "Type of product"
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form of the SKU"
    - name: "strength"
      expr: strength
      comment: "Strength of the product"
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for the SKU"
    - name: "prescription_status"
      expr: prescription_status
      comment: "Whether product is prescription or OTC"
    - name: "controlled_substance_schedule"
      expr: controlled_substance_schedule
      comment: "DEA schedule if controlled substance"
    - name: "serialization_required_flag"
      expr: serialization_required
      comment: "Whether serialization is required for this SKU"
    - name: "is_active_flag"
      expr: is_active
      comment: "Whether SKU is currently active"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for pricing"
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year SKU was launched"
    - name: "launch_month"
      expr: DATE_TRUNC('MONTH', launch_date)
      comment: "Month SKU was launched"
  measures:
    - name: "total_skus"
      expr: COUNT(1)
      comment: "Total count of SKUs in portfolio"
    - name: "active_skus"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active SKUs available for sale"
    - name: "discontinued_skus"
      expr: COUNT(CASE WHEN discontinuation_date IS NOT NULL THEN 1 END)
      comment: "Count of discontinued SKUs"
    - name: "serialization_required_skus"
      expr: COUNT(CASE WHEN serialization_required = TRUE THEN 1 END)
      comment: "Count of SKUs requiring serialization for track-and-trace compliance"
    - name: "controlled_substance_skus"
      expr: COUNT(CASE WHEN controlled_substance_schedule IS NOT NULL THEN 1 END)
      comment: "Count of controlled substance SKUs requiring DEA oversight"
    - name: "total_list_price"
      expr: SUM(CAST(list_price AS DOUBLE))
      comment: "Total list price across all SKUs"
    - name: "avg_list_price"
      expr: AVG(CAST(list_price AS DOUBLE))
      comment: "Average list price per SKU"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`product_change_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product change control metrics tracking regulatory changes, impact assessments, and compliance with change management processes"
  source: "`pharmaceuticals_ecm`.`product`.`product_change_control`"
  dimensions:
    - name: "change_control_number"
      expr: change_control_number
      comment: "Unique identifier for the change control record"
    - name: "change_status"
      expr: change_status
      comment: "Current status of the change control"
    - name: "change_type"
      expr: change_type
      comment: "Type of change being implemented"
    - name: "change_category"
      expr: change_category
      comment: "Category of the change"
    - name: "quality_impact_level"
      expr: quality_impact_level
      comment: "Level of impact on product quality"
    - name: "safety_impact_level"
      expr: safety_impact_level
      comment: "Level of impact on product safety"
    - name: "efficacy_impact_level"
      expr: efficacy_impact_level
      comment: "Level of impact on product efficacy"
    - name: "prior_approval_required_flag"
      expr: prior_approval_required_flag
      comment: "Whether prior regulatory approval is required"
    - name: "notification_required_flag"
      expr: notification_required_flag
      comment: "Whether regulatory notification is required"
    - name: "stability_study_required_flag"
      expr: stability_study_required_flag
      comment: "Whether stability studies are required for the change"
    - name: "validation_required_flag"
      expr: validation_required_flag
      comment: "Whether validation is required for the change"
    - name: "health_authority"
      expr: health_authority
      comment: "Health authority overseeing the change"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year change was approved"
    - name: "implementation_year"
      expr: YEAR(implementation_date)
      comment: "Year change was implemented"
  measures:
    - name: "total_change_controls"
      expr: COUNT(1)
      comment: "Total count of product change control records"
    - name: "approved_changes"
      expr: COUNT(CASE WHEN change_status = 'Approved' THEN 1 END)
      comment: "Count of approved change controls"
    - name: "closed_changes"
      expr: COUNT(CASE WHEN change_status = 'Closed' THEN 1 END)
      comment: "Count of closed change controls (completed implementation)"
    - name: "prior_approval_changes"
      expr: COUNT(CASE WHEN prior_approval_required_flag = TRUE THEN 1 END)
      comment: "Count of changes requiring prior regulatory approval (high regulatory burden)"
    - name: "notification_required_changes"
      expr: COUNT(CASE WHEN notification_required_flag = TRUE THEN 1 END)
      comment: "Count of changes requiring regulatory notification"
    - name: "stability_study_required_changes"
      expr: COUNT(CASE WHEN stability_study_required_flag = TRUE THEN 1 END)
      comment: "Count of changes requiring stability studies (significant quality impact)"
    - name: "validation_required_changes"
      expr: COUNT(CASE WHEN validation_required_flag = TRUE THEN 1 END)
      comment: "Count of changes requiring validation (process/method changes)"
    - name: "high_quality_impact_changes"
      expr: COUNT(CASE WHEN quality_impact_level = 'High' THEN 1 END)
      comment: "Count of changes with high quality impact (critical quality attributes affected)"
    - name: "high_safety_impact_changes"
      expr: COUNT(CASE WHEN safety_impact_level = 'High' THEN 1 END)
      comment: "Count of changes with high safety impact (patient safety risk)"
    - name: "high_efficacy_impact_changes"
      expr: COUNT(CASE WHEN efficacy_impact_level = 'High' THEN 1 END)
      comment: "Count of changes with high efficacy impact (therapeutic effect affected)"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`product_formulation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formulation development metrics tracking composition, manufacturing complexity, and quality-by-design approaches"
  source: "`pharmaceuticals_ecm`.`product`.`formulation`"
  dimensions:
    - name: "formulation_code"
      expr: formulation_code
      comment: "Unique code identifier for the formulation"
    - name: "formulation_name"
      expr: formulation_name
      comment: "Name of the formulation"
    - name: "formulation_status"
      expr: formulation_status
      comment: "Current development status of the formulation"
    - name: "formulation_type"
      expr: formulation_type
      comment: "Type of formulation (immediate release, extended release, etc.)"
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form of the formulation"
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration for the formulation"
    - name: "manufacturing_process_type"
      expr: manufacturing_process_type
      comment: "Type of manufacturing process used"
    - name: "qbd_design_space_defined_flag"
      expr: qbd_design_space_defined
      comment: "Whether Quality by Design design space has been defined"
    - name: "patent_protected_flag"
      expr: patent_protected
      comment: "Whether formulation is patent protected"
    - name: "technology_transfer_status"
      expr: technology_transfer_status
      comment: "Status of technology transfer to manufacturing"
    - name: "version_number"
      expr: version_number
      comment: "Version number of the formulation"
  measures:
    - name: "total_formulations"
      expr: COUNT(1)
      comment: "Total count of formulations in development and production"
    - name: "active_formulations"
      expr: COUNT(CASE WHEN formulation_status = 'Active' THEN 1 END)
      comment: "Count of currently active formulations"
    - name: "qbd_formulations"
      expr: COUNT(CASE WHEN qbd_design_space_defined = TRUE THEN 1 END)
      comment: "Count of formulations developed using Quality by Design principles (regulatory advantage)"
    - name: "patent_protected_formulations"
      expr: COUNT(CASE WHEN patent_protected = TRUE THEN 1 END)
      comment: "Count of patent-protected formulations (competitive advantage)"
    - name: "avg_batch_size_target"
      expr: AVG(CAST(batch_size_target AS DOUBLE))
      comment: "Average target batch size across formulations"
    - name: "avg_scale_up_factor"
      expr: AVG(CAST(scale_up_factor AS DOUBLE))
      comment: "Average scale-up factor from development to commercial manufacturing"
    - name: "avg_unit_dose_strength"
      expr: AVG(CAST(unit_dose_strength AS DOUBLE))
      comment: "Average unit dose strength across formulations"
    - name: "avg_shelf_life_months"
      expr: AVG(CAST(shelf_life_months AS DOUBLE))
      comment: "Average shelf life in months for formulations"
    - name: "technology_transfer_complete"
      expr: COUNT(CASE WHEN technology_transfer_status = 'Complete' THEN 1 END)
      comment: "Count of formulations with completed technology transfer (ready for commercial manufacturing)"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`product_prescription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prescription and patient therapy metrics tracking adherence, utilization, and specialty pharmacy requirements"
  source: "`pharmaceuticals_ecm`.`product`.`prescription`"
  dimensions:
    - name: "prescription_status"
      expr: prescription_status
      comment: "Current status of the prescription"
    - name: "prior_authorization_required_flag"
      expr: prior_authorization_required
      comment: "Whether prior authorization is required for this prescription"
    - name: "specialty_pharmacy_flag"
      expr: specialty_pharmacy_flag
      comment: "Whether prescription must be filled through specialty pharmacy"
    - name: "discontinuation_reason"
      expr: discontinuation_reason
      comment: "Reason for therapy discontinuation if applicable"
    - name: "prescription_year"
      expr: YEAR(prescription_date)
      comment: "Year prescription was written"
    - name: "prescription_month"
      expr: DATE_TRUNC('MONTH', prescription_date)
      comment: "Month prescription was written"
    - name: "therapy_start_year"
      expr: YEAR(therapy_start_date)
      comment: "Year patient started therapy"
  measures:
    - name: "total_prescriptions"
      expr: COUNT(1)
      comment: "Total count of prescriptions written"
    - name: "active_prescriptions"
      expr: COUNT(CASE WHEN prescription_status = 'Active' THEN 1 END)
      comment: "Count of currently active prescriptions"
    - name: "prior_authorization_prescriptions"
      expr: COUNT(CASE WHEN prior_authorization_required = TRUE THEN 1 END)
      comment: "Count of prescriptions requiring prior authorization (access barrier)"
    - name: "specialty_pharmacy_prescriptions"
      expr: COUNT(CASE WHEN specialty_pharmacy_flag = TRUE THEN 1 END)
      comment: "Count of prescriptions requiring specialty pharmacy (high-cost/complex therapies)"
    - name: "discontinued_prescriptions"
      expr: COUNT(CASE WHEN discontinuation_reason IS NOT NULL THEN 1 END)
      comment: "Count of discontinued prescriptions (therapy persistence issue)"
    - name: "avg_adherence_score"
      expr: AVG(CAST(adherence_score AS DOUBLE))
      comment: "Average patient adherence score (critical for therapy effectiveness)"
    - name: "avg_refill_count"
      expr: AVG(CAST(refill_count AS DOUBLE))
      comment: "Average number of refills per prescription (persistence indicator)"
    - name: "unique_patients"
      expr: COUNT(DISTINCT patient_id)
      comment: "Count of unique patients receiving prescriptions"
$$;