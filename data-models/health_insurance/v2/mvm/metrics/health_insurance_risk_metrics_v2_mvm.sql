-- Metric views for domain: risk | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 01:44:05

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_member_risk_score`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for member risk scoring — tracks plan-calculated vs CMS-published risk scores, score variance, demographic factor contributions, and submission quality. Used by actuarial, finance, and risk adjustment teams to monitor RAF accuracy and payment year exposure."
  source: "`vibe_health_insurance_v1`.`risk`.`member_risk_score`"
  dimensions:
    - name: "payment_year"
      expr: CAST(payment_year AS INT)
      comment: "Payment year for which the risk score applies — primary time dimension for year-over-year risk trend analysis."
    - name: "model_name"
      expr: model_name
      comment: "CMS risk adjustment model name (e.g., CMS-HCC, RxHCC) used to calculate the score — enables model-level performance comparison."
    - name: "model_version"
      expr: model_version
      comment: "Version of the risk adjustment model applied — critical for tracking model year transitions and their financial impact."
    - name: "cms_submission_status"
      expr: cms_submission_status
      comment: "CMS acknowledgment status of the risk score submission — used to identify accepted, rejected, or pending records."
    - name: "variance_category"
      expr: variance_category
      comment: "Categorical classification of the score variance between plan-calculated and CMS-published scores — drives corrective action prioritization."
    - name: "record_status"
      expr: record_status
      comment: "Lifecycle status of the risk score record (active, voided, superseded) — used to filter to current valid scores."
    - name: "is_manual_override"
      expr: is_manual_override
      comment: "Indicates whether the risk score was manually overridden — flags records requiring additional audit scrutiny."
    - name: "score_effective_date_month"
      expr: DATE_TRUNC('MONTH', score_effective_date)
      comment: "Month in which the risk score became effective — supports monthly trend analysis of risk score changes."
  measures:
    - name: "avg_plan_calculated_score"
      expr: AVG(CAST(plan_calculated_score AS DOUBLE))
      comment: "Average plan-calculated risk adjustment factor score across members — primary actuarial KPI for estimating expected medical costs and CMS payments."
    - name: "avg_cms_published_score"
      expr: AVG(CAST(cms_published_score AS DOUBLE))
      comment: "Average CMS-published risk score — the official score used for capitation payment calculations; compared against plan-calculated score to identify revenue leakage."
    - name: "avg_score_variance"
      expr: AVG(CAST(score_variance AS DOUBLE))
      comment: "Average difference between plan-calculated and CMS-published risk scores — a key indicator of risk adjustment accuracy and potential revenue impact."
    - name: "total_score_variance"
      expr: SUM(CAST(score_variance AS DOUBLE))
      comment: "Total cumulative score variance across all members — quantifies the aggregate financial exposure from risk score discrepancies between plan and CMS."
    - name: "avg_demographic_factor_score"
      expr: AVG(CAST(demographic_factor_score AS DOUBLE))
      comment: "Average demographic adjustment factor contribution to the risk score — used to assess the demographic mix of the enrolled population and its payment impact."
    - name: "avg_risk_score_confidence"
      expr: AVG(CAST(risk_score_confidence_score AS DOUBLE))
      comment: "Average confidence score assigned to risk score calculations — low confidence scores signal data quality issues requiring remediation before CMS submission."
    - name: "manual_override_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_manual_override = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risk score records that were manually overridden — high rates indicate systemic data quality or coding issues requiring process improvement."
    - name: "total_risk_score_value"
      expr: SUM(CAST(risk_score_value AS DOUBLE))
      comment: "Sum of all risk score values across the scored population — used to estimate total expected cost burden and validate aggregate payment calculations."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_raps_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for RAPS (Risk Adjustment Processing System) submissions to CMS. Tracks submission volumes, acceptance rates, risk adjustment factors, and payment year exposure. Used by risk adjustment operations and compliance teams."
  source: "`vibe_health_insurance_v1`.`risk`.`raps_submission`"
  dimensions:
    - name: "payment_year"
      expr: CAST(payment_year AS INT)
      comment: "Payment year associated with the RAPS submission — primary dimension for year-over-year submission performance tracking."
    - name: "risk_adjustment_year"
      expr: risk_adjustment_year
      comment: "The risk adjustment data year (RADY) for the submission — used to align submissions with the correct CMS processing cycle."
    - name: "plan_contract_number"
      expr: plan_contract_number
      comment: "CMS contract number for the health plan — enables contract-level submission performance analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of health plan (e.g., MA-PD, PDP) — used to segment submission metrics by plan type for regulatory reporting."
    - name: "raps_submission_status"
      expr: raps_submission_status
      comment: "Current processing status of the RAPS submission (submitted, accepted, rejected, pending) — operational dimension for submission pipeline monitoring."
    - name: "cms_acknowledgment_status"
      expr: cms_acknowledgment_status
      comment: "CMS acknowledgment status returned for the submission — distinguishes accepted, rejected, and error submissions for compliance tracking."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of submission to CMS — used to track submission cadence and identify late or missing submission windows."
  measures:
    - name: "total_submissions"
      expr: COUNT(DISTINCT raps_submission_id)
      comment: "Total number of RAPS submissions — baseline volume metric for submission pipeline capacity and throughput monitoring."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor across all submissions — key financial metric directly tied to CMS capitation payment amounts."
    - name: "total_risk_score"
      expr: SUM(CAST(risk_score AS DOUBLE))
      comment: "Sum of risk scores across all submissions — aggregate measure of total risk burden submitted to CMS for payment reconciliation."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score per submission — used to benchmark submission quality and identify anomalous batches requiring review."
    - name: "total_records_submitted"
      expr: SUM(CAST(total_record_count AS DOUBLE))
      comment: "Total number of diagnosis records submitted across all RAPS batches — measures the scale of risk adjustment data submitted to CMS."
    - name: "total_payment_year_exposure"
      expr: SUM(CAST(payment_year AS DOUBLE))
      comment: "Sum of payment years across submissions — used as a proxy weight for multi-year submission volume analysis and financial exposure aggregation."
    - name: "unique_plan_contracts"
      expr: COUNT(DISTINCT plan_contract_number)
      comment: "Number of distinct CMS contract numbers with active submissions — measures breadth of risk adjustment program coverage across the plan portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_radv_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and compliance KPIs for RADV (Risk Adjustment Data Validation) audits conducted by CMS. Tracks audit error rates, payment errors, settlement amounts, and HCC validation outcomes. Used by compliance, finance, and risk adjustment leadership to manage audit risk and financial exposure."
  source: "`vibe_health_insurance_v1`.`risk`.`radv_audit`"
  dimensions:
    - name: "audit_year"
      expr: audit_year
      comment: "CMS audit year — primary time dimension for tracking RADV audit cycles and year-over-year compliance trends."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of RADV audit (e.g., contract-level, national) — used to segment financial exposure by audit scope."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (open, closed, appealed, settled) — operational dimension for audit pipeline management."
    - name: "audit_source"
      expr: audit_source
      comment: "Source or initiator of the audit (CMS, internal, third-party) — used to distinguish regulatory audits from internal quality reviews."
    - name: "audit_error_flag"
      expr: audit_error_flag
      comment: "Boolean flag indicating whether the audit identified an error — primary filter for isolating problematic audit records."
    - name: "medical_record_request_status"
      expr: medical_record_request_status
      comment: "Status of medical record retrieval for the audit — tracks documentation completeness which directly impacts audit outcomes."
    - name: "audit_start_month"
      expr: DATE_TRUNC('MONTH', audit_start_timestamp)
      comment: "Month the audit was initiated — used to track audit volume trends and resource planning for audit response teams."
  measures:
    - name: "total_audits"
      expr: COUNT(DISTINCT radv_audit_id)
      comment: "Total number of RADV audit records — baseline volume metric for audit program scope and workload management."
    - name: "audit_error_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN audit_error_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits with identified errors — primary compliance KPI; high error rates trigger CMS payment adjustments and corrective action plans."
    - name: "total_extrapolated_payment_error"
      expr: SUM(CAST(extrapolated_payment_error AS DOUBLE))
      comment: "Total extrapolated payment error amount across all audits — the primary financial exposure metric from RADV audits; directly impacts CMS payment recoupment amounts."
    - name: "avg_extrapolated_payment_error"
      expr: AVG(CAST(extrapolated_payment_error AS DOUBLE))
      comment: "Average extrapolated payment error per audit — used to benchmark audit severity and prioritize corrective action resources."
    - name: "total_final_settlement_amount"
      expr: SUM(CAST(final_settlement_amount AS DOUBLE))
      comment: "Total amount settled with CMS across all closed RADV audits — key financial outcome metric representing actual cash impact of audit findings."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor validated through RADV audit — compared against submitted RAF to quantify the accuracy of risk score submissions."
    - name: "audits_with_errors"
      expr: SUM(CASE WHEN audit_error_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Absolute count of audits with identified errors — used alongside error rate to assess total compliance burden and CMS recoupment risk."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_hcc_mapping`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governance and quality KPIs for the HCC (Hierarchical Condition Category) code mapping repository. Tracks mapping coverage, coefficient distributions, and adjustment factor profiles. Used by clinical informatics and risk adjustment teams to ensure coding accuracy and model integrity."
  source: "`vibe_health_insurance_v1`.`risk`.`hcc_mapping`"
  dimensions:
    - name: "model_year"
      expr: model_year
      comment: "CMS HCC model year — primary dimension for tracking mapping changes across annual model updates."
    - name: "hcc_code"
      expr: hcc_code
      comment: "HCC category code — the core clinical grouping used in CMS risk adjustment payment models."
    - name: "hcc_mapping_status"
      expr: hcc_mapping_status
      comment: "Current status of the HCC mapping record (active, deprecated, under review) — used to filter to production-ready mappings."
    - name: "review_status"
      expr: review_status
      comment: "Clinical review status of the mapping — identifies mappings pending validation that may introduce risk score inaccuracies."
    - name: "mapping_source"
      expr: mapping_source
      comment: "Source system or authority for the mapping (CMS, internal, vendor) — used to assess mapping provenance and reliability."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Hierarchical level of the HCC code within the condition category tree — used to analyze coding specificity and hierarchy compliance."
    - name: "disease_interaction_group"
      expr: disease_interaction_group
      comment: "Disease interaction group for the HCC — identifies codes eligible for interaction adjustments that increase risk score complexity."
    - name: "is_mapped"
      expr: is_mapped
      comment: "Boolean indicating whether the ICD-10 code has a valid HCC mapping — used to measure mapping coverage gaps."
    - name: "interaction_flag"
      expr: interaction_flag
      comment: "Indicates whether this HCC participates in a disease interaction adjustment — interaction codes carry higher financial weight."
    - name: "effective_date_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the HCC mapping became effective — used to track mapping lifecycle and annual model transitions."
  measures:
    - name: "total_active_mappings"
      expr: SUM(CASE WHEN is_mapped = TRUE AND is_excluded = FALSE THEN 1 ELSE 0 END)
      comment: "Count of active, non-excluded HCC mappings — measures the breadth of the coding library available for risk score calculation."
    - name: "mapping_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_mapped = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ICD-10 codes with a valid HCC mapping — a critical data quality KPI; low coverage means diagnoses are not contributing to risk scores, causing revenue leakage."
    - name: "avg_risk_score_weight"
      expr: AVG(CAST(risk_score_weight AS DOUBLE))
      comment: "Average risk score weight assigned to HCC mappings — reflects the average clinical severity and financial impact of the mapped condition portfolio."
    - name: "avg_coefficient"
      expr: AVG(CAST(coefficient AS DOUBLE))
      comment: "Average HCC coefficient across all mappings — the coefficient directly determines the RAF contribution of each condition; used to benchmark model calibration."
    - name: "avg_age_adjustment_factor"
      expr: AVG(CAST(age_adjustment_factor AS DOUBLE))
      comment: "Average age adjustment factor across HCC mappings — used to assess how age-related adjustments are distributed across the condition portfolio."
    - name: "avg_demographic_adjustment_factor"
      expr: AVG(CAST(demographic_adjustment_factor AS DOUBLE))
      comment: "Average demographic adjustment factor — measures the overall demographic weighting applied to the HCC mapping set, informing population risk profiling."
    - name: "interaction_hcc_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN interaction_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HCC mappings that participate in disease interaction adjustments — higher rates indicate a more complex, higher-acuity member population with elevated payment risk."
    - name: "excluded_mapping_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_excluded = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HCC mappings that are excluded from risk score calculation — high exclusion rates may signal coding policy issues or model year misalignments."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_score_hcc_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for HCC-to-risk-score assignment records — measures HCC contribution weights, primary HCC designation rates, and assignment coverage. Used by risk adjustment analysts to understand which conditions are driving member risk scores and to validate HCC hierarchy compliance."
  source: "`vibe_health_insurance_v1`.`risk`.`score_hcc_assignment`"
  dimensions:
    - name: "hcc_codes"
      expr: hcc_codes
      comment: "HCC code(s) assigned to the risk score record — primary clinical dimension for analyzing which conditions are most frequently driving risk scores."
    - name: "is_primary_hcc"
      expr: is_primary_hcc
      comment: "Indicates whether this HCC is the primary (highest-weighted) condition for the member's risk score — used to distinguish primary vs. secondary condition contributions."
    - name: "inclusion_reason"
      expr: inclusion_reason
      comment: "Business reason for including this HCC in the risk score calculation — used to audit coding decisions and validate clinical justification."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the HCC assignment became effective — used to track assignment volume trends and identify seasonal coding patterns."
  measures:
    - name: "total_hcc_assignments"
      expr: COUNT(DISTINCT score_hcc_assignment_id)
      comment: "Total number of HCC-to-risk-score assignments — baseline volume metric measuring the breadth of condition coding captured in risk scores."
    - name: "avg_contribution_weight"
      expr: AVG(CAST(contribution_weight AS DOUBLE))
      comment: "Average HCC contribution weight to the overall risk score — measures the typical clinical severity contribution per assigned condition; higher weights indicate more complex member populations."
    - name: "total_contribution_weight"
      expr: SUM(CAST(contribution_weight AS DOUBLE))
      comment: "Total sum of HCC contribution weights across all assignments — aggregate measure of total condition-driven risk burden in the scored population."
    - name: "primary_hcc_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_primary_hcc = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HCC assignments designated as the primary condition — used to assess HCC hierarchy compliance and identify members with multiple competing primary conditions."
    - name: "unique_members_with_hcc"
      expr: COUNT(DISTINCT member_risk_score_id)
      comment: "Count of distinct risk score records with at least one HCC assignment — measures HCC coding coverage across the scored member population; gaps indicate potential risk score understatement."
    - name: "avg_hcc_assignments_per_score"
      expr: ROUND(CAST(COUNT(score_hcc_assignment_id) AS DOUBLE) / NULLIF(COUNT(DISTINCT member_risk_score_id), 0), 2)
      comment: "Average number of HCC conditions assigned per member risk score — a proxy for member acuity complexity; higher values indicate more comorbid, higher-cost populations."
$$;