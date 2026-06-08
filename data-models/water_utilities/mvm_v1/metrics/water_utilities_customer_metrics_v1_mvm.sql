-- Metric views for domain: customer | Business: Water Utilities | Version: 1 | Generated on: 2026-05-06 01:55:38

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`customer_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for customer service cases — tracks case volume, financial exposure, SLA compliance, and resolution efficiency. Used by Customer Service leadership to manage workload, prioritize escalations, and monitor service quality commitments."
  source: "`water_utilities_ecm`.`customer`.`case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Category of the service case (e.g., billing dispute, service outage, water quality) — primary grouping for case volume analysis."
    - name: "case_status"
      expr: case_status
      comment: "Current lifecycle status of the case (e.g., open, closed, pending) — used to filter active vs. resolved workloads."
    - name: "priority"
      expr: priority
      comment: "Case priority level (e.g., critical, high, medium, low) — drives escalation and resource allocation decisions."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the case was initiated (e.g., phone, web, field) — informs channel investment and self-service strategy."
    - name: "assigned_department"
      expr: assigned_department
      comment: "Department responsible for resolving the case — used for workload distribution and departmental performance reporting."
    - name: "sla_met"
      expr: sla_met
      comment: "Boolean flag indicating whether the case was resolved within the SLA target — key quality indicator."
    - name: "opened_month"
      expr: DATE_TRUNC('MONTH', opened_timestamp)
      comment: "Month the case was opened — enables trend analysis of case intake volume over time."
    - name: "closed_month"
      expr: DATE_TRUNC('MONTH', closed_timestamp)
      comment: "Month the case was closed — used to track resolution throughput trends."
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total number of cases — baseline volume metric for workload and trend analysis."
    - name: "open_cases"
      expr: COUNT(CASE WHEN case_status = 'Open' THEN 1 END)
      comment: "Number of currently open cases — real-time workload indicator for customer service operations."
    - name: "sla_met_cases"
      expr: COUNT(CASE WHEN sla_met = TRUE THEN 1 END)
      comment: "Number of cases resolved within SLA — numerator for SLA compliance rate calculation."
    - name: "closed_cases"
      expr: COUNT(CASE WHEN case_status = 'Closed' THEN 1 END)
      comment: "Number of closed cases — denominator for SLA compliance rate and resolution throughput."
    - name: "total_case_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charge amount across all cases — measures financial exposure and revenue recovery from case-related charges."
    - name: "total_case_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount associated with cases — supports financial reconciliation and regulatory reporting."
    - name: "total_case_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total billed amount (charges + tax) across all cases — key financial KPI for case-related revenue and cost recovery."
    - name: "avg_case_charge_amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge amount per case — benchmarks typical case financial impact and detects anomalies."
    - name: "distinct_customer_accounts_with_cases"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customer accounts with at least one case — measures breadth of service issues across the customer base."
    - name: "high_priority_cases"
      expr: COUNT(CASE WHEN priority IN ('Critical', 'High') THEN 1 END)
      comment: "Number of critical or high-priority cases — executive indicator for urgent service risk requiring immediate attention."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`customer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer engagement and service quality KPIs derived from all customer interactions — tracks contact volume, channel mix, resolution rates, escalations, and satisfaction scores. Used by CX leadership to optimize service delivery and digital channel strategy."
  source: "`water_utilities_ecm`.`customer`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of customer interaction (e.g., inbound call, outbound call, chat, email) — primary dimension for channel analysis."
    - name: "interaction_category"
      expr: interaction_category
      comment: "Business category of the interaction (e.g., billing inquiry, service request, complaint) — drives topic-level analysis."
    - name: "subcategory"
      expr: subcategory
      comment: "Detailed sub-classification of the interaction topic — enables granular drill-down for root-cause analysis."
    - name: "channel"
      expr: channel
      comment: "Communication channel used for the interaction (e.g., phone, IVR, web, mobile app) — key dimension for digital transformation tracking."
    - name: "interaction_status"
      expr: interaction_status
      comment: "Current status of the interaction (e.g., open, resolved, escalated) — tracks resolution pipeline."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the interaction was escalated — used to identify service failure patterns."
    - name: "first_contact_resolution_flag"
      expr: first_contact_resolution_flag
      comment: "Indicates whether the issue was resolved on the first contact — key CX efficiency metric."
    - name: "interaction_month"
      expr: DATE_TRUNC('MONTH', interaction_timestamp)
      comment: "Month of the interaction — enables trend analysis of contact volume and channel mix over time."
    - name: "language_code"
      expr: language_code
      comment: "Language used during the interaction — supports equity and accessibility reporting for multilingual service delivery."
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total number of customer interactions — baseline volume metric for contact center capacity planning."
    - name: "escalated_interactions"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of interactions that were escalated — measures service failure frequency and escalation risk."
    - name: "first_contact_resolved_interactions"
      expr: COUNT(CASE WHEN first_contact_resolution_flag = TRUE THEN 1 END)
      comment: "Number of interactions resolved on first contact — numerator for FCR rate; key CX efficiency KPI."
    - name: "callback_requested_interactions"
      expr: COUNT(CASE WHEN callback_requested_flag = TRUE THEN 1 END)
      comment: "Number of interactions where a callback was requested — measures unmet real-time service demand."
    - name: "survey_completed_interactions"
      expr: COUNT(CASE WHEN survey_completed_flag = TRUE THEN 1 END)
      comment: "Number of interactions where the customer completed a satisfaction survey — measures feedback capture rate."
    - name: "distinct_customers_contacted"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customer accounts that had an interaction — measures reach and engagement breadth."
    - name: "interpreter_required_interactions"
      expr: COUNT(CASE WHEN interpreter_required_flag = TRUE THEN 1 END)
      comment: "Number of interactions requiring language interpretation — informs multilingual staffing and accessibility investment decisions."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`customer_service_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service application processing KPIs — tracks application volume, approval and rejection rates, processing cycle times, deposit and connection fee financials, and SLA adherence. Used by Operations and Customer Service leadership to manage new service onboarding efficiency."
  source: "`water_utilities_ecm`.`customer`.`service_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the service application (e.g., submitted, approved, rejected, withdrawn) — primary lifecycle dimension."
    - name: "application_type"
      expr: application_type
      comment: "Type of service application (e.g., new service, transfer, upgrade) — drives volume analysis by service request type."
    - name: "service_type_requested"
      expr: service_type_requested
      comment: "Type of service requested (e.g., water, wastewater, reclaimed) — aligns application volume to service line planning."
    - name: "service_class_requested"
      expr: service_class_requested
      comment: "Customer class for the requested service (e.g., residential, commercial, industrial) — key segmentation for capacity planning."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the application was submitted (e.g., online, in-person, phone) — informs digital adoption strategy."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the application — used to track expedited processing and SLA compliance."
    - name: "deposit_required_flag"
      expr: deposit_required_flag
      comment: "Indicates whether a deposit was required — used for credit risk and revenue assurance analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month the application was submitted — enables trend analysis of new service demand over time."
    - name: "credit_check_status"
      expr: credit_check_status
      comment: "Status of the credit check performed during application review — used for credit risk segmentation."
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of service applications submitted — baseline volume metric for new customer onboarding demand."
    - name: "approved_applications"
      expr: COUNT(CASE WHEN application_status = 'Approved' THEN 1 END)
      comment: "Number of approved service applications — numerator for approval rate; measures onboarding success."
    - name: "rejected_applications"
      expr: COUNT(CASE WHEN application_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected service applications — tracks denial volume for credit risk and process improvement analysis."
    - name: "withdrawn_applications"
      expr: COUNT(CASE WHEN application_status = 'Withdrawn' THEN 1 END)
      comment: "Number of withdrawn applications — measures customer abandonment rate during the onboarding process."
    - name: "deposit_required_applications"
      expr: COUNT(CASE WHEN deposit_required_flag = TRUE THEN 1 END)
      comment: "Number of applications requiring a deposit — measures credit risk exposure in the new customer pipeline."
    - name: "total_connection_fee_amount"
      expr: SUM(CAST(connection_fee_amount AS DOUBLE))
      comment: "Total connection fees assessed across all applications — measures capital recovery from new service connections."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts collected — measures cash held as security against credit risk in the new customer portfolio."
    - name: "avg_connection_fee_amount"
      expr: AVG(CAST(connection_fee_amount AS DOUBLE))
      comment: "Average connection fee per application — benchmarks fee consistency and identifies outliers."
    - name: "avg_deposit_amount"
      expr: AVG(CAST(deposit_amount AS DOUBLE))
      comment: "Average deposit amount per application — benchmarks deposit levels relative to credit risk policy."
    - name: "distinct_premises_applied"
      expr: COUNT(DISTINCT premise_id)
      comment: "Number of unique premises with service applications — measures geographic expansion of service demand."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`customer_person`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer demographic, consent, and assistance eligibility KPIs — tracks the composition of the customer base by segment, assistance eligibility, life support needs, and digital engagement enrollment. Used by Customer Strategy and Equity teams to ensure equitable service delivery and program targeting."
  source: "`water_utilities_ecm`.`customer`.`person`"
  dimensions:
    - name: "customer_segment"
      expr: customer_segment
      comment: "Business segment of the customer (e.g., residential, commercial, low-income) — primary segmentation for strategic analysis."
    - name: "person_type"
      expr: person_type
      comment: "Classification of the person (e.g., primary account holder, co-applicant, authorized user) — used for relationship analysis."
    - name: "person_status"
      expr: person_status
      comment: "Current status of the person record (e.g., active, inactive, deceased) — used to filter active customer population."
    - name: "language_preference"
      expr: language_preference
      comment: "Preferred language of the customer — informs multilingual service delivery and communication strategy."
    - name: "paperless_billing_flag"
      expr: paperless_billing_flag
      comment: "Indicates enrollment in paperless billing — measures digital adoption and operational cost reduction."
    - name: "autopay_enrollment_flag"
      expr: autopay_enrollment_flag
      comment: "Indicates enrollment in autopay — measures payment automation adoption and revenue predictability."
    - name: "low_income_assistance_eligible_flag"
      expr: low_income_assistance_eligible_flag
      comment: "Indicates eligibility for low-income assistance programs — key equity and affordability program targeting dimension."
    - name: "senior_citizen_flag"
      expr: senior_citizen_flag
      comment: "Indicates whether the customer is a senior citizen — used for targeted assistance program eligibility and equity reporting."
    - name: "life_support_equipment_flag"
      expr: life_support_equipment_flag
      comment: "Indicates whether the customer uses life-support equipment — critical for service interruption risk management and regulatory compliance."
    - name: "identity_verification_status"
      expr: identity_verification_status
      comment: "Status of identity verification (e.g., verified, pending, failed) — used for fraud risk and compliance monitoring."
  measures:
    - name: "total_persons"
      expr: COUNT(1)
      comment: "Total number of person records — baseline count of the customer population."
    - name: "paperless_billing_enrolled"
      expr: COUNT(CASE WHEN paperless_billing_flag = TRUE THEN 1 END)
      comment: "Number of customers enrolled in paperless billing — measures digital adoption progress and operational cost savings potential."
    - name: "autopay_enrolled"
      expr: COUNT(CASE WHEN autopay_enrollment_flag = TRUE THEN 1 END)
      comment: "Number of customers enrolled in autopay — measures payment automation adoption and its impact on collection efficiency."
    - name: "low_income_assistance_eligible"
      expr: COUNT(CASE WHEN low_income_assistance_eligible_flag = TRUE THEN 1 END)
      comment: "Number of customers eligible for low-income assistance — measures the scale of affordability program demand."
    - name: "life_support_customers"
      expr: COUNT(CASE WHEN life_support_equipment_flag = TRUE THEN 1 END)
      comment: "Number of customers with life-support equipment — critical safety metric for service interruption planning and regulatory compliance."
    - name: "senior_citizen_customers"
      expr: COUNT(CASE WHEN senior_citizen_flag = TRUE THEN 1 END)
      comment: "Number of senior citizen customers — used for targeted assistance program sizing and equity reporting."
    - name: "disability_accommodation_customers"
      expr: COUNT(CASE WHEN disability_accommodation_flag = TRUE THEN 1 END)
      comment: "Number of customers requiring disability accommodations — informs accessibility investment and ADA compliance reporting."
    - name: "marketing_consent_customers"
      expr: COUNT(CASE WHEN marketing_consent_flag = TRUE THEN 1 END)
      comment: "Number of customers who have provided marketing consent — defines the addressable audience for customer engagement campaigns."
    - name: "identity_verified_customers"
      expr: COUNT(CASE WHEN identity_verification_status = 'Verified' THEN 1 END)
      comment: "Number of customers with verified identity — measures compliance with identity verification requirements and fraud risk exposure."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`customer_premise`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Infrastructure and service capacity KPIs at the premise level — tracks service availability, demand estimates, infrastructure characteristics, and assistance eligibility across the service territory. Used by Operations, Planning, and Engineering to manage capacity and prioritize infrastructure investment."
  source: "`water_utilities_ecm`.`customer`.`premise`"
  dimensions:
    - name: "premise_type"
      expr: premise_type
      comment: "Type of premise (e.g., residential, commercial, industrial, multi-family) — primary segmentation for demand and capacity planning."
    - name: "premise_status"
      expr: premise_status
      comment: "Current status of the premise (e.g., active, inactive, pending) — used to filter the active service footprint."
    - name: "zoning_classification"
      expr: zoning_classification
      comment: "Zoning classification of the premise — aligns service planning with land use and development patterns."
    - name: "pressure_zone"
      expr: pressure_zone
      comment: "Hydraulic pressure zone serving the premise — critical for distribution system capacity and pressure management analysis."
    - name: "service_line_material"
      expr: service_line_material
      comment: "Material of the service line (e.g., copper, lead, PVC) — critical for LCRR compliance and lead service line replacement program tracking."
    - name: "water_service_available_flag"
      expr: water_service_available_flag
      comment: "Indicates whether water service is available at the premise — used for service territory coverage analysis."
    - name: "wastewater_service_available_flag"
      expr: wastewater_service_available_flag
      comment: "Indicates whether wastewater service is available at the premise — used for sewer service coverage analysis."
    - name: "low_income_assistance_eligible_flag"
      expr: low_income_assistance_eligible_flag
      comment: "Indicates whether the premise is eligible for low-income assistance — used for affordability program targeting."
    - name: "backflow_prevention_required_flag"
      expr: backflow_prevention_required_flag
      comment: "Indicates whether backflow prevention is required — used for cross-connection control compliance tracking."
  measures:
    - name: "total_premises"
      expr: COUNT(1)
      comment: "Total number of premises in the service territory — baseline count for service footprint and capacity planning."
    - name: "active_premises"
      expr: COUNT(CASE WHEN premise_status = 'Active' THEN 1 END)
      comment: "Number of currently active premises — measures the live service footprint for operational planning."
    - name: "total_estimated_daily_demand_gallons"
      expr: SUM(CAST(estimated_daily_demand_gallons AS DOUBLE))
      comment: "Total estimated daily water demand across all premises in gallons — critical capacity planning KPI for supply and distribution management."
    - name: "avg_estimated_daily_demand_gallons"
      expr: AVG(CAST(estimated_daily_demand_gallons AS DOUBLE))
      comment: "Average estimated daily demand per premise in gallons — benchmarks per-premise consumption for demand forecasting."
    - name: "total_peak_demand_gpm"
      expr: SUM(CAST(peak_demand_gpm AS DOUBLE))
      comment: "Total peak demand in gallons per minute across all premises — used for hydraulic capacity and fire flow adequacy analysis."
    - name: "premises_with_lead_service_lines"
      expr: COUNT(CASE WHEN service_line_material = 'Lead' THEN 1 END)
      comment: "Number of premises with lead service lines — critical LCRR compliance KPI driving lead service line replacement program prioritization."
    - name: "premises_requiring_backflow_prevention"
      expr: COUNT(CASE WHEN backflow_prevention_required_flag = TRUE THEN 1 END)
      comment: "Number of premises requiring backflow prevention devices — measures cross-connection control compliance workload."
    - name: "low_income_eligible_premises"
      expr: COUNT(CASE WHEN low_income_assistance_eligible_flag = TRUE THEN 1 END)
      comment: "Number of premises eligible for low-income assistance — measures the scale of affordability program demand across the service territory."
    - name: "total_building_square_footage"
      expr: SUM(CAST(building_square_footage AS DOUBLE))
      comment: "Total building square footage across all premises — proxy for service demand scale and infrastructure sizing."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`customer_organization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commercial and industrial customer account KPIs — tracks account portfolio health, credit exposure, digital enrollment, and industrial user classification. Used by Commercial Services and Finance leadership to manage the non-residential customer portfolio."
  source: "`water_utilities_ecm`.`customer`.`organization`"
  dimensions:
    - name: "organization_type"
      expr: organization_type
      comment: "Type of organization (e.g., commercial, industrial, government, non-profit) — primary segmentation for portfolio analysis."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Business segment assigned to the organization — used for strategic account management and revenue analysis."
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account (e.g., active, inactive, suspended) — used to filter the active commercial portfolio."
    - name: "credit_tier"
      expr: credit_tier
      comment: "Credit tier assigned to the organization — used for credit risk segmentation and deposit policy decisions."
    - name: "industrial_user_flag"
      expr: industrial_user_flag
      comment: "Indicates whether the organization is classified as an industrial user — drives pretreatment compliance and permit tracking."
    - name: "industrial_user_classification"
      expr: industrial_user_classification
      comment: "Specific industrial user classification (e.g., significant industrial user, categorical) — used for pretreatment program management."
    - name: "paperless_billing_flag"
      expr: paperless_billing_flag
      comment: "Indicates enrollment in paperless billing — measures digital adoption among commercial accounts."
    - name: "auto_pay_enrolled_flag"
      expr: auto_pay_enrolled_flag
      comment: "Indicates enrollment in autopay — measures payment automation adoption and collection efficiency."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Indicates whether the organization is tax-exempt — used for billing accuracy and revenue reporting."
    - name: "account_opened_month"
      expr: DATE_TRUNC('MONTH', account_opened_date)
      comment: "Month the account was opened — enables cohort analysis of commercial account acquisition trends."
  measures:
    - name: "total_organizations"
      expr: COUNT(1)
      comment: "Total number of organization accounts — baseline count of the commercial and industrial customer portfolio."
    - name: "active_organizations"
      expr: COUNT(CASE WHEN account_status = 'Active' THEN 1 END)
      comment: "Number of active organization accounts — measures the live commercial customer base."
    - name: "industrial_user_accounts"
      expr: COUNT(CASE WHEN industrial_user_flag = TRUE THEN 1 END)
      comment: "Number of industrial user accounts — measures the scale of the pretreatment compliance program portfolio."
    - name: "total_credit_limit_amount"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across all organization accounts — measures aggregate credit exposure in the commercial portfolio."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposits held from organization accounts — measures cash security held against commercial credit risk."
    - name: "avg_credit_limit_amount"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per organization account — benchmarks credit policy consistency across the commercial portfolio."
    - name: "deposit_required_organizations"
      expr: COUNT(CASE WHEN deposit_required_flag = TRUE THEN 1 END)
      comment: "Number of organizations required to pay a deposit — measures credit risk concentration in the commercial portfolio."
    - name: "paperless_billing_enrolled_organizations"
      expr: COUNT(CASE WHEN paperless_billing_flag = TRUE THEN 1 END)
      comment: "Number of commercial accounts enrolled in paperless billing — measures digital adoption and billing cost reduction."
    - name: "autopay_enrolled_organizations"
      expr: COUNT(CASE WHEN auto_pay_enrolled_flag = TRUE THEN 1 END)
      comment: "Number of commercial accounts enrolled in autopay — measures payment automation adoption and its impact on DSO."
$$;