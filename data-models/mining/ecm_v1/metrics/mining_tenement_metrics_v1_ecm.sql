-- Metric views for domain: tenement | Business: Mining | Version: 1 | Generated on: 2026-05-05 10:45:25

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Application business metrics"
  source: "`mining_ecm`.`tenement`.`application`"
  dimensions:
    - name: "Application Number"
      expr: application_number
    - name: "Application Status"
      expr: application_status
    - name: "Application Type"
      expr: application_type
    - name: "Conditions Of Grant"
      expr: conditions_of_grant
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Decision Date"
      expr: decision_date
    - name: "Environmental Assessment Required Flag"
      expr: environmental_assessment_required_flag
    - name: "Environmental Assessment Status"
      expr: environmental_assessment_status
    - name: "Expenditure Commitment Currency"
      expr: expenditure_commitment_currency
    - name: "Fee Currency"
      expr: fee_currency
    - name: "Grant Date"
      expr: grant_date
    - name: "Hearing Scheduled Date"
      expr: hearing_scheduled_date
    - name: "Heritage Clearance Required Flag"
      expr: heritage_clearance_required_flag
    - name: "Heritage Clearance Status"
      expr: heritage_clearance_status
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Application"
      expr: COUNT(DISTINCT application_id)
    - name: "Total Area Hectares"
      expr: SUM(area_hectares)
    - name: "Average Area Hectares"
      expr: AVG(area_hectares)
    - name: "Total Expenditure Commitment Amount"
      expr: SUM(expenditure_commitment_amount)
    - name: "Average Expenditure Commitment Amount"
      expr: AVG(expenditure_commitment_amount)
    - name: "Total Fee Amount"
      expr: SUM(fee_amount)
    - name: "Average Fee Amount"
      expr: AVG(fee_amount)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_boundary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Boundary business metrics"
  source: "`mining_ecm`.`tenement`.`boundary`"
  dimensions:
    - name: "Accuracy Class"
      expr: accuracy_class
    - name: "Amendment Reason"
      expr: amendment_reason
    - name: "Area Calculation Method"
      expr: area_calculation_method
    - name: "Boundary Status"
      expr: boundary_status
    - name: "Comments"
      expr: comments
    - name: "Coordinate Reference System"
      expr: coordinate_reference_system
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source"
      expr: data_source
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Environmental Overlay Flag"
      expr: environmental_overlay_flag
    - name: "Geometry Wkb"
      expr: geometry_wkb
    - name: "Geometry Wkt"
      expr: geometry_wkt
    - name: "Gis Layer Name"
      expr: gis_layer_name
    - name: "Heritage Area Overlap Flag"
      expr: heritage_area_overlap_flag
    - name: "Is Current Boundary"
      expr: is_current_boundary
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Boundary"
      expr: COUNT(DISTINCT boundary_id)
    - name: "Total Area Hectares"
      expr: SUM(area_hectares)
    - name: "Average Area Hectares"
      expr: AVG(area_hectares)
    - name: "Total Area Square Kilometers"
      expr: SUM(area_square_kilometers)
    - name: "Average Area Square Kilometers"
      expr: AVG(area_square_kilometers)
    - name: "Total Perimeter Meters"
      expr: SUM(perimeter_meters)
    - name: "Average Perimeter Meters"
      expr: AVG(perimeter_meters)
    - name: "Total Positional Accuracy Meters"
      expr: SUM(positional_accuracy_meters)
    - name: "Average Positional Accuracy Meters"
      expr: AVG(positional_accuracy_meters)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_contract_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract Allocation business metrics"
  source: "`mining_ecm`.`tenement`.`contract_allocation`"
  dimensions:
    - name: "Allocated By User"
      expr: allocated_by_user
    - name: "Allocation Date"
      expr: allocation_date
    - name: "Allocation Reason"
      expr: allocation_reason
    - name: "Allocation Status"
      expr: allocation_status
    - name: "Cost Centre Code"
      expr: cost_centre_code
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Allocation Date Month"
      expr: DATE_TRUNC('MONTH', allocation_date)
    - name: "Effective From Date Month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contract Allocation"
      expr: COUNT(DISTINCT contract_allocation_id)
    - name: "Total Percentage"
      expr: SUM(percentage)
    - name: "Average Percentage"
      expr: AVG(percentage)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_expenditure_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Expenditure Commitment business metrics"
  source: "`mining_ecm`.`tenement`.`expenditure_commitment`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Carry Forward Expiry Date"
      expr: carry_forward_expiry_date
    - name: "Commitment Reference Number"
      expr: commitment_reference_number
    - name: "Commitment Type"
      expr: commitment_type
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Exemption Granted Flag"
      expr: exemption_granted_flag
    - name: "Exemption Reason"
      expr: exemption_reason
    - name: "Expenditure Category"
      expr: expenditure_category
    - name: "Forfeiture Risk Flag"
      expr: forfeiture_risk_flag
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Notes"
      expr: notes
    - name: "Reporting Period End Date"
      expr: reporting_period_end_date
    - name: "Reporting Period Start Date"
      expr: reporting_period_start_date
    - name: "Responsible Party"
      expr: responsible_party
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Expenditure Commitment"
      expr: COUNT(DISTINCT expenditure_commitment_id)
    - name: "Total Actual Expenditure Amount"
      expr: SUM(actual_expenditure_amount)
    - name: "Average Actual Expenditure Amount"
      expr: AVG(actual_expenditure_amount)
    - name: "Total Carry Forward Amount"
      expr: SUM(carry_forward_amount)
    - name: "Average Carry Forward Amount"
      expr: AVG(carry_forward_amount)
    - name: "Total Committed Amount"
      expr: SUM(committed_amount)
    - name: "Average Committed Amount"
      expr: AVG(committed_amount)
    - name: "Total Penalty Amount"
      expr: SUM(penalty_amount)
    - name: "Average Penalty Amount"
      expr: AVG(penalty_amount)
    - name: "Total Variance Amount"
      expr: SUM(variance_amount)
    - name: "Average Variance Amount"
      expr: AVG(variance_amount)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_heritage_clearance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Heritage Clearance business metrics"
  source: "`mining_ecm`.`tenement`.`heritage_clearance`"
  dimensions:
    - name: "Clearance Expiry Date"
      expr: clearance_expiry_date
    - name: "Clearance Outcome"
      expr: clearance_outcome
    - name: "Clearance Reference Number"
      expr: clearance_reference_number
    - name: "Clearance Status"
      expr: clearance_status
    - name: "Clearance Valid From Date"
      expr: clearance_valid_from_date
    - name: "Conditions And Restrictions"
      expr: conditions_and_restrictions
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Heritage Site Register Numbers"
      expr: heritage_site_register_numbers
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Monitoring Required"
      expr: monitoring_required
    - name: "Notes"
      expr: notes
    - name: "Regulatory Approval Authority"
      expr: regulatory_approval_authority
    - name: "Regulatory Approval Date"
      expr: regulatory_approval_date
    - name: "Regulatory Approval Reference"
      expr: regulatory_approval_reference
    - name: "Restricted Zone Description"
      expr: restricted_zone_description
    - name: "Restricted Zone Spatial Reference"
      expr: restricted_zone_spatial_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Heritage Clearance"
      expr: COUNT(DISTINCT heritage_clearance_id)
    - name: "Total Clearance Area Hectares"
      expr: SUM(clearance_area_hectares)
    - name: "Average Clearance Area Hectares"
      expr: AVG(clearance_area_hectares)
    - name: "Total Survey Cost Aud"
      expr: SUM(survey_cost_aud)
    - name: "Average Survey Cost Aud"
      expr: AVG(survey_cost_aud)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_holder`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Holder business metrics"
  source: "`mining_ecm`.`tenement`.`holder`"
  dimensions:
    - name: "Annual Return Lodgement Flag"
      expr: annual_return_lodgement_flag
    - name: "Beneficial Owner Disclosed Flag"
      expr: beneficial_owner_disclosed_flag
    - name: "Consideration Currency Code"
      expr: consideration_currency_code
    - name: "Contributing Interest Flag"
      expr: contributing_interest_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dilution Trigger Event"
      expr: dilution_trigger_event
    - name: "Effective Date"
      expr: effective_date
    - name: "End Date"
      expr: end_date
    - name: "Free Carried Until Date"
      expr: free_carried_until_date
    - name: "Joint Venture Agreement Reference"
      expr: joint_venture_agreement_reference
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Notes"
      expr: notes
    - name: "Notification Acknowledgement Date"
      expr: notification_acknowledgement_date
    - name: "Notification Lodged Date"
      expr: notification_lodged_date
    - name: "Operator Flag"
      expr: operator_flag
    - name: "Reference Number"
      expr: reference_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Holder"
      expr: COUNT(DISTINCT holder_id)
    - name: "Total Consideration Amount"
      expr: SUM(consideration_amount)
    - name: "Average Consideration Amount"
      expr: AVG(consideration_amount)
    - name: "Total Free Carried Percentage"
      expr: SUM(free_carried_percentage)
    - name: "Average Free Carried Percentage"
      expr: AVG(free_carried_percentage)
    - name: "Total Ownership Percentage"
      expr: SUM(ownership_percentage)
    - name: "Average Ownership Percentage"
      expr: AVG(ownership_percentage)
    - name: "Total Royalty Rate Percentage"
      expr: SUM(royalty_rate_percentage)
    - name: "Average Royalty Rate Percentage"
      expr: AVG(royalty_rate_percentage)
    - name: "Total Stamp Duty Amount"
      expr: SUM(stamp_duty_amount)
    - name: "Average Stamp Duty Amount"
      expr: AVG(stamp_duty_amount)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_native_title_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Native Title Agreement business metrics"
  source: "`mining_ecm`.`tenement`.`native_title_agreement`"
  dimensions:
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Compensation Currency Code"
      expr: compensation_currency_code
    - name: "Compensation Type"
      expr: compensation_type
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Consultation Requirements"
      expr: consultation_requirements
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cultural Heritage Obligations"
      expr: cultural_heritage_obligations
    - name: "Dispute Resolution Mechanism"
      expr: dispute_resolution_mechanism
    - name: "Document Repository Path"
      expr: document_repository_path
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Employment Commitment"
      expr: employment_commitment
    - name: "Environmental Obligations"
      expr: environmental_obligations
    - name: "Execution Date"
      expr: execution_date
    - name: "Expiry Date"
      expr: expiry_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Native Title Agreement"
      expr: COUNT(DISTINCT native_title_agreement_id)
    - name: "Total Royalty Rate Percent"
      expr: SUM(royalty_rate_percent)
    - name: "Average Royalty Rate Percent"
      expr: AVG(royalty_rate_percent)
    - name: "Total Total Compensation Amount"
      expr: SUM(total_compensation_amount)
    - name: "Average Total Compensation Amount"
      expr: AVG(total_compensation_amount)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_programme_of_work`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Programme Of Work business metrics"
  source: "`mining_ecm`.`tenement`.`programme_of_work`"
  dimensions:
    - name: "Activity Type"
      expr: activity_type
    - name: "Approval Conditions"
      expr: approval_conditions
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Close Out Date"
      expr: close_out_date
    - name: "Completion Date"
      expr: completion_date
    - name: "Completion Status"
      expr: completion_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Environmental Management Commitments"
      expr: environmental_management_commitments
    - name: "Heritage Clearance Obtained Flag"
      expr: heritage_clearance_obtained_flag
    - name: "Heritage Clearance Reference"
      expr: heritage_clearance_reference
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Notes"
      expr: notes
    - name: "Pow Reference Number"
      expr: pow_reference_number
    - name: "Regulatory Authority"
      expr: regulatory_authority
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Programme Of Work"
      expr: COUNT(DISTINCT programme_of_work_id)
    - name: "Total Actual Expenditure Amount"
      expr: SUM(actual_expenditure_amount)
    - name: "Average Actual Expenditure Amount"
      expr: AVG(actual_expenditure_amount)
    - name: "Total Disturbance Area Hectares"
      expr: SUM(disturbance_area_hectares)
    - name: "Average Disturbance Area Hectares"
      expr: AVG(disturbance_area_hectares)
    - name: "Total Estimated Expenditure Amount"
      expr: SUM(estimated_expenditure_amount)
    - name: "Average Estimated Expenditure Amount"
      expr: AVG(estimated_expenditure_amount)
    - name: "Total Variance Amount"
      expr: SUM(variance_amount)
    - name: "Average Variance Amount"
      expr: AVG(variance_amount)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_regulatory_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory Condition business metrics"
  source: "`mining_ecm`.`tenement`.`regulatory_condition`"
  dimensions:
    - name: "Breach Date"
      expr: breach_date
    - name: "Breach Description"
      expr: breach_description
    - name: "Breach Flag"
      expr: breach_flag
    - name: "Compliance Due Date"
      expr: compliance_due_date
    - name: "Condition Description"
      expr: condition_description
    - name: "Condition Reference Number"
      expr: condition_reference_number
    - name: "Condition Status"
      expr: condition_status
    - name: "Condition Title"
      expr: condition_title
    - name: "Condition Type"
      expr: condition_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source System"
      expr: data_source_system
    - name: "Effective Date"
      expr: effective_date
    - name: "Enforcement Action Date"
      expr: enforcement_action_date
    - name: "Enforcement Action Type"
      expr: enforcement_action_type
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Granting Authority"
      expr: granting_authority
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Regulatory Condition"
      expr: COUNT(DISTINCT regulatory_condition_id)
    - name: "Total Penalty Amount"
      expr: SUM(penalty_amount)
    - name: "Average Penalty Amount"
      expr: AVG(penalty_amount)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_relinquishment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Relinquishment business metrics"
  source: "`mining_ecm`.`tenement`.`relinquishment`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approving Authority"
      expr: approving_authority
    - name: "Coordinate System"
      expr: coordinate_system
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Environmental Condition Status"
      expr: environmental_condition_status
    - name: "Expenditure Commitment Impact"
      expr: expenditure_commitment_impact
    - name: "Gis Boundary File Reference"
      expr: gis_boundary_file_reference
    - name: "Heritage Clearance Flag"
      expr: heritage_clearance_flag
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Lodgement Date"
      expr: lodgement_date
    - name: "Native Title Clearance Flag"
      expr: native_title_clearance_flag
    - name: "Notes"
      expr: notes
    - name: "Notification Sent Date"
      expr: notification_sent_date
    - name: "Public Notice Flag"
      expr: public_notice_flag
    - name: "Reason Code"
      expr: reason_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Relinquishment"
      expr: COUNT(DISTINCT relinquishment_id)
    - name: "Total Area Relinquished Hectares"
      expr: SUM(area_relinquished_hectares)
    - name: "Average Area Relinquished Hectares"
      expr: AVG(area_relinquished_hectares)
    - name: "Total Financial Impact Amount"
      expr: SUM(financial_impact_amount)
    - name: "Average Financial Impact Amount"
      expr: AVG(financial_impact_amount)
    - name: "Total Percentage"
      expr: SUM(percentage)
    - name: "Average Percentage"
      expr: AVG(percentage)
    - name: "Total Remaining Area Hectares"
      expr: SUM(remaining_area_hectares)
    - name: "Average Remaining Area Hectares"
      expr: AVG(remaining_area_hectares)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_renewal_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Renewal Obligation business metrics"
  source: "`mining_ecm`.`tenement`.`renewal_obligation`"
  dimensions:
    - name: "Alert Notification Date"
      expr: alert_notification_date
    - name: "Area Relinquishment Required Flag"
      expr: area_relinquishment_required_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Decision Date"
      expr: decision_date
    - name: "Environmental Compliance Status"
      expr: environmental_compliance_status
    - name: "Expenditure Commitment Currency Code"
      expr: expenditure_commitment_currency_code
    - name: "Heritage Clearance Required Flag"
      expr: heritage_clearance_required_flag
    - name: "Heritage Clearance Status"
      expr: heritage_clearance_status
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lodgement Deadline Date"
      expr: lodgement_deadline_date
    - name: "Lodgement Submitted Date"
      expr: lodgement_submitted_date
    - name: "Native Title Clearance Required Flag"
      expr: native_title_clearance_required_flag
    - name: "Native Title Clearance Status"
      expr: native_title_clearance_status
    - name: "New Expiry Date"
      expr: new_expiry_date
    - name: "Notes"
      expr: notes
    - name: "Regulatory Authority Name"
      expr: regulatory_authority_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Renewal Obligation"
      expr: COUNT(DISTINCT renewal_obligation_id)
    - name: "Total Expenditure Commitment Amount"
      expr: SUM(expenditure_commitment_amount)
    - name: "Average Expenditure Commitment Amount"
      expr: AVG(expenditure_commitment_amount)
    - name: "Total Relinquishment Area Hectares"
      expr: SUM(relinquishment_area_hectares)
    - name: "Average Relinquishment Area Hectares"
      expr: AVG(relinquishment_area_hectares)
    - name: "Total Relinquishment Percentage"
      expr: SUM(relinquishment_percentage)
    - name: "Average Relinquishment Percentage"
      expr: AVG(relinquishment_percentage)
    - name: "Total Renewal Fee Amount"
      expr: SUM(renewal_fee_amount)
    - name: "Average Renewal Fee Amount"
      expr: AVG(renewal_fee_amount)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_royalty_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Royalty Agreement business metrics"
  source: "`mining_ecm`.`tenement`.`royalty_agreement`"
  dimensions:
    - name: "Accrual Method"
      expr: accrual_method
    - name: "Agreement Name"
      expr: agreement_name
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Applicable Commodity"
      expr: applicable_commodity
    - name: "Assignment Restrictions"
      expr: assignment_restrictions
    - name: "Audit Rights"
      expr: audit_rights
    - name: "Calculation Basis"
      expr: calculation_basis
    - name: "Contract Document Reference"
      expr: contract_document_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Classification"
      expr: data_classification
    - name: "Deduction Allowances"
      expr: deduction_allowances
    - name: "Dispute Resolution Mechanism"
      expr: dispute_resolution_mechanism
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Royalty Agreement"
      expr: COUNT(DISTINCT royalty_agreement_id)
    - name: "Total Maximum Royalty Amount"
      expr: SUM(maximum_royalty_amount)
    - name: "Average Maximum Royalty Amount"
      expr: AVG(maximum_royalty_amount)
    - name: "Total Minimum Royalty Amount"
      expr: SUM(minimum_royalty_amount)
    - name: "Average Minimum Royalty Amount"
      expr: AVG(minimum_royalty_amount)
    - name: "Total Royalty Rate"
      expr: SUM(royalty_rate)
    - name: "Average Royalty Rate"
      expr: AVG(royalty_rate)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_royalty_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Royalty Payment business metrics"
  source: "`mining_ecm`.`tenement`.`royalty_payment`"
  dimensions:
    - name: "Actual Payment Date"
      expr: actual_payment_date
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Calculation Date"
      expr: calculation_date
    - name: "Commodity Type"
      expr: commodity_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Finance Gl Account Code"
      expr: finance_gl_account_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Payee Account Reference"
      expr: payee_account_reference
    - name: "Payee Name"
      expr: payee_name
    - name: "Payee Type"
      expr: payee_type
    - name: "Payment Due Date"
      expr: payment_due_date
    - name: "Payment Reference Number"
      expr: payment_reference_number
    - name: "Payment Status"
      expr: payment_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Royalty Payment"
      expr: COUNT(DISTINCT royalty_payment_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Calculated Royalty Amount"
      expr: SUM(calculated_royalty_amount)
    - name: "Average Calculated Royalty Amount"
      expr: AVG(calculated_royalty_amount)
    - name: "Total Commodity Grade Percent"
      expr: SUM(commodity_grade_percent)
    - name: "Average Commodity Grade Percent"
      expr: AVG(commodity_grade_percent)
    - name: "Total Net Royalty Amount"
      expr: SUM(net_royalty_amount)
    - name: "Average Net Royalty Amount"
      expr: AVG(net_royalty_amount)
    - name: "Total Production Tonnage"
      expr: SUM(production_tonnage)
    - name: "Average Production Tonnage"
      expr: AVG(production_tonnage)
    - name: "Total Production Value Amount"
      expr: SUM(production_value_amount)
    - name: "Average Production Value Amount"
      expr: AVG(production_value_amount)
    - name: "Total Royalty Rate Percent"
      expr: SUM(royalty_rate_percent)
    - name: "Average Royalty Rate Percent"
      expr: AVG(royalty_rate_percent)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_surface_right`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Surface Right business metrics"
  source: "`mining_ecm`.`tenement`.`surface_right`"
  dimensions:
    - name: "Agreement Document Reference"
      expr: agreement_document_reference
    - name: "Area Description"
      expr: area_description
    - name: "Compensation Currency"
      expr: compensation_currency
    - name: "Compensation Frequency"
      expr: compensation_frequency
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Environmental Conditions"
      expr: environmental_conditions
    - name: "Gis Boundary Reference"
      expr: gis_boundary_reference
    - name: "Grantor Contact Email"
      expr: grantor_contact_email
    - name: "Grantor Contact Name"
      expr: grantor_contact_name
    - name: "Grantor Contact Phone"
      expr: grantor_contact_phone
    - name: "Grantor Name"
      expr: grantor_name
    - name: "Grantor Type"
      expr: grantor_type
    - name: "Heritage Clearance Flag"
      expr: heritage_clearance_flag
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Surface Right"
      expr: COUNT(DISTINCT surface_right_id)
    - name: "Total Area Hectares"
      expr: SUM(area_hectares)
    - name: "Average Area Hectares"
      expr: AVG(area_hectares)
    - name: "Total Compensation Amount"
      expr: SUM(compensation_amount)
    - name: "Average Compensation Amount"
      expr: AVG(compensation_amount)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_tenement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tenement business metrics"
  source: "`mining_ecm`.`tenement`.`tenement`"
  dimensions:
    - name: "Application Date"
      expr: application_date
    - name: "Coordinate System"
      expr: coordinate_system
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Environmental Conditions"
      expr: environmental_conditions
    - name: "Expenditure Currency"
      expr: expenditure_currency
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Gis Boundary Reference"
      expr: gis_boundary_reference
    - name: "Grant Date"
      expr: grant_date
    - name: "Granted Commodities"
      expr: granted_commodities
    - name: "Heritage Clearance Status"
      expr: heritage_clearance_status
    - name: "Holder Name"
      expr: holder_name
    - name: "Joint Venture Flag"
      expr: joint_venture_flag
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tenement"
      expr: COUNT(DISTINCT tenement_id)
    - name: "Total Annual Expenditure Commitment"
      expr: SUM(annual_expenditure_commitment)
    - name: "Average Annual Expenditure Commitment"
      expr: AVG(annual_expenditure_commitment)
    - name: "Total Area Hectares"
      expr: SUM(area_hectares)
    - name: "Average Area Hectares"
      expr: AVG(area_hectares)
    - name: "Total Centroid Latitude"
      expr: SUM(centroid_latitude)
    - name: "Average Centroid Latitude"
      expr: AVG(centroid_latitude)
    - name: "Total Centroid Longitude"
      expr: SUM(centroid_longitude)
    - name: "Average Centroid Longitude"
      expr: AVG(centroid_longitude)
    - name: "Total Holder Percentage"
      expr: SUM(holder_percentage)
    - name: "Average Holder Percentage"
      expr: AVG(holder_percentage)
    - name: "Total Royalty Rate Percent"
      expr: SUM(royalty_rate_percent)
    - name: "Average Royalty Rate Percent"
      expr: AVG(royalty_rate_percent)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_tenement_recovery_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tenement Recovery Target business metrics"
  source: "`mining_ecm`.`tenement`.`tenement_recovery_target`"
  dimensions:
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Ore Type"
      expr: ore_type
    - name: "Effective From Date Month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
    - name: "Effective To Date Month"
      expr: DATE_TRUNC('MONTH', effective_to_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tenement Recovery Target"
      expr: COUNT(DISTINCT tenement_recovery_target_id)
    - name: "Total Target Recovery Pct"
      expr: SUM(target_recovery_pct)
    - name: "Average Target Recovery Pct"
      expr: AVG(target_recovery_pct)
    - name: "Total Target Throughput Tph"
      expr: SUM(target_throughput_tph)
    - name: "Average Target Throughput Tph"
      expr: AVG(target_throughput_tph)
    - name: "Total Tenement Contribution Pct"
      expr: SUM(tenement_contribution_pct)
    - name: "Average Tenement Contribution Pct"
      expr: AVG(tenement_contribution_pct)
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transfer business metrics"
  source: "`mining_ecm`.`tenement`.`transfer`"
  dimensions:
    - name: "Agreement Document Reference"
      expr: agreement_document_reference
    - name: "Completion Date"
      expr: completion_date
    - name: "Consideration Currency Code"
      expr: consideration_currency_code
    - name: "Contingent Payment Flag"
      expr: contingent_payment_flag
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Due Diligence Completion Date"
      expr: due_diligence_completion_date
    - name: "Effective Date"
      expr: effective_date
    - name: "Environmental Approval Flag"
      expr: environmental_approval_flag
    - name: "Expenditure Commitment Transferred Flag"
      expr: expenditure_commitment_transferred_flag
    - name: "Heritage Clearance Flag"
      expr: heritage_clearance_flag
    - name: "Last Modified By User"
      expr: last_modified_by_user
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Native Title Consent Date"
      expr: native_title_consent_date
    - name: "Native Title Consent Flag"
      expr: native_title_consent_flag
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Transfer"
      expr: COUNT(DISTINCT transfer_id)
    - name: "Total Consideration Amount"
      expr: SUM(consideration_amount)
    - name: "Average Consideration Amount"
      expr: AVG(consideration_amount)
    - name: "Total Interest Percentage Transferred"
      expr: SUM(interest_percentage_transferred)
    - name: "Average Interest Percentage Transferred"
      expr: AVG(interest_percentage_transferred)
    - name: "Total Transferor Retained Interest Percentage"
      expr: SUM(transferor_retained_interest_percentage)
    - name: "Average Transferor Retained Interest Percentage"
      expr: AVG(transferor_retained_interest_percentage)
$$;