-- Metric views for domain: tenant | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 04:45:11

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`tenant_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks the tenant application pipeline — volume, financial qualification, proposed economics, and decisioning outcomes. Enables leasing teams and executives to monitor pipeline health, approval rates, and proposed rent performance."
  source: "`real_estate_ecm`.`tenant`.`application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application (e.g. Submitted, Under Review, Approved, Declined) — primary pipeline stage dimension."
    - name: "applicant_type"
      expr: applicant_type
      comment: "Type of applicant (e.g. Individual, Corporate, Guarantor-backed) — used to segment pipeline by applicant category."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the application was sourced (e.g. Online, Broker, Walk-in) — used to evaluate lead channel effectiveness."
    - name: "portfolio_type"
      expr: portfolio_type
      comment: "Portfolio classification of the application (e.g. Residential, Commercial) — enables cross-portfolio pipeline comparison."
    - name: "background_check_status"
      expr: background_check_status
      comment: "Status of the background check for the applicant — used to track compliance and screening completeness."
    - name: "fee_paid_flag"
      expr: fee_paid
      comment: "Boolean indicating whether the application fee has been paid — used to identify incomplete applications."
    - name: "guarantor_required_flag"
      expr: guarantor_required
      comment: "Boolean indicating whether a guarantor is required for this application — used to assess risk profile of the pipeline."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of application submission — used for trend analysis of application volume over time."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month in which the application decision was made — used to track decisioning throughput over time."
    - name: "decline_reason_code"
      expr: decline_reason_code
      comment: "Reason code for declined applications — used to identify systemic qualification barriers."
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of applications submitted — baseline pipeline volume KPI used to track leasing demand."
    - name: "approved_applications"
      expr: COUNT(CASE WHEN application_status = 'Approved' THEN 1 END)
      comment: "Count of applications with Approved status — measures successful qualification throughput."
    - name: "declined_applications"
      expr: COUNT(CASE WHEN application_status = 'Declined' THEN 1 END)
      comment: "Count of applications with Declined status — used to monitor rejection volume and identify qualification issues."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN application_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications that were approved — key leasing funnel conversion KPI for executive dashboards."
    - name: "avg_proposed_base_rent_monthly"
      expr: AVG(CAST(proposed_base_rent_monthly AS DOUBLE))
      comment: "Average proposed monthly base rent across applications — indicates market rent expectations and pricing alignment."
    - name: "total_proposed_base_rent_monthly"
      expr: SUM(CAST(proposed_base_rent_monthly AS DOUBLE))
      comment: "Total proposed monthly base rent across all active applications — measures potential revenue in the pipeline."
    - name: "avg_proposed_rent_psf"
      expr: AVG(CAST(proposed_rent_psf AS DOUBLE))
      comment: "Average proposed rent per square foot across applications — benchmarks pricing against market rates."
    - name: "avg_dti_ratio"
      expr: AVG(CAST(dti_ratio AS DOUBLE))
      comment: "Average debt-to-income ratio of applicants — key financial qualification health indicator for risk management."
    - name: "avg_annual_income"
      expr: AVG(CAST(annual_income AS DOUBLE))
      comment: "Average annual income of applicants — used to assess affordability and qualification strength of the pipeline."
    - name: "total_fee_revenue"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total application fee revenue collected — tracks ancillary income from the application process."
    - name: "avg_requested_gla_sqft"
      expr: AVG(CAST(requested_gla_sqft AS DOUBLE))
      comment: "Average gross leasable area requested by applicants — used to match supply to demand and plan space allocation."
    - name: "total_ti_allowance_requested"
      expr: SUM(CAST(ti_allowance_requested AS DOUBLE))
      comment: "Total tenant improvement allowance requested across applications — measures capital commitment exposure in the pipeline."
    - name: "avg_security_deposit_amount"
      expr: AVG(CAST(security_deposit_amount AS DOUBLE))
      comment: "Average security deposit amount proposed — used to assess risk mitigation coverage across the application pool."
    - name: "fee_paid_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fee_paid = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications where the fee has been paid — indicates application seriousness and process completion rate."
    - name: "guarantor_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN guarantor_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications requiring a guarantor — measures the proportion of higher-risk applicants in the pipeline."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`tenant_occupancy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks physical occupancy events and space utilization across the portfolio. Provides executives and asset managers with occupancy status, area under management, holdover exposure, and move-in/move-out throughput."
  source: "`real_estate_ecm`.`tenant`.`occupancy`"
  dimensions:
    - name: "occupancy_status"
      expr: occupancy_status
      comment: "Current status of the occupancy record (e.g. Active, Vacated, Holdover) — primary dimension for occupancy state analysis."
    - name: "occupancy_type"
      expr: occupancy_type
      comment: "Type of occupancy (e.g. Direct, Sublease, License) — used to segment occupied space by tenure structure."
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class of the occupied property (e.g. Office, Retail, Industrial) — enables cross-asset-class occupancy benchmarking."
    - name: "portfolio_type"
      expr: portfolio_type
      comment: "Portfolio classification (e.g. Residential, Commercial) — used for portfolio-level occupancy reporting."
    - name: "is_holdover_flag"
      expr: is_holdover
      comment: "Boolean indicating whether the occupancy is in holdover status — used to quantify holdover exposure risk."
    - name: "is_sublease_flag"
      expr: is_sublease
      comment: "Boolean indicating whether the occupancy is a sublease — used to distinguish direct vs. sublease occupancy."
    - name: "ti_completed_flag"
      expr: ti_completed
      comment: "Boolean indicating whether tenant improvements have been completed — tracks TI delivery performance."
    - name: "vacate_reason_code"
      expr: vacate_reason_code
      comment: "Reason code for vacating the space — used to analyze churn drivers and retention opportunities."
    - name: "move_in_condition_rating"
      expr: move_in_condition_rating
      comment: "Condition rating of the space at move-in — used to assess property readiness and maintenance standards."
    - name: "move_out_condition_rating"
      expr: move_out_condition_rating
      comment: "Condition rating of the space at move-out — used to assess tenant care and potential damage recovery."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of occupancy commencement — used for move-in trend analysis."
    - name: "end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month of occupancy end — used for move-out and lease expiry trend analysis."
  measures:
    - name: "total_occupancies"
      expr: COUNT(1)
      comment: "Total number of occupancy records — baseline count of occupied units/spaces across the portfolio."
    - name: "active_occupancies"
      expr: COUNT(CASE WHEN occupancy_status = 'Active' THEN 1 END)
      comment: "Count of currently active occupancies — primary measure of live portfolio occupancy."
    - name: "holdover_occupancies"
      expr: COUNT(CASE WHEN is_holdover = TRUE THEN 1 END)
      comment: "Count of occupancies in holdover status — measures lease expiry risk and portfolio management urgency."
    - name: "total_occupied_area_sqf"
      expr: SUM(CAST(occupied_area_sqf AS DOUBLE))
      comment: "Total occupied area in square feet — primary space utilization KPI for asset and portfolio managers."
    - name: "avg_occupied_area_sqf"
      expr: AVG(CAST(occupied_area_sqf AS DOUBLE))
      comment: "Average occupied area per occupancy record in square feet — used to understand typical tenant footprint."
    - name: "total_occupied_area_sqm"
      expr: SUM(CAST(occupied_area_sqm AS DOUBLE))
      comment: "Total occupied area in square metres — metric-unit equivalent of total occupied area for international reporting."
    - name: "holdover_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_holdover = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of occupancies in holdover — key risk indicator for lease management and renewal urgency."
    - name: "sublease_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_sublease = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of occupancies that are subleases — measures sublease exposure within the portfolio."
    - name: "ti_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ti_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of occupancies where tenant improvements have been completed — tracks TI delivery efficiency."
    - name: "vacated_occupancies"
      expr: COUNT(CASE WHEN occupancy_status = 'Vacated' THEN 1 END)
      comment: "Count of vacated occupancies — measures churn volume and space availability pipeline."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`tenant_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures tenant screening throughput, qualification outcomes, and compliance adherence. Enables risk, compliance, and leasing teams to monitor screening pass rates, FCRA compliance, and income qualification ratios."
  source: "`real_estate_ecm`.`tenant`.`screening`"
  dimensions:
    - name: "screening_status"
      expr: screening_status
      comment: "Current status of the screening record (e.g. Pending, Complete, Expired) — primary screening pipeline dimension."
    - name: "overall_result"
      expr: overall_result
      comment: "Overall screening result (e.g. Pass, Fail, Conditional) — key qualification outcome dimension."
    - name: "applicant_type"
      expr: applicant_type
      comment: "Type of applicant being screened (e.g. Individual, Corporate) — used to segment screening outcomes by applicant category."
    - name: "portfolio_type"
      expr: portfolio_type
      comment: "Portfolio classification for the screening (e.g. Residential, Commercial) — enables cross-portfolio screening comparison."
    - name: "credit_check_result"
      expr: credit_check_result
      comment: "Result of the credit check component — used to analyze credit qualification rates."
    - name: "criminal_check_result"
      expr: criminal_check_result
      comment: "Result of the criminal background check — used to monitor safety and compliance screening outcomes."
    - name: "eviction_check_result"
      expr: eviction_check_result
      comment: "Result of the eviction history check — used to assess prior tenancy risk."
    - name: "employment_verification_result"
      expr: employment_verification_result
      comment: "Result of employment verification — used to assess income stability of applicants."
    - name: "fcra_compliant_flag"
      expr: fcra_compliant
      comment: "Boolean indicating FCRA compliance for the screening — critical regulatory compliance dimension."
    - name: "adverse_action_required_flag"
      expr: adverse_action_required
      comment: "Boolean indicating whether an adverse action notice is required — used to track regulatory notification obligations."
    - name: "vendor"
      expr: vendor
      comment: "Screening vendor used — used to compare vendor performance and cost-effectiveness."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month the screening was requested — used for screening volume trend analysis."
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month the screening was completed — used to track screening turnaround trends."
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of screening records — baseline volume KPI for the screening pipeline."
    - name: "passed_screenings"
      expr: COUNT(CASE WHEN overall_result = 'Pass' THEN 1 END)
      comment: "Count of screenings with a Pass result — measures qualified applicant throughput."
    - name: "failed_screenings"
      expr: COUNT(CASE WHEN overall_result = 'Fail' THEN 1 END)
      comment: "Count of screenings with a Fail result — measures disqualification volume and risk exposure."
    - name: "screening_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_result = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings that passed — key leasing funnel qualification KPI for executive reporting."
    - name: "fcra_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fcra_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings that are FCRA compliant — critical regulatory compliance KPI for risk and legal teams."
    - name: "adverse_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN adverse_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings requiring an adverse action notice — measures regulatory notification burden and risk exposure."
    - name: "avg_income_to_rent_ratio"
      expr: AVG(CAST(income_to_rent_ratio AS DOUBLE))
      comment: "Average income-to-rent ratio across screened applicants — key affordability and qualification health metric."
    - name: "total_screening_fee_revenue"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total screening fee revenue collected — tracks ancillary income from the screening process."
    - name: "consent_obtained_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN applicant_consent_obtained = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings where applicant consent was obtained — measures process compliance and data governance adherence."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`tenant_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides financial risk intelligence on tenant credit profiles including DTI ratios, income verification, underwriting decisions, and deposit requirements. Enables risk management and underwriting teams to monitor portfolio credit quality."
  source: "`real_estate_ecm`.`tenant`.`credit_profile`"
  dimensions:
    - name: "credit_tier"
      expr: credit_tier
      comment: "Credit tier classification of the tenant (e.g. Prime, Near-Prime, Subprime) — primary risk segmentation dimension."
    - name: "underwriting_decision"
      expr: underwriting_decision
      comment: "Underwriting decision outcome (e.g. Approved, Declined, Conditional) — key credit decisioning dimension."
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the credit profile (e.g. Active, Expired, Pending) — used to filter for current vs. stale profiles."
    - name: "tenant_type"
      expr: tenant_type
      comment: "Type of tenant (e.g. Individual, Corporate) — used to segment credit risk by tenant category."
    - name: "income_verification_status"
      expr: income_verification_status
      comment: "Status of income verification (e.g. Verified, Pending, Failed) — used to assess underwriting data quality."
    - name: "income_verification_method"
      expr: income_verification_method
      comment: "Method used to verify income (e.g. Pay Stub, Tax Return, Bank Statement) — used to assess verification rigor."
    - name: "bankruptcy_flag"
      expr: bankruptcy_flag
      comment: "Boolean indicating prior bankruptcy — used to segment high-risk applicants in the credit portfolio."
    - name: "prior_eviction_flag"
      expr: prior_eviction_flag
      comment: "Boolean indicating prior eviction history — used to assess tenancy risk in the credit portfolio."
    - name: "guarantor_required_flag"
      expr: guarantor_required_flag
      comment: "Boolean indicating whether a guarantor is required based on credit assessment — measures risk mitigation requirements."
    - name: "bureau_name"
      expr: bureau_name
      comment: "Credit bureau used for the credit check — used to compare bureau coverage and data quality."
    - name: "credit_check_month"
      expr: DATE_TRUNC('MONTH', credit_check_date)
      comment: "Month the credit check was performed — used for credit assessment volume trend analysis."
    - name: "underwriting_decision_month"
      expr: DATE_TRUNC('MONTH', underwriting_decision_date)
      comment: "Month the underwriting decision was made — used to track decisioning throughput over time."
  measures:
    - name: "total_credit_profiles"
      expr: COUNT(1)
      comment: "Total number of credit profiles — baseline volume KPI for the credit underwriting pipeline."
    - name: "approved_profiles"
      expr: COUNT(CASE WHEN underwriting_decision = 'Approved' THEN 1 END)
      comment: "Count of credit profiles with an Approved underwriting decision — measures credit qualification throughput."
    - name: "declined_profiles"
      expr: COUNT(CASE WHEN underwriting_decision = 'Declined' THEN 1 END)
      comment: "Count of credit profiles with a Declined underwriting decision — measures credit disqualification volume."
    - name: "underwriting_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN underwriting_decision = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credit profiles approved by underwriting — key portfolio credit quality KPI for risk executives."
    - name: "avg_dti_ratio"
      expr: AVG(CAST(dti_ratio AS DOUBLE))
      comment: "Average debt-to-income ratio across credit profiles — primary financial health indicator for the tenant portfolio."
    - name: "avg_monthly_gross_income"
      expr: AVG(CAST(monthly_gross_income AS DOUBLE))
      comment: "Average monthly gross income of tenants with credit profiles — used to assess affordability across the portfolio."
    - name: "avg_recommended_max_rent"
      expr: AVG(CAST(recommended_max_rent AS DOUBLE))
      comment: "Average recommended maximum rent based on credit assessment — used to align pricing with tenant affordability."
    - name: "avg_security_deposit_multiplier"
      expr: AVG(CAST(security_deposit_multiplier AS DOUBLE))
      comment: "Average security deposit multiplier applied — measures risk mitigation intensity across the credit portfolio."
    - name: "total_collections_amount"
      expr: SUM(CAST(collections_amount AS DOUBLE))
      comment: "Total outstanding collections amount across credit profiles — measures aggregate credit risk exposure in the portfolio."
    - name: "bankruptcy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN bankruptcy_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credit profiles with a prior bankruptcy — key risk concentration metric for underwriting policy review."
    - name: "prior_eviction_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN prior_eviction_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credit profiles with prior eviction history — measures tenancy risk concentration in the portfolio."
    - name: "guarantor_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN guarantor_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credit profiles requiring a guarantor — measures the proportion of higher-risk tenants needing additional security."
    - name: "income_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN income_verification_status = 'Verified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credit profiles with verified income — measures underwriting data quality and process completeness."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`tenant_prospect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks the tenant prospect pipeline from initial inquiry through to application submission. Enables leasing and marketing teams to monitor pipeline conversion, budget alignment, and lead source effectiveness."
  source: "`real_estate_ecm`.`tenant`.`tenant_prospect`"
  dimensions:
    - name: "pipeline_status"
      expr: pipeline_status
      comment: "Current status of the prospect in the leasing pipeline (e.g. Active, Lost, Converted) — primary pipeline health dimension."
    - name: "pipeline_stage"
      expr: pipeline_stage
      comment: "Stage of the prospect in the leasing funnel (e.g. Inquiry, Tour, Proposal, Application) — used for funnel stage analysis."
    - name: "prospect_type"
      expr: prospect_type
      comment: "Type of prospect (e.g. Individual, Corporate, Institutional) — used to segment pipeline by prospect category."
    - name: "lead_source"
      expr: lead_source
      comment: "Source of the prospect lead (e.g. Website, Broker, Referral) — used to evaluate lead channel ROI."
    - name: "segment"
      expr: segment
      comment: "Market segment of the prospect — used to align pipeline with target market strategy."
    - name: "lost_reason"
      expr: lost_reason
      comment: "Reason the prospect was lost — used to identify systemic barriers to conversion and improve retention strategy."
    - name: "background_check_status"
      expr: background_check_status
      comment: "Background check status for the prospect — used to track pre-qualification completeness."
    - name: "credit_check_status"
      expr: credit_check_status
      comment: "Credit check status for the prospect — used to monitor financial pre-qualification progress."
    - name: "inquiry_month"
      expr: DATE_TRUNC('MONTH', inquiry_date)
      comment: "Month of initial prospect inquiry — used for pipeline intake volume trend analysis."
    - name: "tour_month"
      expr: DATE_TRUNC('MONTH', tour_completed_date)
      comment: "Month the property tour was completed — used to track tour-to-application conversion timing."
  measures:
    - name: "total_prospects"
      expr: COUNT(1)
      comment: "Total number of tenant prospects in the pipeline — baseline leasing demand KPI."
    - name: "converted_prospects"
      expr: COUNT(CASE WHEN pipeline_status = 'Converted' THEN 1 END)
      comment: "Count of prospects that converted to an application — measures leasing funnel conversion throughput."
    - name: "lost_prospects"
      expr: COUNT(CASE WHEN pipeline_status = 'Lost' THEN 1 END)
      comment: "Count of prospects lost from the pipeline — measures leasing attrition and opportunity cost."
    - name: "prospect_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pipeline_status = 'Converted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prospects that converted to an application — primary leasing funnel efficiency KPI for executives."
    - name: "avg_conversion_probability_pct"
      expr: AVG(CAST(conversion_probability_pct AS DOUBLE))
      comment: "Average conversion probability score across active prospects — used to forecast pipeline close rates."
    - name: "total_expected_lease_value"
      expr: SUM(CAST(expected_lease_value AS DOUBLE))
      comment: "Total expected lease value across all prospects — measures the financial value of the leasing pipeline."
    - name: "avg_expected_lease_value"
      expr: AVG(CAST(expected_lease_value AS DOUBLE))
      comment: "Average expected lease value per prospect — used to assess deal quality and prioritize high-value prospects."
    - name: "avg_budget_max_monthly"
      expr: AVG(CAST(budget_max_monthly AS DOUBLE))
      comment: "Average maximum monthly budget of prospects — used to align available inventory with prospect affordability."
    - name: "avg_budget_psf"
      expr: AVG(CAST(budget_psf AS DOUBLE))
      comment: "Average budget per square foot of prospects — used to benchmark prospect pricing expectations against market rates."
    - name: "avg_desired_size_max_sqft"
      expr: AVG(CAST(desired_size_max_sqft AS DOUBLE))
      comment: "Average maximum desired space size in square feet — used to match available inventory to prospect space requirements."
    - name: "tour_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN tour_completed_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prospects who completed a property tour — measures engagement depth and pipeline quality."
    - name: "application_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN application_submitted_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prospects who submitted an application — measures the prospect-to-applicant conversion rate."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`tenant_guarantor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks guarantor coverage, financial strength, and instrument types across the tenant portfolio. Enables risk management teams to monitor guarantee exposure, coverage adequacy, and guarantor qualification health."
  source: "`real_estate_ecm`.`tenant`.`guarantor`"
  dimensions:
    - name: "guarantee_status"
      expr: guarantee_status
      comment: "Current status of the guarantee (e.g. Active, Released, Expired) — primary guarantee lifecycle dimension."
    - name: "guarantor_type"
      expr: guarantor_type
      comment: "Type of guarantor (e.g. Individual, Corporate, Bank) — used to segment guarantee coverage by guarantor category."
    - name: "guarantee_instrument_type"
      expr: guarantee_instrument_type
      comment: "Type of guarantee instrument (e.g. Personal Guarantee, Letter of Credit, Cash Deposit) — used to analyze risk mitigation structure."
    - name: "credit_qualification_status"
      expr: credit_qualification_status
      comment: "Credit qualification status of the guarantor — used to assess guarantor financial strength."
    - name: "relationship_to_tenant"
      expr: relationship_to_tenant
      comment: "Relationship of the guarantor to the tenant (e.g. Parent Company, Principal, Spouse) — used to assess guarantee enforceability."
    - name: "is_foreign_entity_flag"
      expr: is_foreign_entity
      comment: "Boolean indicating whether the guarantor is a foreign entity — used to assess cross-border enforcement risk."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the guarantee became effective — used for guarantee inception trend analysis."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the guarantee expires — used to track upcoming guarantee expiry exposure."
  measures:
    - name: "total_guarantors"
      expr: COUNT(1)
      comment: "Total number of guarantor records — baseline count of guarantee coverage across the portfolio."
    - name: "active_guarantors"
      expr: COUNT(CASE WHEN guarantee_status = 'Active' THEN 1 END)
      comment: "Count of currently active guarantors — measures live guarantee coverage in the portfolio."
    - name: "total_guaranteed_amount"
      expr: SUM(CAST(guaranteed_amount AS DOUBLE))
      comment: "Total guaranteed amount across all active guarantors — measures aggregate financial risk coverage in the portfolio."
    - name: "avg_guaranteed_amount"
      expr: AVG(CAST(guaranteed_amount AS DOUBLE))
      comment: "Average guaranteed amount per guarantor — used to assess typical guarantee coverage levels."
    - name: "avg_guaranteed_pct"
      expr: AVG(CAST(guaranteed_pct AS DOUBLE))
      comment: "Average percentage of lease obligation covered by guarantee — measures guarantee coverage adequacy across the portfolio."
    - name: "avg_guarantor_annual_income"
      expr: AVG(CAST(annual_income AS DOUBLE))
      comment: "Average annual income of guarantors — used to assess the financial strength of the guarantor pool."
    - name: "avg_guarantor_net_worth"
      expr: AVG(CAST(net_worth AS DOUBLE))
      comment: "Average net worth of guarantors — key financial strength indicator for guarantee enforceability assessment."
    - name: "avg_guarantor_dti_ratio"
      expr: AVG(CAST(dti_ratio AS DOUBLE))
      comment: "Average debt-to-income ratio of guarantors — used to assess guarantor financial health and guarantee reliability."
    - name: "foreign_entity_guarantor_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_foreign_entity = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guarantors that are foreign entities — measures cross-border enforcement risk concentration."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`tenant_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks legal and operational notices issued to or from tenants including default notices, rent increase notices, and renewal offers. Enables property management and legal teams to monitor notice compliance, cure rates, and rent adjustment activity."
  source: "`real_estate_ecm`.`tenant`.`notice`"
  dimensions:
    - name: "notice_type"
      expr: notice_type
      comment: "Type of notice issued (e.g. Default, Rent Increase, Vacate, Renewal Offer) — primary notice classification dimension."
    - name: "notice_status"
      expr: notice_status
      comment: "Current status of the notice (e.g. Issued, Delivered, Responded, Closed) — used to track notice lifecycle progress."
    - name: "direction"
      expr: direction
      comment: "Direction of the notice (e.g. Landlord-to-Tenant, Tenant-to-Landlord) — used to distinguish notice origination."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver the notice (e.g. Certified Mail, Email, Hand Delivery) — used to assess delivery compliance."
    - name: "cured_flag"
      expr: cured_flag
      comment: "Boolean indicating whether the default or violation was cured — used to measure cure rate and legal escalation risk."
    - name: "delivery_confirmed_flag"
      expr: delivery_confirmed
      comment: "Boolean indicating whether delivery was confirmed — used to track notice delivery compliance."
    - name: "response_received_flag"
      expr: response_received
      comment: "Boolean indicating whether a response was received — used to measure tenant engagement with notices."
    - name: "legal_counsel_engaged_flag"
      expr: legal_counsel_engaged
      comment: "Boolean indicating whether legal counsel was engaged — used to track legal escalation volume and cost exposure."
    - name: "litigation_hold_flag"
      expr: litigation_hold
      comment: "Boolean indicating whether a litigation hold is in place — used to monitor active legal dispute exposure."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the notice was issued — used for notice volume trend analysis."
  measures:
    - name: "total_notices"
      expr: COUNT(1)
      comment: "Total number of notices issued — baseline volume KPI for legal and property management activity."
    - name: "default_notices"
      expr: COUNT(CASE WHEN notice_type = 'Default' THEN 1 END)
      comment: "Count of default notices issued — measures tenant default incidence and portfolio credit risk."
    - name: "cure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cured_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of notices where the default or violation was cured — key risk resolution KPI for property management."
    - name: "delivery_confirmation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivery_confirmed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of notices with confirmed delivery — measures legal process compliance and notice enforceability."
    - name: "response_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN response_received = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of notices that received a tenant response — measures tenant engagement and dispute resolution activity."
    - name: "legal_escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN legal_counsel_engaged = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of notices that escalated to legal counsel — measures legal cost exposure and dispute severity."
    - name: "litigation_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN litigation_hold = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of notices under litigation hold — measures active legal dispute concentration in the portfolio."
    - name: "total_rent_increase_amount"
      expr: SUM(CAST(rent_increase_amount AS DOUBLE))
      comment: "Total rent increase amount across all rent increase notices — measures aggregate rental revenue uplift from notice activity."
    - name: "avg_rent_increase_pct"
      expr: AVG(CAST(rent_increase_pct AS DOUBLE))
      comment: "Average rent increase percentage across rent increase notices — benchmarks rent escalation rates against market and lease terms."
    - name: "total_renewal_offer_rent_amount"
      expr: SUM(CAST(renewal_offer_rent_amount AS DOUBLE))
      comment: "Total rent amount offered in renewal notices — measures the financial value of the lease renewal pipeline."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`tenant_corporate_entity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides a financial and risk profile of corporate tenant entities including revenue, credit ratings, ESG status, and KYC compliance. Enables asset management and risk teams to monitor the quality and concentration of the corporate tenant base."
  source: "`real_estate_ecm`.`tenant`.`corporate_entity`"
  dimensions:
    - name: "entity_type"
      expr: entity_type
      comment: "Legal entity type of the corporate tenant (e.g. LLC, Corporation, Partnership) — used to segment the tenant base by legal structure."
    - name: "entity_status"
      expr: entity_status
      comment: "Current status of the corporate entity (e.g. Active, Inactive, Dissolved) — used to filter for active tenants."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating of the corporate entity (e.g. AAA, BBB, Unrated) — primary credit quality dimension for portfolio risk analysis."
    - name: "credit_rating_agency"
      expr: credit_rating_agency
      comment: "Agency that issued the credit rating (e.g. Moody's, S&P, Fitch) — used to assess rating source consistency."
    - name: "kyc_status"
      expr: kyc_status
      comment: "KYC verification status of the entity (e.g. Verified, Pending, Failed) — critical compliance dimension."
    - name: "hierarchy_type"
      expr: hierarchy_type
      comment: "Type of corporate hierarchy (e.g. Parent, Subsidiary, Standalone) — used to analyze tenant concentration by corporate group."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level within the corporate hierarchy — used to identify ultimate parent entities and group exposure."
    - name: "is_publicly_traded_flag"
      expr: is_publicly_traded
      comment: "Boolean indicating whether the entity is publicly traded — used to segment tenants by financial transparency."
    - name: "is_reit_flag"
      expr: is_reit
      comment: "Boolean indicating whether the entity is a REIT — used to identify real estate investment trust tenants."
    - name: "esg_rating"
      expr: esg_rating
      comment: "ESG rating of the corporate entity — used to assess portfolio alignment with ESG investment mandates."
    - name: "incorporation_month"
      expr: DATE_TRUNC('MONTH', incorporation_date)
      comment: "Month of entity incorporation — used to analyze the age profile of the corporate tenant base."
  measures:
    - name: "total_corporate_entities"
      expr: COUNT(1)
      comment: "Total number of corporate tenant entities — baseline count of the corporate tenant base."
    - name: "kyc_verified_entities"
      expr: COUNT(CASE WHEN kyc_status = 'Verified' THEN 1 END)
      comment: "Count of corporate entities with verified KYC status — measures compliance completeness of the tenant base."
    - name: "kyc_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN kyc_status = 'Verified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corporate entities with verified KYC — critical regulatory compliance KPI for risk and legal teams."
    - name: "total_annual_revenue_usd"
      expr: SUM(CAST(annual_revenue_usd AS DOUBLE))
      comment: "Total annual revenue of all corporate tenant entities in USD — measures the aggregate financial strength of the corporate tenant base."
    - name: "avg_annual_revenue_usd"
      expr: AVG(CAST(annual_revenue_usd AS DOUBLE))
      comment: "Average annual revenue per corporate tenant entity in USD — used to assess typical tenant financial scale."
    - name: "publicly_traded_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_publicly_traded = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corporate entities that are publicly traded — measures financial transparency and credit quality of the tenant base."
    - name: "rated_entities_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN credit_rating IS NOT NULL AND credit_rating != 'Unrated' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corporate entities with a formal credit rating — measures the proportion of the tenant base with third-party credit validation."
$$;