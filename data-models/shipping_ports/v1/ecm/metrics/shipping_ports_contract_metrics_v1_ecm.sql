-- Metric views for domain: contract | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 03:38:16

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`contract_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agreement business metrics"
  source: "`shipping_ports_ecm`.`contract`.`agreement`"
  dimensions:
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Alliance Membership"
      expr: alliance_membership
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Concession Term Years"
      expr: concession_term_years
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crm Opportunity Reference"
      expr: crm_opportunity_reference
    - name: "Currency Code"
      expr: currency_code
    - name: "Document Reference"
      expr: document_reference
    - name: "Edi Required Flag"
      expr: edi_required_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Governing Law"
      expr: governing_law
    - name: "Insurance Required Flag"
      expr: insurance_required_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Agreement"
      expr: COUNT(DISTINCT agreement_id)
    - name: "Total Contract Value"
      expr: SUM(contract_value)
    - name: "Average Contract Value"
      expr: AVG(contract_value)
    - name: "Total Credit Limit Amount"
      expr: SUM(credit_limit_amount)
    - name: "Average Credit Limit Amount"
      expr: AVG(credit_limit_amount)
    - name: "Total Insurance Coverage Amount"
      expr: SUM(insurance_coverage_amount)
    - name: "Average Insurance Coverage Amount"
      expr: AVG(insurance_coverage_amount)
    - name: "Total Investment Commitment Amount"
      expr: SUM(investment_commitment_amount)
    - name: "Average Investment Commitment Amount"
      expr: AVG(investment_commitment_amount)
    - name: "Total Magr Amount"
      expr: SUM(magr_amount)
    - name: "Average Magr Amount"
      expr: AVG(magr_amount)
    - name: "Total Revenue Share Percentage"
      expr: SUM(revenue_share_percentage)
    - name: "Average Revenue Share Percentage"
      expr: AVG(revenue_share_percentage)
    - name: "Total Security Deposit Amount"
      expr: SUM(security_deposit_amount)
    - name: "Average Security Deposit Amount"
      expr: AVG(security_deposit_amount)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`contract_agreement_party`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agreement Party business metrics"
  source: "`shipping_ports_ecm`.`contract`.`agreement_party`"
  dimensions:
    - name: "Amendment Count"
      expr: amendment_count
    - name: "Authorized Representative Email"
      expr: authorized_representative_email
    - name: "Authorized Representative Name"
      expr: authorized_representative_name
    - name: "Authorized Representative Phone"
      expr: authorized_representative_phone
    - name: "Compliance Certifications Required"
      expr: compliance_certifications_required
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Limit Currency"
      expr: credit_limit_currency
    - name: "Dispute Resolution Method"
      expr: dispute_resolution_method
    - name: "Governing Law Jurisdiction"
      expr: governing_law_jurisdiction
    - name: "Guarantee Currency"
      expr: guarantee_currency
    - name: "Guarantee Expiry Date"
      expr: guarantee_expiry_date
    - name: "Guarantee Instrument Type"
      expr: guarantee_instrument_type
    - name: "Indemnity Scope"
      expr: indemnity_scope
    - name: "Insurance Coverage Currency"
      expr: insurance_coverage_currency
    - name: "Insurance Coverage Types"
      expr: insurance_coverage_types
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Agreement Party"
      expr: COUNT(DISTINCT agreement_party_id)
    - name: "Total Credit Limit Amount"
      expr: SUM(credit_limit_amount)
    - name: "Average Credit Limit Amount"
      expr: AVG(credit_limit_amount)
    - name: "Total Guarantee Amount"
      expr: SUM(guarantee_amount)
    - name: "Average Guarantee Amount"
      expr: AVG(guarantee_amount)
    - name: "Total Insurance Minimum Coverage"
      expr: SUM(insurance_minimum_coverage)
    - name: "Average Insurance Minimum Coverage"
      expr: AVG(insurance_minimum_coverage)
    - name: "Total Liability Cap Amount"
      expr: SUM(liability_cap_amount)
    - name: "Average Liability Cap Amount"
      expr: AVG(liability_cap_amount)
    - name: "Total Performance Bond Amount"
      expr: SUM(performance_bond_amount)
    - name: "Average Performance Bond Amount"
      expr: AVG(performance_bond_amount)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`contract_agreement_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agreement Version business metrics"
  source: "`shipping_ports_ecm`.`contract`.`agreement_version`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Change Reason"
      expr: change_reason
    - name: "Change Summary"
      expr: change_summary
    - name: "Change Type"
      expr: change_type
    - name: "Counterparty Acceptance Date"
      expr: counterparty_acceptance_date
    - name: "Counterparty Acceptance Required"
      expr: counterparty_acceptance_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Format"
      expr: document_format
    - name: "Document Reference"
      expr: document_reference
    - name: "Financial Impact Flag"
      expr: financial_impact_flag
    - name: "Financial Impact Summary"
      expr: financial_impact_summary
    - name: "Legal Review Date"
      expr: legal_review_date
    - name: "Legal Review Required"
      expr: legal_review_required
    - name: "Legal Reviewer"
      expr: legal_reviewer
    - name: "Modified By"
      expr: modified_by
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Agreement Version"
      expr: COUNT(DISTINCT agreement_version_id)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`contract_contract_document`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract Document business metrics"
  source: "`shipping_ports_ecm`.`contract`.`contract_document`"
  dimensions:
    - name: "Access Count"
      expr: access_count
    - name: "Checksum Hash"
      expr: checksum_hash
    - name: "Classification"
      expr: classification
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Disposal Eligible Date"
      expr: disposal_eligible_date
    - name: "Document Date"
      expr: document_date
    - name: "Document Number"
      expr: document_number
    - name: "Document Status"
      expr: document_status
    - name: "Document Type"
      expr: document_type
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "File Format"
      expr: file_format
    - name: "File Reference"
      expr: file_reference
    - name: "Issuing Authority"
      expr: issuing_authority
    - name: "Keywords"
      expr: keywords
    - name: "Language"
      expr: language
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contract Document"
      expr: COUNT(DISTINCT contract_document_id)
    - name: "Total File Size Bytes"
      expr: SUM(file_size_bytes)
    - name: "Average File Size Bytes"
      expr: AVG(file_size_bytes)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`contract_dispute_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispute Record business metrics"
  source: "`shipping_ports_ecm`.`contract`.`dispute_record`"
  dimensions:
    - name: "Arbitration Body"
      expr: arbitration_body
    - name: "Confidentiality Flag"
      expr: confidentiality_flag
    - name: "Corrective Action Taken"
      expr: corrective_action_taken
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Description"
      expr: dispute_description
    - name: "Dispute Number"
      expr: dispute_number
    - name: "Dispute Status"
      expr: dispute_status
    - name: "Dispute Type"
      expr: dispute_type
    - name: "Disputed Clause Reference"
      expr: disputed_clause_reference
    - name: "Escalation Level"
      expr: escalation_level
    - name: "Governing Law"
      expr: governing_law
    - name: "Impact On Relationship"
      expr: impact_on_relationship
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Legal Representative Counterparty"
      expr: legal_representative_counterparty
    - name: "Legal Representative Port"
      expr: legal_representative_port
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dispute Record"
      expr: COUNT(DISTINCT dispute_record_id)
    - name: "Total Final Settled Amount"
      expr: SUM(final_settled_amount)
    - name: "Average Final Settled Amount"
      expr: AVG(final_settled_amount)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`contract_guarantee_bond`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guarantee Bond business metrics"
  source: "`shipping_ports_ecm`.`contract`.`guarantee_bond`"
  dimensions:
    - name: "Arbitration Body"
      expr: arbitration_body
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Beneficiary Name"
      expr: beneficiary_name
    - name: "Bond Fee Currency Code"
      expr: bond_fee_currency_code
    - name: "Bond Fee Frequency"
      expr: bond_fee_frequency
    - name: "Bond Number"
      expr: bond_number
    - name: "Bond Provider Credit Rating"
      expr: bond_provider_credit_rating
    - name: "Bond Status"
      expr: bond_status
    - name: "Bond Type"
      expr: bond_type
    - name: "Claim Conditions"
      expr: claim_conditions
    - name: "Claim Notice Period Days"
      expr: claim_notice_period_days
    - name: "Claim Procedure"
      expr: claim_procedure
    - name: "Compliance Framework"
      expr: compliance_framework
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Resolution Method"
      expr: dispute_resolution_method
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Guarantee Bond"
      expr: COUNT(DISTINCT guarantee_bond_id)
    - name: "Total Bond Fee Amount"
      expr: SUM(bond_fee_amount)
    - name: "Average Bond Fee Amount"
      expr: AVG(bond_fee_amount)
    - name: "Total Bond Value"
      expr: SUM(bond_value)
    - name: "Average Bond Value"
      expr: AVG(bond_value)
    - name: "Total Remaining Bond Value"
      expr: SUM(remaining_bond_value)
    - name: "Average Remaining Bond Value"
      expr: AVG(remaining_bond_value)
    - name: "Total Total Claimed Amount"
      expr: SUM(total_claimed_amount)
    - name: "Average Total Claimed Amount"
      expr: AVG(total_claimed_amount)
    - name: "Total Total Paid Amount"
      expr: SUM(total_paid_amount)
    - name: "Average Total Paid Amount"
      expr: AVG(total_paid_amount)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`contract_penalty_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Penalty Assessment business metrics"
  source: "`shipping_ports_ecm`.`contract`.`penalty_assessment`"
  dimensions:
    - name: "Approved Date"
      expr: approved_date
    - name: "Assessed Metric Name"
      expr: assessed_metric_name
    - name: "Assessed Unit Of Measure"
      expr: assessed_unit_of_measure
    - name: "Assessment Date"
      expr: assessment_date
    - name: "Assessment Number"
      expr: assessment_number
    - name: "Assessment Period End"
      expr: assessment_period_end
    - name: "Assessment Period Start"
      expr: assessment_period_start
    - name: "Assessment Status"
      expr: assessment_status
    - name: "Assessment Type"
      expr: assessment_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Date"
      expr: dispute_date
    - name: "Dispute Flag"
      expr: dispute_flag
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Dispute Resolution Date"
      expr: dispute_resolution_date
    - name: "Exemption Applied Flag"
      expr: exemption_applied_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Penalty Assessment"
      expr: COUNT(DISTINCT penalty_assessment_id)
    - name: "Total Adjusted Amount"
      expr: SUM(adjusted_amount)
    - name: "Average Adjusted Amount"
      expr: AVG(adjusted_amount)
    - name: "Total Assessed Value"
      expr: SUM(assessed_value)
    - name: "Average Assessed Value"
      expr: AVG(assessed_value)
    - name: "Total Exemption Amount"
      expr: SUM(exemption_amount)
    - name: "Average Exemption Amount"
      expr: AVG(exemption_amount)
    - name: "Total Final Amount"
      expr: SUM(final_amount)
    - name: "Average Final Amount"
      expr: AVG(final_amount)
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Rate Applied"
      expr: SUM(rate_applied)
    - name: "Average Rate Applied"
      expr: AVG(rate_applied)
    - name: "Total Threshold Value"
      expr: SUM(threshold_value)
    - name: "Average Threshold Value"
      expr: AVG(threshold_value)
    - name: "Total Variance Value"
      expr: SUM(variance_value)
    - name: "Average Variance Value"
      expr: AVG(variance_value)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`contract_penalty_clause`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Penalty Clause business metrics"
  source: "`shipping_ports_ecm`.`contract`.`penalty_clause`"
  dimensions:
    - name: "Assessment Frequency"
      expr: assessment_frequency
    - name: "Calculation Method"
      expr: calculation_method
    - name: "Clause Reference Number"
      expr: clause_reference_number
    - name: "Clause Status"
      expr: clause_status
    - name: "Clause Type"
      expr: clause_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cumulative Trigger Flag"
      expr: cumulative_trigger_flag
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Resolution Process"
      expr: dispute_resolution_process
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective Until Date"
      expr: effective_until_date
    - name: "Grace Period Unit"
      expr: grace_period_unit
    - name: "Grace Period Value"
      expr: grace_period_value
    - name: "Last Modified By User"
      expr: last_modified_by_user
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Measurement Period Type"
      expr: measurement_period_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Penalty Clause"
      expr: COUNT(DISTINCT penalty_clause_id)
    - name: "Total Incentive Maximum Cap Amount"
      expr: SUM(incentive_maximum_cap_amount)
    - name: "Average Incentive Maximum Cap Amount"
      expr: AVG(incentive_maximum_cap_amount)
    - name: "Total Incentive Rate Value"
      expr: SUM(incentive_rate_value)
    - name: "Average Incentive Rate Value"
      expr: AVG(incentive_rate_value)
    - name: "Total Penalty Maximum Cap Amount"
      expr: SUM(penalty_maximum_cap_amount)
    - name: "Average Penalty Maximum Cap Amount"
      expr: AVG(penalty_maximum_cap_amount)
    - name: "Total Penalty Rate Value"
      expr: SUM(penalty_rate_value)
    - name: "Average Penalty Rate Value"
      expr: AVG(penalty_rate_value)
    - name: "Total Trigger Threshold Value"
      expr: SUM(trigger_threshold_value)
    - name: "Average Trigger Threshold Value"
      expr: AVG(trigger_threshold_value)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`contract_pil_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pil Arrangement business metrics"
  source: "`shipping_ports_ecm`.`contract`.`pil_arrangement`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Arrangement Code"
      expr: arrangement_code
    - name: "Arrangement Name"
      expr: arrangement_name
    - name: "Arrangement Status"
      expr: arrangement_status
    - name: "Audit Trail Required"
      expr: audit_trail_required
    - name: "Calculation Basis"
      expr: calculation_basis
    - name: "Collection Responsibility"
      expr: collection_responsibility
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dispute Resolution Mechanism"
      expr: dispute_resolution_mechanism
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Escalation Clause"
      expr: escalation_clause
    - name: "Exemption Flag"
      expr: exemption_flag
    - name: "Exemption Reason"
      expr: exemption_reason
    - name: "Last Escalation Date"
      expr: last_escalation_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pil Arrangement"
      expr: COUNT(DISTINCT pil_arrangement_id)
    - name: "Total Escalation Rate"
      expr: SUM(escalation_rate)
    - name: "Average Escalation Rate"
      expr: AVG(escalation_rate)
    - name: "Total Exemption Percentage"
      expr: SUM(exemption_percentage)
    - name: "Average Exemption Percentage"
      expr: AVG(exemption_percentage)
    - name: "Total Maximum Levy Amount"
      expr: SUM(maximum_levy_amount)
    - name: "Average Maximum Levy Amount"
      expr: AVG(maximum_levy_amount)
    - name: "Total Minimum Levy Amount"
      expr: SUM(minimum_levy_amount)
    - name: "Average Minimum Levy Amount"
      expr: AVG(minimum_levy_amount)
    - name: "Total Rate Value"
      expr: SUM(rate_value)
    - name: "Average Rate Value"
      expr: AVG(rate_value)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`contract_rate_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate Schedule business metrics"
  source: "`shipping_ports_ecm`.`contract`.`rate_schedule`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Billing Cycle"
      expr: billing_cycle
    - name: "Calculation Basis"
      expr: calculation_basis
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Escalation Clause Flag"
      expr: escalation_clause_flag
    - name: "Escalation Frequency"
      expr: escalation_frequency
    - name: "Escalation Index"
      expr: escalation_index
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Free Time Days"
      expr: free_time_days
    - name: "Grace Period Hours"
      expr: grace_period_hours
    - name: "Hazmat Surcharge Flag"
      expr: hazmat_surcharge_flag
    - name: "Imdg Class"
      expr: imdg_class
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rate Schedule"
      expr: COUNT(DISTINCT rate_schedule_id)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Escalation Percentage"
      expr: SUM(escalation_percentage)
    - name: "Average Escalation Percentage"
      expr: AVG(escalation_percentage)
    - name: "Total Grt Lower Bound"
      expr: SUM(grt_lower_bound)
    - name: "Average Grt Lower Bound"
      expr: AVG(grt_lower_bound)
    - name: "Total Grt Upper Bound"
      expr: SUM(grt_upper_bound)
    - name: "Average Grt Upper Bound"
      expr: AVG(grt_upper_bound)
    - name: "Total Maximum Charge"
      expr: SUM(maximum_charge)
    - name: "Average Maximum Charge"
      expr: AVG(maximum_charge)
    - name: "Total Minimum Charge"
      expr: SUM(minimum_charge)
    - name: "Average Minimum Charge"
      expr: AVG(minimum_charge)
    - name: "Total Peak Season Surcharge"
      expr: SUM(peak_season_surcharge)
    - name: "Average Peak Season Surcharge"
      expr: AVG(peak_season_surcharge)
    - name: "Total Rate Value"
      expr: SUM(rate_value)
    - name: "Average Rate Value"
      expr: AVG(rate_value)
    - name: "Total Tax Rate Percentage"
      expr: SUM(tax_rate_percentage)
    - name: "Average Tax Rate Percentage"
      expr: AVG(tax_rate_percentage)
    - name: "Total Volume Threshold"
      expr: SUM(volume_threshold)
    - name: "Average Volume Threshold"
      expr: AVG(volume_threshold)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`contract_service_scope`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service Scope business metrics"
  source: "`shipping_ports_ecm`.`contract`.`service_scope`"
  dimensions:
    - name: "Amendment Number"
      expr: amendment_number
    - name: "Approval Date"
      expr: approval_date
    - name: "Billing Basis"
      expr: billing_basis
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crew Competency Required"
      expr: crew_competency_required
    - name: "Customs Clearance Included"
      expr: customs_clearance_included
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Environmental Compliance Required"
      expr: environmental_compliance_required
    - name: "Equipment Type Required"
      expr: equipment_type_required
    - name: "Exclusions"
      expr: exclusions
    - name: "Imdg Handling Authorized"
      expr: imdg_handling_authorized
    - name: "Isps Security Level"
      expr: isps_security_level
    - name: "Last Amended Date"
      expr: last_amended_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Service Scope"
      expr: COUNT(DISTINCT service_scope_id)
    - name: "Total Sla Target Turnaround Hours"
      expr: SUM(sla_target_turnaround_hours)
    - name: "Average Sla Target Turnaround Hours"
      expr: AVG(sla_target_turnaround_hours)
    - name: "Total Throughput Guarantee Amount"
      expr: SUM(throughput_guarantee_amount)
    - name: "Average Throughput Guarantee Amount"
      expr: AVG(throughput_guarantee_amount)
    - name: "Total Volume Commitment Dwt"
      expr: SUM(volume_commitment_dwt)
    - name: "Average Volume Commitment Dwt"
      expr: AVG(volume_commitment_dwt)
    - name: "Total Volume Commitment Teu"
      expr: SUM(volume_commitment_teu)
    - name: "Average Volume Commitment Teu"
      expr: AVG(volume_commitment_teu)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`contract_sla_breach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sla Breach business metrics"
  source: "`shipping_ports_ecm`.`contract`.`sla_breach`"
  dimensions:
    - name: "Breach Date"
      expr: breach_date
    - name: "Breach Notification Date"
      expr: breach_notification_date
    - name: "Breach Number"
      expr: breach_number
    - name: "Breach Severity"
      expr: breach_severity
    - name: "Breach Status"
      expr: breach_status
    - name: "Breach Timestamp"
      expr: breach_timestamp
    - name: "Communication Log"
      expr: communication_log
    - name: "Counterparty Acknowledgement Date"
      expr: counterparty_acknowledgement_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dispute Outcome"
      expr: dispute_outcome
    - name: "Dispute Raised Flag"
      expr: dispute_raised_flag
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Dispute Resolution Date"
      expr: dispute_resolution_date
    - name: "Escalation Date"
      expr: escalation_date
    - name: "Escalation Level"
      expr: escalation_level
    - name: "Impact Assessment"
      expr: impact_assessment
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sla Breach"
      expr: COUNT(DISTINCT sla_breach_id)
    - name: "Total Actual Value"
      expr: SUM(actual_value)
    - name: "Average Actual Value"
      expr: AVG(actual_value)
    - name: "Total Breach Duration Hours"
      expr: SUM(breach_duration_hours)
    - name: "Average Breach Duration Hours"
      expr: AVG(breach_duration_hours)
    - name: "Total Deviation Percentage"
      expr: SUM(deviation_percentage)
    - name: "Average Deviation Percentage"
      expr: AVG(deviation_percentage)
    - name: "Total Deviation Value"
      expr: SUM(deviation_value)
    - name: "Average Deviation Value"
      expr: AVG(deviation_value)
    - name: "Total Threshold Value"
      expr: SUM(threshold_value)
    - name: "Average Threshold Value"
      expr: AVG(threshold_value)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`contract_sla_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sla Definition business metrics"
  source: "`shipping_ports_ecm`.`contract`.`sla_definition`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Compliance Framework"
      expr: compliance_framework
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Segment"
      expr: customer_segment
    - name: "Data Source System"
      expr: data_source_system
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Escalation Required Flag"
      expr: escalation_required_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Measurement Frequency"
      expr: measurement_frequency
    - name: "Measurement Methodology"
      expr: measurement_methodology
    - name: "Measurement Unit"
      expr: measurement_unit
    - name: "Notes"
      expr: notes
    - name: "Penalty Applicable Flag"
      expr: penalty_applicable_flag
    - name: "Penalty Calculation Method"
      expr: penalty_calculation_method
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sla Definition"
      expr: COUNT(DISTINCT sla_definition_id)
    - name: "Total Critical Threshold"
      expr: SUM(critical_threshold)
    - name: "Average Critical Threshold"
      expr: AVG(critical_threshold)
    - name: "Total Target Threshold"
      expr: SUM(target_threshold)
    - name: "Average Target Threshold"
      expr: AVG(target_threshold)
    - name: "Total Warning Threshold"
      expr: SUM(warning_threshold)
    - name: "Average Warning Threshold"
      expr: AVG(warning_threshold)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`contract_sla_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sla Measurement business metrics"
  source: "`shipping_ports_ecm`.`contract`.`sla_measurement`"
  dimensions:
    - name: "Adjustment Reason"
      expr: adjustment_reason
    - name: "Billing Period"
      expr: billing_period
    - name: "Breach Notification Timestamp"
      expr: breach_notification_timestamp
    - name: "Breach Notification Triggered"
      expr: breach_notification_triggered
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dispute Raised Flag"
      expr: dispute_raised_flag
    - name: "Dispute Resolution Date"
      expr: dispute_resolution_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Measurement Approved Timestamp"
      expr: measurement_approved_timestamp
    - name: "Measurement Date"
      expr: measurement_date
    - name: "Measurement Notes"
      expr: measurement_notes
    - name: "Measurement Period End Date"
      expr: measurement_period_end_date
    - name: "Measurement Period Start Date"
      expr: measurement_period_start_date
    - name: "Measurement Period Type"
      expr: measurement_period_type
    - name: "Measurement Source System"
      expr: measurement_source_system
    - name: "Measurement Status"
      expr: measurement_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sla Measurement"
      expr: COUNT(DISTINCT sla_measurement_id)
    - name: "Total Actual Value"
      expr: SUM(actual_value)
    - name: "Average Actual Value"
      expr: AVG(actual_value)
    - name: "Total Adjusted Actual Value"
      expr: SUM(adjusted_actual_value)
    - name: "Average Adjusted Actual Value"
      expr: AVG(adjusted_actual_value)
    - name: "Total Incentive Amount"
      expr: SUM(incentive_amount)
    - name: "Average Incentive Amount"
      expr: AVG(incentive_amount)
    - name: "Total Penalty Amount"
      expr: SUM(penalty_amount)
    - name: "Average Penalty Amount"
      expr: AVG(penalty_amount)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
    - name: "Total Variance Absolute"
      expr: SUM(variance_absolute)
    - name: "Average Variance Absolute"
      expr: AVG(variance_absolute)
    - name: "Total Variance Percentage"
      expr: SUM(variance_percentage)
    - name: "Average Variance Percentage"
      expr: AVG(variance_percentage)
    - name: "Total Volume Shortfall"
      expr: SUM(volume_shortfall)
    - name: "Average Volume Shortfall"
      expr: AVG(volume_shortfall)
    - name: "Total Volume Surplus"
      expr: SUM(volume_surplus)
    - name: "Average Volume Surplus"
      expr: AVG(volume_surplus)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`contract_volume_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volume Commitment business metrics"
  source: "`shipping_ports_ecm`.`contract`.`volume_commitment`"
  dimensions:
    - name: "Auto Renew Flag"
      expr: auto_renew_flag
    - name: "Commitment Period Type"
      expr: commitment_period_type
    - name: "Commitment Reference Number"
      expr: commitment_reference_number
    - name: "Commitment Status"
      expr: commitment_status
    - name: "Commitment Type"
      expr: commitment_type
    - name: "Commitment Unit"
      expr: commitment_unit
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dispute Raised Date"
      expr: dispute_raised_date
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Incentive Currency Code"
      expr: incentive_currency_code
    - name: "Incentive Type"
      expr: incentive_type
    - name: "Last Measurement Date"
      expr: last_measurement_date
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Volume Commitment"
      expr: COUNT(DISTINCT volume_commitment_id)
    - name: "Total Actual Volume To Date"
      expr: SUM(actual_volume_to_date)
    - name: "Average Actual Volume To Date"
      expr: AVG(actual_volume_to_date)
    - name: "Total Committed Volume"
      expr: SUM(committed_volume)
    - name: "Average Committed Volume"
      expr: AVG(committed_volume)
    - name: "Total Excess Volume"
      expr: SUM(excess_volume)
    - name: "Average Excess Volume"
      expr: AVG(excess_volume)
    - name: "Total Incentive Amount Earned"
      expr: SUM(incentive_amount_earned)
    - name: "Average Incentive Amount Earned"
      expr: AVG(incentive_amount_earned)
    - name: "Total Incentive Rate"
      expr: SUM(incentive_rate)
    - name: "Average Incentive Rate"
      expr: AVG(incentive_rate)
    - name: "Total Penalty Amount Assessed"
      expr: SUM(penalty_amount_assessed)
    - name: "Average Penalty Amount Assessed"
      expr: AVG(penalty_amount_assessed)
    - name: "Total Penalty Rate"
      expr: SUM(penalty_rate)
    - name: "Average Penalty Rate"
      expr: AVG(penalty_rate)
    - name: "Total Shortfall Volume"
      expr: SUM(shortfall_volume)
    - name: "Average Shortfall Volume"
      expr: AVG(shortfall_volume)
$$;