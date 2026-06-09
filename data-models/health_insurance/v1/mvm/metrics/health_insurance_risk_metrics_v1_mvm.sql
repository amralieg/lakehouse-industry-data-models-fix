-- Metric views for domain: risk | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 21:18:32

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`risk_member_risk_score`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core risk adjustment metrics tracking member-level risk scores, CMS submissions, and score variance for payment accuracy and audit compliance"
  source: "`health_insurance_ecm`.`risk`.`member_risk_score`"
  dimensions:
    - name: "risk_score_status"
      expr: risk_score_status
      comment: "Current status of the risk score calculation (e.g., finalized, pending, under review)"
    - name: "risk_score_type"
      expr: risk_score_type
      comment: "Type of risk score model applied (e.g., CMS-HCC, RxHCC, ESRD)"
    - name: "model_version"
      expr: model_version
      comment: "Version of the risk adjustment model used for scoring"
    - name: "payment_year"
      expr: payment_year
      comment: "Year for which the risk score determines payment"
    - name: "cms_submission_status"
      expr: cms_submission_status
      comment: "Status of submission to CMS (e.g., accepted, rejected, pending)"
    - name: "variance_category"
      expr: variance_category
      comment: "Categorization of score variance between plan-calculated and CMS-published scores"
    - name: "is_manual_override"
      expr: is_manual_override
      comment: "Flag indicating whether the risk score was manually overridden"
    - name: "score_effective_month"
      expr: DATE_TRUNC('MONTH', score_effective_date)
      comment: "Month when the risk score became effective"
  measures:
    - name: "total_member_risk_scores"
      expr: COUNT(1)
      comment: "Total number of member risk score records"
    - name: "unique_members_scored"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members with risk scores"
    - name: "avg_risk_score_value"
      expr: AVG(CAST(risk_score_value AS DOUBLE))
      comment: "Average risk score value across all members, indicating overall population health risk"
    - name: "total_plan_calculated_score"
      expr: SUM(CAST(plan_calculated_score AS DOUBLE))
      comment: "Sum of plan-calculated risk scores for payment projection"
    - name: "total_cms_published_score"
      expr: SUM(CAST(cms_published_score AS DOUBLE))
      comment: "Sum of CMS-published risk scores for actual payment reconciliation"
    - name: "avg_score_variance"
      expr: AVG(CAST(score_variance AS DOUBLE))
      comment: "Average variance between plan-calculated and CMS-published scores, indicating submission accuracy"
    - name: "total_score_variance"
      expr: SUM(CAST(score_variance AS DOUBLE))
      comment: "Total variance between plan-calculated and CMS-published scores for financial impact analysis"
    - name: "avg_demographic_factor_score"
      expr: AVG(CAST(demographic_factor_score AS DOUBLE))
      comment: "Average demographic component of risk scores"
    - name: "manual_override_count"
      expr: SUM(CASE WHEN is_manual_override = TRUE THEN 1 ELSE 0 END)
      comment: "Count of risk scores that were manually overridden, indicating data quality or clinical documentation issues"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`risk_cms_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CMS submission performance metrics tracking acceptance rates, error disposition, and risk adjustment factors for regulatory compliance and revenue optimization"
  source: "`health_insurance_ecm`.`risk`.`cms_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Overall status of the CMS submission batch"
    - name: "cms_acknowledgment_status"
      expr: cms_acknowledgment_status
      comment: "CMS acknowledgment status indicating acceptance or rejection"
    - name: "submission_type"
      expr: submission_type
      comment: "Type of submission (e.g., initial, correction, delete)"
    - name: "encounter_type"
      expr: encounter_type
      comment: "Type of encounter data submitted (e.g., professional, institutional)"
    - name: "error_disposition"
      expr: error_disposition
      comment: "Categorization of errors encountered during submission"
    - name: "payment_year"
      expr: payment_year
      comment: "Payment year for which the submission applies"
    - name: "service_year"
      expr: service_year
      comment: "Service year of the encounter data submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month when the submission was made to CMS"
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of CMS submission batches"
    - name: "total_records_submitted"
      expr: SUM(CAST(record_count AS BIGINT))
      comment: "Total number of records submitted to CMS across all batches"
    - name: "total_accepted_records"
      expr: SUM(CAST(accepted_record_count AS BIGINT))
      comment: "Total number of records accepted by CMS"
    - name: "total_rejected_records"
      expr: SUM(CAST(rejected_record_count AS BIGINT))
      comment: "Total number of records rejected by CMS, indicating data quality issues"
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor across submissions for payment rate analysis"
    - name: "avg_risk_adjustment_score"
      expr: AVG(CAST(risk_adjustment_score AS DOUBLE))
      comment: "Average risk adjustment score across submissions"
    - name: "total_claim_amount"
      expr: SUM(CAST(total_claim_amount AS DOUBLE))
      comment: "Total claim amount submitted to CMS for payment"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount applied to submissions for reconciliation"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after adjustments, representing final payment impact"
    - name: "avg_submission_file_size"
      expr: AVG(CAST(submission_file_size AS BIGINT))
      comment: "Average file size of submissions for infrastructure planning"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`risk_reinsurance_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance claim recovery metrics tracking high-cost claims, recoverable amounts, and stop-loss protection effectiveness for financial risk management"
  source: "`health_insurance_ecm`.`risk`.`reinsurance_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the reinsurance claim (e.g., submitted, approved, paid)"
    - name: "recovery_status"
      expr: recovery_status
      comment: "Status of recovery from reinsurer"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of reinsurance claim (e.g., specific, aggregate)"
    - name: "loss_category"
      expr: loss_category
      comment: "Category of loss triggering reinsurance coverage"
    - name: "is_aggregated"
      expr: is_aggregated
      comment: "Flag indicating whether claim is part of aggregate stop-loss calculation"
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period for the reinsurance claim"
    - name: "covered_month"
      expr: DATE_TRUNC('MONTH', covered_start_date)
      comment: "Month when the covered service period began"
  measures:
    - name: "total_reinsurance_claims"
      expr: COUNT(1)
      comment: "Total number of reinsurance claims filed"
    - name: "unique_members_with_reinsurance_claims"
      expr: COUNT(DISTINCT member_eligibility_span_id)
      comment: "Distinct count of members with reinsurance claims, indicating high-cost population"
    - name: "total_incurred_amount"
      expr: SUM(CAST(total_incurred_amount AS DOUBLE))
      comment: "Total incurred claim amount triggering reinsurance coverage"
    - name: "total_recoverable_amount"
      expr: SUM(CAST(recoverable_amount AS DOUBLE))
      comment: "Total amount recoverable from reinsurer, representing risk transfer effectiveness"
    - name: "avg_incurred_per_claim"
      expr: AVG(CAST(total_incurred_amount AS DOUBLE))
      comment: "Average incurred amount per reinsurance claim"
    - name: "avg_recoverable_per_claim"
      expr: AVG(CAST(recoverable_amount AS DOUBLE))
      comment: "Average recoverable amount per claim"
    - name: "total_attachment_point_amount"
      expr: SUM(CAST(attachment_point_amount AS DOUBLE))
      comment: "Total attachment point amounts across claims for stop-loss analysis"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`risk_reinsurance_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance treaty metrics tracking stop-loss coverage, attachment points, and premium ceded for catastrophic risk protection strategy"
  source: "`health_insurance_ecm`.`risk`.`reinsurance_arrangement`"
  dimensions:
    - name: "treaty_type"
      expr: treaty_type
      comment: "Type of reinsurance treaty (e.g., quota share, excess of loss)"
    - name: "stop_loss_type"
      expr: stop_loss_type
      comment: "Type of stop-loss coverage (e.g., specific, aggregate)"
    - name: "reinsurance_arrangement_status"
      expr: reinsurance_arrangement_status
      comment: "Current status of the reinsurance arrangement"
    - name: "reinsurer_name"
      expr: reinsurer_name
      comment: "Name of the reinsurance carrier"
    - name: "lob_coverage"
      expr: lob_coverage
      comment: "Line of business covered by the reinsurance arrangement"
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year when the reinsurance arrangement became effective"
  measures:
    - name: "total_reinsurance_arrangements"
      expr: COUNT(1)
      comment: "Total number of active reinsurance arrangements"
    - name: "total_premium_ceded"
      expr: SUM(CAST(premium_ceded AS DOUBLE))
      comment: "Total premium ceded to reinsurers, representing cost of risk transfer"
    - name: "avg_attachment_point"
      expr: AVG(CAST(attachment_point AS DOUBLE))
      comment: "Average attachment point across arrangements, indicating risk retention level"
    - name: "total_maximum_recovery_limit"
      expr: SUM(CAST(maximum_recovery_limit AS DOUBLE))
      comment: "Total maximum recovery limit across all arrangements, representing total catastrophic protection"
    - name: "avg_coinsurance_percentage"
      expr: AVG(CAST(coinsurance_percentage AS DOUBLE))
      comment: "Average coinsurance percentage, indicating risk sharing ratio"
    - name: "total_stop_loss_limit"
      expr: SUM(CAST(stop_loss_limit AS DOUBLE))
      comment: "Total stop-loss limit across arrangements for aggregate risk protection"
    - name: "avg_specific_deductible"
      expr: AVG(CAST(specific_deductible AS DOUBLE))
      comment: "Average specific deductible per arrangement"
    - name: "total_maximum_liability"
      expr: SUM(CAST(maximum_liability AS DOUBLE))
      comment: "Total maximum liability retained by the plan before reinsurance coverage"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`risk_underwriting_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group underwriting metrics tracking risk classification, premium rating, and expected claims for new business pricing and portfolio management"
  source: "`health_insurance_ecm`.`risk`.`risk_underwriting_case`"
  dimensions:
    - name: "risk_underwriting_case_status"
      expr: risk_underwriting_case_status
      comment: "Current status of the underwriting case (e.g., pending, approved, declined)"
    - name: "medical_underwriting_status"
      expr: medical_underwriting_status
      comment: "Medical underwriting decision status"
    - name: "risk_classification"
      expr: risk_classification
      comment: "Risk classification assigned to the group (e.g., standard, substandard, preferred)"
    - name: "underwriting_tier"
      expr: underwriting_tier
      comment: "Underwriting tier for pricing segmentation"
    - name: "lob"
      expr: lob
      comment: "Line of business being underwritten"
    - name: "applicant_type"
      expr: applicant_type
      comment: "Type of applicant (e.g., small group, large group, individual)"
    - name: "is_self_insured"
      expr: is_self_insured
      comment: "Flag indicating whether the group is self-insured"
    - name: "rating_period"
      expr: rating_period
      comment: "Rating period for the underwriting case"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year when the underwriting case becomes effective"
  measures:
    - name: "total_underwriting_cases"
      expr: COUNT(1)
      comment: "Total number of underwriting cases processed"
    - name: "unique_groups_underwritten"
      expr: COUNT(DISTINCT group_id)
      comment: "Distinct count of employer groups underwritten"
    - name: "total_gross_premium"
      expr: SUM(CAST(gross_premium_amount AS DOUBLE))
      comment: "Total gross premium amount across all underwriting cases for revenue projection"
    - name: "total_net_premium"
      expr: SUM(CAST(net_premium_amount AS DOUBLE))
      comment: "Total net premium amount after adjustments for actual revenue"
    - name: "avg_overall_group_risk_score"
      expr: AVG(CAST(overall_group_risk_score AS DOUBLE))
      comment: "Average group risk score across cases, indicating portfolio risk level"
    - name: "avg_expected_claims_pmpm"
      expr: AVG(CAST(expected_claims_pmpm AS DOUBLE))
      comment: "Average expected claims per member per month for loss ratio projection"
    - name: "avg_prior_year_claims_pmpm"
      expr: AVG(CAST(prior_year_claims_pmpm AS DOUBLE))
      comment: "Average prior year claims PMPM for trend analysis"
    - name: "avg_morbidity_factor"
      expr: AVG(CAST(morbidity_factor AS DOUBLE))
      comment: "Average morbidity factor indicating health status of underwritten groups"
    - name: "total_premium_adjustment"
      expr: SUM(CAST(premium_adjustment_amount AS DOUBLE))
      comment: "Total premium adjustments applied during underwriting for pricing accuracy"
    - name: "avg_chronic_condition_prevalence_rate"
      expr: AVG(CAST(chronic_condition_prevalence_rate AS DOUBLE))
      comment: "Average chronic condition prevalence rate across groups for population health assessment"
    - name: "avg_industry_risk_factor"
      expr: AVG(CAST(industry_risk_factor AS DOUBLE))
      comment: "Average industry risk factor for sector-based risk segmentation"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`risk_score_hcc_contribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HCC contribution metrics tracking individual condition contributions to member risk scores for clinical documentation improvement and coding accuracy"
  source: "`health_insurance_ecm`.`risk`.`score_hcc_contribution`"
  dimensions:
    - name: "is_primary_hcc"
      expr: is_primary_hcc
      comment: "Flag indicating whether this is the primary HCC contributing to the risk score"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month when the HCC contribution became effective"
  measures:
    - name: "total_hcc_contributions"
      expr: COUNT(1)
      comment: "Total number of HCC contributions across all member risk scores"
    - name: "unique_members_with_hcc"
      expr: COUNT(DISTINCT member_risk_score_id)
      comment: "Distinct count of member risk scores with HCC contributions"
    - name: "unique_hcc_mappings"
      expr: COUNT(DISTINCT hcc_mapping_id)
      comment: "Distinct count of HCC mappings contributing to risk scores"
    - name: "total_score_contribution"
      expr: SUM(CAST(score_contribution_amount AS DOUBLE))
      comment: "Total score contribution amount from all HCCs for aggregate risk impact"
    - name: "avg_score_contribution"
      expr: AVG(CAST(score_contribution_amount AS DOUBLE))
      comment: "Average score contribution per HCC for condition severity analysis"
    - name: "avg_contribution_weight"
      expr: AVG(CAST(contribution_weight AS DOUBLE))
      comment: "Average contribution weight across HCCs"
    - name: "primary_hcc_count"
      expr: SUM(CASE WHEN is_primary_hcc = TRUE THEN 1 ELSE 0 END)
      comment: "Count of primary HCC contributions for principal diagnosis tracking"
$$;