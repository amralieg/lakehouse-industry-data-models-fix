-- Metric views for domain: regulatory | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 17:46:18

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`regulatory_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core regulatory application metrics tracking submission pipeline, approval rates, and designation success across therapeutic areas and regulatory pathways"
  source: "`pharmaceuticals_ecm`.`regulatory`.`application`"
  dimensions:
    - name: "application_type"
      expr: application_type
      comment: "Type of regulatory application (NDA, BLA, ANDA, 505b2, etc.)"
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application (submitted, under review, approved, rejected, withdrawn)"
    - name: "regulatory_pathway"
      expr: regulatory_pathway
      comment: "Regulatory pathway designation (standard, accelerated, priority, breakthrough, orphan)"
    - name: "therapeutic_indication"
      expr: therapeutic_indication
      comment: "Primary therapeutic indication for the application"
    - name: "health_authority_code"
      expr: health_authority_code
      comment: "Code identifying the health authority (FDA, EMA, PMDA, etc.)"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the application was submitted"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the application was approved"
    - name: "breakthrough_therapy_flag"
      expr: breakthrough_therapy_flag
      comment: "Whether application received breakthrough therapy designation"
    - name: "orphan_designation_flag"
      expr: orphan_designation_flag
      comment: "Whether application received orphan drug designation"
    - name: "priority_review_flag"
      expr: priority_review_flag
      comment: "Whether application received priority review designation"
    - name: "fast_track_flag"
      expr: fast_track_flag
      comment: "Whether application received fast track designation"
    - name: "new_molecular_entity_flag"
      expr: new_molecular_entity_flag
      comment: "Whether application is for a new molecular entity"
    - name: "rems_required_flag"
      expr: rems_required_flag
      comment: "Whether a Risk Evaluation and Mitigation Strategy is required"
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form of the medicinal product"
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration for the product"
  measures:
    - name: "total_applications"
      expr: COUNT(application_id)
      comment: "Total number of regulatory applications"
    - name: "approved_applications"
      expr: COUNT(CASE WHEN approval_date IS NOT NULL THEN application_id END)
      comment: "Number of applications that have received approval"
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_date IS NOT NULL THEN application_id END) / NULLIF(COUNT(application_id), 0), 2)
      comment: "Percentage of applications that have been approved"
    - name: "breakthrough_designation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN breakthrough_therapy_flag = TRUE THEN application_id END) / NULLIF(COUNT(application_id), 0), 2)
      comment: "Percentage of applications receiving breakthrough therapy designation"
    - name: "orphan_designation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN orphan_designation_flag = TRUE THEN application_id END) / NULLIF(COUNT(application_id), 0), 2)
      comment: "Percentage of applications receiving orphan drug designation"
    - name: "priority_review_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN priority_review_flag = TRUE THEN application_id END) / NULLIF(COUNT(application_id), 0), 2)
      comment: "Percentage of applications receiving priority review"
    - name: "avg_review_time_days"
      expr: AVG(DATEDIFF(approval_date, submission_date))
      comment: "Average number of days from submission to approval for approved applications"
    - name: "rems_requirement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rems_required_flag = TRUE THEN application_id END) / NULLIF(COUNT(application_id), 0), 2)
      comment: "Percentage of applications requiring REMS programs"
    - name: "pai_requirement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pai_required_flag = TRUE THEN application_id END) / NULLIF(COUNT(application_id), 0), 2)
      comment: "Percentage of applications requiring pre-approval inspection"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory submission performance metrics tracking submission volume, validation success, review timelines, and fee management across health authorities"
  source: "`pharmaceuticals_ecm`.`regulatory`.`submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (original, supplement, amendment, response)"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the submission was made"
    - name: "submission_quarter"
      expr: CONCAT('Q', QUARTER(submission_date), '-', YEAR(submission_date))
      comment: "Quarter and year of submission"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the submission"
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the submission"
    - name: "regulatory_pathway"
      expr: regulatory_pathway
      comment: "Regulatory pathway for the submission"
    - name: "priority_designation"
      expr: priority_designation
      comment: "Priority designation assigned to the submission"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the submission"
    - name: "dossier_format"
      expr: dossier_format
      comment: "Format of the submission dossier (eCTD, NeeS, paper)"
    - name: "pai_required"
      expr: pai_required
      comment: "Whether pre-approval inspection is required"
    - name: "rems_required"
      expr: rems_required
      comment: "Whether REMS is required for this submission"
    - name: "fee_waiver_granted"
      expr: fee_waiver_granted
      comment: "Whether a fee waiver was granted"
  measures:
    - name: "total_submissions"
      expr: COUNT(submission_id)
      comment: "Total number of regulatory submissions"
    - name: "validated_submissions"
      expr: COUNT(CASE WHEN validation_status = 'Validated' THEN submission_id END)
      comment: "Number of submissions that passed validation"
    - name: "validation_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN validation_status = 'Validated' THEN submission_id END) / NULLIF(COUNT(submission_id), 0), 2)
      comment: "Percentage of submissions that passed validation on first attempt"
    - name: "total_submission_fees_usd"
      expr: SUM(CAST(fee_usd AS DOUBLE))
      comment: "Total regulatory submission fees in USD"
    - name: "avg_submission_fee_usd"
      expr: AVG(CAST(fee_usd AS DOUBLE))
      comment: "Average submission fee in USD"
    - name: "fee_waiver_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fee_waiver_granted = TRUE THEN submission_id END) / NULLIF(COUNT(submission_id), 0), 2)
      comment: "Percentage of submissions receiving fee waivers"
    - name: "avg_validation_error_count"
      expr: AVG(CAST(validation_error_count AS DOUBLE))
      comment: "Average number of validation errors per submission"
    - name: "avg_document_count"
      expr: AVG(CAST(document_count AS DOUBLE))
      comment: "Average number of documents per submission"
    - name: "avg_review_time_days"
      expr: AVG(DATEDIFF(actual_decision_date, submission_date))
      comment: "Average number of days from submission to regulatory decision"
    - name: "on_time_decision_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_decision_date <= target_action_date THEN submission_id END) / NULLIF(COUNT(CASE WHEN actual_decision_date IS NOT NULL THEN submission_id END), 0), 2)
      comment: "Percentage of submissions receiving decisions by target action date"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`regulatory_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory approval metrics tracking market authorization success, exclusivity periods, and post-approval obligations across jurisdictions"
  source: "`pharmaceuticals_ecm`.`regulatory`.`approval`"
  dimensions:
    - name: "approval_type"
      expr: approval_type
      comment: "Type of regulatory approval (full, conditional, accelerated)"
    - name: "approval_status"
      expr: approval_status
      comment: "Current status of the approval"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the approval was granted"
    - name: "regulatory_region"
      expr: regulatory_region
      comment: "Regulatory region where approval was granted"
    - name: "approved_indication"
      expr: approved_indication
      comment: "Indication approved by the health authority"
    - name: "approved_dosage_form"
      expr: approved_dosage_form
      comment: "Dosage form approved"
    - name: "approved_route_of_administration"
      expr: approved_route_of_administration
      comment: "Route of administration approved"
    - name: "orphan_drug_designation"
      expr: orphan_drug_designation
      comment: "Whether the approval includes orphan drug designation"
    - name: "pediatric_indication"
      expr: pediatric_indication
      comment: "Whether the approval includes pediatric indication"
    - name: "has_rems"
      expr: has_rems
      comment: "Whether the approval requires REMS"
    - name: "pai_required"
      expr: pai_required
      comment: "Whether pre-approval inspection was required"
    - name: "regulatory_exclusivity_type"
      expr: regulatory_exclusivity_type
      comment: "Type of regulatory exclusivity granted"
  measures:
    - name: "total_approvals"
      expr: COUNT(approval_id)
      comment: "Total number of regulatory approvals"
    - name: "active_approvals"
      expr: COUNT(CASE WHEN approval_status = 'Active' THEN approval_id END)
      comment: "Number of currently active approvals"
    - name: "orphan_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN orphan_drug_designation = TRUE THEN approval_id END) / NULLIF(COUNT(approval_id), 0), 2)
      comment: "Percentage of approvals with orphan drug designation"
    - name: "pediatric_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pediatric_indication = TRUE THEN approval_id END) / NULLIF(COUNT(approval_id), 0), 2)
      comment: "Percentage of approvals including pediatric indications"
    - name: "rems_requirement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN has_rems = TRUE THEN approval_id END) / NULLIF(COUNT(approval_id), 0), 2)
      comment: "Percentage of approvals requiring REMS programs"
    - name: "avg_exclusivity_period_days"
      expr: AVG(DATEDIFF(exclusivity_expiry_date, approval_date))
      comment: "Average length of exclusivity period in days from approval"
    - name: "avg_approval_to_effective_days"
      expr: AVG(DATEDIFF(effective_date, approval_date))
      comment: "Average days from approval date to effective date"
    - name: "approvals_with_commitments"
      expr: COUNT(CASE WHEN post_approval_commitment_count IS NOT NULL AND CAST(post_approval_commitment_count AS INT) > 0 THEN approval_id END)
      comment: "Number of approvals with post-approval commitments"
    - name: "avg_post_approval_commitments"
      expr: AVG(CAST(post_approval_commitment_count AS DOUBLE))
      comment: "Average number of post-approval commitments per approval"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`regulatory_post_approval_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Post-approval commitment tracking metrics measuring fulfillment rates, timeline adherence, and regulatory compliance burden"
  source: "`pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment`"
  dimensions:
    - name: "commitment_type"
      expr: commitment_type
      comment: "Type of post-approval commitment (clinical trial, labeling update, manufacturing change, etc.)"
    - name: "commitment_category"
      expr: commitment_category
      comment: "Category of the commitment"
    - name: "commitment_status"
      expr: commitment_status
      comment: "Current status of the commitment (pending, in progress, completed, delayed, waived)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the commitment"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the commitment"
    - name: "issuing_agency"
      expr: issuing_agency
      comment: "Health authority that issued the commitment"
    - name: "country_code"
      expr: country_code
      comment: "Country where the commitment applies"
    - name: "is_pediatric_commitment"
      expr: is_pediatric_commitment
      comment: "Whether this is a pediatric-related commitment"
    - name: "is_rems_related"
      expr: is_rems_related
      comment: "Whether this commitment is REMS-related"
    - name: "deliverable_type"
      expr: deliverable_type
      comment: "Type of deliverable required"
    - name: "regulatory_basis"
      expr: regulatory_basis
      comment: "Regulatory basis for the commitment"
    - name: "responsible_function"
      expr: responsible_function
      comment: "Internal function responsible for fulfillment"
  measures:
    - name: "total_commitments"
      expr: COUNT(post_approval_commitment_id)
      comment: "Total number of post-approval commitments"
    - name: "completed_commitments"
      expr: COUNT(CASE WHEN commitment_status = 'Completed' THEN post_approval_commitment_id END)
      comment: "Number of commitments that have been completed"
    - name: "commitment_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN commitment_status = 'Completed' THEN post_approval_commitment_id END) / NULLIF(COUNT(post_approval_commitment_id), 0), 2)
      comment: "Percentage of commitments that have been completed"
    - name: "overdue_commitments"
      expr: COUNT(CASE WHEN commitment_status NOT IN ('Completed', 'Waived') AND original_due_date < CURRENT_DATE THEN post_approval_commitment_id END)
      comment: "Number of commitments that are overdue"
    - name: "overdue_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN commitment_status NOT IN ('Completed', 'Waived') AND original_due_date < CURRENT_DATE THEN post_approval_commitment_id END) / NULLIF(COUNT(CASE WHEN commitment_status NOT IN ('Completed', 'Waived') THEN post_approval_commitment_id END), 0), 2)
      comment: "Percentage of active commitments that are overdue"
    - name: "avg_fulfillment_time_days"
      expr: AVG(DATEDIFF(fulfillment_date, original_due_date))
      comment: "Average days from original due date to fulfillment (negative means early, positive means late)"
    - name: "on_time_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fulfillment_date <= original_due_date THEN post_approval_commitment_id END) / NULLIF(COUNT(CASE WHEN fulfillment_date IS NOT NULL THEN post_approval_commitment_id END), 0), 2)
      comment: "Percentage of completed commitments fulfilled by original due date"
    - name: "avg_completed_milestones"
      expr: AVG(CAST(completed_milestone_count AS DOUBLE))
      comment: "Average number of completed milestones per commitment"
    - name: "avg_total_milestones"
      expr: AVG(CAST(milestone_count AS DOUBLE))
      comment: "Average total number of milestones per commitment"
    - name: "pediatric_commitment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_pediatric_commitment = TRUE THEN post_approval_commitment_id END) / NULLIF(COUNT(post_approval_commitment_id), 0), 2)
      comment: "Percentage of commitments that are pediatric-related"
    - name: "rems_commitment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_rems_related = TRUE THEN post_approval_commitment_id END) / NULLIF(COUNT(post_approval_commitment_id), 0), 2)
      comment: "Percentage of commitments that are REMS-related"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`regulatory_variation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Post-approval variation metrics tracking change control efficiency, approval timelines, and implementation success for marketed products"
  source: "`pharmaceuticals_ecm`.`regulatory`.`variation`"
  dimensions:
    - name: "variation_type"
      expr: variation_type
      comment: "Type of variation (Type IA, Type IB, Type II, extension, etc.)"
    - name: "variation_status"
      expr: variation_status
      comment: "Current status of the variation"
    - name: "change_category"
      expr: change_category
      comment: "Category of change (quality, safety, efficacy, administrative)"
    - name: "implementation_status"
      expr: implementation_status
      comment: "Implementation status of approved variations"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the product"
    - name: "market_country_code"
      expr: market_country_code
      comment: "Country/market where variation applies"
    - name: "is_grouped"
      expr: is_grouped
      comment: "Whether this variation is part of a grouped submission"
    - name: "is_labeling_change"
      expr: is_labeling_change
      comment: "Whether the variation includes labeling changes"
    - name: "is_safety_driven"
      expr: is_safety_driven
      comment: "Whether the variation is driven by safety concerns"
    - name: "regulatory_basis"
      expr: regulatory_basis
      comment: "Regulatory basis for the variation"
    - name: "submission_year"
      expr: YEAR(acceptance_date)
      comment: "Year the variation was accepted for review"
  measures:
    - name: "total_variations"
      expr: COUNT(variation_id)
      comment: "Total number of variations submitted"
    - name: "approved_variations"
      expr: COUNT(CASE WHEN variation_status = 'Approved' THEN variation_id END)
      comment: "Number of variations that have been approved"
    - name: "variation_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN variation_status = 'Approved' THEN variation_id END) / NULLIF(COUNT(variation_id), 0), 2)
      comment: "Percentage of variations that have been approved"
    - name: "avg_review_time_days"
      expr: AVG(DATEDIFF(approval_date, acceptance_date))
      comment: "Average number of days from acceptance to approval"
    - name: "avg_implementation_time_days"
      expr: AVG(DATEDIFF(implementation_date, approval_date))
      comment: "Average number of days from approval to implementation"
    - name: "on_time_implementation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN implementation_date <= implementation_deadline THEN variation_id END) / NULLIF(COUNT(CASE WHEN implementation_date IS NOT NULL THEN variation_id END), 0), 2)
      comment: "Percentage of variations implemented by deadline"
    - name: "safety_driven_variation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_safety_driven = TRUE THEN variation_id END) / NULLIF(COUNT(variation_id), 0), 2)
      comment: "Percentage of variations driven by safety concerns"
    - name: "labeling_change_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_labeling_change = TRUE THEN variation_id END) / NULLIF(COUNT(variation_id), 0), 2)
      comment: "Percentage of variations including labeling changes"
    - name: "grouped_variation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_grouped = TRUE THEN variation_id END) / NULLIF(COUNT(variation_id), 0), 2)
      comment: "Percentage of variations submitted as part of grouped applications"
    - name: "avg_clock_stop_days"
      expr: AVG(CAST(clock_stop_days AS DOUBLE))
      comment: "Average number of clock-stop days per variation"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`regulatory_product_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product registration lifecycle metrics tracking renewal compliance, market authorization maintenance, and exclusivity management across jurisdictions"
  source: "`pharmaceuticals_ecm`.`regulatory`.`product_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current status of the product registration"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the registered product"
    - name: "health_authority_code"
      expr: health_authority_code
      comment: "Health authority code for the registration"
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form of the registered product"
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration"
    - name: "orphan_designation_flag"
      expr: orphan_designation_flag
      comment: "Whether the registration has orphan designation"
    - name: "rems_required_flag"
      expr: rems_required_flag
      comment: "Whether REMS is required for this registration"
    - name: "post_approval_commitment_flag"
      expr: post_approval_commitment_flag
      comment: "Whether there are post-approval commitments"
    - name: "renewal_type"
      expr: renewal_type
      comment: "Type of renewal (standard, expedited, etc.)"
    - name: "renewal_outcome"
      expr: renewal_outcome
      comment: "Outcome of the most recent renewal"
    - name: "renewal_fee_status"
      expr: renewal_fee_status
      comment: "Status of renewal fee payment"
    - name: "registration_year"
      expr: YEAR(registration_date)
      comment: "Year the product was registered"
  measures:
    - name: "total_registrations"
      expr: COUNT(product_registration_id)
      comment: "Total number of product registrations"
    - name: "active_registrations"
      expr: COUNT(CASE WHEN registration_status = 'Active' THEN product_registration_id END)
      comment: "Number of currently active registrations"
    - name: "registrations_due_for_renewal"
      expr: COUNT(CASE WHEN renewal_due_date <= DATE_ADD(CURRENT_DATE, 90) AND registration_status = 'Active' THEN product_registration_id END)
      comment: "Number of registrations due for renewal within 90 days"
    - name: "avg_registration_lifetime_days"
      expr: AVG(DATEDIFF(expiry_date, registration_date))
      comment: "Average lifetime of registrations from registration to expiry"
    - name: "avg_data_exclusivity_period_days"
      expr: AVG(DATEDIFF(data_exclusivity_expiry_date, registration_date))
      comment: "Average data exclusivity period in days"
    - name: "avg_market_exclusivity_period_days"
      expr: AVG(DATEDIFF(market_exclusivity_expiry_date, registration_date))
      comment: "Average market exclusivity period in days"
    - name: "total_renewal_fees"
      expr: SUM(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Total renewal fees across all registrations"
    - name: "avg_renewal_fee"
      expr: AVG(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Average renewal fee per registration"
    - name: "renewal_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN renewal_outcome = 'Approved' THEN product_registration_id END) / NULLIF(COUNT(CASE WHEN renewal_outcome IS NOT NULL THEN product_registration_id END), 0), 2)
      comment: "Percentage of renewal applications that were approved"
    - name: "avg_renewal_processing_time_days"
      expr: AVG(DATEDIFF(renewal_approval_date, renewal_submission_date))
      comment: "Average days from renewal submission to approval"
    - name: "orphan_registration_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN orphan_designation_flag = TRUE THEN product_registration_id END) / NULLIF(COUNT(product_registration_id), 0), 2)
      comment: "Percentage of registrations with orphan designation"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`regulatory_rems`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk Evaluation and Mitigation Strategy program metrics tracking REMS burden, assessment compliance, and program modification frequency"
  source: "`pharmaceuticals_ecm`.`regulatory`.`rems`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of the REMS program"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the REMS program"
    - name: "has_etasu"
      expr: has_etasu
      comment: "Whether the program includes Elements to Assure Safe Use"
    - name: "has_medication_guide"
      expr: has_medication_guide
      comment: "Whether the program includes a medication guide"
    - name: "has_communication_plan"
      expr: has_communication_plan
      comment: "Whether the program includes a communication plan"
    - name: "requires_patient_enrollment"
      expr: requires_patient_enrollment
      comment: "Whether patient enrollment is required"
    - name: "requires_certified_prescriber"
      expr: requires_certified_prescriber
      comment: "Whether certified prescribers are required"
    - name: "requires_certified_pharmacy"
      expr: requires_certified_pharmacy
      comment: "Whether certified pharmacies are required"
    - name: "requires_lab_monitoring"
      expr: requires_lab_monitoring
      comment: "Whether laboratory monitoring is required"
    - name: "shared_rems_indicator"
      expr: shared_rems_indicator
      comment: "Whether this is a shared REMS program"
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form covered by the REMS"
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration"
  measures:
    - name: "total_rems_programs"
      expr: COUNT(rems_id)
      comment: "Total number of REMS programs"
    - name: "active_rems_programs"
      expr: COUNT(CASE WHEN program_status = 'Active' THEN rems_id END)
      comment: "Number of currently active REMS programs"
    - name: "etasu_program_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN has_etasu = TRUE THEN rems_id END) / NULLIF(COUNT(rems_id), 0), 2)
      comment: "Percentage of REMS programs with ETASU requirements"
    - name: "patient_enrollment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN requires_patient_enrollment = TRUE THEN rems_id END) / NULLIF(COUNT(rems_id), 0), 2)
      comment: "Percentage of REMS programs requiring patient enrollment"
    - name: "certified_prescriber_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN requires_certified_prescriber = TRUE THEN rems_id END) / NULLIF(COUNT(rems_id), 0), 2)
      comment: "Percentage of REMS programs requiring certified prescribers"
    - name: "certified_pharmacy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN requires_certified_pharmacy = TRUE THEN rems_id END) / NULLIF(COUNT(rems_id), 0), 2)
      comment: "Percentage of REMS programs requiring certified pharmacies"
    - name: "avg_modification_count"
      expr: AVG(CAST(modification_count AS DOUBLE))
      comment: "Average number of modifications per REMS program"
    - name: "avg_days_since_last_assessment"
      expr: AVG(DATEDIFF(CURRENT_DATE, last_assessment_submission_date))
      comment: "Average days since last REMS assessment submission"
    - name: "overdue_assessments"
      expr: COUNT(CASE WHEN next_assessment_due_date < CURRENT_DATE AND program_status = 'Active' THEN rems_id END)
      comment: "Number of REMS programs with overdue assessments"
    - name: "shared_rems_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN shared_rems_indicator = TRUE THEN rems_id END) / NULLIF(COUNT(rems_id), 0), 2)
      comment: "Percentage of REMS programs that are shared across products"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`regulatory_designation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Special regulatory designation metrics tracking breakthrough, orphan, fast-track, and priority review success rates and strategic value"
  source: "`pharmaceuticals_ecm`.`regulatory`.`designation`"
  dimensions:
    - name: "designation_type"
      expr: designation_type
      comment: "Type of regulatory designation (breakthrough, orphan, fast track, priority review, PRIME, etc.)"
    - name: "designation_status"
      expr: designation_status
      comment: "Current status of the designation"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the designated product"
    - name: "target_indication"
      expr: target_indication
      comment: "Target indication for the designation"
    - name: "market_country_code"
      expr: market_country_code
      comment: "Country/market where designation was granted"
    - name: "development_phase"
      expr: development_phase
      comment: "Development phase when designation was granted"
    - name: "accelerated_approval_pathway"
      expr: accelerated_approval_pathway
      comment: "Whether accelerated approval pathway is available"
    - name: "rolling_review_enabled"
      expr: rolling_review_enabled
      comment: "Whether rolling review is enabled"
    - name: "priority_review_voucher_eligible"
      expr: priority_review_voucher_eligible
      comment: "Whether eligible for priority review voucher"
    - name: "confirmatory_trial_required"
      expr: confirmatory_trial_required
      comment: "Whether confirmatory trial is required"
    - name: "strategic_importance"
      expr: strategic_importance
      comment: "Strategic importance rating of the designation"
    - name: "voucher_redeemed"
      expr: voucher_redeemed
      comment: "Whether priority review voucher has been redeemed"
  measures:
    - name: "total_designations"
      expr: COUNT(designation_id)
      comment: "Total number of regulatory designations"
    - name: "active_designations"
      expr: COUNT(CASE WHEN designation_status = 'Active' THEN designation_id END)
      comment: "Number of currently active designations"
    - name: "granted_designations"
      expr: COUNT(CASE WHEN grant_date IS NOT NULL THEN designation_id END)
      comment: "Number of designations that have been granted"
    - name: "designation_grant_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN grant_date IS NOT NULL THEN designation_id END) / NULLIF(COUNT(designation_id), 0), 2)
      comment: "Percentage of designation requests that were granted"
    - name: "avg_review_time_days"
      expr: AVG(DATEDIFF(grant_date, request_date))
      comment: "Average days from designation request to grant"
    - name: "avg_exclusivity_period_years"
      expr: AVG(CAST(exclusivity_period_years AS DOUBLE))
      comment: "Average exclusivity period in years for granted designations"
    - name: "accelerated_pathway_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accelerated_approval_pathway = TRUE THEN designation_id END) / NULLIF(COUNT(designation_id), 0), 2)
      comment: "Percentage of designations with accelerated approval pathway"
    - name: "rolling_review_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rolling_review_enabled = TRUE THEN designation_id END) / NULLIF(COUNT(designation_id), 0), 2)
      comment: "Percentage of designations with rolling review enabled"
    - name: "voucher_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN priority_review_voucher_eligible = TRUE THEN designation_id END) / NULLIF(COUNT(designation_id), 0), 2)
      comment: "Percentage of designations eligible for priority review voucher"
    - name: "voucher_redemption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN voucher_redeemed = TRUE THEN designation_id END) / NULLIF(COUNT(CASE WHEN priority_review_voucher_eligible = TRUE THEN designation_id END), 0), 2)
      comment: "Percentage of eligible vouchers that have been redeemed"
    - name: "avg_orphan_disease_prevalence"
      expr: AVG(CAST(orphan_disease_prevalence AS DOUBLE))
      comment: "Average disease prevalence for orphan designations"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`regulatory_correspondence`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory correspondence metrics tracking agency interaction volume, response timeliness, and information request management"
  source: "`pharmaceuticals_ecm`.`regulatory`.`correspondence`"
  dimensions:
    - name: "correspondence_type"
      expr: correspondence_type
      comment: "Type of correspondence (information request, deficiency letter, meeting minutes, etc.)"
    - name: "correspondence_status"
      expr: correspondence_status
      comment: "Current status of the correspondence"
    - name: "direction"
      expr: direction
      comment: "Direction of correspondence (inbound from agency, outbound to agency)"
    - name: "health_authority_code"
      expr: health_authority_code
      comment: "Health authority code"
    - name: "country_code"
      expr: country_code
      comment: "Country code"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area"
    - name: "subject_matter_category"
      expr: subject_matter_category
      comment: "Category of the subject matter"
    - name: "priority_flag"
      expr: priority_flag
      comment: "Whether this is priority correspondence"
    - name: "confidential_flag"
      expr: confidential_flag
      comment: "Whether the correspondence is confidential"
    - name: "pai_flag"
      expr: pai_flag
      comment: "Whether related to pre-approval inspection"
    - name: "rems_flag"
      expr: rems_flag
      comment: "Whether related to REMS"
    - name: "response_extension_requested"
      expr: response_extension_requested
      comment: "Whether a response extension was requested"
    - name: "received_year"
      expr: YEAR(received_date)
      comment: "Year the correspondence was received"
  measures:
    - name: "total_correspondence"
      expr: COUNT(correspondence_id)
      comment: "Total number of correspondence items"
    - name: "inbound_correspondence"
      expr: COUNT(CASE WHEN direction = 'Inbound' THEN correspondence_id END)
      comment: "Number of inbound correspondence items from agencies"
    - name: "outbound_correspondence"
      expr: COUNT(CASE WHEN direction = 'Outbound' THEN correspondence_id END)
      comment: "Number of outbound correspondence items to agencies"
    - name: "priority_correspondence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN priority_flag = TRUE THEN correspondence_id END) / NULLIF(COUNT(correspondence_id), 0), 2)
      comment: "Percentage of correspondence marked as priority"
    - name: "avg_response_time_days"
      expr: AVG(DATEDIFF(response_date, received_date))
      comment: "Average days from receipt to response for inbound correspondence"
    - name: "on_time_response_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN response_date <= response_due_date THEN correspondence_id END) / NULLIF(COUNT(CASE WHEN response_date IS NOT NULL THEN correspondence_id END), 0), 2)
      comment: "Percentage of responses submitted by due date"
    - name: "overdue_responses"
      expr: COUNT(CASE WHEN response_due_date < CURRENT_DATE AND response_date IS NULL THEN correspondence_id END)
      comment: "Number of correspondence items with overdue responses"
    - name: "extension_request_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN response_extension_requested = TRUE THEN correspondence_id END) / NULLIF(COUNT(CASE WHEN direction = 'Inbound' THEN correspondence_id END), 0), 2)
      comment: "Percentage of inbound correspondence requiring extension requests"
    - name: "avg_closure_time_days"
      expr: AVG(DATEDIFF(closure_date, received_date))
      comment: "Average days from receipt to closure"
    - name: "pai_related_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pai_flag = TRUE THEN correspondence_id END) / NULLIF(COUNT(correspondence_id), 0), 2)
      comment: "Percentage of correspondence related to pre-approval inspections"
$$;