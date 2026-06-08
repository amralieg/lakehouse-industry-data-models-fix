-- Metric views for domain: member | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 18:36:19

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`member_subscriber`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core member subscriber metrics covering enrollment demographics, risk scoring, and population health indicators for strategic member management."
  source: "`health_insurance_ecm`.`member`.`subscriber`"
  dimensions:
    - name: "subscriber_status"
      expr: subscriber_status
      comment: "Current status of the subscriber (active, terminated, suspended, etc.)"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business the subscriber is enrolled in (Commercial, Medicare, Medicaid, etc.)"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage held by the subscriber (medical, dental, vision, etc.)"
    - name: "gender"
      expr: gender
      comment: "Gender of the subscriber for demographic analysis"
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Channel or source through which the subscriber enrolled"
    - name: "language_preference"
      expr: language_preference
      comment: "Preferred language of the subscriber for communication planning"
    - name: "citizenship_status"
      expr: citizenship_status
      comment: "Citizenship status of the subscriber for regulatory compliance"
    - name: "disability_status"
      expr: disability_status
      comment: "Disability status indicator for ADA compliance and care management"
    - name: "tobacco_use_status"
      expr: tobacco_use_status
      comment: "Tobacco use status for wellness program targeting and risk rating"
    - name: "marital_status"
      expr: marital_status
      comment: "Marital status for household and dependent analysis"
    - name: "race_ethnicity"
      expr: race_ethnicity
      comment: "Race/ethnicity for health equity and disparity analysis"
    - name: "is_deceased"
      expr: is_deceased
      comment: "Flag indicating if the subscriber is deceased"
    - name: "veteran_status"
      expr: veteran_status
      comment: "Veteran status for special program eligibility"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the subscriber coverage became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the subscriber coverage became effective"
  measures:
    - name: "total_subscribers"
      expr: COUNT(1)
      comment: "Total count of subscriber records for population sizing and capacity planning"
    - name: "active_subscribers"
      expr: COUNT(CASE WHEN subscriber_status = 'Active' THEN 1 END)
      comment: "Count of currently active subscribers — primary membership KPI"
    - name: "terminated_subscribers"
      expr: COUNT(CASE WHEN subscriber_status = 'Terminated' THEN 1 END)
      comment: "Count of terminated subscribers for attrition tracking"
    - name: "avg_hcc_risk_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average HCC risk score across the subscriber population — key for risk adjustment revenue forecasting"
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor for CMS payment accuracy and revenue optimization"
    - name: "avg_annual_income"
      expr: AVG(CAST(annual_income AS DOUBLE))
      comment: "Average annual income of subscribers for subsidy eligibility and affordability analysis"
    - name: "total_annual_income"
      expr: SUM(CAST(annual_income AS DOUBLE))
      comment: "Total annual income across subscriber base for socioeconomic profiling"
    - name: "deceased_member_count"
      expr: COUNT(CASE WHEN is_deceased = true THEN 1 END)
      comment: "Count of deceased members for mortality tracking and coverage termination processing"
    - name: "tobacco_user_count"
      expr: COUNT(CASE WHEN tobacco_use_status = 'Current' THEN 1 END)
      comment: "Count of current tobacco users for wellness intervention targeting and actuarial risk assessment"
    - name: "veteran_member_count"
      expr: COUNT(CASE WHEN veteran_status = true THEN 1 END)
      comment: "Count of veteran members for VA coordination and special program eligibility"
    - name: "electronic_comm_consent_count"
      expr: COUNT(CASE WHEN consent_to_electronic_communication = true THEN 1 END)
      comment: "Count of subscribers who consented to electronic communications for digital engagement strategy"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`member_eligibility_span`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eligibility span metrics tracking coverage continuity, premium revenue, and enrollment patterns critical for financial forecasting and regulatory compliance."
  source: "`health_insurance_ecm`.`member`.`member_eligibility_span`"
  dimensions:
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Current eligibility status of the span (eligible, ineligible, pending)"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage (medical, dental, vision, pharmacy)"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the eligibility span (Commercial, Medicare, Medicaid)"
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (new, renewal, transfer, COBRA)"
    - name: "subscriber_relationship_code"
      expr: subscriber_relationship_code
      comment: "Relationship of the member to the subscriber (self, spouse, child, etc.)"
    - name: "is_primary_coverage"
      expr: is_primary_coverage
      comment: "Whether this is the member's primary coverage for COB determination"
    - name: "gap_in_coverage_flag"
      expr: gap_in_coverage_flag
      comment: "Flag indicating a gap in coverage continuity — critical for ACA compliance"
    - name: "retroactive_eligibility_flag"
      expr: retroactive_eligibility_flag
      comment: "Flag for retroactive eligibility adjustments impacting claims processing"
    - name: "eligibility_source"
      expr: eligibility_source
      comment: "Source system or process that established eligibility"
    - name: "termination_reason_code"
      expr: termination_reason_code
      comment: "Reason code for eligibility termination for attrition root cause analysis"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the eligibility span became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the eligibility span became effective"
  measures:
    - name: "total_eligibility_spans"
      expr: COUNT(1)
      comment: "Total count of eligibility spans for coverage volume tracking"
    - name: "active_eligibility_spans"
      expr: COUNT(CASE WHEN eligibility_status = 'Active' OR eligibility_status = 'Eligible' THEN 1 END)
      comment: "Count of currently active/eligible spans — core membership metric"
    - name: "total_premium_revenue"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium amount across all eligibility spans — primary revenue metric"
    - name: "avg_premium_per_span"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium per eligibility span for PMPM and pricing analysis"
    - name: "coverage_gap_count"
      expr: COUNT(CASE WHEN gap_in_coverage_flag = true THEN 1 END)
      comment: "Count of spans with coverage gaps — ACA compliance and member experience indicator"
    - name: "retroactive_eligibility_count"
      expr: COUNT(CASE WHEN retroactive_eligibility_flag = true THEN 1 END)
      comment: "Count of retroactive eligibility adjustments impacting claims reprocessing volume"
    - name: "primary_coverage_count"
      expr: COUNT(CASE WHEN is_primary_coverage = true THEN 1 END)
      comment: "Count of primary coverage spans for COB coordination and payment priority"
    - name: "terminated_spans"
      expr: COUNT(CASE WHEN termination_reason_code IS NOT NULL THEN 1 END)
      comment: "Count of terminated eligibility spans for disenrollment trend analysis"
    - name: "distinct_members_covered"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members with eligibility spans — unique lives covered"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`member_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy-level financial metrics covering premiums, deductibles, out-of-pocket maximums, and coverage limits essential for actuarial analysis and financial planning."
  source: "`health_insurance_ecm`.`member`.`policy`"
  dimensions:
    - name: "policy_status"
      expr: policy_status
      comment: "Current status of the policy (active, terminated, pending, lapsed)"
    - name: "policy_type"
      expr: policy_type
      comment: "Type of policy (individual, family, group)"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage provided by the policy (medical, dental, vision)"
    - name: "coverage_status"
      expr: coverage_status
      comment: "Current coverage status within the policy"
    - name: "premium_frequency"
      expr: premium_frequency
      comment: "Frequency of premium payments (monthly, quarterly, annual)"
    - name: "coverage_limit_type"
      expr: coverage_limit_type
      comment: "Type of coverage limit applied to the policy"
    - name: "policy_termination_reason"
      expr: policy_termination_reason
      comment: "Reason for policy termination for retention analysis"
    - name: "policy_renewal_status"
      expr: policy_renewal_status
      comment: "Status of policy renewal for retention forecasting"
    - name: "policy_effective_year"
      expr: YEAR(policy_effective_date)
      comment: "Year the policy became effective"
    - name: "policy_effective_month"
      expr: DATE_TRUNC('month', policy_effective_date)
      comment: "Month the policy became effective"
  measures:
    - name: "total_policies"
      expr: COUNT(1)
      comment: "Total count of policies for book of business sizing"
    - name: "active_policies"
      expr: COUNT(CASE WHEN policy_status = 'Active' THEN 1 END)
      comment: "Count of active policies — core business volume metric"
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium amount across all policies — primary revenue driver"
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium per policy for pricing benchmarking"
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible amounts for member cost-sharing analysis"
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average deductible per policy for benefit design analysis"
    - name: "avg_out_of_pocket_max"
      expr: AVG(CAST(out_of_pocket_max_amount AS DOUBLE))
      comment: "Average out-of-pocket maximum for member financial exposure analysis"
    - name: "total_coverage_limit"
      expr: SUM(CAST(coverage_limit_amount AS DOUBLE))
      comment: "Total coverage limit amounts for risk exposure assessment"
    - name: "total_renewal_premium"
      expr: SUM(CAST(policy_renewal_premium_amount AS DOUBLE))
      comment: "Total renewal premium amounts for revenue forecasting"
    - name: "avg_renewal_premium"
      expr: AVG(CAST(policy_renewal_premium_amount AS DOUBLE))
      comment: "Average renewal premium for rate change analysis"
    - name: "distinct_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct subscribers with policies for unique policyholder count"
    - name: "terminated_policies"
      expr: COUNT(CASE WHEN policy_status = 'Terminated' THEN 1 END)
      comment: "Count of terminated policies for lapse and attrition analysis"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`member_disenrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disenrollment metrics tracking member attrition, refund processing, and termination patterns critical for retention strategy and financial reconciliation."
  source: "`health_insurance_ecm`.`member`.`disenrollment`"
  dimensions:
    - name: "disenrollment_status"
      expr: disenrollment_status
      comment: "Current status of the disenrollment request"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for disenrollment for root cause analysis"
    - name: "termination_type"
      expr: termination_type
      comment: "Type of termination (voluntary, involuntary, administrative)"
    - name: "source"
      expr: source
      comment: "Source of the disenrollment request (member, employer, system)"
    - name: "eligibility_loss_indicator"
      expr: eligibility_loss_indicator
      comment: "Whether disenrollment was due to eligibility loss"
    - name: "cobro_eligibility"
      expr: cobro_eligibility
      comment: "Whether the member is eligible for COBRA continuation"
    - name: "appeal_rights_notified"
      expr: appeal_rights_notified
      comment: "Whether the member was notified of appeal rights — regulatory compliance indicator"
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Year the disenrollment was requested"
    - name: "request_month"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month the disenrollment was requested"
  measures:
    - name: "total_disenrollments"
      expr: COUNT(1)
      comment: "Total count of disenrollment events — primary attrition volume metric"
    - name: "total_refund_gross_amount"
      expr: SUM(CAST(refund_gross_amount AS DOUBLE))
      comment: "Total gross refund amounts from disenrollments for financial reconciliation"
    - name: "total_refund_net_amount"
      expr: SUM(CAST(refund_net_amount AS DOUBLE))
      comment: "Total net refund amounts after adjustments for cash flow impact analysis"
    - name: "total_refund_adjustment_amount"
      expr: SUM(CAST(refund_adjustment_amount AS DOUBLE))
      comment: "Total refund adjustments for financial variance analysis"
    - name: "avg_refund_net_amount"
      expr: AVG(CAST(refund_net_amount AS DOUBLE))
      comment: "Average net refund per disenrollment for financial planning"
    - name: "voluntary_disenrollments"
      expr: COUNT(CASE WHEN termination_type = 'Voluntary' THEN 1 END)
      comment: "Count of voluntary disenrollments — key retention failure indicator"
    - name: "involuntary_disenrollments"
      expr: COUNT(CASE WHEN termination_type = 'Involuntary' THEN 1 END)
      comment: "Count of involuntary disenrollments for compliance and process review"
    - name: "cobra_eligible_disenrollments"
      expr: COUNT(CASE WHEN cobro_eligibility = true THEN 1 END)
      comment: "Count of disenrollments eligible for COBRA continuation coverage"
    - name: "eligibility_loss_disenrollments"
      expr: COUNT(CASE WHEN eligibility_loss_indicator = true THEN 1 END)
      comment: "Count of disenrollments due to eligibility loss for regulatory reporting"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`member_grievance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member grievance metrics tracking complaint volumes, resolution effectiveness, and regulatory compliance — critical for CMS Star Ratings and member satisfaction."
  source: "`health_insurance_ecm`.`member`.`member_grievance`"
  dimensions:
    - name: "member_grievance_status"
      expr: member_grievance_status
      comment: "Current status of the grievance (open, under review, resolved, closed)"
    - name: "issue_category_code"
      expr: issue_category_code
      comment: "Category of the grievance issue for root cause classification"
    - name: "type_code"
      expr: type_code
      comment: "Type of grievance (quality of care, access, billing, etc.)"
    - name: "grievance_source"
      expr: grievance_source
      comment: "Source channel of the grievance (phone, web, mail, in-person)"
    - name: "resolution_type_code"
      expr: resolution_type_code
      comment: "Type of resolution applied to the grievance"
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business associated with the grievance"
    - name: "state_code"
      expr: state_code
      comment: "State where the grievance originated for regulatory jurisdiction"
    - name: "cms_reportable_indicator"
      expr: cms_reportable_indicator
      comment: "Whether the grievance is reportable to CMS — critical for compliance"
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Whether the grievance requires regulatory reporting"
    - name: "received_year"
      expr: YEAR(received_timestamp)
      comment: "Year the grievance was received"
    - name: "received_month"
      expr: DATE_TRUNC('month', received_timestamp)
      comment: "Month the grievance was received"
  measures:
    - name: "total_grievances"
      expr: COUNT(1)
      comment: "Total count of member grievances — primary member satisfaction and quality indicator"
    - name: "open_grievances"
      expr: COUNT(CASE WHEN member_grievance_status = 'Open' OR member_grievance_status = 'Under Review' THEN 1 END)
      comment: "Count of open/in-progress grievances for workload and SLA management"
    - name: "resolved_grievances"
      expr: COUNT(CASE WHEN member_grievance_status = 'Resolved' OR member_grievance_status = 'Closed' THEN 1 END)
      comment: "Count of resolved grievances for resolution rate calculation"
    - name: "cms_reportable_grievances"
      expr: COUNT(CASE WHEN cms_reportable_indicator = true THEN 1 END)
      comment: "Count of CMS-reportable grievances — critical for Star Ratings and regulatory compliance"
    - name: "regulatory_reportable_grievances"
      expr: COUNT(CASE WHEN regulatory_reporting_flag = true THEN 1 END)
      comment: "Count of grievances requiring regulatory reporting for compliance tracking"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total disputed dollar amount across all grievances for financial exposure assessment"
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per grievance for severity benchmarking"
    - name: "distinct_members_with_grievances"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct members who filed grievances for member-level complaint rate analysis"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`member_dependent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dependent metrics tracking dependent population demographics, coverage status, and special eligibility flags critical for benefit design and regulatory compliance."
  source: "`health_insurance_ecm`.`member`.`dependent`"
  dimensions:
    - name: "coverage_status"
      expr: coverage_status
      comment: "Current coverage status of the dependent"
    - name: "relationship_type"
      expr: relationship_type
      comment: "Relationship of the dependent to the subscriber (spouse, child, domestic partner)"
    - name: "gender"
      expr: gender
      comment: "Gender of the dependent for demographic analysis"
    - name: "record_status"
      expr: record_status
      comment: "Record status of the dependent entry"
    - name: "disability_status"
      expr: disability_status
      comment: "Whether the dependent has a disability — impacts age-out rules and coverage continuation"
    - name: "student_status"
      expr: student_status
      comment: "Whether the dependent is a student — impacts age-out eligibility under ACA"
    - name: "age_out_eligibility_flag"
      expr: age_out_eligibility_flag
      comment: "Flag indicating the dependent is approaching age-out for proactive outreach"
    - name: "chip_eligibility_flag"
      expr: chip_eligibility_flag
      comment: "CHIP eligibility flag for government program coordination"
    - name: "medicaid_eligibility_flag"
      expr: medicaid_eligibility_flag
      comment: "Medicaid eligibility flag for dual-eligible coordination"
    - name: "coverage_start_year"
      expr: YEAR(coverage_start_date)
      comment: "Year the dependent coverage started"
  measures:
    - name: "total_dependents"
      expr: COUNT(1)
      comment: "Total count of dependents for covered lives calculation"
    - name: "active_dependents"
      expr: COUNT(CASE WHEN coverage_status = 'Active' THEN 1 END)
      comment: "Count of actively covered dependents — key for total covered lives reporting"
    - name: "age_out_eligible_dependents"
      expr: COUNT(CASE WHEN age_out_eligibility_flag = true THEN 1 END)
      comment: "Count of dependents approaching age-out for proactive retention and transition outreach"
    - name: "disabled_dependents"
      expr: COUNT(CASE WHEN disability_status = true THEN 1 END)
      comment: "Count of dependents with disabilities for special needs program planning"
    - name: "chip_eligible_dependents"
      expr: COUNT(CASE WHEN chip_eligibility_flag = true THEN 1 END)
      comment: "Count of CHIP-eligible dependents for government program coordination"
    - name: "medicaid_eligible_dependents"
      expr: COUNT(CASE WHEN medicaid_eligibility_flag = true THEN 1 END)
      comment: "Count of Medicaid-eligible dependents for dual-eligible program management"
    - name: "student_dependents"
      expr: COUNT(CASE WHEN student_status = true THEN 1 END)
      comment: "Count of student dependents for ACA age-out extension tracking"
    - name: "distinct_subscribers_with_dependents"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct subscribers who have dependents for family coverage analysis"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`member_cobra_continuant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "COBRA continuation coverage metrics tracking election rates, premium collection, and exhaustion patterns for regulatory compliance and revenue management."
  source: "`health_insurance_ecm`.`member`.`cobra_continuant`"
  dimensions:
    - name: "cobra_continuant_status"
      expr: cobra_continuant_status
      comment: "Current status of the COBRA continuation (active, elected, exhausted, terminated)"
    - name: "qualifying_event_type"
      expr: qualifying_event_type
      comment: "Type of qualifying event that triggered COBRA eligibility"
    - name: "cobra_eligibility_indicator"
      expr: cobra_eligibility_indicator
      comment: "Whether the member is eligible for COBRA continuation"
    - name: "premium_payment_status"
      expr: premium_payment_status
      comment: "Status of COBRA premium payment (current, delinquent, paid)"
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of COBRA premium payments"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of COBRA premium payment"
    - name: "member_relationship"
      expr: member_relationship
      comment: "Relationship of the COBRA continuant to the original subscriber"
    - name: "is_exhausted"
      expr: is_exhausted
      comment: "Whether the COBRA coverage period has been exhausted"
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for COBRA termination"
    - name: "cobra_notice_type"
      expr: cobra_notice_type
      comment: "Type of COBRA notice sent for compliance tracking"
    - name: "qualifying_event_year"
      expr: YEAR(qualifying_event_date)
      comment: "Year of the qualifying event"
  measures:
    - name: "total_cobra_continuants"
      expr: COUNT(1)
      comment: "Total count of COBRA continuation records for volume tracking"
    - name: "active_cobra_continuants"
      expr: COUNT(CASE WHEN cobra_continuant_status = 'Active' THEN 1 END)
      comment: "Count of active COBRA continuants for current obligation tracking"
    - name: "total_cobra_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total COBRA premium amounts for revenue tracking"
    - name: "avg_cobra_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average COBRA premium for pricing analysis"
    - name: "elected_cobra_count"
      expr: COUNT(CASE WHEN cobra_continuant_status = 'Elected' OR cobra_continuant_status = 'Active' THEN 1 END)
      comment: "Count of COBRA elections for election rate analysis"
    - name: "exhausted_cobra_count"
      expr: COUNT(CASE WHEN is_exhausted = true THEN 1 END)
      comment: "Count of exhausted COBRA coverages for transition planning"
    - name: "cobra_eligible_count"
      expr: COUNT(CASE WHEN cobra_eligibility_indicator = true THEN 1 END)
      comment: "Count of COBRA-eligible members for compliance and outreach planning"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`member_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level metrics tracking income, subsidy eligibility, risk scoring, and enrollment patterns for ACA compliance and population health management."
  source: "`health_insurance_ecm`.`member`.`household`"
  dimensions:
    - name: "household_status"
      expr: household_status
      comment: "Current status of the household record"
    - name: "household_type"
      expr: household_type
      comment: "Type of household for demographic segmentation"
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Enrollment status of the household"
    - name: "state"
      expr: state
      comment: "State of residence for geographic and regulatory analysis"
    - name: "aca_subsidy_eligible"
      expr: aca_subsidy_eligible
      comment: "Whether the household is eligible for ACA subsidies"
    - name: "medicaid_eligible"
      expr: medicaid_eligible
      comment: "Whether the household is Medicaid-eligible"
    - name: "income_verification_flag"
      expr: income_verification_flag
      comment: "Whether household income has been verified"
    - name: "is_multi_plan"
      expr: is_multi_plan
      comment: "Whether the household has multiple plan enrollments"
    - name: "cobra_coverage_flag"
      expr: cobra_coverage_flag
      comment: "Whether the household has COBRA coverage"
    - name: "language_preference"
      expr: language_preference
      comment: "Preferred language of the household"
    - name: "creation_method"
      expr: creation_method
      comment: "Method by which the household was created"
    - name: "fpl_year"
      expr: fpl_year
      comment: "Federal Poverty Level reference year"
  measures:
    - name: "total_households"
      expr: COUNT(1)
      comment: "Total count of households for population and market sizing"
    - name: "aca_subsidy_eligible_households"
      expr: COUNT(CASE WHEN aca_subsidy_eligible = true THEN 1 END)
      comment: "Count of ACA subsidy-eligible households for exchange and marketplace analysis"
    - name: "medicaid_eligible_households"
      expr: COUNT(CASE WHEN medicaid_eligible = true THEN 1 END)
      comment: "Count of Medicaid-eligible households for government program planning"
    - name: "total_household_income"
      expr: SUM(CAST(total_income AS DOUBLE))
      comment: "Total household income for socioeconomic analysis and subsidy calculations"
    - name: "avg_household_income"
      expr: AVG(CAST(total_income AS DOUBLE))
      comment: "Average household income for affordability and pricing strategy"
    - name: "avg_fpl_percentage"
      expr: AVG(CAST(fpl_percentage AS DOUBLE))
      comment: "Average Federal Poverty Level percentage for subsidy tier analysis"
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy amounts for ACA financial impact analysis"
    - name: "total_tax_credit_amount"
      expr: SUM(CAST(tax_credit_amount AS DOUBLE))
      comment: "Total tax credit amounts for premium assistance tracking"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average household risk score for population health stratification"
    - name: "income_verified_households"
      expr: COUNT(CASE WHEN income_verification_flag = true THEN 1 END)
      comment: "Count of households with verified income for data quality and compliance"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`member_pcp_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PCP assignment metrics tracking provider assignment patterns, panel management, and care continuity — critical for network adequacy and quality of care."
  source: "`health_insurance_ecm`.`member`.`pcp_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the PCP assignment (active, terminated, pending)"
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of PCP assignment (auto-assigned, member-selected, default)"
    - name: "assignment_reason"
      expr: assignment_reason
      comment: "Reason for the PCP assignment or change"
    - name: "change_reason"
      expr: change_reason
      comment: "Reason for PCP change for care continuity analysis"
    - name: "is_current"
      expr: is_current
      comment: "Whether this is the current active PCP assignment"
    - name: "is_primary"
      expr: is_primary
      comment: "Whether this is the primary PCP assignment"
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier of the assigned PCP for tiered network analysis"
    - name: "panel_status"
      expr: panel_status
      comment: "Panel status of the PCP (open, closed, limited)"
    - name: "pcp_specialty_code"
      expr: pcp_specialty_code
      comment: "Specialty code of the assigned PCP"
    - name: "source_system"
      expr: source_system
      comment: "Source system of the assignment record"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the PCP assignment became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the PCP assignment became effective"
  measures:
    - name: "total_pcp_assignments"
      expr: COUNT(1)
      comment: "Total count of PCP assignment records for assignment volume tracking"
    - name: "current_active_assignments"
      expr: COUNT(CASE WHEN is_current = true AND assignment_status = 'Active' THEN 1 END)
      comment: "Count of current active PCP assignments — primary network utilization metric"
    - name: "auto_assigned_count"
      expr: COUNT(CASE WHEN assignment_type = 'Auto' OR assignment_type = 'Auto-Assigned' THEN 1 END)
      comment: "Count of auto-assigned PCPs for assignment algorithm effectiveness analysis"
    - name: "member_selected_count"
      expr: COUNT(CASE WHEN assignment_type = 'Member-Selected' OR assignment_type = 'Member Selected' THEN 1 END)
      comment: "Count of member-selected PCP assignments for member engagement analysis"
    - name: "distinct_members_assigned"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct members with PCP assignments for network adequacy reporting"
    - name: "distinct_pcps_utilized"
      expr: COUNT(DISTINCT pcp_provider_id)
      comment: "Distinct PCPs with member assignments for panel distribution analysis"
    - name: "pcp_changes"
      expr: COUNT(CASE WHEN change_reason IS NOT NULL THEN 1 END)
      comment: "Count of PCP changes for care continuity and member satisfaction analysis"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`member_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member segmentation metrics tracking risk stratification, chronic conditions, and population health segments for care management targeting and Star Ratings optimization."
  source: "`health_insurance_ecm`.`member`.`segment`"
  dimensions:
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment assignment"
    - name: "segment_name"
      expr: segment_name
      comment: "Name of the member segment for population stratification"
    - name: "segment_category"
      expr: segment_category
      comment: "Category of the segment (risk, clinical, behavioral, etc.)"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier classification for care management prioritization"
    - name: "hcc_risk_score_tier"
      expr: hcc_risk_score_tier
      comment: "HCC risk score tier for CMS risk adjustment analysis"
    - name: "chronic_condition_flag"
      expr: chronic_condition_flag
      comment: "Whether the member has chronic conditions"
    - name: "chronic_condition_code"
      expr: chronic_condition_code
      comment: "Specific chronic condition code for disease management targeting"
    - name: "dual_eligible"
      expr: dual_eligible
      comment: "Whether the member is dual-eligible (Medicare/Medicaid)"
    - name: "snp_eligibility"
      expr: snp_eligibility
      comment: "Special Needs Plan eligibility for SNP program management"
    - name: "is_current"
      expr: is_current
      comment: "Whether this is the current active segment assignment"
    - name: "segmentation_source"
      expr: segmentation_source
      comment: "Source of the segmentation model"
    - name: "star_rating_cohort"
      expr: star_rating_cohort
      comment: "Star Rating cohort assignment for quality measure targeting"
  measures:
    - name: "total_segment_assignments"
      expr: COUNT(1)
      comment: "Total count of segment assignments for segmentation coverage tracking"
    - name: "current_segment_assignments"
      expr: COUNT(CASE WHEN is_current = true THEN 1 END)
      comment: "Count of current active segment assignments"
    - name: "chronic_condition_members"
      expr: COUNT(CASE WHEN chronic_condition_flag = true THEN 1 END)
      comment: "Count of members with chronic conditions for disease management program sizing"
    - name: "dual_eligible_members"
      expr: COUNT(CASE WHEN dual_eligible = true THEN 1 END)
      comment: "Count of dual-eligible members for D-SNP and coordination of benefits planning"
    - name: "snp_eligible_members"
      expr: COUNT(CASE WHEN snp_eligibility = true THEN 1 END)
      comment: "Count of SNP-eligible members for special needs program capacity planning"
    - name: "avg_sdoh_risk_score"
      expr: AVG(CAST(sdoh_risk_score AS DOUBLE))
      comment: "Average SDOH risk score for social determinants of health intervention targeting"
    - name: "distinct_segmented_members"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct members with segment assignments for segmentation coverage rate"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`member_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member lifecycle event metrics tracking qualifying life events, special enrollment periods, and regulatory triggers critical for enrollment operations and compliance."
  source: "`health_insurance_ecm`.`member`.`member_lifecycle_event`"
  dimensions:
    - name: "member_lifecycle_event_status"
      expr: member_lifecycle_event_status
      comment: "Current status of the lifecycle event"
    - name: "event_type_code"
      expr: event_type_code
      comment: "Type of lifecycle event (enrollment, disenrollment, transfer, QLE)"
    - name: "event_reason_code"
      expr: event_reason_code
      comment: "Reason code for the lifecycle event"
    - name: "disenrollment_source"
      expr: disenrollment_source
      comment: "Source of disenrollment for attrition channel analysis"
    - name: "disenrollment_reason_code"
      expr: disenrollment_reason_code
      comment: "Specific reason for disenrollment"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the lifecycle event"
    - name: "qualified_life_event_flag"
      expr: qualified_life_event_flag
      comment: "Whether this is a qualified life event triggering special enrollment"
    - name: "special_enrollment_period_flag"
      expr: special_enrollment_period_flag
      comment: "Whether a special enrollment period was triggered"
    - name: "cobra_qualifying_event_flag"
      expr: cobra_qualifying_event_flag
      comment: "Whether this event qualifies for COBRA continuation"
    - name: "medicare_entitlement_flag"
      expr: medicare_entitlement_flag
      comment: "Whether the event involves Medicare entitlement"
    - name: "source_system"
      expr: source_system
      comment: "Source system of the lifecycle event"
    - name: "event_year"
      expr: YEAR(effective_date)
      comment: "Year the lifecycle event became effective"
    - name: "event_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the lifecycle event became effective"
  measures:
    - name: "total_lifecycle_events"
      expr: COUNT(1)
      comment: "Total count of member lifecycle events for operational volume tracking"
    - name: "qualified_life_events"
      expr: COUNT(CASE WHEN qualified_life_event_flag = true THEN 1 END)
      comment: "Count of qualified life events triggering special enrollment periods"
    - name: "special_enrollment_events"
      expr: COUNT(CASE WHEN special_enrollment_period_flag = true THEN 1 END)
      comment: "Count of special enrollment period events for SEP volume management"
    - name: "cobra_qualifying_events"
      expr: COUNT(CASE WHEN cobra_qualifying_event_flag = true THEN 1 END)
      comment: "Count of COBRA qualifying events for continuation coverage obligation tracking"
    - name: "medicare_entitlement_events"
      expr: COUNT(CASE WHEN medicare_entitlement_flag = true THEN 1 END)
      comment: "Count of Medicare entitlement events for aging-in population management"
    - name: "medicaid_eligibility_gain_events"
      expr: COUNT(CASE WHEN medicaid_eligibility_gain_flag = true THEN 1 END)
      comment: "Count of Medicaid eligibility gain events for government program coordination"
    - name: "medicaid_eligibility_loss_events"
      expr: COUNT(CASE WHEN medicaid_eligibility_loss_flag = true THEN 1 END)
      comment: "Count of Medicaid eligibility loss events for coverage transition management"
    - name: "distinct_members_with_events"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct members with lifecycle events for event frequency analysis"
$$;