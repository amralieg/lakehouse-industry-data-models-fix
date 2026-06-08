-- Metric views for domain: customer | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 14:35:41

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Account business metrics"
  source: "`chemical_mfg_ecm`.`customer`.`account`"
  dimensions:
    - name: "Account Status"
      expr: account_status
    - name: "Account Tier"
      expr: account_tier
    - name: "Account Type"
      expr: account_type
    - name: "Annual Revenue Band"
      expr: annual_revenue_band
    - name: "Billing Address Line1"
      expr: billing_address_line1
    - name: "Billing City"
      expr: billing_city
    - name: "Billing Country Code"
      expr: billing_country_code
    - name: "Billing Postal Code"
      expr: billing_postal_code
    - name: "Billing State Province"
      expr: billing_state_province
    - name: "Blocked"
      expr: blocked
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Limit Currency"
      expr: credit_limit_currency
    - name: "Credit Rating"
      expr: credit_rating
    - name: "Duns Number"
      expr: duns_number
    - name: "Employee Count Band"
      expr: employee_count_band
    - name: "Incoterms Code"
      expr: incoterms_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Account"
      expr: COUNT(DISTINCT account_id)
    - name: "Total Credit Limit"
      expr: SUM(credit_limit)
    - name: "Average Credit Limit"
      expr: AVG(credit_limit)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`customer_account_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Account Hierarchy business metrics"
  source: "`chemical_mfg_ecm`.`customer`.`account_hierarchy`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Change Reason"
      expr: change_reason
    - name: "Consolidation Flag"
      expr: consolidation_flag
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Rollup Flag"
      expr: credit_rollup_flag
    - name: "Customer Group Code"
      expr: customer_group_code
    - name: "Domestic Ultimate Duns"
      expr: domestic_ultimate_duns
    - name: "Duns Number"
      expr: duns_number
    - name: "Effective Date"
      expr: effective_date
    - name: "End Date"
      expr: end_date
    - name: "Global Ultimate Duns"
      expr: global_ultimate_duns
    - name: "Hierarchy Code"
      expr: hierarchy_code
    - name: "Hierarchy Depth"
      expr: hierarchy_depth
    - name: "Hierarchy Level"
      expr: hierarchy_level
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Account Hierarchy"
      expr: COUNT(DISTINCT account_hierarchy_id)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`customer_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Case business metrics"
  source: "`chemical_mfg_ecm`.`customer`.`case`"
  dimensions:
    - name: "Case Description"
      expr: case_description
    - name: "Case Number"
      expr: case_number
    - name: "Case Status"
      expr: case_status
    - name: "Case Type"
      expr: case_type
    - name: "Channel"
      expr: channel
    - name: "Closed Date"
      expr: closed_date
    - name: "Coa Reference"
      expr: coa_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Note Issued"
      expr: credit_note_issued
    - name: "Credit Note Number"
      expr: credit_note_number
    - name: "Crm Case Code"
      expr: crm_case_code
    - name: "Customer Satisfaction Outcome"
      expr: customer_satisfaction_outcome
    - name: "Customer Satisfaction Rating"
      expr: customer_satisfaction_rating
    - name: "Eight D Report Number"
      expr: eight_d_report_number
    - name: "Escalated"
      expr: escalated
    - name: "Escalation Date"
      expr: escalation_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Case"
      expr: COUNT(DISTINCT case_id)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`customer_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contact business metrics"
  source: "`chemical_mfg_ecm`.`customer`.`contact`"
  dimensions:
    - name: "Coa Delivery Method"
      expr: coa_delivery_method
    - name: "Contact Role"
      expr: contact_role
    - name: "Contact Status"
      expr: contact_status
    - name: "Contact Type"
      expr: contact_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crm Contact Code"
      expr: crm_contact_code
    - name: "Currency Code"
      expr: currency_code
    - name: "Department"
      expr: department
    - name: "Do Not Contact Flag"
      expr: do_not_contact_flag
    - name: "Do Not Contact Reason"
      expr: do_not_contact_reason
    - name: "Ehs Contact Flag"
      expr: ehs_contact_flag
    - name: "Email"
      expr: email
    - name: "Email Secondary"
      expr: email_secondary
    - name: "First Name"
      expr: first_name
    - name: "Is Decision Maker"
      expr: is_decision_maker
    - name: "Is Primary Contact"
      expr: is_primary_contact
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contact"
      expr: COUNT(DISTINCT contact_id)
    - name: "Total Purchase Order Authority Limit"
      expr: SUM(purchase_order_authority_limit)
    - name: "Average Purchase Order Authority Limit"
      expr: AVG(purchase_order_authority_limit)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`customer_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit Profile business metrics"
  source: "`chemical_mfg_ecm`.`customer`.`credit_profile`"
  dimensions:
    - name: "Credit Block Flag"
      expr: credit_block_flag
    - name: "Credit Block Reason"
      expr: credit_block_reason
    - name: "Credit Control Area"
      expr: credit_control_area
    - name: "Credit Hold Flag"
      expr: credit_hold_flag
    - name: "Credit Insurance Policy Ref"
      expr: credit_insurance_policy_ref
    - name: "Credit Limit Approval Level"
      expr: credit_limit_approval_level
    - name: "Credit Limit Currency"
      expr: credit_limit_currency
    - name: "Credit Limit Effective Date"
      expr: credit_limit_effective_date
    - name: "Credit Limit Expiry Date"
      expr: credit_limit_expiry_date
    - name: "Credit Notes Text"
      expr: credit_notes_text
    - name: "Credit Profile Status"
      expr: credit_profile_status
    - name: "Credit Review Date"
      expr: credit_review_date
    - name: "Credit Risk Category"
      expr: credit_risk_category
    - name: "Credit Segment"
      expr: credit_segment
    - name: "Dso Actual Days"
      expr: dso_actual_days
    - name: "Dso Target Days"
      expr: dso_target_days
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Credit Profile"
      expr: COUNT(DISTINCT credit_profile_id)
    - name: "Total Credit Exposure Amount"
      expr: SUM(credit_exposure_amount)
    - name: "Average Credit Exposure Amount"
      expr: AVG(credit_exposure_amount)
    - name: "Total Credit Insurance Coverage Amount"
      expr: SUM(credit_insurance_coverage_amount)
    - name: "Average Credit Insurance Coverage Amount"
      expr: AVG(credit_insurance_coverage_amount)
    - name: "Total Credit Limit Amount"
      expr: SUM(credit_limit_amount)
    - name: "Average Credit Limit Amount"
      expr: AVG(credit_limit_amount)
    - name: "Total Credit Utilization Pct"
      expr: SUM(credit_utilization_pct)
    - name: "Average Credit Utilization Pct"
      expr: AVG(credit_utilization_pct)
    - name: "Total Overdue Amount"
      expr: SUM(overdue_amount)
    - name: "Average Overdue Amount"
      expr: AVG(overdue_amount)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`customer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interaction business metrics"
  source: "`chemical_mfg_ecm`.`customer`.`interaction`"
  dimensions:
    - name: "Channel"
      expr: channel
    - name: "Coa Request Flag"
      expr: coa_request_flag
    - name: "Complaint Flag"
      expr: complaint_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crm Activity Code"
      expr: crm_activity_code
    - name: "Customer Participant Count"
      expr: customer_participant_count
    - name: "Customer Participants"
      expr: customer_participants
    - name: "Customer Satisfaction Score"
      expr: customer_satisfaction_score
    - name: "Duration Minutes"
      expr: duration_minutes
    - name: "Follow Up Due Date"
      expr: follow_up_due_date
    - name: "Follow Up Notes"
      expr: follow_up_notes
    - name: "Follow Up Required"
      expr: follow_up_required
    - name: "Interaction Date"
      expr: interaction_date
    - name: "Interaction Description"
      expr: interaction_description
    - name: "Interaction Status"
      expr: interaction_status
    - name: "Interaction Timestamp"
      expr: interaction_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Interaction"
      expr: COUNT(DISTINCT interaction_id)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`customer_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Qualification business metrics"
  source: "`chemical_mfg_ecm`.`customer`.`qualification`"
  dimensions:
    - name: "Apl Number"
      expr: apl_number
    - name: "Application Use Case"
      expr: application_use_case
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By Internal User"
      expr: approved_by_internal_user
    - name: "Change Notification Lead Days"
      expr: change_notification_lead_days
    - name: "Change Notification Required Flag"
      expr: change_notification_required_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crm Qualification Code"
      expr: crm_qualification_code
    - name: "Customer Part Number"
      expr: customer_part_number
    - name: "Customer Spec Number"
      expr: customer_spec_number
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Exclusive Supply Flag"
      expr: exclusive_supply_flag
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Industry Segment"
      expr: industry_segment
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Qualification"
      expr: COUNT(DISTINCT qualification_id)
    - name: "Total Max Approved Volume Kg"
      expr: SUM(max_approved_volume_kg)
    - name: "Average Max Approved Volume Kg"
      expr: AVG(max_approved_volume_kg)
    - name: "Total Min Approved Volume Kg"
      expr: SUM(min_approved_volume_kg)
    - name: "Average Min Approved Volume Kg"
      expr: AVG(min_approved_volume_kg)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`customer_regulatory_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory Profile business metrics"
  source: "`chemical_mfg_ecm`.`customer`.`regulatory_profile`"
  dimensions:
    - name: "Approved Product Categories"
      expr: approved_product_categories
    - name: "Audit Rights Agreed"
      expr: audit_rights_agreed
    - name: "Audit Rights Agreement Date"
      expr: audit_rights_agreement_date
    - name: "Coa Required"
      expr: coa_required
    - name: "Coc Required"
      expr: coc_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Destination Country Code"
      expr: destination_country_code
    - name: "Destination Region"
      expr: destination_region
    - name: "Downstream User Notification"
      expr: downstream_user_notification
    - name: "Effective Date"
      expr: effective_date
    - name: "Ehs Certification Expiry"
      expr: ehs_certification_expiry
    - name: "Ehs Certification Number"
      expr: ehs_certification_number
    - name: "Ehs Certification Status"
      expr: ehs_certification_status
    - name: "End Use Declaration"
      expr: end_use_declaration
    - name: "End Use Sector"
      expr: end_use_sector
    - name: "Expiry Date"
      expr: expiry_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Regulatory Profile"
      expr: COUNT(DISTINCT regulatory_profile_id)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Segment business metrics"
  source: "`chemical_mfg_ecm`.`customer`.`segment`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Date"
      expr: approved_date
    - name: "Business Unit"
      expr: business_unit
    - name: "Coa Requirement Flag"
      expr: coa_requirement_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Risk Category"
      expr: credit_risk_category
    - name: "Crm Segment Code"
      expr: crm_segment_code
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Gmp Compliance Required"
      expr: gmp_compliance_required
    - name: "Growth Potential Rating"
      expr: growth_potential_rating
    - name: "Hazmat Shipping Flag"
      expr: hazmat_shipping_flag
    - name: "Incoterms Code"
      expr: incoterms_code
    - name: "Industry Vertical"
      expr: industry_vertical
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Min Order Quantity Uom"
      expr: min_order_quantity_uom
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Segment"
      expr: COUNT(DISTINCT segment_id)
    - name: "Total Min Order Quantity"
      expr: SUM(min_order_quantity)
    - name: "Average Min Order Quantity"
      expr: AVG(min_order_quantity)
    - name: "Total Target Revenue Usd"
      expr: SUM(target_revenue_usd)
    - name: "Average Target Revenue Usd"
      expr: AVG(target_revenue_usd)
    - name: "Total Wallet Share Estimate Pct"
      expr: SUM(wallet_share_estimate_pct)
    - name: "Average Wallet Share Estimate Pct"
      expr: AVG(wallet_share_estimate_pct)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`customer_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site business metrics"
  source: "`chemical_mfg_ecm`.`customer`.`site`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Bulk Receipt Capable"
      expr: bulk_receipt_capable
    - name: "City"
      expr: city
    - name: "Coa Required"
      expr: coa_required
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Window End"
      expr: delivery_window_end
    - name: "Delivery Window Start"
      expr: delivery_window_start
    - name: "Dock Restrictions"
      expr: dock_restrictions
    - name: "Ehs Contact Name"
      expr: ehs_contact_name
    - name: "Ehs Contact Phone"
      expr: ehs_contact_phone
    - name: "Fax"
      expr: fax
    - name: "Hazmat Receiving Capable"
      expr: hazmat_receiving_capable
    - name: "Incoterms Code"
      expr: incoterms_code
    - name: "Operating Hours"
      expr: operating_hours
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Site"
      expr: COUNT(DISTINCT site_id)
    - name: "Total Capacity Mt"
      expr: SUM(capacity_mt)
    - name: "Average Capacity Mt"
      expr: AVG(capacity_mt)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
$$;