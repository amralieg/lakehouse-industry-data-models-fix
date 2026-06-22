-- Metric views for domain: customer | Business: Water_Utilities | Version: 2 | Generated on: 2026-06-22 20:08:50

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the customer account portfolio — account health, financial exposure, billing program adoption, and delinquency risk. Used by Customer Operations, Finance, and Executive leadership to steer revenue protection and customer engagement programs."
  source: "`vibe_water_utilities_v1`.`customer`.`customer_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current lifecycle status of the account (Active, Closed, Suspended, etc.) — primary segmentation for portfolio health analysis."
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account type (Residential, Commercial, Industrial, etc.) — drives rate schedule and service tier analysis."
    - name: "account_class"
      expr: account_class
      comment: "Regulatory or billing class of the account — used for rate-class segmentation and regulatory reporting."
    - name: "customer_class"
      expr: customer_class
      comment: "Customer classification (e.g. Residential, Small Business, Large Commercial) — used for strategic segmentation and program targeting."
    - name: "billing_cycle_code"
      expr: billing_cycle_code
      comment: "Billing cycle assignment — used to analyze workload distribution and billing program performance across cycles."
    - name: "billing_method"
      expr: billing_method
      comment: "Method by which the customer is billed (paper, electronic, etc.) — used to track paperless adoption and cost-to-serve."
    - name: "collection_status"
      expr: collection_status
      comment: "Current collections standing of the account — critical for delinquency and revenue-at-risk reporting."
    - name: "delinquency_status"
      expr: delinquency_status
      comment: "Delinquency classification of the account — used to segment accounts by payment risk tier."
    - name: "payment_method"
      expr: payment_method
      comment: "Preferred payment method on file — used to analyze autopay adoption and payment channel mix."
    - name: "rate_schedule_code"
      expr: rate_schedule_code
      comment: "Rate schedule assigned to the account — used for revenue mix and rate-class performance analysis."
    - name: "service_type"
      expr: service_type
      comment: "Type of utility service (Water, Sewer, Recycled, etc.) — used to segment accounts by service line."
    - name: "credit_score_band"
      expr: credit_score_band
      comment: "Banded credit score tier of the account holder — used for credit risk segmentation and deposit policy analysis."
    - name: "language_preference"
      expr: language_preference
      comment: "Preferred communication language — used for equity reporting and multilingual outreach program sizing."
    - name: "autopay_enrolled_flag"
      expr: autopay_enrolled_flag
      comment: "Indicates whether the account is enrolled in autopay — used to track autopay adoption rate."
    - name: "paperless_billing_flag"
      expr: paperless_billing_flag
      comment: "Indicates whether the account is enrolled in paperless billing — used to track digital adoption and reduce print/mail costs."
    - name: "low_income_flag"
      expr: low_income_flag
      comment: "Indicates whether the account qualifies for low-income assistance programs — used for equity and affordability program reporting."
    - name: "life_support_flag"
      expr: life_support_flag
      comment: "Indicates whether the account has a life-support designation — critical for shutoff protection compliance and emergency planning."
    - name: "shutoff_protected"
      expr: shutoff_protected
      comment: "Indicates whether the account is protected from service shutoff — used for compliance and operational planning."
    - name: "service_start_year"
      expr: YEAR(service_start_date)
      comment: "Year the service started — used for cohort analysis and customer tenure segmentation."
    - name: "last_payment_year_month"
      expr: DATE_TRUNC('MONTH', last_payment_date)
      comment: "Month of the most recent payment — used to identify accounts with stale payment activity."
  measures:
    - name: "total_active_accounts"
      expr: COUNT(CASE WHEN account_status = 'Active' THEN customer_account_id END)
      comment: "Total number of active customer accounts. Core portfolio size KPI used by executives to track customer base growth and churn."
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance_amount AS DOUBLE))
      comment: "Total outstanding balance across all accounts. Measures aggregate accounts-receivable exposure — a primary revenue-at-risk indicator for Finance."
    - name: "total_past_due_balance"
      expr: SUM(CAST(past_due_amount AS DOUBLE))
      comment: "Total past-due balance across all accounts. Directly measures delinquency exposure and drives collections prioritization decisions."
    - name: "avg_current_balance_per_account"
      expr: AVG(CAST(current_balance_amount AS DOUBLE))
      comment: "Average outstanding balance per account. Used to benchmark account-level financial exposure and detect anomalous billing patterns."
    - name: "total_last_payment_amount"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Sum of the most recent payment amounts across all accounts. Approximates recent cash collection volume — used by Finance for short-term cash flow analysis."
    - name: "avg_monthly_usage_gallons"
      expr: AVG(CAST(average_monthly_usage_gallons AS DOUBLE))
      comment: "Average monthly water consumption in gallons across accounts. Used by Operations and Planning to size demand forecasts and conservation program targets."
    - name: "total_deposit_held"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts held across accounts. Tracks aggregate deposit liability — used by Finance for balance sheet reporting and deposit policy review."
    - name: "autopay_enrolled_account_count"
      expr: COUNT(CASE WHEN autopay_enrolled_flag = TRUE THEN customer_account_id END)
      comment: "Number of accounts enrolled in autopay. Used to track autopay adoption, which reduces payment delinquency and lowers collection costs."
    - name: "paperless_enrolled_account_count"
      expr: COUNT(CASE WHEN paperless_billing_flag = TRUE THEN customer_account_id END)
      comment: "Number of accounts enrolled in paperless billing. Tracks digital adoption progress — directly tied to print/mail cost reduction initiatives."
    - name: "low_income_account_count"
      expr: COUNT(CASE WHEN low_income_flag = TRUE THEN customer_account_id END)
      comment: "Number of accounts flagged as low-income assistance eligible. Used for affordability program sizing, grant reporting, and equity compliance."
    - name: "life_support_account_count"
      expr: COUNT(CASE WHEN life_support_flag = TRUE THEN customer_account_id END)
      comment: "Number of accounts with life-support designations. Critical for shutoff protection compliance, emergency response planning, and regulatory reporting."
    - name: "delinquent_account_count"
      expr: COUNT(CASE WHEN delinquency_status IS NOT NULL AND delinquency_status != 'Current' THEN customer_account_id END)
      comment: "Number of accounts in a delinquent status. Primary delinquency volume KPI used by Collections and Finance to size intervention programs."
    - name: "budget_billing_enrolled_count"
      expr: COUNT(CASE WHEN budget_billing_flag = TRUE THEN customer_account_id END)
      comment: "Number of accounts enrolled in budget billing. Tracks adoption of payment smoothing programs — used to assess customer financial stability support."
    - name: "total_budget_billing_amount"
      expr: SUM(CAST(budget_billing_amount AS DOUBLE))
      comment: "Total monthly budget billing commitment across enrolled accounts. Used by Finance to forecast predictable monthly revenue from budget billing participants."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and regulatory KPIs for customer complaints — resolution performance, escalation rates, regulatory exposure, and customer satisfaction. Used by Customer Service, Regulatory Affairs, and Executive leadership to manage service quality and compliance risk."
  source: "`vibe_water_utilities_v1`.`customer`.`complaint`"
  dimensions:
    - name: "complaint_type"
      expr: complaint_type
      comment: "Type of complaint (Billing, Water Quality, Pressure, Service, etc.) — primary dimension for complaint root-cause analysis."
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current resolution status of the complaint (Open, In Progress, Resolved, Closed) — used to track backlog and resolution pipeline."
    - name: "category"
      expr: category
      comment: "High-level complaint category — used for trend analysis and program prioritization."
    - name: "subcategory"
      expr: subcategory
      comment: "Detailed complaint subcategory — used for granular root-cause analysis and operational improvement targeting."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the complaint (Critical, High, Medium, Low) — used to assess SLA compliance and resource allocation."
    - name: "assigned_to_department"
      expr: assigned_to_department
      comment: "Department responsible for resolving the complaint — used for workload distribution and departmental performance analysis."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the complaint was received (Phone, Web, Email, Walk-in) — used to optimize customer contact channel strategy."
    - name: "contact_method"
      expr: contact_method
      comment: "Method used to contact the customer regarding the complaint — used for communication effectiveness analysis."
    - name: "escalated_flag"
      expr: escalated_flag
      comment: "Indicates whether the complaint was escalated — used to measure escalation rate and identify systemic service failures."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Indicates whether the complaint must be reported to a regulatory agency — critical for compliance tracking and regulatory risk management."
    - name: "regulatory_escalation_flag"
      expr: regulatory_escalation_flag
      comment: "Indicates whether the complaint was escalated to a regulatory body — used for regulatory relationship and compliance risk reporting."
    - name: "water_quality_related_flag"
      expr: water_quality_related_flag
      comment: "Indicates whether the complaint is related to water quality — used to trigger water quality investigation workflows and regulatory notifications."
    - name: "complaint_year_month"
      expr: DATE_TRUNC('MONTH', complaint_date)
      comment: "Month the complaint was filed — used for trend analysis and seasonal pattern detection."
    - name: "resolution_code"
      expr: resolution_code
      comment: "Standardized code describing how the complaint was resolved — used for resolution pattern analysis and process improvement."
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause identified for the complaint — used for systemic issue identification and capital/operational investment prioritization."
    - name: "regulatory_agency"
      expr: regulatory_agency
      comment: "Regulatory agency associated with the complaint — used for agency-specific compliance reporting."
  measures:
    - name: "total_complaints"
      expr: COUNT(complaint_id)
      comment: "Total number of complaints received. Core volume KPI used by Customer Service leadership to track complaint load and service quality trends."
    - name: "open_complaint_count"
      expr: COUNT(CASE WHEN complaint_status NOT IN ('Resolved', 'Closed') THEN complaint_id END)
      comment: "Number of complaints currently open or in progress. Measures active backlog — used by Customer Service to manage resolution capacity and SLA risk."
    - name: "escalated_complaint_count"
      expr: COUNT(CASE WHEN escalated_flag = TRUE THEN complaint_id END)
      comment: "Number of complaints that were escalated. Used to identify systemic service failures and measure escalation volume for management intervention."
    - name: "regulatory_reportable_complaint_count"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN complaint_id END)
      comment: "Number of complaints requiring regulatory reporting. Directly measures regulatory compliance exposure — used by Regulatory Affairs for agency submissions."
    - name: "regulatory_escalated_complaint_count"
      expr: COUNT(CASE WHEN regulatory_escalation_flag = TRUE THEN complaint_id END)
      comment: "Number of complaints escalated to a regulatory body. Tracks regulatory relationship risk — a leading indicator of enforcement or audit activity."
    - name: "water_quality_complaint_count"
      expr: COUNT(CASE WHEN water_quality_related_flag = TRUE THEN complaint_id END)
      comment: "Number of water-quality-related complaints. Critical public health KPI — triggers investigation workflows and regulatory notification requirements."
    - name: "avg_customer_satisfaction_score"
      expr: AVG(CAST(customer_satisfaction_score AS DOUBLE))
      comment: "Average customer satisfaction score across resolved complaints. Primary customer experience KPI — used by executives to benchmark service quality and drive improvement programs."
    - name: "total_billing_adjustment_amount"
      expr: SUM(CAST(billing_adjustment_amount AS DOUBLE))
      comment: "Total billing adjustments issued as complaint resolutions. Measures financial cost of service failures — used by Finance and Customer Service to quantify complaint-driven revenue leakage."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN complaint_id END)
      comment: "Number of complaints requiring follow-up action. Used to size follow-up workload and ensure no complaints fall through the resolution process."
    - name: "compensation_provided_count"
      expr: COUNT(CASE WHEN compensation_provided_flag = TRUE THEN complaint_id END)
      comment: "Number of complaints where compensation was provided to the customer. Used to track goodwill/compensation program utilization and associated cost exposure."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_service_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and contract KPIs for service agreements — contracted demand, financial commitments, deposit exposure, and agreement portfolio health. Used by Finance, Revenue Management, and Operations to manage the contracted revenue base and service portfolio."
  source: "`vibe_water_utilities_v1`.`customer`.`service_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the service agreement (Active, Terminated, Pending, Expired) — primary dimension for portfolio health analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of service agreement (Standard, Commercial, Industrial, Fire Service, etc.) — used for revenue mix and contract type analysis."
    - name: "service_type"
      expr: service_type
      comment: "Type of utility service covered by the agreement (Water, Sewer, Recycled Water, etc.) — used for service line revenue segmentation."
    - name: "service_class"
      expr: service_class
      comment: "Service class designation — used for rate-class revenue analysis and regulatory reporting."
    - name: "rate_class"
      expr: rate_class
      comment: "Rate class assigned to the agreement — used for revenue mix analysis and rate design impact assessment."
    - name: "rate_code"
      expr: rate_code
      comment: "Specific rate code applied to the agreement — used for granular rate schedule performance analysis."
    - name: "billing_cycle_code"
      expr: billing_cycle_code
      comment: "Billing cycle for the agreement — used to analyze billing workload distribution and cycle-level revenue patterns."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency of billing (Monthly, Bi-Monthly, Quarterly) — used to analyze billing program mix and cash flow timing."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the agreement is currently active — used as a primary filter for active portfolio analysis."
    - name: "seasonal_flag"
      expr: seasonal_flag
      comment: "Indicates whether the agreement is seasonal — used for demand forecasting and seasonal revenue planning."
    - name: "irrigation_flag"
      expr: irrigation_flag
      comment: "Indicates whether the agreement covers irrigation service — used for water demand management and conservation program targeting."
    - name: "fire_service_flag"
      expr: fire_service_flag
      comment: "Indicates whether the agreement includes fire protection service — used for fire service revenue tracking and infrastructure planning."
    - name: "reclaimed_water_flag"
      expr: reclaimed_water_flag
      comment: "Indicates whether the agreement covers reclaimed water service — used for recycled water program adoption tracking."
    - name: "deposit_required_flag"
      expr: deposit_required_flag
      comment: "Indicates whether a deposit is required for this agreement — used for credit risk and deposit policy analysis."
    - name: "auto_pay_enrolled"
      expr: auto_pay_enrolled
      comment: "Indicates whether the agreement is enrolled in autopay — used to track autopay adoption at the agreement level."
    - name: "effective_start_year_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the agreement became effective — used for cohort analysis and new agreement activation trend reporting."
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for agreement termination — used for churn analysis and service discontinuation root-cause reporting."
  measures:
    - name: "total_active_agreements"
      expr: COUNT(CASE WHEN is_active = TRUE THEN service_agreement_id END)
      comment: "Total number of active service agreements. Core contracted portfolio size KPI — used by Revenue Management to track the active revenue-generating base."
    - name: "total_contracted_demand_gpd"
      expr: SUM(CAST(contracted_demand_gpd AS DOUBLE))
      comment: "Total contracted daily demand in gallons per day across all active agreements. Used by Operations and Planning for capacity planning and demand forecasting."
    - name: "total_contracted_volume_gallons"
      expr: SUM(CAST(contracted_volume_gallons AS DOUBLE))
      comment: "Total contracted volume in gallons across agreements. Measures the aggregate committed water volume — used for supply planning and take-or-pay contract management."
    - name: "total_estimated_annual_usage_gallons"
      expr: SUM(CAST(estimated_annual_usage_gal AS DOUBLE))
      comment: "Total estimated annual water usage in gallons across all agreements. Used for annual demand forecasting, infrastructure sizing, and conservation target setting."
    - name: "avg_estimated_annual_usage_gallons"
      expr: AVG(CAST(estimated_annual_usage_gal AS DOUBLE))
      comment: "Average estimated annual usage per agreement. Used to benchmark per-account consumption and identify high-usage segments for conservation outreach."
    - name: "total_monthly_base_charge"
      expr: SUM(CAST(monthly_base_charge_usd AS DOUBLE))
      comment: "Total monthly base charge revenue across all active agreements. Measures the fixed recurring revenue base — a primary financial planning KPI for Finance."
    - name: "avg_monthly_base_charge"
      expr: AVG(CAST(monthly_base_charge_usd AS DOUBLE))
      comment: "Average monthly base charge per agreement. Used to benchmark per-agreement revenue and assess rate schedule adequacy."
    - name: "total_connection_fee_revenue"
      expr: SUM(CAST(connection_fee_amount AS DOUBLE))
      comment: "Total connection fees collected across agreements. Tracks new connection revenue — used by Finance for capital recovery and growth revenue reporting."
    - name: "total_capacity_fee_revenue"
      expr: SUM(CAST(capacity_fee_amount AS DOUBLE))
      comment: "Total capacity fees collected across agreements. Measures infrastructure capacity recovery revenue — used for capital project funding analysis."
    - name: "total_deposit_held"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts held across service agreements. Tracks aggregate deposit liability — used by Finance for balance sheet reporting and credit risk management."
    - name: "total_minimum_charge_revenue"
      expr: SUM(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Total minimum charge commitments across agreements. Measures guaranteed minimum revenue floor — used by Finance for revenue floor analysis and rate design."
    - name: "avg_meter_size_inches"
      expr: AVG(CAST(meter_size_inches AS DOUBLE))
      comment: "Average meter size in inches across agreements. Used by Engineering and Operations to understand the meter size distribution and plan infrastructure investments."
    - name: "terminated_agreement_count"
      expr: COUNT(CASE WHEN service_agreement_status = 'Terminated' THEN service_agreement_id END)
      comment: "Number of terminated service agreements. Measures churn volume — used by Customer Retention and Finance to track service discontinuation trends."
    - name: "seasonal_agreement_count"
      expr: COUNT(CASE WHEN seasonal_flag = TRUE THEN service_agreement_id END)
      comment: "Number of seasonal service agreements. Used for seasonal demand planning and revenue forecasting for non-year-round customers."
    - name: "reclaimed_water_agreement_count"
      expr: COUNT(CASE WHEN reclaimed_water_flag = TRUE THEN service_agreement_id END)
      comment: "Number of agreements covering reclaimed water service. Tracks recycled water program adoption — used for sustainability reporting and program expansion planning."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_service_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for new service applications — processing throughput, approval/rejection rates, SLA compliance, and credit risk screening. Used by Customer Service Operations, Credit, and Planning to manage new customer onboarding efficiency and growth pipeline."
  source: "`vibe_water_utilities_v1`.`customer`.`service_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the service application (Pending, Approved, Rejected, Withdrawn, In Review) — primary dimension for pipeline and throughput analysis."
    - name: "application_type"
      expr: application_type
      comment: "Type of service application (New Service, Transfer, Upgrade, etc.) — used to segment application volume by request type."
    - name: "service_type_requested"
      expr: service_type_requested
      comment: "Type of service requested in the application — used to forecast new demand by service type."
    - name: "service_class_requested"
      expr: service_class_requested
      comment: "Service class requested — used for rate class demand forecasting and capacity planning."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the application was submitted (Online, Phone, In-Person, Mail) — used to optimize application intake channel strategy."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the application — used to analyze SLA compliance by priority tier."
    - name: "credit_check_status"
      expr: credit_check_status
      comment: "Status of the credit check performed during application review — used for credit risk screening performance analysis."
    - name: "credit_check_result"
      expr: credit_check_result
      comment: "Result of the credit check (Pass, Fail, Conditional) — used to analyze credit risk distribution in the new customer pipeline."
    - name: "identity_verification_status"
      expr: identity_verification_status
      comment: "Status of identity verification for the applicant — used for fraud risk and compliance reporting."
    - name: "deposit_required_flag"
      expr: deposit_required_flag
      comment: "Indicates whether a deposit was required for the application — used to analyze deposit requirement rates by customer segment."
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Standardized code for application rejection reason — used for rejection root-cause analysis and process improvement."
    - name: "meter_size_requested"
      expr: meter_size_requested
      comment: "Meter size requested in the application — used for infrastructure demand planning and capacity allocation."
    - name: "submission_year_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the application was submitted — used for application volume trend analysis and growth pipeline reporting."
    - name: "approval_year_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the application was approved — used for new customer activation trend analysis."
  measures:
    - name: "total_applications"
      expr: COUNT(service_application_id)
      comment: "Total number of service applications received. Core growth pipeline volume KPI — used by Planning and Customer Operations to track new customer demand."
    - name: "approved_application_count"
      expr: COUNT(CASE WHEN application_status = 'Approved' THEN service_application_id END)
      comment: "Number of approved service applications. Measures new customer activation volume — directly tied to revenue growth and connection fee collection."
    - name: "rejected_application_count"
      expr: COUNT(CASE WHEN application_status = 'Rejected' THEN service_application_id END)
      comment: "Number of rejected service applications. Used to monitor rejection rates and identify barriers to service access — relevant for equity and regulatory reporting."
    - name: "withdrawn_application_count"
      expr: COUNT(CASE WHEN application_status = 'Withdrawn' THEN service_application_id END)
      comment: "Number of withdrawn applications. Tracks applicant abandonment — used to identify friction points in the application process."
    - name: "pending_application_count"
      expr: COUNT(CASE WHEN application_status NOT IN ('Approved', 'Rejected', 'Withdrawn') THEN service_application_id END)
      comment: "Number of applications currently in the processing pipeline. Measures active workload — used by Customer Operations to manage staffing and SLA risk."
    - name: "deposit_required_application_count"
      expr: COUNT(CASE WHEN deposit_required_flag = TRUE THEN service_application_id END)
      comment: "Number of applications requiring a deposit. Used to forecast deposit collection volume and assess credit risk in the new customer pipeline."
    - name: "total_connection_fee_amount"
      expr: SUM(CAST(connection_fee_amount AS DOUBLE))
      comment: "Total connection fees associated with applications. Measures new connection revenue in the pipeline — used by Finance for capital recovery forecasting."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts required across applications. Tracks aggregate deposit collection obligation — used by Finance for cash flow and liability planning."
    - name: "avg_connection_fee_amount"
      expr: AVG(CAST(connection_fee_amount AS DOUBLE))
      comment: "Average connection fee per application. Used to benchmark connection fee levels and assess fee schedule adequacy relative to infrastructure costs."
    - name: "sla_breached_application_count"
      expr: COUNT(CASE WHEN sla_due_date IS NOT NULL AND review_completed_date > sla_due_date THEN service_application_id END)
      comment: "Number of applications where the review was completed after the SLA due date. Measures SLA compliance failures — used by Operations management to drive process improvement."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_premise`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Infrastructure and demand KPIs for service premises — physical characteristics, demand profiles, service availability, and special program flags. Used by Engineering, Operations, and Planning to manage the physical service footprint and infrastructure investment decisions."
  source: "`vibe_water_utilities_v1`.`customer`.`premise`"
  dimensions:
    - name: "premise_type"
      expr: premise_type
      comment: "Type of premise (Residential, Commercial, Industrial, Multi-Family, etc.) — primary dimension for demand and infrastructure analysis."
    - name: "premise_status"
      expr: premise_status
      comment: "Current status of the premise (Active, Inactive, Demolished, etc.) — used to filter the active service footprint."
    - name: "building_type"
      expr: building_type
      comment: "Type of building at the premise — used for infrastructure planning and demand segmentation."
    - name: "zoning_classification"
      expr: zoning_classification
      comment: "Zoning classification of the premise — used for land-use planning and future demand forecasting."
    - name: "pressure_zone"
      expr: pressure_zone
      comment: "Pressure zone serving the premise — used for hydraulic analysis and pressure management program targeting."
    - name: "service_line_material"
      expr: service_line_material
      comment: "Material of the service line (Lead, Copper, PVC, etc.) — critical for lead service line replacement program tracking and regulatory compliance."
    - name: "sewer_lateral_material"
      expr: sewer_lateral_material
      comment: "Material of the sewer lateral — used for sewer infrastructure condition assessment and rehabilitation planning."
    - name: "water_service_available_flag"
      expr: water_service_available_flag
      comment: "Indicates whether water service is available at the premise — used for service territory coverage analysis."
    - name: "wastewater_service_available_flag"
      expr: wastewater_service_available_flag
      comment: "Indicates whether wastewater service is available at the premise — used for sewer service coverage analysis."
    - name: "reclaimed_water_service_available_flag"
      expr: reclaimed_water_service_available_flag
      comment: "Indicates whether reclaimed water service is available — used for recycled water program expansion planning."
    - name: "backflow_prevention_required_flag"
      expr: backflow_prevention_required_flag
      comment: "Indicates whether backflow prevention is required — used for cross-connection control program compliance tracking."
    - name: "fire_protection_required_flag"
      expr: fire_protection_required_flag
      comment: "Indicates whether fire protection service is required — used for fire flow infrastructure planning."
    - name: "industrial_user_permit_required_flag"
      expr: industrial_user_permit_required_flag
      comment: "Indicates whether an industrial user permit is required — used for pretreatment program compliance tracking."
    - name: "low_income_assistance_eligible_flag"
      expr: low_income_assistance_eligible_flag
      comment: "Indicates whether the premise is eligible for low-income assistance — used for affordability program geographic targeting."
    - name: "fats_oils_grease_program_flag"
      expr: fats_oils_grease_program_flag
      comment: "Indicates whether the premise is enrolled in the FOG program — used for sewer blockage prevention program management."
  measures:
    - name: "total_active_premises"
      expr: COUNT(CASE WHEN premise_status = 'Active' THEN premise_id END)
      comment: "Total number of active service premises. Core service footprint KPI — used by Planning and Operations to track the physical customer base and infrastructure scope."
    - name: "total_estimated_daily_demand_gallons"
      expr: SUM(CAST(estimated_daily_demand_gallons AS DOUBLE))
      comment: "Total estimated daily water demand in gallons across all premises. Primary demand planning KPI — used by Engineering and Operations for supply capacity and infrastructure sizing."
    - name: "avg_estimated_daily_demand_gallons"
      expr: AVG(CAST(estimated_daily_demand_gallons AS DOUBLE))
      comment: "Average estimated daily demand per premise. Used to benchmark per-premise consumption and identify high-demand segments for conservation targeting."
    - name: "total_peak_demand_gpm"
      expr: SUM(CAST(peak_demand_gpm AS DOUBLE))
      comment: "Total peak demand in gallons per minute across all premises. Used by Engineering for peak-hour infrastructure sizing and pressure zone capacity planning."
    - name: "avg_meter_size_inches"
      expr: AVG(CAST(meter_size_inches AS DOUBLE))
      comment: "Average meter size in inches across premises. Used by Engineering to understand meter size distribution and plan meter replacement and upgrade programs."
    - name: "total_connection_fee_collected"
      expr: SUM(CAST(connection_fee_paid_amount AS DOUBLE))
      comment: "Total connection fees collected across premises. Measures capital recovery from new connections — used by Finance for infrastructure cost recovery reporting."
    - name: "lead_service_line_premise_count"
      expr: COUNT(CASE WHEN service_line_material = 'Lead' THEN premise_id END)
      comment: "Number of premises with lead service lines. Critical regulatory and public health KPI — used to track LCRR compliance progress and prioritize lead service line replacement investments."
    - name: "backflow_prevention_required_count"
      expr: COUNT(CASE WHEN backflow_prevention_required_flag = TRUE THEN premise_id END)
      comment: "Number of premises requiring backflow prevention devices. Used for cross-connection control program compliance tracking and inspection scheduling."
    - name: "industrial_permit_required_count"
      expr: COUNT(CASE WHEN industrial_user_permit_required_flag = TRUE THEN premise_id END)
      comment: "Number of premises requiring industrial user permits. Used for pretreatment program compliance management and regulatory reporting."
    - name: "avg_building_square_footage"
      expr: AVG(CAST(building_square_footage AS DOUBLE))
      comment: "Average building square footage across premises. Used for demand normalization and per-square-foot consumption benchmarking in commercial and industrial segments."
    - name: "total_lot_size_square_feet"
      expr: SUM(CAST(lot_size_square_feet AS DOUBLE))
      comment: "Total lot area in square feet across all premises. Used for irrigation demand estimation and outdoor water use conservation program sizing."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`customer_person`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer demographic, consent, and assistance program KPIs at the individual person level. Used by Customer Service, Equity Programs, Compliance, and Marketing to manage customer identity, program eligibility, and consent governance."
  source: "`vibe_water_utilities_v1`.`customer`.`person`"
  dimensions:
    - name: "person_status"
      expr: person_status
      comment: "Current status of the person record (Active, Inactive, Deceased, etc.) — used to maintain a clean active customer population."
    - name: "person_type"
      expr: person_type
      comment: "Type of person (Primary Account Holder, Co-Applicant, Authorized User, etc.) — used for role-based customer analysis."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment assignment — used for targeted program outreach and strategic segmentation analysis."
    - name: "language_preference"
      expr: language_preference
      comment: "Preferred communication language — used for equity reporting and multilingual service program sizing."
    - name: "preferred_contact_method"
      expr: preferred_contact_method
      comment: "Preferred method of contact — used to optimize communication channel strategy and reduce contact costs."
    - name: "identity_verification_status"
      expr: identity_verification_status
      comment: "Status of identity verification (Verified, Pending, Failed) — used for fraud risk management and compliance reporting."
    - name: "identity_verification_method"
      expr: identity_verification_method
      comment: "Method used for identity verification — used to assess verification channel effectiveness and compliance."
    - name: "senior_citizen_flag"
      expr: senior_citizen_flag
      comment: "Indicates whether the person is a senior citizen — used for senior assistance program eligibility and equity reporting."
    - name: "life_support_equipment_flag"
      expr: life_support_equipment_flag
      comment: "Indicates whether the person uses life-support equipment — critical for shutoff protection compliance and emergency planning."
    - name: "low_income_assistance_eligible_flag"
      expr: low_income_assistance_eligible_flag
      comment: "Indicates whether the person is eligible for low-income assistance — used for affordability program enrollment targeting."
    - name: "disability_accommodation_flag"
      expr: disability_accommodation_flag
      comment: "Indicates whether the person requires disability accommodations — used for ADA compliance and accessible service delivery planning."
    - name: "paperless_billing_flag"
      expr: paperless_billing_flag
      comment: "Indicates whether the person is enrolled in paperless billing — used to track digital adoption at the individual level."
    - name: "marketing_consent_flag"
      expr: marketing_consent_flag
      comment: "Indicates whether the person has consented to marketing communications — used for compliant marketing program targeting."
    - name: "data_sharing_consent_flag"
      expr: data_sharing_consent_flag
      comment: "Indicates whether the person has consented to data sharing — used for privacy compliance and data governance reporting."
    - name: "government_id_type"
      expr: government_id_type
      comment: "Type of government ID provided for identity verification — used for identity verification program analysis."
  measures:
    - name: "total_active_persons"
      expr: COUNT(CASE WHEN person_status = 'Active' THEN person_id END)
      comment: "Total number of active person records. Core customer population KPI — used by Customer Operations to track the active individual customer base."
    - name: "verified_identity_count"
      expr: COUNT(CASE WHEN identity_verification_status = 'Verified' THEN person_id END)
      comment: "Number of persons with verified identities. Measures identity verification program completion — used for fraud risk management and compliance reporting."
    - name: "life_support_person_count"
      expr: COUNT(CASE WHEN life_support_equipment_flag = TRUE THEN person_id END)
      comment: "Number of persons using life-support equipment. Critical public safety KPI — used for shutoff protection compliance, emergency response planning, and regulatory reporting."
    - name: "low_income_eligible_person_count"
      expr: COUNT(CASE WHEN low_income_assistance_eligible_flag = TRUE THEN person_id END)
      comment: "Number of persons eligible for low-income assistance programs. Used for affordability program sizing, grant applications, and equity compliance reporting."
    - name: "senior_citizen_person_count"
      expr: COUNT(CASE WHEN senior_citizen_flag = TRUE THEN person_id END)
      comment: "Number of senior citizen customers. Used for senior assistance program sizing and equity reporting."
    - name: "disability_accommodation_count"
      expr: COUNT(CASE WHEN disability_accommodation_flag = TRUE THEN person_id END)
      comment: "Number of persons requiring disability accommodations. Used for ADA compliance planning and accessible service delivery resource allocation."
    - name: "marketing_consent_count"
      expr: COUNT(CASE WHEN marketing_consent_flag = TRUE THEN person_id END)
      comment: "Number of persons who have consented to marketing communications. Defines the compliant marketing-reachable audience — used by Marketing for campaign sizing."
    - name: "data_sharing_consent_count"
      expr: COUNT(CASE WHEN data_sharing_consent_flag = TRUE THEN person_id END)
      comment: "Number of persons who have consented to data sharing. Used for privacy compliance reporting and data governance program management."
    - name: "autopay_enrolled_person_count"
      expr: COUNT(CASE WHEN autopay_enrollment_flag = TRUE THEN person_id END)
      comment: "Number of persons enrolled in autopay at the individual level. Used to track autopay adoption and its impact on payment delinquency reduction."
    - name: "paperless_billing_person_count"
      expr: COUNT(CASE WHEN paperless_billing_flag = TRUE THEN person_id END)
      comment: "Number of persons enrolled in paperless billing. Tracks digital adoption at the individual level — used to measure progress toward paperless billing cost reduction targets."
$$;