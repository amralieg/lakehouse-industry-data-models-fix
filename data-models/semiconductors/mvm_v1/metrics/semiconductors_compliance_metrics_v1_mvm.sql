-- Metric views for domain: compliance | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 20:31:31

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`compliance_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certification business metrics"
  source: "`semiconductors_ecm`.`compliance`.`certification`"
  dimensions:
    - name: "Audit Findings Summary"
      expr: audit_findings_summary
    - name: "Audit Frequency Months"
      expr: audit_frequency_months
    - name: "Audit Report Url"
      expr: audit_report_url
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Certification Status"
      expr: certification_status
    - name: "Certification Type"
      expr: certification_type
    - name: "Certifying Body"
      expr: certifying_body
    - name: "Compliance Category"
      expr: compliance_category
    - name: "Compliance Risk Level"
      expr: compliance_risk_level
    - name: "Compliance Status Effective Date"
      expr: compliance_status_effective_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Url"
      expr: document_url
    - name: "Expiration Notice Date"
      expr: expiration_notice_date
    - name: "Expiration Notice Sent"
      expr: expiration_notice_sent
    - name: "Expiry Date"
      expr: expiry_date
    - name: "External Audit Agency"
      expr: external_audit_agency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Certification"
      expr: COUNT(DISTINCT certification_id)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`compliance_chips_act_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chips Act Obligation business metrics"
  source: "`semiconductors_ecm`.`compliance`.`chips_act_obligation`"
  dimensions:
    - name: "Award Reference"
      expr: award_reference
    - name: "Childcare Provision"
      expr: childcare_provision
    - name: "Chips Act Obligation Status"
      expr: chips_act_obligation_status
    - name: "Clawback Condition"
      expr: clawback_condition
    - name: "Compliance Metric"
      expr: compliance_metric
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Domestic Production Commitment"
      expr: domestic_production_commitment
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Evidence Document Path"
      expr: evidence_document_path
    - name: "Funding Currency"
      expr: funding_currency
    - name: "Guardrail Restriction"
      expr: guardrail_restriction
    - name: "Last Reported Date"
      expr: last_reported_date
    - name: "Measurement Frequency"
      expr: measurement_frequency
    - name: "Measurement Unit"
      expr: measurement_unit
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Chips Act Obligation"
      expr: COUNT(DISTINCT chips_act_obligation_id)
    - name: "Total Compliance Actual"
      expr: SUM(compliance_actual)
    - name: "Average Compliance Actual"
      expr: AVG(compliance_actual)
    - name: "Total Funding Amount"
      expr: SUM(funding_amount)
    - name: "Average Funding Amount"
      expr: AVG(funding_amount)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`compliance_conflict_minerals_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conflict Minerals Declaration business metrics"
  source: "`semiconductors_ecm`.`compliance`.`conflict_minerals_declaration`"
  dimensions:
    - name: "Amendment Number"
      expr: amendment_number
    - name: "Amendment Reason"
      expr: amendment_reason
    - name: "Audit Date"
      expr: audit_date
    - name: "Audit Outcome"
      expr: audit_outcome
    - name: "Cmrt Version"
      expr: cmrt_version
    - name: "Compliance Officer"
      expr: compliance_officer
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source System"
      expr: data_source_system
    - name: "Declaration Status"
      expr: declaration_status
    - name: "Declaration Type"
      expr: declaration_type
    - name: "Drc Conflict Free Status"
      expr: drc_conflict_free_status
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "External Report Reference"
      expr: external_report_reference
    - name: "Independent Audit Reference"
      expr: independent_audit_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Conflict Minerals Declaration"
      expr: COUNT(DISTINCT conflict_minerals_declaration_id)
    - name: "Total Compliance Risk Score"
      expr: SUM(compliance_risk_score)
    - name: "Average Compliance Risk Score"
      expr: AVG(compliance_risk_score)
    - name: "Total Conflict Minerals Percentage"
      expr: SUM(conflict_minerals_percentage)
    - name: "Average Conflict Minerals Percentage"
      expr: AVG(conflict_minerals_percentage)
    - name: "Total Total Material Weight Kg"
      expr: SUM(total_material_weight_kg)
    - name: "Average Total Material Weight Kg"
      expr: AVG(total_material_weight_kg)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`compliance_eccn_classification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eccn Classification business metrics"
  source: "`semiconductors_ecm`.`compliance`.`eccn_classification`"
  dimensions:
    - name: "Change History"
      expr: change_history
    - name: "Classification Rationale"
      expr: classification_rationale
    - name: "Classification Timestamp"
      expr: classification_timestamp
    - name: "Classification Version"
      expr: classification_version
    - name: "Classifying Engineer"
      expr: classifying_engineer
    - name: "Compliance Officer"
      expr: compliance_officer
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Controlling Parameter"
      expr: controlling_parameter
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Documentation Url"
      expr: documentation_url
    - name: "Ear Control Codes"
      expr: ear_control_codes
    - name: "Eccn Classification Status"
      expr: eccn_classification_status
    - name: "Eccn Code"
      expr: eccn_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Export License Required"
      expr: export_license_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Eccn Classification"
      expr: COUNT(DISTINCT eccn_classification_id)
    - name: "Total Deminimis Value Usd"
      expr: SUM(deminimis_value_usd)
    - name: "Average Deminimis Value Usd"
      expr: AVG(deminimis_value_usd)
    - name: "Total Process Node Nm"
      expr: SUM(process_node_nm)
    - name: "Average Process Node Nm"
      expr: AVG(process_node_nm)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`compliance_export_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Export License business metrics"
  source: "`semiconductors_ecm`.`compliance`.`export_license`"
  dimensions:
    - name: "Authorized Commodities"
      expr: authorized_commodities
    - name: "Authorized Countries"
      expr: authorized_countries
    - name: "Authorized End Users"
      expr: authorized_end_users
    - name: "Compliance Agreement"
      expr: compliance_agreement
    - name: "Conditions"
      expr: conditions
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "End Use Certificate Type"
      expr: end_use_certificate_type
    - name: "End Use Description"
      expr: end_use_description
    - name: "End User Address"
      expr: end_user_address
    - name: "End User Name"
      expr: end_user_name
    - name: "Export License Status"
      expr: export_license_status
    - name: "Issue Date"
      expr: issue_date
    - name: "Issuing Authority"
      expr: issuing_authority
    - name: "License Number"
      expr: license_number
    - name: "License Type"
      expr: license_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Export License"
      expr: COUNT(DISTINCT export_license_id)
    - name: "Total Value Ceiling"
      expr: SUM(value_ceiling)
    - name: "Average Value Ceiling"
      expr: AVG(value_ceiling)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`compliance_export_license_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Export License Usage business metrics"
  source: "`semiconductors_ecm`.`compliance`.`export_license_usage`"
  dimensions:
    - name: "Audit Trail"
      expr: audit_trail
    - name: "Commodity Usml Category"
      expr: commodity_usml_category
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Consignee Name"
      expr: consignee_name
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Country Code"
      expr: destination_country_code
    - name: "End User Name"
      expr: end_user_name
    - name: "Export Control Regulation"
      expr: export_control_regulation
    - name: "Export Date"
      expr: export_date
    - name: "Export License Type"
      expr: export_license_type
    - name: "Export License Usage Status"
      expr: export_license_usage_status
    - name: "Is Sensitive"
      expr: is_sensitive
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Quantity Unit"
      expr: quantity_unit
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Export License Usage"
      expr: COUNT(DISTINCT export_license_usage_id)
    - name: "Total Cumulative License Utilization Percent"
      expr: SUM(cumulative_license_utilization_percent)
    - name: "Average Cumulative License Utilization Percent"
      expr: AVG(cumulative_license_utilization_percent)
    - name: "Total Declared Value"
      expr: SUM(declared_value)
    - name: "Average Declared Value"
      expr: AVG(declared_value)
    - name: "Total License Balance Remaining"
      expr: SUM(license_balance_remaining)
    - name: "Average License Balance Remaining"
      expr: AVG(license_balance_remaining)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total To Export License"
      expr: SUM(to_export_license)
    - name: "Average To Export License"
      expr: AVG(to_export_license)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`compliance_obligation_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Obligation Register business metrics"
  source: "`semiconductors_ecm`.`compliance`.`obligation_register`"
  dimensions:
    - name: "Applicable Product Line"
      expr: applicable_product_line
    - name: "Applicable Site Code"
      expr: applicable_site_code
    - name: "Assessment Frequency"
      expr: assessment_frequency
    - name: "Assessment Method"
      expr: assessment_method
    - name: "Assessor Name"
      expr: assessor_name
    - name: "Audit Trail"
      expr: audit_trail
    - name: "Compliance Category"
      expr: compliance_category
    - name: "Current Compliance Status"
      expr: current_compliance_status
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Gap Description"
      expr: gap_description
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Last Assessment Date"
      expr: last_assessment_date
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Obligation Code"
      expr: obligation_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Obligation Register"
      expr: COUNT(DISTINCT obligation_register_id)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`compliance_reach_svhc_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reach Svhc Declaration business metrics"
  source: "`semiconductors_ecm`.`compliance`.`reach_svhc_declaration`"
  dimensions:
    - name: "Audit Created Timestamp"
      expr: audit_created_timestamp
    - name: "Audit Outcome"
      expr: audit_outcome
    - name: "Audit Updated Timestamp"
      expr: audit_updated_timestamp
    - name: "Compliance Officer"
      expr: compliance_officer
    - name: "Compliance Officer Email"
      expr: compliance_officer_email
    - name: "Compliance Officer Phone"
      expr: compliance_officer_phone
    - name: "Compliance Result"
      expr: compliance_result
    - name: "Concentration Unit"
      expr: concentration_unit
    - name: "Created By User"
      expr: created_by_user
    - name: "Customer Facing Format"
      expr: customer_facing_format
    - name: "Declaration Date"
      expr: declaration_date
    - name: "Declaration Type"
      expr: declaration_type
    - name: "Document Url"
      expr: document_url
    - name: "Document Version"
      expr: document_version
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Reach Svhc Declaration"
      expr: COUNT(DISTINCT reach_svhc_declaration_id)
    - name: "Total Measured Concentration"
      expr: SUM(measured_concentration)
    - name: "Average Measured Concentration"
      expr: AVG(measured_concentration)
    - name: "Total Threshold Value"
      expr: SUM(threshold_value)
    - name: "Average Threshold Value"
      expr: AVG(threshold_value)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory Filing business metrics"
  source: "`semiconductors_ecm`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "Acknowledgment Date"
      expr: acknowledgment_date
    - name: "Action Deadline"
      expr: action_deadline
    - name: "Action Status"
      expr: action_status
    - name: "Agency"
      expr: agency
    - name: "Audit Trail Notes"
      expr: audit_trail_notes
    - name: "Change Description"
      expr: change_description
    - name: "Change Effective Date"
      expr: change_effective_date
    - name: "Change Publication Date"
      expr: change_publication_date
    - name: "Change Type"
      expr: change_type
    - name: "Classification Or Type"
      expr: classification_or_type
    - name: "Compliance Officer"
      expr: compliance_officer
    - name: "Compliance Officer Email"
      expr: compliance_officer_email
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Evidence Document Url"
      expr: evidence_document_url
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Regulatory Filing"
      expr: COUNT(DISTINCT regulatory_filing_id)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`compliance_restricted_party_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Restricted Party Screening business metrics"
  source: "`semiconductors_ecm`.`compliance`.`restricted_party_screening`"
  dimensions:
    - name: "Analyst Name"
      expr: analyst_name
    - name: "Analyst Notes"
      expr: analyst_notes
    - name: "Compliance Regulation"
      expr: compliance_regulation
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Disposition"
      expr: disposition
    - name: "Escalation Required"
      expr: escalation_required
    - name: "Escalation Timestamp"
      expr: escalation_timestamp
    - name: "Is Manual"
      expr: is_manual
    - name: "Match Result"
      expr: match_result
    - name: "Restricted Party Screening Status"
      expr: restricted_party_screening_status
    - name: "Review Deadline"
      expr: review_deadline
    - name: "Risk Category"
      expr: risk_category
    - name: "Screened Entity Name"
      expr: screened_entity_name
    - name: "Screened Entity Type"
      expr: screened_entity_type
    - name: "Screening Date"
      expr: screening_date
    - name: "Screening Lists Checked"
      expr: screening_lists_checked
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Restricted Party Screening"
      expr: COUNT(DISTINCT restricted_party_screening_id)
    - name: "Total Match Score"
      expr: SUM(match_score)
    - name: "Average Match Score"
      expr: AVG(match_score)
    - name: "Total Risk Score"
      expr: SUM(risk_score)
    - name: "Average Risk Score"
      expr: AVG(risk_score)
    - name: "Total Screened Entity Reference"
      expr: SUM(screened_entity_reference)
    - name: "Average Screened Entity Reference"
      expr: AVG(screened_entity_reference)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`compliance_substance_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Substance Inventory business metrics"
  source: "`semiconductors_ecm`.`compliance`.`substance_inventory`"
  dimensions:
    - name: "Cas Number"
      expr: cas_number
    - name: "Chemical Formula"
      expr: chemical_formula
    - name: "Compliance Review Date"
      expr: compliance_review_date
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Controlled Substance Category"
      expr: controlled_substance_category
    - name: "Disposal Method"
      expr: disposal_method
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Hazard Classification"
      expr: hazard_classification
    - name: "Is Controlled Substance"
      expr: is_controlled_substance
    - name: "Is Itar Controlled"
      expr: is_itar_controlled
    - name: "Is Pfas"
      expr: is_pfas
    - name: "Is Prohibited In Eu"
      expr: is_prohibited_in_eu
    - name: "Is Prohibited In Us"
      expr: is_prohibited_in_us
    - name: "Is Prop65"
      expr: is_prop65
    - name: "Is Reach Svhc"
      expr: is_reach_svhc
    - name: "Is Rohs Restricted"
      expr: is_rohs_restricted
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Substance Inventory"
      expr: COUNT(DISTINCT substance_inventory_id)
    - name: "Total Annual Usage Volume Kg"
      expr: SUM(annual_usage_volume_kg)
    - name: "Average Annual Usage Volume Kg"
      expr: AVG(annual_usage_volume_kg)
    - name: "Total Purity Percent"
      expr: SUM(purity_percent)
    - name: "Average Purity Percent"
      expr: AVG(purity_percent)
    - name: "Total Risk Score"
      expr: SUM(risk_score)
    - name: "Average Risk Score"
      expr: AVG(risk_score)
    - name: "Total Storage Temperature C"
      expr: SUM(storage_temperature_c)
    - name: "Average Storage Temperature C"
      expr: AVG(storage_temperature_c)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`compliance_technology_control_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technology Control Plan business metrics"
  source: "`semiconductors_ecm`.`compliance`.`technology_control_plan`"
  dimensions:
    - name: "Access Control Measures"
      expr: access_control_measures
    - name: "Audit Trail"
      expr: audit_trail
    - name: "Change History"
      expr: change_history
    - name: "Classification Rationale"
      expr: classification_rationale
    - name: "Clean Team Protocol Description"
      expr: clean_team_protocol_description
    - name: "Comments"
      expr: comments
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Controlled Technology Description"
      expr: controlled_technology_description
    - name: "Creation Timestamp"
      expr: creation_timestamp
    - name: "Data Retention Period Days"
      expr: data_retention_period_days
    - name: "Design Methodology"
      expr: design_methodology
    - name: "Documentation Url"
      expr: documentation_url
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Export License Required"
      expr: export_license_required
    - name: "Foreign National Exclusions"
      expr: foreign_national_exclusions
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Technology Control Plan"
      expr: COUNT(DISTINCT technology_control_plan_id)
    - name: "Total Deminimis Value Usd"
      expr: SUM(deminimis_value_usd)
    - name: "Average Deminimis Value Usd"
      expr: AVG(deminimis_value_usd)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`compliance_trade_compliance_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade Compliance Hold business metrics"
  source: "`semiconductors_ecm`.`compliance`.`trade_compliance_hold`"
  dimensions:
    - name: "Commodity Usml Category"
      expr: commodity_usml_category
    - name: "Compliance Officer"
      expr: compliance_officer
    - name: "Created By User"
      expr: created_by_user
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Country Code"
      expr: destination_country_code
    - name: "End User Address"
      expr: end_user_address
    - name: "End User Name"
      expr: end_user_name
    - name: "Escalation History"
      expr: escalation_history
    - name: "Export Control Regulation"
      expr: export_control_regulation
    - name: "Hold Notes"
      expr: hold_notes
    - name: "Hold Placed Timestamp"
      expr: hold_placed_timestamp
    - name: "Hold Reason Code"
      expr: hold_reason_code
    - name: "Hold Reason Description"
      expr: hold_reason_description
    - name: "Hold Reference"
      expr: hold_reference
    - name: "Hold Resolution Action"
      expr: hold_resolution_action
    - name: "Hold Status"
      expr: hold_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Trade Compliance Hold"
      expr: COUNT(DISTINCT trade_compliance_hold_id)
    - name: "Total Adjustment Amount Usd"
      expr: SUM(adjustment_amount_usd)
    - name: "Average Adjustment Amount Usd"
      expr: AVG(adjustment_amount_usd)
    - name: "Total Estimated Value Usd"
      expr: SUM(estimated_value_usd)
    - name: "Average Estimated Value Usd"
      expr: AVG(estimated_value_usd)
    - name: "Total Gross Amount Usd"
      expr: SUM(gross_amount_usd)
    - name: "Average Gross Amount Usd"
      expr: AVG(gross_amount_usd)
    - name: "Total Net Amount Usd"
      expr: SUM(net_amount_usd)
    - name: "Average Net Amount Usd"
      expr: AVG(net_amount_usd)
    - name: "Total Triggering Transaction Reference"
      expr: SUM(triggering_transaction_reference)
    - name: "Average Triggering Transaction Reference"
      expr: AVG(triggering_transaction_reference)
$$;