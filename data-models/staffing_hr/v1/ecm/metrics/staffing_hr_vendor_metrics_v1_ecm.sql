-- Metric views for domain: vendor | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 15:43:14

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`vendor_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core supplier performance and compliance metrics tracking vendor quality, risk, and relationship health"
  source: "`staffing_hr_ecm`.`vendor`.`supplier`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Unique identifier for the supplier"
    - name: "legal_name"
      expr: legal_name
      comment: "Legal registered name of the supplier"
    - name: "trade_name"
      expr: trade_name
      comment: "Trading or doing-business-as name"
    - name: "business_type"
      expr: business_type
      comment: "Classification of business entity type"
    - name: "diversity_certifications"
      expr: diversity_certifications
      comment: "Diversity certification categories held by supplier"
    - name: "preferred_supplier_flag"
      expr: preferred_supplier
      comment: "Whether supplier has preferred status"
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current onboarding lifecycle stage"
    - name: "vms_enrollment_status"
      expr: vms_enrollment_status
      comment: "VMS system enrollment status"
    - name: "msa_status"
      expr: msa_status
      comment: "Master service agreement status"
    - name: "ic_compliance_vendor"
      expr: ic_compliance_vendor
      comment: "Independent contractor compliance vendor used"
    - name: "ic_risk_score"
      expr: ic_risk_score
      comment: "Independent contractor risk classification"
    - name: "hq_country"
      expr: hq_country
      comment: "Headquarters country location"
    - name: "hq_state"
      expr: hq_state
      comment: "Headquarters state or province"
    - name: "operational_regions"
      expr: operational_regions
      comment: "Geographic regions where supplier operates"
    - name: "tax_classification"
      expr: tax_classification
      comment: "Tax entity classification"
    - name: "naics_code"
      expr: naics_code
      comment: "North American Industry Classification System code"
  measures:
    - name: "total_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Total unique suppliers in the vendor network"
    - name: "avg_performance_score"
      expr: AVG(CAST(performance_score AS DOUBLE))
      comment: "Average supplier performance score across all rated suppliers"
    - name: "avg_fall_off_rate"
      expr: AVG(CAST(fall_off_rate AS DOUBLE))
      comment: "Average candidate fall-off rate across suppliers, indicating placement quality"
    - name: "preferred_supplier_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN preferred_supplier = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers with preferred status, indicating strategic partnership depth"
    - name: "ic_compliance_enrollment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ic_compliance_enrolled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers enrolled in IC compliance programs, measuring risk mitigation coverage"
    - name: "diversity_certified_supplier_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN diversity_certifications IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers with diversity certifications, tracking supplier diversity program effectiveness"
    - name: "msa_active_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN msa_status = 'Active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers with active master service agreements, indicating contractual readiness"
    - name: "nda_execution_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN nda_executed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers with executed NDAs, measuring legal compliance coverage"
    - name: "insurance_verified_supplier_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN insurance_verified_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers with verified insurance, tracking risk management compliance"
    - name: "avg_insurance_gl_limit"
      expr: AVG(CAST(insurance_gl_limit AS DOUBLE))
      comment: "Average general liability insurance coverage limit across suppliers"
    - name: "avg_insurance_wc_limit"
      expr: AVG(CAST(insurance_wc_limit AS DOUBLE))
      comment: "Average workers compensation insurance coverage limit across suppliers"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`vendor_performance_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance evaluation metrics tracking quality, speed, compliance, and client satisfaction across evaluation periods"
  source: "`staffing_hr_ecm`.`vendor`.`performance_scorecard`"
  dimensions:
    - name: "performance_scorecard_id"
      expr: performance_scorecard_id
      comment: "Unique identifier for the performance scorecard"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier being evaluated"
    - name: "client_account_id"
      expr: client_account_id
      comment: "Client account for which performance is measured"
    - name: "evaluation_period_type"
      expr: evaluation_period_type
      comment: "Type of evaluation period (monthly, quarterly, annual)"
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Current status of the scorecard (draft, finalized, disputed)"
    - name: "overall_score_grade"
      expr: overall_score_grade
      comment: "Letter grade or classification of overall performance"
    - name: "vendor_tier"
      expr: vendor_tier
      comment: "Supplier tier classification based on performance"
    - name: "recommended_tier"
      expr: recommended_tier
      comment: "Recommended tier based on evaluation results"
    - name: "tier_change_recommended_flag"
      expr: tier_change_recommended
      comment: "Whether a tier change is recommended"
    - name: "improvement_plan_required_flag"
      expr: improvement_plan_required
      comment: "Whether supplier requires performance improvement plan"
    - name: "evaluation_year"
      expr: YEAR(evaluation_period_start_date)
      comment: "Year of evaluation period start"
    - name: "evaluation_quarter"
      expr: QUARTER(evaluation_period_start_date)
      comment: "Quarter of evaluation period start"
    - name: "evaluation_month"
      expr: MONTH(evaluation_period_start_date)
      comment: "Month of evaluation period start"
  measures:
    - name: "total_scorecards"
      expr: COUNT(DISTINCT performance_scorecard_id)
      comment: "Total number of performance scorecards evaluated"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall performance score across all evaluations"
    - name: "avg_compliance_rate"
      expr: AVG(CAST(compliance_rate AS DOUBLE))
      comment: "Average compliance rate across suppliers, measuring adherence to policies and regulations"
    - name: "avg_fill_rate"
      expr: AVG(CAST(job_order_fill_rate AS DOUBLE))
      comment: "Average job order fill rate, measuring supplier ability to successfully place candidates"
    - name: "avg_time_to_fill_days"
      expr: AVG(CAST(ttf_avg_days AS DOUBLE))
      comment: "Average time to fill positions in days, measuring supplier speed and efficiency"
    - name: "avg_fall_off_rate"
      expr: AVG(CAST(fall_off_rate AS DOUBLE))
      comment: "Average candidate fall-off rate, measuring placement quality and candidate retention"
    - name: "avg_submittal_to_interview_ratio"
      expr: AVG(CAST(submittal_to_interview_ratio AS DOUBLE))
      comment: "Average ratio of submittals to interviews, measuring candidate quality and relevance"
    - name: "avg_interview_to_offer_ratio"
      expr: AVG(CAST(interview_to_offer_ratio AS DOUBLE))
      comment: "Average ratio of interviews to offers, measuring candidate fit and client satisfaction"
    - name: "avg_offer_to_start_ratio"
      expr: AVG(CAST(offer_to_start_ratio AS DOUBLE))
      comment: "Average ratio of offers to actual starts, measuring conversion effectiveness"
    - name: "avg_client_satisfaction_rating"
      expr: AVG(CAST(client_satisfaction_rating AS DOUBLE))
      comment: "Average client satisfaction rating, measuring overall client experience with supplier"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score, measuring client likelihood to recommend supplier"
    - name: "avg_sla_compliance_score"
      expr: AVG(CAST(sla_compliance_score AS DOUBLE))
      comment: "Average SLA compliance score, measuring adherence to service level agreements"
    - name: "avg_on_time_submittal_rate"
      expr: AVG(CAST(on_time_submittal_rate AS DOUBLE))
      comment: "Average on-time submittal rate, measuring supplier responsiveness and timeliness"
    - name: "improvement_plan_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN improvement_plan_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scorecards requiring improvement plans, indicating supplier performance issues"
    - name: "tier_change_recommendation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN tier_change_recommended = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scorecards recommending tier changes, measuring performance volatility"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`vendor_program_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier program allocation metrics tracking distribution, compliance, and performance targets across client programs"
  source: "`staffing_hr_ecm`.`vendor`.`program_allocation`"
  dimensions:
    - name: "program_allocation_id"
      expr: program_allocation_id
      comment: "Unique identifier for the program allocation"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier allocated to the program"
    - name: "client_account_id"
      expr: client_account_id
      comment: "Client account for the allocation"
    - name: "vms_program_id"
      expr: vms_program_id
      comment: "VMS program identifier"
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the allocation (active, suspended, expired)"
    - name: "vendor_tier"
      expr: vendor_tier
      comment: "Supplier tier classification within the program"
    - name: "job_category"
      expr: job_category
      comment: "Job category or skill area for the allocation"
    - name: "worker_type"
      expr: worker_type
      comment: "Type of worker covered by allocation (W2, 1099, SOW)"
    - name: "program_type"
      expr: program_type
      comment: "Type of program (MSP, VMS, direct)"
    - name: "exclusive_category_flag"
      expr: exclusive_category
      comment: "Whether supplier has exclusive rights to this category"
    - name: "ic_eligible_flag"
      expr: ic_eligible
      comment: "Whether independent contractors are eligible"
    - name: "compliance_verified_flag"
      expr: compliance_verified
      comment: "Whether compliance has been verified for this allocation"
    - name: "auto_distribute_flag"
      expr: auto_distribute
      comment: "Whether requisitions are auto-distributed to this supplier"
    - name: "allocation_year"
      expr: YEAR(effective_date)
      comment: "Year allocation became effective"
    - name: "allocation_quarter"
      expr: QUARTER(effective_date)
      comment: "Quarter allocation became effective"
  measures:
    - name: "total_allocations"
      expr: COUNT(DISTINCT program_allocation_id)
      comment: "Total number of program allocations"
    - name: "active_allocations"
      expr: SUM(CASE WHEN allocation_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of currently active allocations"
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_pct AS DOUBLE))
      comment: "Average allocation percentage across all program allocations"
    - name: "total_allocation_percentage"
      expr: SUM(CAST(allocation_pct AS DOUBLE))
      comment: "Sum of allocation percentages, useful for validating allocation distribution"
    - name: "avg_max_markup_percentage"
      expr: AVG(CAST(max_markup_pct AS DOUBLE))
      comment: "Average maximum markup percentage allowed across allocations"
    - name: "avg_min_fill_rate_target"
      expr: AVG(CAST(min_fill_rate_pct AS DOUBLE))
      comment: "Average minimum fill rate target, measuring performance expectations"
    - name: "avg_max_bill_rate"
      expr: AVG(CAST(max_bill_rate AS DOUBLE))
      comment: "Average maximum bill rate across allocations"
    - name: "avg_max_pay_rate"
      expr: AVG(CAST(max_pay_rate AS DOUBLE))
      comment: "Average maximum pay rate across allocations"
    - name: "compliance_verified_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_verified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations with verified compliance, measuring risk management coverage"
    - name: "exclusive_category_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN exclusive_category = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations with exclusive category rights, indicating strategic partnerships"
    - name: "auto_distribute_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_distribute = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations with auto-distribution enabled, measuring automation adoption"
    - name: "ic_eligible_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ic_eligible = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations allowing independent contractors, tracking workforce flexibility"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`vendor_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor compliance and insurance tracking metrics measuring risk management, document currency, and regulatory adherence"
  source: "`staffing_hr_ecm`.`vendor`.`vendor_compliance`"
  dimensions:
    - name: "vendor_compliance_id"
      expr: vendor_compliance_id
      comment: "Unique identifier for the compliance record"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier subject to compliance requirement"
    - name: "compliance_category"
      expr: compliance_category
      comment: "Category of compliance requirement"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (compliant, expired, pending)"
    - name: "insurance_type"
      expr: insurance_type
      comment: "Type of insurance coverage"
    - name: "is_insurance_record_flag"
      expr: is_insurance_record
      comment: "Whether this is an insurance-related compliance record"
    - name: "required_document_type"
      expr: required_document_type
      comment: "Type of document required for compliance"
    - name: "coverage_limit_type"
      expr: coverage_limit_type
      comment: "Type of coverage limit (per occurrence, aggregate)"
    - name: "additional_insured_flag"
      expr: additional_insured
      comment: "Whether client is named as additional insured"
    - name: "auto_renewal_flag"
      expr: auto_renewal
      comment: "Whether policy has auto-renewal"
    - name: "alert_triggered_flag"
      expr: alert_triggered
      comment: "Whether expiration alert has been triggered"
    - name: "compliance_year"
      expr: YEAR(document_effective_date)
      comment: "Year of document effective date"
  measures:
    - name: "total_compliance_records"
      expr: COUNT(DISTINCT vendor_compliance_id)
      comment: "Total number of vendor compliance records tracked"
    - name: "compliant_records"
      expr: SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END)
      comment: "Number of records in compliant status"
    - name: "compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance records in compliant status, measuring overall compliance health"
    - name: "insurance_records"
      expr: SUM(CASE WHEN is_insurance_record = TRUE THEN 1 ELSE 0 END)
      comment: "Number of insurance-related compliance records"
    - name: "avg_coverage_limit"
      expr: AVG(CAST(coverage_limit_amount AS DOUBLE))
      comment: "Average insurance coverage limit amount across all policies"
    - name: "total_coverage_limit"
      expr: SUM(CAST(coverage_limit_amount AS DOUBLE))
      comment: "Total insurance coverage limit across all policies"
    - name: "additional_insured_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN additional_insured = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of insurance policies naming client as additional insured, measuring risk transfer effectiveness"
    - name: "auto_renewal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_renewal = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of policies with auto-renewal, reducing administrative burden"
    - name: "alert_triggered_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN alert_triggered = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of records with expiration alerts triggered, indicating proactive monitoring"
    - name: "expired_compliance_records"
      expr: SUM(CASE WHEN compliance_status = 'Expired' THEN 1 ELSE 0 END)
      comment: "Number of expired compliance records requiring immediate attention"
    - name: "expiration_risk_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status IN ('Expired', 'Expiring Soon') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance records expired or expiring soon, measuring compliance risk exposure"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`vendor_vms_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "VMS enrollment and onboarding metrics tracking supplier activation, compliance readiness, and program participation"
  source: "`staffing_hr_ecm`.`vendor`.`vms_enrollment`"
  dimensions:
    - name: "vms_enrollment_id"
      expr: vms_enrollment_id
      comment: "Unique identifier for the VMS enrollment"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier being enrolled"
    - name: "client_account_id"
      expr: client_account_id
      comment: "Client account for enrollment"
    - name: "vms_program_id"
      expr: vms_program_id
      comment: "VMS program identifier"
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (active, pending, suspended, terminated)"
    - name: "vendor_tier"
      expr: vendor_tier
      comment: "Supplier tier classification within VMS program"
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of vendor (staffing, SOW, IC)"
    - name: "compliance_attestation_status"
      expr: compliance_attestation_status
      comment: "Status of compliance attestation"
    - name: "contract_execution_status"
      expr: contract_execution_status
      comment: "Status of contract execution"
    - name: "document_submission_status"
      expr: document_submission_status
      comment: "Status of required document submission"
    - name: "insurance_verification_status"
      expr: insurance_verification_status
      comment: "Status of insurance verification"
    - name: "training_completion_status"
      expr: training_completion_status
      comment: "Status of required training completion"
    - name: "system_access_status"
      expr: system_access_status
      comment: "Status of VMS system access provisioning"
    - name: "portal_credentials_status"
      expr: portal_credentials_status
      comment: "Status of portal credential setup"
    - name: "electronic_onboarding_complete_flag"
      expr: electronic_onboarding_complete
      comment: "Whether electronic onboarding is complete"
    - name: "nda_executed_flag"
      expr: nda_executed
      comment: "Whether NDA has been executed"
    - name: "w9_on_file_flag"
      expr: w9_on_file
      comment: "Whether W9 tax form is on file"
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of enrollment"
    - name: "enrollment_quarter"
      expr: QUARTER(enrollment_date)
      comment: "Quarter of enrollment"
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT vms_enrollment_id)
      comment: "Total number of VMS enrollments"
    - name: "active_enrollments"
      expr: SUM(CASE WHEN enrollment_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of currently active VMS enrollments"
    - name: "enrollment_activation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN enrollment_status = 'Active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments in active status, measuring program participation effectiveness"
    - name: "electronic_onboarding_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN electronic_onboarding_complete = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments with completed electronic onboarding, measuring process efficiency"
    - name: "nda_execution_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN nda_executed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments with executed NDAs, measuring legal compliance"
    - name: "w9_on_file_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN w9_on_file = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments with W9 on file, measuring tax compliance readiness"
    - name: "compliance_attestation_complete_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_attestation_status = 'Complete' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments with completed compliance attestation, measuring regulatory readiness"
    - name: "contract_execution_complete_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN contract_execution_status = 'Complete' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments with completed contract execution, measuring contractual readiness"
    - name: "insurance_verified_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN insurance_verification_status = 'Verified' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments with verified insurance, measuring risk management compliance"
    - name: "training_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN training_completion_status = 'Complete' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments with completed training, measuring supplier readiness"
    - name: "system_access_provisioned_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN system_access_status = 'Provisioned' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments with provisioned system access, measuring operational readiness"
    - name: "suspended_enrollment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN enrollment_status = 'Suspended' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments in suspended status, indicating performance or compliance issues"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`vendor_diversity_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Diversity certification metrics tracking supplier diversity program coverage, compliance, and spend eligibility"
  source: "`staffing_hr_ecm`.`vendor`.`diversity_certification`"
  dimensions:
    - name: "diversity_certification_id"
      expr: diversity_certification_id
      comment: "Unique identifier for the diversity certification"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier holding the certification"
    - name: "certification_type"
      expr: certification_type
      comment: "Type of diversity certification (MBE, WBE, SDVOSB, etc.)"
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of certification (active, expired, pending)"
    - name: "certifying_body"
      expr: certifying_body
      comment: "Organization that issued the certification"
    - name: "certifying_body_region"
      expr: certifying_body_region
      comment: "Geographic region of certifying body"
    - name: "diversity_spend_category"
      expr: diversity_spend_category
      comment: "Spend category for diversity reporting"
    - name: "minority_group"
      expr: minority_group
      comment: "Minority group classification"
    - name: "small_business_flag"
      expr: small_business_flag
      comment: "Whether certified as small business"
    - name: "client_reportable_flag"
      expr: client_reportable_flag
      comment: "Whether certification is reportable to client"
    - name: "ofccp_reportable_flag"
      expr: ofccp_reportable_flag
      comment: "Whether certification is OFCCP reportable"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether certification has auto-renewal"
    - name: "document_verified_flag"
      expr: document_verified_flag
      comment: "Whether certification document has been verified"
    - name: "control_and_operations_flag"
      expr: control_and_operations
      comment: "Whether minority group has control and operations authority"
    - name: "certification_year"
      expr: YEAR(issue_date)
      comment: "Year certification was issued"
  measures:
    - name: "total_certifications"
      expr: COUNT(DISTINCT diversity_certification_id)
      comment: "Total number of diversity certifications tracked"
    - name: "active_certifications"
      expr: SUM(CASE WHEN certification_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of currently active diversity certifications"
    - name: "certification_active_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN certification_status = 'Active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications in active status, measuring diversity program health"
    - name: "client_reportable_certification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN client_reportable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications reportable to clients, measuring diversity spend tracking capability"
    - name: "ofccp_reportable_certification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ofccp_reportable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications OFCCP reportable, measuring regulatory compliance coverage"
    - name: "document_verified_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN document_verified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications with verified documentation, measuring audit readiness"
    - name: "small_business_certification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN small_business_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications including small business status, tracking small business participation"
    - name: "avg_ownership_percentage"
      expr: AVG(CAST(ownership_percentage AS DOUBLE))
      comment: "Average minority ownership percentage across certified suppliers"
    - name: "avg_annual_revenue_usd"
      expr: AVG(CAST(annual_revenue_usd AS DOUBLE))
      comment: "Average annual revenue of diversity-certified suppliers"
    - name: "control_and_operations_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN control_and_operations = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications with minority control and operations, measuring authentic diversity ownership"
    - name: "auto_renewal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications with auto-renewal, reducing administrative burden"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`vendor_rate_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor rate agreement metrics tracking pricing structures, markup percentages, and contract terms across supplier agreements"
  source: "`staffing_hr_ecm`.`vendor`.`rate_agreement`"
  dimensions:
    - name: "rate_agreement_id"
      expr: rate_agreement_id
      comment: "Unique identifier for the rate agreement"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier party to the rate agreement"
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement (active, expired, pending)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of rate agreement (master, program-specific, SOW)"
    - name: "vendor_tier"
      expr: vendor_tier
      comment: "Supplier tier classification"
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification covered (W2, 1099, IC)"
    - name: "program_scope"
      expr: program_scope
      comment: "Scope of programs covered by agreement"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for rate agreement"
    - name: "auto_renewal_flag"
      expr: auto_renewal
      comment: "Whether agreement has auto-renewal"
    - name: "escalation_clause_flag"
      expr: escalation_clause
      comment: "Whether agreement includes rate escalation clause"
    - name: "rate_exception_allowed_flag"
      expr: rate_exception_allowed
      comment: "Whether rate exceptions are permitted"
    - name: "burden_rate_included_flag"
      expr: burden_rate_included
      comment: "Whether burden rate is included in pricing"
    - name: "per_diem_included_flag"
      expr: per_diem_included
      comment: "Whether per diem is included"
    - name: "agreement_year"
      expr: YEAR(effective_start_date)
      comment: "Year agreement became effective"
  measures:
    - name: "total_rate_agreements"
      expr: COUNT(DISTINCT rate_agreement_id)
      comment: "Total number of rate agreements"
    - name: "active_rate_agreements"
      expr: SUM(CASE WHEN agreement_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of currently active rate agreements"
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage across all rate agreements, measuring pricing competitiveness"
    - name: "avg_dt_markup_percentage"
      expr: AVG(CAST(dt_markup_percentage AS DOUBLE))
      comment: "Average direct-to-client markup percentage"
    - name: "avg_ot_markup_percentage"
      expr: AVG(CAST(ot_markup_percentage AS DOUBLE))
      comment: "Average overtime markup percentage"
    - name: "avg_msp_fee_percentage"
      expr: AVG(CAST(msp_fee_percentage AS DOUBLE))
      comment: "Average MSP fee percentage across agreements"
    - name: "avg_vms_fee_percentage"
      expr: AVG(CAST(vms_fee_percentage AS DOUBLE))
      comment: "Average VMS fee percentage across agreements"
    - name: "avg_conversion_fee_percentage"
      expr: AVG(CAST(conversion_fee_percentage AS DOUBLE))
      comment: "Average conversion fee percentage for temp-to-perm conversions"
    - name: "avg_escalation_percentage"
      expr: AVG(CAST(escalation_percentage AS DOUBLE))
      comment: "Average annual rate escalation percentage"
    - name: "avg_max_exception_markup"
      expr: AVG(CAST(max_exception_markup_pct AS DOUBLE))
      comment: "Average maximum exception markup percentage allowed"
    - name: "avg_spread_ceiling"
      expr: AVG(CAST(spread_ceiling_amount AS DOUBLE))
      comment: "Average spread ceiling amount across agreements"
    - name: "avg_spread_floor"
      expr: AVG(CAST(spread_floor_amount AS DOUBLE))
      comment: "Average spread floor amount across agreements"
    - name: "auto_renewal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_renewal = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements with auto-renewal, reducing administrative burden"
    - name: "escalation_clause_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_clause = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements with escalation clauses, measuring inflation protection"
    - name: "rate_exception_allowed_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN rate_exception_allowed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements allowing rate exceptions, measuring pricing flexibility"
$$;