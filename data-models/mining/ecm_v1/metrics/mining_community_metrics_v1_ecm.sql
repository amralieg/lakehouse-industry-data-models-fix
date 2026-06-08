-- Metric views for domain: community | Business: Mining | Version: 1 | Generated on: 2026-05-05 10:43:42

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`community_benefit_distribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks benefit distributions to communities including monetary payments, in-kind contributions, and benefit-sharing agreement performance"
  source: "`mining_ecm`.`community`.`benefit_distribution`"
  dimensions:
    - name: "benefit_category"
      expr: benefit_category
      comment: "Category of benefit distributed (e.g., royalty, infrastructure, social investment)"
    - name: "benefit_type"
      expr: benefit_type
      comment: "Specific type of benefit within category"
    - name: "distribution_status"
      expr: distribution_status
      comment: "Current status of the distribution (pending, approved, paid, disputed)"
    - name: "distribution_method"
      expr: distribution_method
      comment: "Method used to distribute benefit (cash, in-kind, trust fund, etc.)"
    - name: "calculation_basis"
      expr: calculation_basis
      comment: "Basis for calculating benefit amount (revenue share, production volume, fixed amount)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of monetary value"
    - name: "distribution_year"
      expr: YEAR(distribution_date)
      comment: "Year of distribution"
    - name: "distribution_quarter"
      expr: CONCAT('Q', QUARTER(distribution_date))
      comment: "Quarter of distribution"
    - name: "reporting_period_year"
      expr: YEAR(reporting_period_start_date)
      comment: "Year of reporting period"
    - name: "dispute_raised_flag"
      expr: dispute_raised
      comment: "Whether a dispute was raised on this distribution"
    - name: "receipt_confirmed_flag"
      expr: receipt_confirmation_received
      comment: "Whether receipt confirmation was received from beneficiary"
  measures:
    - name: "total_benefit_value"
      expr: SUM(CAST(monetary_value_amount AS DOUBLE))
      comment: "Total monetary value of all benefits distributed"
    - name: "distribution_count"
      expr: COUNT(1)
      comment: "Total number of benefit distributions"
    - name: "avg_benefit_value"
      expr: AVG(CAST(monetary_value_amount AS DOUBLE))
      comment: "Average monetary value per distribution"
    - name: "disputed_distribution_count"
      expr: SUM(CASE WHEN dispute_raised = TRUE THEN 1 ELSE 0 END)
      comment: "Number of distributions with disputes raised"
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN dispute_raised = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of distributions that resulted in disputes"
    - name: "receipt_confirmation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN receipt_confirmation_received = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of distributions with confirmed receipt by beneficiary"
    - name: "total_production_volume"
      expr: SUM(CAST(calculation_period_production_volume AS DOUBLE))
      comment: "Total production volume used in benefit calculations"
    - name: "total_revenue_basis"
      expr: SUM(CAST(calculation_period_revenue AS DOUBLE))
      comment: "Total revenue used as basis for benefit calculations"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`community_benefit_sharing_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks benefit-sharing agreements with communities including royalty shares, employment quotas, and infrastructure contributions"
  source: "`mining_ecm`.`community`.`benefit_sharing_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement (draft, active, expired, terminated)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of benefit-sharing agreement"
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of benefit payments (monthly, quarterly, annual)"
    - name: "payment_trigger"
      expr: payment_trigger
      comment: "Event or condition that triggers payment"
    - name: "fpic_obtained_flag"
      expr: free_prior_informed_consent_obtained
      comment: "Whether free, prior, and informed consent was obtained"
    - name: "social_licence_indicator"
      expr: social_licence_to_operate_indicator
      comment: "Whether agreement contributes to social licence to operate"
    - name: "agreement_year"
      expr: YEAR(effective_date)
      comment: "Year agreement became effective"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for monetary commitments"
  measures:
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Total number of benefit-sharing agreements"
    - name: "active_agreement_count"
      expr: SUM(CASE WHEN agreement_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of currently active agreements"
    - name: "total_royalty_share_pct"
      expr: SUM(CAST(royalty_share_percentage AS DOUBLE))
      comment: "Total royalty share percentage committed across all agreements"
    - name: "avg_royalty_share_pct"
      expr: AVG(CAST(royalty_share_percentage AS DOUBLE))
      comment: "Average royalty share percentage per agreement"
    - name: "total_trust_fund_commitment"
      expr: SUM(CAST(trust_fund_contribution_amount AS DOUBLE))
      comment: "Total trust fund contribution amounts committed"
    - name: "total_infrastructure_commitment"
      expr: SUM(CAST(infrastructure_contribution_amount AS DOUBLE))
      comment: "Total infrastructure contribution amounts committed"
    - name: "avg_employment_quota_pct"
      expr: AVG(CAST(employment_quota_percentage AS DOUBLE))
      comment: "Average local employment quota percentage across agreements"
    - name: "avg_local_procurement_target_pct"
      expr: AVG(CAST(local_procurement_target_percentage AS DOUBLE))
      comment: "Average local procurement target percentage across agreements"
    - name: "fpic_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN free_prior_informed_consent_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements with FPIC obtained"
    - name: "social_licence_agreement_count"
      expr: SUM(CASE WHEN social_licence_to_operate_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of agreements contributing to social licence to operate"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`community_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks community commitments including regulatory conditions, stakeholder agreements, and social impact mitigation measures"
  source: "`mining_ecm`.`community`.`commitment`"
  dimensions:
    - name: "commitment_status"
      expr: commitment_status
      comment: "Current status of commitment (planned, in progress, completed, overdue)"
    - name: "commitment_type"
      expr: commitment_type
      comment: "Type of commitment (regulatory, voluntary, contractual)"
    - name: "commitment_category"
      expr: commitment_category
      comment: "Category of commitment (employment, infrastructure, environment, cultural heritage)"
    - name: "commitment_source"
      expr: commitment_source
      comment: "Source of commitment (SIA, benefit agreement, permit condition, stakeholder engagement)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of commitment (critical, high, medium, low)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level if commitment not met"
    - name: "reporting_obligation_flag"
      expr: reporting_obligation_flag
      comment: "Whether commitment requires regulatory reporting"
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether commitment requires escalation"
    - name: "commitment_year"
      expr: YEAR(commitment_date)
      comment: "Year commitment was made"
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year commitment is due"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for cost estimates"
  measures:
    - name: "commitment_count"
      expr: COUNT(1)
      comment: "Total number of commitments"
    - name: "completed_commitment_count"
      expr: SUM(CASE WHEN commitment_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Number of completed commitments"
    - name: "overdue_commitment_count"
      expr: SUM(CASE WHEN commitment_status = 'overdue' THEN 1 ELSE 0 END)
      comment: "Number of overdue commitments"
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN commitment_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of commitments completed"
    - name: "avg_completion_pct"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across all commitments"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated cost of all commitments"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost incurred for commitments"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Average estimated cost per commitment"
    - name: "critical_commitment_count"
      expr: SUM(CASE WHEN priority_level = 'critical' THEN 1 ELSE 0 END)
      comment: "Number of critical priority commitments"
    - name: "high_risk_commitment_count"
      expr: SUM(CASE WHEN risk_level = 'high' THEN 1 ELSE 0 END)
      comment: "Number of high-risk commitments"
    - name: "regulatory_reporting_commitment_count"
      expr: SUM(CASE WHEN reporting_obligation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of commitments requiring regulatory reporting"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`community_grievance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks community grievances including complaints, disputes, and resolution outcomes - critical for social licence to operate"
  source: "`mining_ecm`.`community`.`grievance`"
  dimensions:
    - name: "grievance_status"
      expr: grievance_status
      comment: "Current status of grievance (lodged, investigating, resolved, closed)"
    - name: "grievance_category"
      expr: grievance_category
      comment: "Category of grievance (environmental, employment, land access, compensation, safety)"
    - name: "subcategory"
      expr: subcategory
      comment: "Subcategory providing more detail"
    - name: "severity_classification"
      expr: severity_classification
      comment: "Severity level of grievance (low, medium, high, critical)"
    - name: "lodgement_channel"
      expr: lodgement_channel
      comment: "Channel through which grievance was lodged (hotline, email, in-person, community meeting)"
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of grievance resolution"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Level to which grievance was escalated"
    - name: "is_anonymous"
      expr: is_anonymous
      comment: "Whether grievance was lodged anonymously"
    - name: "is_repeat_grievance"
      expr: is_repeat_grievance
      comment: "Whether this is a repeat grievance on same issue"
    - name: "requires_external_mediation"
      expr: requires_external_mediation
      comment: "Whether external mediation is required"
    - name: "complainant_satisfaction_rating"
      expr: complainant_satisfaction_rating
      comment: "Complainant satisfaction with resolution process"
    - name: "lodgement_year"
      expr: YEAR(lodgement_date)
      comment: "Year grievance was lodged"
    - name: "lodgement_quarter"
      expr: CONCAT('Q', QUARTER(lodgement_date))
      comment: "Quarter grievance was lodged"
    - name: "compensation_currency"
      expr: compensation_currency_code
      comment: "Currency of compensation amount"
  measures:
    - name: "grievance_count"
      expr: COUNT(1)
      comment: "Total number of grievances lodged"
    - name: "resolved_grievance_count"
      expr: SUM(CASE WHEN grievance_status = 'resolved' THEN 1 ELSE 0 END)
      comment: "Number of grievances resolved"
    - name: "closed_grievance_count"
      expr: SUM(CASE WHEN grievance_status = 'closed' THEN 1 ELSE 0 END)
      comment: "Number of grievances closed"
    - name: "resolution_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN grievance_status IN ('resolved', 'closed') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grievances resolved or closed"
    - name: "critical_grievance_count"
      expr: SUM(CASE WHEN severity_classification = 'critical' THEN 1 ELSE 0 END)
      comment: "Number of critical severity grievances"
    - name: "high_severity_grievance_count"
      expr: SUM(CASE WHEN severity_classification = 'high' THEN 1 ELSE 0 END)
      comment: "Number of high severity grievances"
    - name: "repeat_grievance_count"
      expr: SUM(CASE WHEN is_repeat_grievance = TRUE THEN 1 ELSE 0 END)
      comment: "Number of repeat grievances on same issues"
    - name: "repeat_grievance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_repeat_grievance = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grievances that are repeats"
    - name: "external_mediation_count"
      expr: SUM(CASE WHEN requires_external_mediation = TRUE THEN 1 ELSE 0 END)
      comment: "Number of grievances requiring external mediation"
    - name: "total_compensation_paid"
      expr: SUM(CAST(compensation_amount AS DOUBLE))
      comment: "Total compensation paid to resolve grievances"
    - name: "avg_compensation_amount"
      expr: AVG(CAST(compensation_amount AS DOUBLE))
      comment: "Average compensation amount per grievance"
    - name: "anonymous_grievance_count"
      expr: SUM(CASE WHEN is_anonymous = TRUE THEN 1 ELSE 0 END)
      comment: "Number of anonymous grievances lodged"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`community_land_compensation_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks land compensation agreements with landowners including acquisition costs, lease payments, and rehabilitation obligations"
  source: "`mining_ecm`.`community`.`land_compensation_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of land compensation agreement"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of land agreement (acquisition, lease, access, easement)"
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation (cash, in-kind, livelihood program)"
    - name: "land_use_type"
      expr: land_use_type
      comment: "Type of land use (agricultural, residential, grazing, forest)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of agreement"
    - name: "dispute_status"
      expr: dispute_status
      comment: "Status of any disputes related to agreement"
    - name: "is_active"
      expr: is_active
      comment: "Whether agreement is currently active"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year agreement became effective"
    - name: "compensation_currency"
      expr: compensation_currency
      comment: "Currency of compensation amounts"
  measures:
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Total number of land compensation agreements"
    - name: "active_agreement_count"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Number of currently active agreements"
    - name: "total_compensation_amount"
      expr: SUM(CAST(compensation_amount AS DOUBLE))
      comment: "Total compensation amount committed across all agreements"
    - name: "avg_compensation_amount"
      expr: AVG(CAST(compensation_amount AS DOUBLE))
      comment: "Average compensation amount per agreement"
    - name: "total_land_area_hectares"
      expr: SUM(CAST(land_area_hectares AS DOUBLE))
      comment: "Total land area covered by agreements in hectares"
    - name: "avg_land_area_hectares"
      expr: AVG(CAST(land_area_hectares AS DOUBLE))
      comment: "Average land area per agreement in hectares"
    - name: "total_paid_to_date"
      expr: SUM(CAST(total_paid_to_date AS DOUBLE))
      comment: "Total amount paid to date across all agreements"
    - name: "avg_agreement_duration_years"
      expr: AVG(CAST(agreement_duration_years AS DOUBLE))
      comment: "Average duration of agreements in years"
    - name: "disputed_agreement_count"
      expr: SUM(CASE WHEN dispute_status IS NOT NULL AND dispute_status != 'none' THEN 1 ELSE 0 END)
      comment: "Number of agreements with active disputes"
    - name: "non_compliant_agreement_count"
      expr: SUM(CASE WHEN compliance_status = 'non-compliant' THEN 1 ELSE 0 END)
      comment: "Number of agreements in non-compliant status"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`community_local_content_actual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks actual local content performance against targets including local employment and local supplier spend"
  source: "`mining_ecm`.`community`.`local_content_actual`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status against local content targets"
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of local content reporting"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required to meet targets"
    - name: "reporting_period_year"
      expr: YEAR(reporting_period_start_date)
      comment: "Year of reporting period"
    - name: "reporting_period_quarter"
      expr: CONCAT('Q', QUARTER(reporting_period_start_date))
      comment: "Quarter of reporting period"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for spend amounts"
  measures:
    - name: "reporting_period_count"
      expr: COUNT(1)
      comment: "Number of reporting periods"
    - name: "compliant_period_count"
      expr: SUM(CASE WHEN compliance_status = 'compliant' THEN 1 ELSE 0 END)
      comment: "Number of periods meeting compliance"
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reporting periods meeting compliance"
    - name: "avg_local_employment_pct_achieved"
      expr: AVG(CAST(local_employment_percentage_achieved AS DOUBLE))
      comment: "Average local employment percentage achieved"
    - name: "avg_local_spend_pct_achieved"
      expr: AVG(CAST(local_spend_percentage_achieved AS DOUBLE))
      comment: "Average local spend percentage achieved"
    - name: "total_local_supplier_spend"
      expr: SUM(CAST(actual_local_supplier_spend_amount AS DOUBLE))
      comment: "Total spend with local suppliers"
    - name: "total_procurement_spend"
      expr: SUM(CAST(total_procurement_spend_amount AS DOUBLE))
      comment: "Total procurement spend"
    - name: "avg_employment_variance_pct"
      expr: AVG(CAST(employment_variance_percentage AS DOUBLE))
      comment: "Average variance from employment target as percentage"
    - name: "avg_spend_variance_pct"
      expr: AVG(CAST(spend_variance_percentage AS DOUBLE))
      comment: "Average variance from spend target as percentage"
    - name: "corrective_action_required_count"
      expr: SUM(CASE WHEN corrective_action_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of periods requiring corrective action"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`community_resettlement_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks resettlement households including compensation, relocation status, and livelihood restoration - critical for IFC PS5 compliance"
  source: "`mining_ecm`.`community`.`resettlement_household`"
  dimensions:
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Eligibility status for resettlement compensation"
    - name: "entitlement_category"
      expr: entitlement_category
      comment: "Category of entitlement (full, partial, vulnerable)"
    - name: "relocation_status"
      expr: relocation_status
      comment: "Status of household relocation"
    - name: "compensation_payment_status"
      expr: compensation_payment_status
      comment: "Status of compensation payment"
    - name: "livelihood_restoration_plan_status"
      expr: livelihood_restoration_plan_status
      comment: "Status of livelihood restoration plan implementation"
    - name: "monitoring_phase"
      expr: monitoring_phase
      comment: "Current monitoring phase (baseline, transition, post-resettlement)"
    - name: "land_tenure_type"
      expr: land_tenure_type
      comment: "Type of land tenure (owned, leased, customary, informal)"
    - name: "primary_livelihood_source"
      expr: primary_livelihood_source
      comment: "Primary source of household livelihood"
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Vulnerability category of household"
    - name: "vulnerable_household_flag"
      expr: vulnerable_household_flag
      comment: "Whether household is classified as vulnerable"
    - name: "indigenous_household_flag"
      expr: indigenous_household_flag
      comment: "Whether household is indigenous"
    - name: "grievance_lodged_flag"
      expr: grievance_lodged_flag
      comment: "Whether household has lodged a grievance"
    - name: "grievance_resolution_status"
      expr: grievance_resolution_status
      comment: "Status of grievance resolution"
    - name: "relocation_year"
      expr: YEAR(relocation_date)
      comment: "Year of household relocation"
    - name: "income_currency"
      expr: income_currency_code
      comment: "Currency of income amounts"
  measures:
    - name: "household_count"
      expr: COUNT(1)
      comment: "Total number of resettlement households"
    - name: "relocated_household_count"
      expr: SUM(CASE WHEN relocation_status = 'relocated' THEN 1 ELSE 0 END)
      comment: "Number of households successfully relocated"
    - name: "relocation_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN relocation_status = 'relocated' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of households successfully relocated"
    - name: "vulnerable_household_count"
      expr: SUM(CASE WHEN vulnerable_household_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of vulnerable households"
    - name: "indigenous_household_count"
      expr: SUM(CASE WHEN indigenous_household_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of indigenous households"
    - name: "total_cash_compensation"
      expr: SUM(CAST(cash_compensation_amount AS DOUBLE))
      comment: "Total cash compensation paid to households"
    - name: "avg_cash_compensation"
      expr: AVG(CAST(cash_compensation_amount AS DOUBLE))
      comment: "Average cash compensation per household"
    - name: "total_entitlement_value"
      expr: SUM(CAST(total_entitlement_value AS DOUBLE))
      comment: "Total entitlement value across all households"
    - name: "avg_entitlement_value"
      expr: AVG(CAST(total_entitlement_value AS DOUBLE))
      comment: "Average entitlement value per household"
    - name: "total_land_area_hectares"
      expr: SUM(CAST(land_area_hectares AS DOUBLE))
      comment: "Total land area affected in hectares"
    - name: "avg_land_area_hectares"
      expr: AVG(CAST(land_area_hectares AS DOUBLE))
      comment: "Average land area per household in hectares"
    - name: "total_allocated_land_hectares"
      expr: SUM(CAST(allocated_land_area_hectares AS DOUBLE))
      comment: "Total land area allocated to households in hectares"
    - name: "avg_baseline_annual_income"
      expr: AVG(CAST(baseline_annual_income AS DOUBLE))
      comment: "Average baseline annual income per household"
    - name: "grievance_lodged_count"
      expr: SUM(CASE WHEN grievance_lodged_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of households that lodged grievances"
    - name: "grievance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN grievance_lodged_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of households that lodged grievances"
    - name: "compensation_paid_count"
      expr: SUM(CASE WHEN compensation_payment_status = 'paid' THEN 1 ELSE 0 END)
      comment: "Number of households with compensation paid"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`community_social_licence_indicator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks social licence to operate indicators including community acceptance scores, stakeholder sentiment, and risk levels"
  source: "`mining_ecm`.`community`.`social_licence_indicator`"
  dimensions:
    - name: "indicator_category"
      expr: indicator_category
      comment: "Category of social licence indicator (acceptance, trust, legitimacy, approval)"
    - name: "indicator_type"
      expr: indicator_type
      comment: "Specific type of indicator within category"
    - name: "rating"
      expr: rating
      comment: "Qualitative rating of social licence (strong, moderate, weak, at risk)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level to social licence (low, medium, high, critical)"
    - name: "trend_direction"
      expr: trend_direction
      comment: "Trend direction of indicator (improving, stable, declining)"
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure indicator (survey, focus group, stakeholder interview)"
    - name: "action_required"
      expr: action_required
      comment: "Whether action is required based on indicator"
    - name: "indigenous_peoples_included"
      expr: indigenous_peoples_included
      comment: "Whether indigenous peoples were included in measurement"
    - name: "third_party_verified"
      expr: third_party_verified
      comment: "Whether indicator was verified by third party"
    - name: "measurement_year"
      expr: YEAR(measurement_date)
      comment: "Year of measurement"
    - name: "measurement_quarter"
      expr: CONCAT('Q', QUARTER(measurement_date))
      comment: "Quarter of measurement"
  measures:
    - name: "indicator_measurement_count"
      expr: COUNT(1)
      comment: "Total number of indicator measurements"
    - name: "avg_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average social licence score across all measurements"
    - name: "avg_target_score"
      expr: AVG(CAST(target_score AS DOUBLE))
      comment: "Average target score"
    - name: "avg_variance_from_target"
      expr: AVG(CAST(variance_from_target AS DOUBLE))
      comment: "Average variance from target score"
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_percent AS DOUBLE))
      comment: "Average confidence level in measurements"
    - name: "avg_response_rate_pct"
      expr: AVG(CAST(response_rate_percent AS DOUBLE))
      comment: "Average response rate for surveys/consultations"
    - name: "high_risk_indicator_count"
      expr: SUM(CASE WHEN risk_level = 'high' THEN 1 ELSE 0 END)
      comment: "Number of high-risk indicators"
    - name: "critical_risk_indicator_count"
      expr: SUM(CASE WHEN risk_level = 'critical' THEN 1 ELSE 0 END)
      comment: "Number of critical-risk indicators"
    - name: "action_required_count"
      expr: SUM(CASE WHEN action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of indicators requiring action"
    - name: "declining_trend_count"
      expr: SUM(CASE WHEN trend_direction = 'declining' THEN 1 ELSE 0 END)
      comment: "Number of indicators with declining trend"
    - name: "improving_trend_count"
      expr: SUM(CASE WHEN trend_direction = 'improving' THEN 1 ELSE 0 END)
      comment: "Number of indicators with improving trend"
    - name: "third_party_verified_count"
      expr: SUM(CASE WHEN third_party_verified = TRUE THEN 1 ELSE 0 END)
      comment: "Number of third-party verified measurements"
    - name: "indigenous_included_count"
      expr: SUM(CASE WHEN indigenous_peoples_included = TRUE THEN 1 ELSE 0 END)
      comment: "Number of measurements including indigenous peoples"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`community_stakeholder`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks community stakeholders including indigenous groups, local communities, NGOs, and government - foundation for stakeholder engagement"
  source: "`mining_ecm`.`community`.`stakeholder`"
  dimensions:
    - name: "stakeholder_type"
      expr: stakeholder_type
      comment: "Type of stakeholder (community, indigenous group, NGO, government, media)"
    - name: "stakeholder_category"
      expr: stakeholder_category
      comment: "Category of stakeholder"
    - name: "engagement_status"
      expr: engagement_status
      comment: "Current engagement status (active, inactive, pending)"
    - name: "social_licence_risk_rating"
      expr: social_licence_risk_rating
      comment: "Risk rating to social licence (low, medium, high, critical)"
    - name: "influence_level"
      expr: influence_level
      comment: "Level of stakeholder influence (low, medium, high)"
    - name: "interest_level"
      expr: interest_level
      comment: "Level of stakeholder interest (low, medium, high)"
    - name: "opposition_level"
      expr: opposition_level
      comment: "Level of opposition to operations (none, low, medium, high)"
    - name: "indigenous_status"
      expr: indigenous_status
      comment: "Whether stakeholder is indigenous"
    - name: "traditional_owner_status"
      expr: traditional_owner_status
      comment: "Whether stakeholder is traditional owner of land"
    - name: "fpic_status"
      expr: fpic_status
      comment: "Status of free, prior, and informed consent"
    - name: "grievance_mechanism_registered"
      expr: grievance_mechanism_registered
      comment: "Whether stakeholder is registered in grievance mechanism"
    - name: "social_investment_recipient"
      expr: social_investment_recipient
      comment: "Whether stakeholder receives social investment"
    - name: "land_compensation_agreement_status"
      expr: land_compensation_agreement_status
      comment: "Status of land compensation agreement"
    - name: "engagement_frequency_required"
      expr: engagement_frequency_required
      comment: "Required frequency of engagement"
    - name: "preferred_communication_channel"
      expr: preferred_communication_channel
      comment: "Preferred channel for communication"
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of stakeholder"
  measures:
    - name: "stakeholder_count"
      expr: COUNT(1)
      comment: "Total number of stakeholders"
    - name: "active_stakeholder_count"
      expr: SUM(CASE WHEN engagement_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of actively engaged stakeholders"
    - name: "indigenous_stakeholder_count"
      expr: SUM(CASE WHEN indigenous_status = TRUE THEN 1 ELSE 0 END)
      comment: "Number of indigenous stakeholders"
    - name: "traditional_owner_count"
      expr: SUM(CASE WHEN traditional_owner_status = TRUE THEN 1 ELSE 0 END)
      comment: "Number of traditional owner stakeholders"
    - name: "high_influence_stakeholder_count"
      expr: SUM(CASE WHEN influence_level = 'high' THEN 1 ELSE 0 END)
      comment: "Number of high-influence stakeholders"
    - name: "high_interest_stakeholder_count"
      expr: SUM(CASE WHEN interest_level = 'high' THEN 1 ELSE 0 END)
      comment: "Number of high-interest stakeholders"
    - name: "high_opposition_stakeholder_count"
      expr: SUM(CASE WHEN opposition_level = 'high' THEN 1 ELSE 0 END)
      comment: "Number of stakeholders with high opposition"
    - name: "high_risk_stakeholder_count"
      expr: SUM(CASE WHEN social_licence_risk_rating = 'high' THEN 1 ELSE 0 END)
      comment: "Number of high-risk stakeholders to social licence"
    - name: "critical_risk_stakeholder_count"
      expr: SUM(CASE WHEN social_licence_risk_rating = 'critical' THEN 1 ELSE 0 END)
      comment: "Number of critical-risk stakeholders to social licence"
    - name: "grievance_registered_count"
      expr: SUM(CASE WHEN grievance_mechanism_registered = TRUE THEN 1 ELSE 0 END)
      comment: "Number of stakeholders registered in grievance mechanism"
    - name: "social_investment_recipient_count"
      expr: SUM(CASE WHEN social_investment_recipient = TRUE THEN 1 ELSE 0 END)
      comment: "Number of stakeholders receiving social investment"
    - name: "avg_proximity_km"
      expr: AVG(CAST(proximity_to_operations_km AS DOUBLE))
      comment: "Average proximity of stakeholders to operations in kilometers"
$$;