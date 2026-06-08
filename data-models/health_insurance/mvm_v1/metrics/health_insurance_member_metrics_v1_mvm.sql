-- Metric views for domain: member | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 21:18:32

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`member_subscriber`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core member subscriber metrics tracking enrollment, demographics, and risk profiles for strategic population health management and actuarial analysis."
  source: "`health_insurance_ecm`.`member`.`subscriber`"
  dimensions:
    - name: "subscriber_status"
      expr: subscriber_status
      comment: "Current enrollment status of the subscriber (active, terminated, suspended, etc.)"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Product line (Commercial, Medicare, Medicaid, Exchange, etc.)"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage (Individual, Family, Employee+Spouse, etc.)"
    - name: "gender"
      expr: gender
      comment: "Member gender for demographic segmentation"
    - name: "age_band"
      expr: CASE WHEN YEAR(CURRENT_DATE()) - YEAR(date_of_birth) < 18 THEN 'Under 18' WHEN YEAR(CURRENT_DATE()) - YEAR(date_of_birth) BETWEEN 18 AND 34 THEN '18-34' WHEN YEAR(CURRENT_DATE()) - YEAR(date_of_birth) BETWEEN 35 AND 49 THEN '35-49' WHEN YEAR(CURRENT_DATE()) - YEAR(date_of_birth) BETWEEN 50 AND 64 THEN '50-64' ELSE '65+' END
      comment: "Age cohort for actuarial and product segmentation"
    - name: "risk_tier"
      expr: CASE WHEN hcc_score < 1.0 THEN 'Low Risk' WHEN hcc_score BETWEEN 1.0 AND 2.0 THEN 'Medium Risk' WHEN hcc_score > 2.0 THEN 'High Risk' ELSE 'Unknown' END
      comment: "Risk stratification based on HCC score for care management prioritization"
    - name: "language_preference"
      expr: language_preference
      comment: "Preferred language for member communications and cultural competency"
    - name: "race_ethnicity"
      expr: race_ethnicity
      comment: "Race and ethnicity for health equity analysis and HEDIS reporting"
    - name: "disability_status"
      expr: disability_status
      comment: "Disability status for special needs program eligibility"
    - name: "tobacco_use_status"
      expr: tobacco_use_status
      comment: "Tobacco use indicator for wellness program targeting and premium rating"
    - name: "enrollment_year"
      expr: YEAR(effective_date)
      comment: "Year of initial enrollment for cohort analysis"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of enrollment for seasonal trend analysis"
    - name: "is_deceased"
      expr: is_deceased
      comment: "Deceased indicator for mortality tracking and eligibility termination"
    - name: "veteran_status"
      expr: veteran_status
      comment: "Veteran status for coordination with VA benefits"
  measures:
    - name: "total_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Unique count of subscribers for membership reporting and market share analysis"
    - name: "avg_hcc_risk_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average HCC risk score across population for risk adjustment revenue forecasting and actuarial reserving"
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average RAF for CMS risk adjustment payment calculations and MLR compliance"
    - name: "high_risk_member_count"
      expr: COUNT(DISTINCT CASE WHEN hcc_score > 2.0 THEN subscriber_id END)
      comment: "Count of high-risk members (HCC > 2.0) for care management capacity planning and intervention targeting"
    - name: "high_risk_member_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN hcc_score > 2.0 THEN subscriber_id END) / NULLIF(COUNT(DISTINCT subscriber_id), 0), 2)
      comment: "Percentage of members in high-risk tier for population health strategy and resource allocation"
    - name: "avg_annual_income"
      expr: AVG(CAST(annual_income AS DOUBLE))
      comment: "Average annual income for subsidy eligibility modeling and affordability analysis"
    - name: "medicare_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN medicare_beneficiary_number IS NOT NULL THEN subscriber_id END)
      comment: "Count of Medicare-eligible members for dual-eligible coordination and COB management"
    - name: "medicaid_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN medicaid_number IS NOT NULL THEN subscriber_id END)
      comment: "Count of Medicaid-eligible members for dual-eligible programs and state contract reporting"
    - name: "dual_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN medicare_beneficiary_number IS NOT NULL AND medicaid_number IS NOT NULL THEN subscriber_id END)
      comment: "Count of dual-eligible members for specialized care coordination and integrated care programs"
    - name: "electronic_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_to_electronic_communication = TRUE THEN subscriber_id END) / NULLIF(COUNT(DISTINCT subscriber_id), 0), 2)
      comment: "Percentage of members consenting to electronic communication for digital engagement strategy and cost reduction"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`member_eligibility_span`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member eligibility span metrics tracking coverage continuity, enrollment patterns, and benefit utilization for retention analysis and actuarial experience studies."
  source: "`health_insurance_ecm`.`member`.`member_eligibility_span`"
  dimensions:
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Current eligibility status (active, terminated, suspended, pending)"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Product line for segment-specific retention and utilization analysis"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type (medical, dental, vision, pharmacy) for product mix analysis"
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Enrollment channel (new, renewal, conversion, special enrollment) for acquisition cost analysis"
    - name: "termination_reason_code"
      expr: termination_reason_code
      comment: "Reason for coverage termination for churn root-cause analysis and retention strategy"
    - name: "is_primary_coverage"
      expr: is_primary_coverage
      comment: "Primary vs secondary coverage indicator for COB sequencing and claims adjudication"
    - name: "gap_in_coverage_flag"
      expr: gap_in_coverage_flag
      comment: "Indicator of coverage gap for re-enrollment targeting and continuity of care risk"
    - name: "retroactive_eligibility_flag"
      expr: retroactive_eligibility_flag
      comment: "Retroactive eligibility indicator for claims reprocessing volume forecasting"
    - name: "subscriber_relationship_code"
      expr: subscriber_relationship_code
      comment: "Relationship to subscriber (self, spouse, child, dependent) for family coverage analysis"
    - name: "eligibility_year"
      expr: YEAR(effective_date)
      comment: "Year of eligibility start for cohort retention analysis"
    - name: "eligibility_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of eligibility start for seasonal enrollment pattern analysis"
    - name: "termination_year"
      expr: YEAR(termination_date)
      comment: "Year of termination for churn trend analysis"
  measures:
    - name: "total_eligibility_spans"
      expr: COUNT(member_eligibility_span_id)
      comment: "Total count of eligibility spans for enrollment transaction volume and system capacity planning"
    - name: "unique_members"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Unique member count for membership reporting and market penetration analysis"
    - name: "avg_coverage_duration_days"
      expr: AVG(DATEDIFF(COALESCE(termination_date, CURRENT_DATE()), effective_date))
      comment: "Average coverage duration in days for retention performance and lifetime value modeling"
    - name: "active_coverage_count"
      expr: COUNT(CASE WHEN eligibility_status = 'active' AND termination_date IS NULL THEN member_eligibility_span_id END)
      comment: "Count of currently active coverage spans for member months reporting and premium revenue forecasting"
    - name: "terminated_coverage_count"
      expr: COUNT(CASE WHEN termination_date IS NOT NULL THEN member_eligibility_span_id END)
      comment: "Count of terminated coverage spans for churn volume analysis and retention program ROI"
    - name: "churn_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN termination_date IS NOT NULL THEN member_eligibility_span_id END) / NULLIF(COUNT(member_eligibility_span_id), 0), 2)
      comment: "Percentage of eligibility spans terminated for retention strategy effectiveness and competitive benchmarking"
    - name: "coverage_gap_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gap_in_coverage_flag = TRUE THEN member_eligibility_span_id END) / NULLIF(COUNT(member_eligibility_span_id), 0), 2)
      comment: "Percentage of spans with coverage gaps for continuity of care risk assessment and re-enrollment targeting"
    - name: "retroactive_eligibility_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN retroactive_eligibility_flag = TRUE THEN member_eligibility_span_id END) / NULLIF(COUNT(member_eligibility_span_id), 0), 2)
      comment: "Percentage of spans with retroactive eligibility for claims reprocessing workload forecasting and financial reserve adequacy"
    - name: "primary_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_primary_coverage = TRUE THEN member_eligibility_span_id END) / NULLIF(COUNT(member_eligibility_span_id), 0), 2)
      comment: "Percentage of spans where coverage is primary for COB savings opportunity and claims payment liability"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`member_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy-level metrics tracking premium revenue, coverage limits, renewal performance, and policy lifecycle for financial planning and product profitability analysis."
  source: "`health_insurance_ecm`.`member`.`policy`"
  dimensions:
    - name: "policy_status"
      expr: policy_status
      comment: "Current policy status (active, lapsed, cancelled, expired) for book of business composition"
    - name: "policy_type"
      expr: policy_type
      comment: "Policy type (individual, group, family) for product mix and pricing strategy"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type for product line revenue attribution"
    - name: "coverage_status"
      expr: coverage_status
      comment: "Coverage status for active policy tracking and lapse prevention"
    - name: "premium_frequency"
      expr: premium_frequency
      comment: "Premium payment frequency (monthly, quarterly, annual) for cash flow forecasting"
    - name: "coverage_limit_type"
      expr: coverage_limit_type
      comment: "Type of coverage limit (annual, lifetime, per-incident) for risk exposure analysis"
    - name: "renewal_status"
      expr: renewal_status
      comment: "Renewal status for retention campaign targeting and persistency analysis"
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for policy termination for churn root-cause and competitive intelligence"
    - name: "policy_year"
      expr: YEAR(effective_date)
      comment: "Policy effective year for vintage analysis and cohort profitability"
    - name: "policy_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Policy effective month for seasonal sales pattern analysis"
    - name: "renewal_year"
      expr: YEAR(renewal_date)
      comment: "Renewal year for persistency trend analysis"
  measures:
    - name: "total_policies"
      expr: COUNT(policy_id)
      comment: "Total policy count for book of business size and market share reporting"
    - name: "active_policies"
      expr: COUNT(CASE WHEN policy_status = 'active' THEN policy_id END)
      comment: "Count of active policies for in-force premium revenue and risk exposure"
    - name: "total_premium_revenue"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium revenue for financial performance and budget variance analysis"
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium per policy for pricing competitiveness and product positioning"
    - name: "total_coverage_limit"
      expr: SUM(CAST(coverage_limit_amount AS DOUBLE))
      comment: "Total coverage limit exposure for reinsurance treaty structuring and capital adequacy"
    - name: "avg_coverage_limit"
      expr: AVG(CAST(coverage_limit_amount AS DOUBLE))
      comment: "Average coverage limit per policy for product design and risk appetite alignment"
    - name: "total_renewal_premium"
      expr: SUM(CAST(renewal_premium_amount AS DOUBLE))
      comment: "Total renewal premium for persistency revenue forecasting and retention ROI"
    - name: "avg_renewal_premium"
      expr: AVG(CAST(renewal_premium_amount AS DOUBLE))
      comment: "Average renewal premium for pricing trend analysis and rate adequacy assessment"
    - name: "premium_increase_amount"
      expr: SUM(CAST(renewal_premium_amount AS DOUBLE) - CAST(premium_amount AS DOUBLE))
      comment: "Total premium increase at renewal for rate action effectiveness and member affordability impact"
    - name: "renewal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN renewal_status = 'renewed' THEN policy_id END) / NULLIF(COUNT(CASE WHEN renewal_date IS NOT NULL THEN policy_id END), 0), 2)
      comment: "Percentage of policies renewed for persistency performance and retention strategy effectiveness"
    - name: "lapse_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN policy_status = 'lapsed' THEN policy_id END) / NULLIF(COUNT(policy_id), 0), 2)
      comment: "Percentage of lapsed policies for retention risk and premium leakage quantification"
    - name: "avg_renewal_deductible"
      expr: AVG(CAST(renewal_deductible_amount AS DOUBLE))
      comment: "Average renewal deductible for benefit design trend and member cost-sharing analysis"
    - name: "avg_renewal_oop_max"
      expr: AVG(CAST(renewal_out_of_pocket_max_amount AS DOUBLE))
      comment: "Average renewal out-of-pocket maximum for member financial protection and ACA compliance"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`member_disenrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disenrollment event metrics tracking termination reasons, refund processing, and churn patterns for retention strategy and financial reconciliation."
  source: "`health_insurance_ecm`.`member`.`disenrollment`"
  dimensions:
    - name: "disenrollment_status"
      expr: disenrollment_status
      comment: "Disenrollment processing status (pending, approved, completed, reversed) for operational workflow tracking"
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized termination reason code for churn root-cause analysis and retention targeting"
    - name: "reason_description"
      expr: reason_description
      comment: "Detailed termination reason for qualitative churn analysis and member feedback"
    - name: "termination_type"
      expr: termination_type
      comment: "Type of termination (voluntary, involuntary, death, non-payment) for churn segmentation"
    - name: "source"
      expr: source
      comment: "Disenrollment request source (member, employer, system, regulator) for process improvement"
    - name: "eligibility_loss_indicator"
      expr: eligibility_loss_indicator
      comment: "Indicator of eligibility loss for involuntary churn vs voluntary disenrollment"
    - name: "cobro_eligibility"
      expr: cobro_eligibility
      comment: "COBRA continuation eligibility for post-termination revenue opportunity"
    - name: "appeal_rights_notified"
      expr: appeal_rights_notified
      comment: "Appeal rights notification indicator for regulatory compliance and member satisfaction"
    - name: "disenrollment_year"
      expr: YEAR(request_date)
      comment: "Year of disenrollment request for annual churn trend analysis"
    - name: "disenrollment_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month of disenrollment for seasonal churn pattern identification"
  measures:
    - name: "total_disenrollments"
      expr: COUNT(disenrollment_id)
      comment: "Total disenrollment event count for churn volume tracking and retention program sizing"
    - name: "unique_disenrolled_members"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Unique member count disenrolled for member-level churn rate calculation"
    - name: "total_refund_gross"
      expr: SUM(CAST(refund_gross_amount AS DOUBLE))
      comment: "Total gross refund amount for cash flow impact and premium revenue reversal"
    - name: "total_refund_net"
      expr: SUM(CAST(refund_net_amount AS DOUBLE))
      comment: "Total net refund amount after adjustments for actual cash outflow and liquidity planning"
    - name: "total_refund_adjustment"
      expr: SUM(CAST(refund_adjustment_amount AS DOUBLE))
      comment: "Total refund adjustment amount for premium reconciliation and accounting accuracy"
    - name: "avg_refund_per_disenrollment"
      expr: AVG(CAST(refund_net_amount AS DOUBLE))
      comment: "Average net refund per disenrollment for financial forecasting and reserve adequacy"
    - name: "voluntary_disenrollment_count"
      expr: COUNT(CASE WHEN termination_type = 'voluntary' THEN disenrollment_id END)
      comment: "Count of voluntary terminations for competitive positioning and satisfaction analysis"
    - name: "involuntary_disenrollment_count"
      expr: COUNT(CASE WHEN termination_type = 'involuntary' THEN disenrollment_id END)
      comment: "Count of involuntary terminations for payment collection effectiveness and underwriting quality"
    - name: "voluntary_churn_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN termination_type = 'voluntary' THEN disenrollment_id END) / NULLIF(COUNT(disenrollment_id), 0), 2)
      comment: "Percentage of voluntary terminations for member satisfaction and competitive threat assessment"
    - name: "cobra_eligible_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cobro_eligibility = TRUE THEN disenrollment_id END) / NULLIF(COUNT(disenrollment_id), 0), 2)
      comment: "Percentage of disenrollments eligible for COBRA for continuation revenue opportunity sizing"
    - name: "appeal_notification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_rights_notified = TRUE THEN disenrollment_id END) / NULLIF(COUNT(disenrollment_id), 0), 2)
      comment: "Percentage of disenrollments with appeal rights notified for regulatory compliance and member rights protection"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`member_pcp_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Primary care provider assignment metrics tracking attribution accuracy, panel capacity, and care coordination effectiveness for network steerage and quality improvement."
  source: "`health_insurance_ecm`.`member`.`pcp_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "PCP assignment status (active, pending, terminated) for attribution accuracy and care coordination"
    - name: "assignment_type"
      expr: assignment_type
      comment: "Assignment method (member-selected, auto-assigned, default) for member engagement and steerage effectiveness"
    - name: "is_current"
      expr: is_current
      comment: "Current assignment indicator for active attribution reporting"
    - name: "is_primary"
      expr: is_primary
      comment: "Primary PCP indicator for multi-PCP scenarios and attribution logic"
    - name: "assignment_reason"
      expr: assignment_reason
      comment: "Reason for assignment (new enrollment, member request, provider change) for attribution pattern analysis"
    - name: "change_reason"
      expr: change_reason
      comment: "Reason for PCP change for provider satisfaction and network adequacy assessment"
    - name: "panel_status"
      expr: panel_status
      comment: "Provider panel status (open, closed, limited) for capacity management and access monitoring"
    - name: "pcp_specialty_code"
      expr: pcp_specialty_code
      comment: "PCP specialty for primary care mix and pediatric vs adult attribution"
    - name: "assignment_year"
      expr: YEAR(effective_date)
      comment: "Year of PCP assignment for longitudinal continuity analysis"
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of assignment for seasonal attribution pattern analysis"
  measures:
    - name: "total_pcp_assignments"
      expr: COUNT(pcp_assignment_id)
      comment: "Total PCP assignment count for attribution volume and care coordination capacity"
    - name: "unique_members_with_pcp"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Unique member count with PCP assignment for attribution rate and access to primary care"
    - name: "unique_pcps_assigned"
      expr: COUNT(DISTINCT pcp_provider_id)
      comment: "Unique PCP count with member assignments for panel distribution and network utilization"
    - name: "active_assignments"
      expr: COUNT(CASE WHEN assignment_status = 'active' AND is_current = TRUE THEN pcp_assignment_id END)
      comment: "Count of active current PCP assignments for care coordination and quality measure attribution"
    - name: "avg_panel_size"
      expr: COUNT(CASE WHEN assignment_status = 'active' AND is_current = TRUE THEN pcp_assignment_id END) / NULLIF(COUNT(DISTINCT pcp_provider_id), 0)
      comment: "Average panel size per PCP for capacity planning and provider compensation modeling"
    - name: "member_selected_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN assignment_type = 'member-selected' THEN pcp_assignment_id END) / NULLIF(COUNT(pcp_assignment_id), 0), 2)
      comment: "Percentage of member-selected PCP assignments for member engagement and network steerage effectiveness"
    - name: "auto_assigned_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN assignment_type = 'auto-assigned' THEN pcp_assignment_id END) / NULLIF(COUNT(pcp_assignment_id), 0), 2)
      comment: "Percentage of auto-assigned PCPs for default attribution logic effectiveness and member education opportunity"
    - name: "pcp_change_count"
      expr: COUNT(CASE WHEN change_reason IS NOT NULL THEN pcp_assignment_id END)
      comment: "Count of PCP changes for continuity of care risk and provider satisfaction assessment"
    - name: "pcp_change_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN change_reason IS NOT NULL THEN pcp_assignment_id END) / NULLIF(COUNT(pcp_assignment_id), 0), 2)
      comment: "Percentage of assignments with PCP change for care continuity and network stability"
    - name: "closed_panel_assignment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN panel_status = 'closed' THEN pcp_assignment_id END) / NULLIF(COUNT(pcp_assignment_id), 0), 2)
      comment: "Percentage of assignments to closed panels for network capacity constraint and access risk"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`member_cobra_continuant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "COBRA continuation coverage metrics tracking election rates, premium collection, and exhaustion patterns for post-employment revenue and regulatory compliance."
  source: "`health_insurance_ecm`.`member`.`cobra_continuant`"
  dimensions:
    - name: "cobra_continuant_status"
      expr: cobra_continuant_status
      comment: "COBRA continuation status (active, exhausted, terminated, pending) for book of business composition"
    - name: "cobra_eligibility_reason"
      expr: cobra_eligibility_reason
      comment: "Qualifying event reason (termination, reduction of hours, divorce, death) for eligibility audit and compliance"
    - name: "cobra_notice_type"
      expr: cobra_notice_type
      comment: "Type of COBRA notice sent (initial, election, termination) for regulatory compliance tracking"
    - name: "premium_payment_status"
      expr: premium_payment_status
      comment: "Premium payment status (current, delinquent, grace period) for collection effectiveness and termination risk"
    - name: "payment_method"
      expr: payment_method
      comment: "Premium payment method for operational efficiency and member convenience"
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Premium payment frequency for cash flow forecasting and member affordability"
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for COBRA termination (exhaustion, non-payment, new coverage) for continuation revenue leakage analysis"
    - name: "is_exhausted"
      expr: is_exhausted
      comment: "Maximum coverage period exhausted indicator for natural termination vs early disenrollment"
    - name: "member_relationship"
      expr: member_relationship
      comment: "Relationship to former employee (self, spouse, dependent) for family coverage analysis"
    - name: "election_year"
      expr: YEAR(election_date)
      comment: "Year of COBRA election for take-up rate trend analysis"
    - name: "election_month"
      expr: DATE_TRUNC('MONTH', election_date)
      comment: "Month of COBRA election for seasonal pattern analysis"
  measures:
    - name: "total_cobra_continuants"
      expr: COUNT(cobra_continuant_id)
      comment: "Total COBRA continuant count for post-employment revenue opportunity and regulatory reporting"
    - name: "unique_cobra_members"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Unique member count on COBRA for continuation coverage penetration"
    - name: "total_cobra_premium_revenue"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total COBRA premium revenue for post-employment income stream and financial forecasting"
    - name: "avg_cobra_premium"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average COBRA premium per continuant for pricing adequacy and administrative cost recovery"
    - name: "cobra_election_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN election_date IS NOT NULL THEN cobra_continuant_id END) / NULLIF(COUNT(CASE WHEN cobra_eligibility_indicator = TRUE THEN cobra_continuant_id END), 0), 2)
      comment: "Percentage of eligible individuals electing COBRA for take-up rate benchmarking and revenue forecasting"
    - name: "active_cobra_count"
      expr: COUNT(CASE WHEN cobra_continuant_status = 'active' THEN cobra_continuant_id END)
      comment: "Count of active COBRA continuants for in-force premium revenue and member months"
    - name: "exhausted_cobra_count"
      expr: COUNT(CASE WHEN is_exhausted = TRUE THEN cobra_continuant_id END)
      comment: "Count of exhausted COBRA coverage for natural termination volume and transition support"
    - name: "cobra_exhaustion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_exhausted = TRUE THEN cobra_continuant_id END) / NULLIF(COUNT(cobra_continuant_id), 0), 2)
      comment: "Percentage of COBRA coverage reaching maximum duration for persistency and member retention to individual market"
    - name: "delinquent_premium_count"
      expr: COUNT(CASE WHEN premium_payment_status = 'delinquent' THEN cobra_continuant_id END)
      comment: "Count of delinquent COBRA premium payments for collection risk and termination forecasting"
    - name: "delinquency_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN premium_payment_status = 'delinquent' THEN cobra_continuant_id END) / NULLIF(COUNT(CASE WHEN cobra_continuant_status = 'active' THEN cobra_continuant_id END), 0), 2)
      comment: "Percentage of active COBRA with delinquent premiums for collection effectiveness and bad debt reserve"
    - name: "avg_coverage_duration_months"
      expr: AVG(DATEDIFF(COALESCE(coverage_end_date, CURRENT_DATE()), coverage_start_date) / 30.0)
      comment: "Average COBRA coverage duration in months for persistency analysis and revenue lifetime value"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`member_cob_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coordination of benefits metrics tracking other coverage, payment sequencing, and COB savings for claims cost avoidance and subrogation recovery."
  source: "`health_insurance_ecm`.`member`.`cob_record`"
  dimensions:
    - name: "cob_status"
      expr: cob_status
      comment: "COB record status (active, inactive, pending verification) for claims adjudication accuracy"
    - name: "cob_order"
      expr: cob_order
      comment: "Payment order (primary, secondary, tertiary) for claims payment sequencing and liability determination"
    - name: "policy_type"
      expr: policy_type
      comment: "Other coverage policy type (group, individual, Medicare, Medicaid) for COB rule application"
    - name: "coordination_of_benefits_rule"
      expr: coordination_of_benefits_rule
      comment: "COB rule applied (birthday rule, gender rule, active/inactive) for payment coordination logic"
    - name: "is_msp_compliant"
      expr: is_msp_compliant
      comment: "Medicare Secondary Payer compliance indicator for CMS reporting and audit readiness"
    - name: "is_subrogation_flag"
      expr: is_subrogation_flag
      comment: "Subrogation opportunity flag for recovery potential and legal action prioritization"
    - name: "verification_method"
      expr: verification_method
      comment: "COB verification method (member attestation, data match, provider inquiry) for data quality assessment"
    - name: "cob_year"
      expr: YEAR(effective_date)
      comment: "Year of COB record effective date for dual coverage trend analysis"
  measures:
    - name: "total_cob_records"
      expr: COUNT(cob_record_id)
      comment: "Total COB record count for dual coverage prevalence and claims coordination workload"
    - name: "unique_members_with_cob"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Unique member count with other coverage for COB savings opportunity sizing"
    - name: "active_cob_records"
      expr: COUNT(CASE WHEN cob_status = 'active' THEN cob_record_id END)
      comment: "Count of active COB records for current claims coordination volume and cost avoidance potential"
    - name: "secondary_payer_count"
      expr: COUNT(CASE WHEN cob_order = 'secondary' THEN cob_record_id END)
      comment: "Count of records where plan is secondary payer for claims cost avoidance and payment liability reduction"
    - name: "secondary_payer_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cob_order = 'secondary' THEN cob_record_id END) / NULLIF(COUNT(cob_record_id), 0), 2)
      comment: "Percentage of COB records with secondary payer status for cost avoidance opportunity and claims savings"
    - name: "msp_compliant_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_msp_compliant = TRUE THEN cob_record_id END) / NULLIF(COUNT(cob_record_id), 0), 2)
      comment: "Percentage of COB records MSP compliant for CMS audit readiness and penalty avoidance"
    - name: "subrogation_opportunity_count"
      expr: COUNT(CASE WHEN is_subrogation_flag = TRUE THEN cob_record_id END)
      comment: "Count of COB records with subrogation opportunity for recovery potential and legal resource allocation"
    - name: "subrogation_opportunity_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_subrogation_flag = TRUE THEN cob_record_id END) / NULLIF(COUNT(cob_record_id), 0), 2)
      comment: "Percentage of COB records flagged for subrogation for recovery program ROI and legal action prioritization"
    - name: "birthday_rule_application_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN coordination_of_benefits_rule = 'birthday_rule' THEN cob_record_id END) / NULLIF(COUNT(cob_record_id), 0), 2)
      comment: "Percentage of COB using birthday rule for dependent coverage coordination accuracy"
$$;