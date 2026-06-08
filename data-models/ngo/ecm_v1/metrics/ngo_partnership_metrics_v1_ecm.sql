-- Metric views for domain: partnership | Business: Ngo | Version: 1 | Generated on: 2026-05-07 01:26:41

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_agreement_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agreement Amendment business metrics"
  source: "`ngo_ecm`.`partnership`.`agreement_amendment`"
  dimensions:
    - name: "Amendment Number"
      expr: amendment_number
    - name: "Amendment Status"
      expr: amendment_status
    - name: "Amendment Title"
      expr: amendment_title
    - name: "Amendment Type"
      expr: amendment_type
    - name: "Approval Authority"
      expr: approval_authority
    - name: "Approved Date"
      expr: approved_date
    - name: "Beneficiary Target Change"
      expr: beneficiary_target_change
    - name: "Clauses Modified"
      expr: clauses_modified
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Document Reference"
      expr: document_reference
    - name: "Donor Approval Reference"
      expr: donor_approval_reference
    - name: "Donor Prior Approval Required"
      expr: donor_prior_approval_required
    - name: "Effective Date"
      expr: effective_date
    - name: "Execution Date"
      expr: execution_date
    - name: "Extension Duration Days"
      expr: extension_duration_days
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Agreement Amendment"
      expr: COUNT(DISTINCT agreement_amendment_id)
    - name: "Total Budget Change Amount"
      expr: SUM(budget_change_amount)
    - name: "Average Budget Change Amount"
      expr: AVG(budget_change_amount)
    - name: "Total Original Budget Amount"
      expr: SUM(original_budget_amount)
    - name: "Average Original Budget Amount"
      expr: AVG(original_budget_amount)
    - name: "Total Revised Budget Amount"
      expr: SUM(revised_budget_amount)
    - name: "Average Revised Budget Amount"
      expr: AVG(revised_budget_amount)
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_campaign_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign Participation business metrics"
  source: "`ngo_ecm`.`partnership`.`campaign_participation`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Contribution Type"
      expr: contribution_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Participation End Date"
      expr: participation_end_date
    - name: "Participation Start Date"
      expr: participation_start_date
    - name: "Partner Role"
      expr: partner_role
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Visibility Level"
      expr: visibility_level
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Participation End Date Month"
      expr: DATE_TRUNC('MONTH', participation_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Campaign Participation"
      expr: COUNT(DISTINCT campaign_participation_id)
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_capacity_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity Assessment business metrics"
  source: "`ngo_ecm`.`partnership`.`capacity_assessment`"
  dimensions:
    - name: "Assessment Date"
      expr: assessment_date
    - name: "Assessment End Date"
      expr: assessment_end_date
    - name: "Assessment Location Country"
      expr: assessment_location_country
    - name: "Assessment Methodology"
      expr: assessment_methodology
    - name: "Assessment Reference Code"
      expr: assessment_reference_code
    - name: "Assessment Report Url"
      expr: assessment_report_url
    - name: "Assessment Scope"
      expr: assessment_scope
    - name: "Assessment Start Date"
      expr: assessment_start_date
    - name: "Assessment Status"
      expr: assessment_status
    - name: "Assessment Tool Version"
      expr: assessment_tool_version
    - name: "Assessment Type"
      expr: assessment_type
    - name: "Capacity Building Plan Required"
      expr: capacity_building_plan_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Enhanced Monitoring Required"
      expr: enhanced_monitoring_required
    - name: "Financial Risk Rating"
      expr: financial_risk_rating
    - name: "Key Findings Summary"
      expr: key_findings_summary
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Capacity Assessment"
      expr: COUNT(DISTINCT capacity_assessment_id)
    - name: "Total Financial Mgmt Score"
      expr: SUM(financial_mgmt_score)
    - name: "Average Financial Mgmt Score"
      expr: AVG(financial_mgmt_score)
    - name: "Total Governance Score"
      expr: SUM(governance_score)
    - name: "Average Governance Score"
      expr: AVG(governance_score)
    - name: "Total Hr Mgmt Score"
      expr: SUM(hr_mgmt_score)
    - name: "Average Hr Mgmt Score"
      expr: AVG(hr_mgmt_score)
    - name: "Total It Systems Score"
      expr: SUM(it_systems_score)
    - name: "Average It Systems Score"
      expr: AVG(it_systems_score)
    - name: "Total Mel Score"
      expr: SUM(mel_score)
    - name: "Average Mel Score"
      expr: AVG(mel_score)
    - name: "Total Overall Score"
      expr: SUM(overall_score)
    - name: "Average Overall Score"
      expr: AVG(overall_score)
    - name: "Total Partner Self Assessment Score"
      expr: SUM(partner_self_assessment_score)
    - name: "Average Partner Self Assessment Score"
      expr: AVG(partner_self_assessment_score)
    - name: "Total Procurement Score"
      expr: SUM(procurement_score)
    - name: "Average Procurement Score"
      expr: AVG(procurement_score)
    - name: "Total Program Mgmt Score"
      expr: SUM(program_mgmt_score)
    - name: "Average Program Mgmt Score"
      expr: AVG(program_mgmt_score)
    - name: "Total Score Scale Max"
      expr: SUM(score_scale_max)
    - name: "Average Score Scale Max"
      expr: AVG(score_scale_max)
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_capacity_building_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity Building Activity business metrics"
  source: "`ngo_ecm`.`partnership`.`capacity_building_activity`"
  dimensions:
    - name: "Activity Reference Code"
      expr: activity_reference_code
    - name: "Activity Status"
      expr: activity_status
    - name: "Activity Title"
      expr: activity_title
    - name: "Activity Type"
      expr: activity_type
    - name: "Actual Delivery Date"
      expr: actual_delivery_date
    - name: "Actual End Date"
      expr: actual_end_date
    - name: "Assessment Method"
      expr: assessment_method
    - name: "Capacity Domain"
      expr: capacity_domain
    - name: "Certification Body"
      expr: certification_body
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Mode"
      expr: delivery_mode
    - name: "Facilitator Name"
      expr: facilitator_name
    - name: "Facilitator Type"
      expr: facilitator_type
    - name: "Feedback Collected"
      expr: feedback_collected
    - name: "Female Participants"
      expr: female_participants
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Capacity Building Activity"
      expr: COUNT(DISTINCT capacity_building_activity_id)
    - name: "Total Activity Cost Usd"
      expr: SUM(activity_cost_usd)
    - name: "Average Activity Cost Usd"
      expr: AVG(activity_cost_usd)
    - name: "Total Completion Rate Pct"
      expr: SUM(completion_rate_pct)
    - name: "Average Completion Rate Pct"
      expr: AVG(completion_rate_pct)
    - name: "Total Duration Hours"
      expr: SUM(duration_hours)
    - name: "Average Duration Hours"
      expr: AVG(duration_hours)
    - name: "Total Participant Satisfaction Score"
      expr: SUM(participant_satisfaction_score)
    - name: "Average Participant Satisfaction Score"
      expr: AVG(participant_satisfaction_score)
    - name: "Total Post Assessment Score"
      expr: SUM(post_assessment_score)
    - name: "Average Post Assessment Score"
      expr: AVG(post_assessment_score)
    - name: "Total Pre Assessment Score"
      expr: SUM(pre_assessment_score)
    - name: "Average Pre Assessment Score"
      expr: AVG(pre_assessment_score)
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_capacity_building_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity Building Plan business metrics"
  source: "`ngo_ecm`.`partnership`.`capacity_building_plan`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Capacity Score Scale"
      expr: capacity_score_scale
    - name: "Chs Standard Aligned"
      expr: chs_standard_aligned
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Donor Reporting Required"
      expr: donor_reporting_required
    - name: "End Date"
      expr: end_date
    - name: "Gender Mainstreaming Included"
      expr: gender_mainstreaming_included
    - name: "Grand Bargain Commitment Ref"
      expr: grand_bargain_commitment_ref
    - name: "Implementation Region"
      expr: implementation_region
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Localization Strategy Aligned"
      expr: localization_strategy_aligned
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Capacity Building Plan"
      expr: COUNT(DISTINCT capacity_building_plan_id)
    - name: "Total Baseline Capacity Score"
      expr: SUM(baseline_capacity_score)
    - name: "Average Baseline Capacity Score"
      expr: AVG(baseline_capacity_score)
    - name: "Total Current Capacity Score"
      expr: SUM(current_capacity_score)
    - name: "Average Current Capacity Score"
      expr: AVG(current_capacity_score)
    - name: "Total Expenditure To Date Usd"
      expr: SUM(expenditure_to_date_usd)
    - name: "Average Expenditure To Date Usd"
      expr: AVG(expenditure_to_date_usd)
    - name: "Total Target Capacity Score"
      expr: SUM(target_capacity_score)
    - name: "Average Target Capacity Score"
      expr: AVG(target_capacity_score)
    - name: "Total Total Budget Usd"
      expr: SUM(total_budget_usd)
    - name: "Average Total Budget Usd"
      expr: AVG(total_budget_usd)
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_consortium`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consortium business metrics"
  source: "`ngo_ecm`.`partnership`.`consortium`"
  dimensions:
    - name: "Chs Compliance Status"
      expr: chs_compliance_status
    - name: "Consortium Name"
      expr: consortium_name
    - name: "Consortium Type"
      expr: consortium_type
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Decision Making Protocol"
      expr: decision_making_protocol
    - name: "Due Diligence Date"
      expr: due_diligence_date
    - name: "Due Diligence Status"
      expr: due_diligence_status
    - name: "End Date"
      expr: end_date
    - name: "Funding Currency"
      expr: funding_currency
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Governance Structure"
      expr: governance_structure
    - name: "Grand Bargain Localization"
      expr: grand_bargain_localization
    - name: "Iasc Working Group"
      expr: iasc_working_group
    - name: "Iati Identifier"
      expr: iati_identifier
    - name: "Logframe Ref"
      expr: logframe_ref
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Consortium"
      expr: COUNT(DISTINCT consortium_id)
    - name: "Total Localization Percentage"
      expr: SUM(localization_percentage)
    - name: "Average Localization Percentage"
      expr: AVG(localization_percentage)
    - name: "Total Ngo Funding Share"
      expr: SUM(ngo_funding_share)
    - name: "Average Ngo Funding Share"
      expr: AVG(ngo_funding_share)
    - name: "Total Total Funding Amount"
      expr: SUM(total_funding_amount)
    - name: "Average Total Funding Amount"
      expr: AVG(total_funding_amount)
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_consortium_communication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consortium Communication business metrics"
  source: "`ngo_ecm`.`partnership`.`consortium_communication`"
  dimensions:
    - name: "Approval Authority"
      expr: approval_authority
    - name: "Assigned Date"
      expr: assigned_date
    - name: "Branding Guidelines"
      expr: branding_guidelines
    - name: "Consortium Role"
      expr: consortium_role
    - name: "Review Completed Date"
      expr: review_completed_date
    - name: "Review Deadline"
      expr: review_deadline
    - name: "Review Notes"
      expr: review_notes
    - name: "Review Status"
      expr: review_status
    - name: "Visibility Requirements"
      expr: visibility_requirements
    - name: "Assigned Date Month"
      expr: DATE_TRUNC('MONTH', assigned_date)
    - name: "Review Completed Date Month"
      expr: DATE_TRUNC('MONTH', review_completed_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Consortium Communication"
      expr: COUNT(DISTINCT consortium_communication_id)
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_consortium_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consortium Member business metrics"
  source: "`ngo_ecm`.`partnership`.`consortium_member`"
  dimensions:
    - name: "Capacity Assessment Date"
      expr: capacity_assessment_date
    - name: "Contribution Type"
      expr: contribution_type
    - name: "Cost Share Required"
      expr: cost_share_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Due Diligence Completion Date"
      expr: due_diligence_completion_date
    - name: "Due Diligence Status"
      expr: due_diligence_status
    - name: "Funding Currency Code"
      expr: funding_currency_code
    - name: "Geographic Responsibility"
      expr: geographic_responsibility
    - name: "Member Role"
      expr: member_role
    - name: "Membership End Date"
      expr: membership_end_date
    - name: "Membership Start Date"
      expr: membership_start_date
    - name: "Membership Status"
      expr: membership_status
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Performance Rating"
      expr: performance_rating
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Consortium Member"
      expr: COUNT(DISTINCT consortium_member_id)
    - name: "Total Capacity Assessment Score"
      expr: SUM(capacity_assessment_score)
    - name: "Average Capacity Assessment Score"
      expr: AVG(capacity_assessment_score)
    - name: "Total Cost Share Percentage"
      expr: SUM(cost_share_percentage)
    - name: "Average Cost Share Percentage"
      expr: AVG(cost_share_percentage)
    - name: "Total Funding Allocation Amount"
      expr: SUM(funding_allocation_amount)
    - name: "Average Funding Allocation Amount"
      expr: AVG(funding_allocation_amount)
    - name: "Total Funding Allocation Percentage"
      expr: SUM(funding_allocation_percentage)
    - name: "Average Funding Allocation Percentage"
      expr: AVG(funding_allocation_percentage)
    - name: "Total Indirect Cost Rate"
      expr: SUM(indirect_cost_rate)
    - name: "Average Indirect Cost Rate"
      expr: AVG(indirect_cost_rate)
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_coordination_meeting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coordination Meeting business metrics"
  source: "`ngo_ecm`.`partnership`.`coordination_meeting`"
  dimensions:
    - name: "Action Items Summary"
      expr: action_items_summary
    - name: "Agenda Document Url"
      expr: agenda_document_url
    - name: "Agenda Summary"
      expr: agenda_summary
    - name: "Associated Response Plan"
      expr: associated_response_plan
    - name: "City"
      expr: city
    - name: "Cluster Sector"
      expr: cluster_sector
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Duration Minutes"
      expr: duration_minutes
    - name: "End Time"
      expr: end_time
    - name: "Follow Up Status"
      expr: follow_up_status
    - name: "Hosting Organization"
      expr: hosting_organization
    - name: "Humanitarian Context"
      expr: humanitarian_context
    - name: "Is Recurring"
      expr: is_recurring
    - name: "Key Decisions"
      expr: key_decisions
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Coordination Meeting"
      expr: COUNT(DISTINCT coordination_meeting_id)
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_due_diligence_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Due Diligence Record business metrics"
  source: "`ngo_ecm`.`partnership`.`due_diligence_record`"
  dimensions:
    - name: "Aml Cft Check Status"
      expr: aml_cft_check_status
    - name: "Anti Terrorism Cert Date"
      expr: anti_terrorism_cert_date
    - name: "Anti Terrorism Certification"
      expr: anti_terrorism_certification
    - name: "Chs Cert Expiry Date"
      expr: chs_cert_expiry_date
    - name: "Chs Certificate Number"
      expr: chs_certificate_number
    - name: "Chs Certification Status"
      expr: chs_certification_status
    - name: "Completion Date"
      expr: completion_date
    - name: "Conditions Of Approval"
      expr: conditions_of_approval
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Debarment Check Date"
      expr: debarment_check_date
    - name: "Debarment Check Status"
      expr: debarment_check_status
    - name: "Diligence Status"
      expr: diligence_status
    - name: "Diligence Type"
      expr: diligence_type
    - name: "Financial Audit Opinion"
      expr: financial_audit_opinion
    - name: "Financial Audit Reviewed"
      expr: financial_audit_reviewed
    - name: "Financial Audit Year"
      expr: financial_audit_year
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Due Diligence Record"
      expr: COUNT(DISTINCT due_diligence_record_id)
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_field_monitoring_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field Monitoring Visit business metrics"
  source: "`ngo_ecm`.`partnership`.`field_monitoring_visit`"
  dimensions:
    - name: "Assets Verified"
      expr: assets_verified
    - name: "Beneficiaries Interviewed Count"
      expr: beneficiaries_interviewed_count
    - name: "Corrective Action Plan Deadline"
      expr: corrective_action_plan_deadline
    - name: "Corrective Action Plan Required"
      expr: corrective_action_plan_required
    - name: "Corrective Action Plan Status"
      expr: corrective_action_plan_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Findings Count"
      expr: critical_findings_count
    - name: "Donor Notification Required"
      expr: donor_notification_required
    - name: "Financial Findings Summary"
      expr: financial_findings_summary
    - name: "Findings Summary"
      expr: findings_summary
    - name: "Follow Up Visit Due Date"
      expr: follow_up_visit_due_date
    - name: "Follow Up Visit Required"
      expr: follow_up_visit_required
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Major Findings Count"
      expr: major_findings_count
    - name: "Minor Findings Count"
      expr: minor_findings_count
    - name: "Monitoring Checklist Version"
      expr: monitoring_checklist_version
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Field Monitoring Visit"
      expr: COUNT(DISTINCT field_monitoring_visit_id)
    - name: "Total Site Latitude"
      expr: SUM(site_latitude)
    - name: "Average Site Latitude"
      expr: AVG(site_latitude)
    - name: "Total Site Longitude"
      expr: SUM(site_longitude)
    - name: "Average Site Longitude"
      expr: AVG(site_longitude)
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_mou_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mou Obligation business metrics"
  source: "`ngo_ecm`.`partnership`.`mou_obligation`"
  dimensions:
    - name: "Amendment Reference"
      expr: amendment_reference
    - name: "Capacity Building Component"
      expr: capacity_building_component
    - name: "Cluster Lead Agency"
      expr: cluster_lead_agency
    - name: "Completion Date"
      expr: completion_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Days Overdue"
      expr: days_overdue
    - name: "Donor Reference Number"
      expr: donor_reference_number
    - name: "Due Date"
      expr: due_date
    - name: "Escalation Date"
      expr: escalation_date
    - name: "Escalation Notes"
      expr: escalation_notes
    - name: "Escalation Status"
      expr: escalation_status
    - name: "Evidence Description"
      expr: evidence_description
    - name: "Evidence Document Reference"
      expr: evidence_document_reference
    - name: "Geographic Location"
      expr: geographic_location
    - name: "Indicator Reference"
      expr: indicator_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mou Obligation"
      expr: COUNT(DISTINCT mou_obligation_id)
    - name: "Total Achieved Value"
      expr: SUM(achieved_value)
    - name: "Average Achieved Value"
      expr: AVG(achieved_value)
    - name: "Total Financial Value Amount"
      expr: SUM(financial_value_amount)
    - name: "Average Financial Value Amount"
      expr: AVG(financial_value_amount)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_partner_accreditation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Accreditation business metrics"
  source: "`ngo_ecm`.`partnership`.`partner_accreditation`"
  dimensions:
    - name: "Accreditation Code"
      expr: accreditation_code
    - name: "Accreditation Name"
      expr: accreditation_name
    - name: "Accreditation Status"
      expr: accreditation_status
    - name: "Accreditation Type"
      expr: accreditation_type
    - name: "Accrediting Body Country Code"
      expr: accrediting_body_country_code
    - name: "Accrediting Body Name"
      expr: accrediting_body_name
    - name: "Applicable Standard Version"
      expr: applicable_standard_version
    - name: "Assessment Level"
      expr: assessment_level
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Chs Commitment Level"
      expr: chs_commitment_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Reference"
      expr: document_reference
    - name: "Document Upload Date"
      expr: document_upload_date
    - name: "Donor Reference"
      expr: donor_reference
    - name: "Donor Required"
      expr: donor_required
    - name: "Expiry Date"
      expr: expiry_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Accreditation"
      expr: COUNT(DISTINCT partner_accreditation_id)
    - name: "Total Accreditation Score"
      expr: SUM(accreditation_score)
    - name: "Average Accreditation Score"
      expr: AVG(accreditation_score)
    - name: "Total Due Diligence Weight"
      expr: SUM(due_diligence_weight)
    - name: "Average Due Diligence Weight"
      expr: AVG(due_diligence_weight)
    - name: "Total Max Possible Score"
      expr: SUM(max_possible_score)
    - name: "Average Max Possible Score"
      expr: AVG(max_possible_score)
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_partner_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Compliance business metrics"
  source: "`ngo_ecm`.`partnership`.`partner_compliance`"
  dimensions:
    - name: "Assigned Date"
      expr: assigned_date
    - name: "Completion Date"
      expr: completion_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Due Date"
      expr: due_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Notes"
      expr: notes
    - name: "Partner Compliance Status"
      expr: partner_compliance_status
    - name: "Responsible Focal Point"
      expr: responsible_focal_point
    - name: "Waiver Status"
      expr: waiver_status
    - name: "Assigned Date Month"
      expr: DATE_TRUNC('MONTH', assigned_date)
    - name: "Completion Date Month"
      expr: DATE_TRUNC('MONTH', completion_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Compliance"
      expr: COUNT(DISTINCT partner_compliance_id)
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_partner_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Contact business metrics"
  source: "`ngo_ecm`.`partnership`.`partner_contact`"
  dimensions:
    - name: "Cluster Membership"
      expr: cluster_membership
    - name: "Consent Date"
      expr: consent_date
    - name: "Contact Status"
      expr: contact_status
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Sharing Consent"
      expr: data_sharing_consent
    - name: "Department"
      expr: department
    - name: "Do Not Contact"
      expr: do_not_contact
    - name: "Duty Station"
      expr: duty_station
    - name: "End Date"
      expr: end_date
    - name: "First Name"
      expr: first_name
    - name: "Gender"
      expr: gender
    - name: "Is Authorized Signatory"
      expr: is_authorized_signatory
    - name: "Is Financial Authorized"
      expr: is_financial_authorized
    - name: "Is Primary Contact"
      expr: is_primary_contact
    - name: "Job Title"
      expr: job_title
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Contact"
      expr: COUNT(DISTINCT partner_contact_id)
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_partner_org`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Org business metrics"
  source: "`ngo_ecm`.`partnership`.`partner_org`"
  dimensions:
    - name: "Accreditation Status"
      expr: accreditation_status
    - name: "Authorized Rep Name"
      expr: authorized_rep_name
    - name: "Authorized Rep Title"
      expr: authorized_rep_title
    - name: "Bank Country"
      expr: bank_country
    - name: "Bank Name"
      expr: bank_name
    - name: "Capacity Assessment Date"
      expr: capacity_assessment_date
    - name: "Chs Certified"
      expr: chs_certified
    - name: "Cluster Memberships"
      expr: cluster_memberships
    - name: "Countries Of Operation"
      expr: countries_of_operation
    - name: "Due Diligence Expiry Date"
      expr: due_diligence_expiry_date
    - name: "Due Diligence Status"
      expr: due_diligence_status
    - name: "Finance Contact Email"
      expr: finance_contact_email
    - name: "Founding Year"
      expr: founding_year
    - name: "Hq Address"
      expr: hq_address
    - name: "Hq City"
      expr: hq_city
    - name: "Hq Country"
      expr: hq_country
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Org"
      expr: COUNT(DISTINCT partner_org_id)
    - name: "Total Annual Budget Usd"
      expr: SUM(annual_budget_usd)
    - name: "Average Annual Budget Usd"
      expr: AVG(annual_budget_usd)
    - name: "Total Capacity Assessment Score"
      expr: SUM(capacity_assessment_score)
    - name: "Average Capacity Assessment Score"
      expr: AVG(capacity_assessment_score)
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_partner_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Performance Review business metrics"
  source: "`ngo_ecm`.`partnership`.`partner_performance_review`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Areas For Improvement"
      expr: areas_for_improvement
    - name: "Beneficiary Feedback Incorporated"
      expr: beneficiary_feedback_incorporated
    - name: "Capacity Building Areas"
      expr: capacity_building_areas
    - name: "Capacity Building Recommended"
      expr: capacity_building_recommended
    - name: "Corrective Action Description"
      expr: corrective_action_description
    - name: "Corrective Action Due Date"
      expr: corrective_action_due_date
    - name: "Corrective Action Required"
      expr: corrective_action_required
    - name: "Corrective Action Status"
      expr: corrective_action_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Field Visit Conducted"
      expr: field_visit_conducted
    - name: "Financial Accountability Rating"
      expr: financial_accountability_rating
    - name: "Key Findings Summary"
      expr: key_findings_summary
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Milestones Achieved Count"
      expr: milestones_achieved_count
    - name: "Milestones Planned Count"
      expr: milestones_planned_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Performance Review"
      expr: COUNT(DISTINCT partner_performance_review_id)
    - name: "Total Budget Utilisation Rate"
      expr: SUM(budget_utilisation_rate)
    - name: "Average Budget Utilisation Rate"
      expr: AVG(budget_utilisation_rate)
    - name: "Total Milestone Achievement Rate"
      expr: SUM(milestone_achievement_rate)
    - name: "Average Milestone Achievement Rate"
      expr: AVG(milestone_achievement_rate)
    - name: "Total Overall Performance Score"
      expr: SUM(overall_performance_score)
    - name: "Average Overall Performance Score"
      expr: AVG(overall_performance_score)
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_partner_report_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Report Submission business metrics"
  source: "`ngo_ecm`.`partnership`.`partner_report_submission`"
  dimensions:
    - name: "Acceptance Date"
      expr: acceptance_date
    - name: "Beneficiaries Reached"
      expr: beneficiaries_reached
    - name: "Cluster Sector"
      expr: cluster_sector
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Days Late"
      expr: days_late
    - name: "Document Url"
      expr: document_url
    - name: "Donor Report Reference"
      expr: donor_report_reference
    - name: "Donor Reporting Obligation"
      expr: donor_reporting_obligation
    - name: "Due Date"
      expr: due_date
    - name: "Feedback Provided"
      expr: feedback_provided
    - name: "Financial Documentation Attached"
      expr: financial_documentation_attached
    - name: "Geographic Coverage"
      expr: geographic_coverage
    - name: "Is Late Submission"
      expr: is_late_submission
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Report Submission"
      expr: COUNT(DISTINCT partner_report_submission_id)
    - name: "Total Approved Budget Amount"
      expr: SUM(approved_budget_amount)
    - name: "Average Approved Budget Amount"
      expr: AVG(approved_budget_amount)
    - name: "Total Quality Score"
      expr: SUM(quality_score)
    - name: "Average Quality Score"
      expr: AVG(quality_score)
    - name: "Total Total Expenditure Reported"
      expr: SUM(total_expenditure_reported)
    - name: "Average Total Expenditure Reported"
      expr: AVG(total_expenditure_reported)
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_partner_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Risk Register business metrics"
  source: "`ngo_ecm`.`partnership`.`partner_risk_register`"
  dimensions:
    - name: "Composite Risk Score"
      expr: composite_risk_score
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Donor Notification Required"
      expr: donor_notification_required
    - name: "Donor Notified Date"
      expr: donor_notified_date
    - name: "Due Diligence Level"
      expr: due_diligence_level
    - name: "Escalated To"
      expr: escalated_to
    - name: "Escalation Date"
      expr: escalation_date
    - name: "Escalation Required"
      expr: escalation_required
    - name: "Fiduciary Risk Flag"
      expr: fiduciary_risk_flag
    - name: "Impact Rating"
      expr: impact_rating
    - name: "Inherent Impact Rating"
      expr: inherent_impact_rating
    - name: "Inherent Likelihood Rating"
      expr: inherent_likelihood_rating
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Likelihood Rating"
      expr: likelihood_rating
    - name: "Mitigation Measures"
      expr: mitigation_measures
    - name: "Mitigation Status"
      expr: mitigation_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Risk Register"
      expr: COUNT(DISTINCT partner_risk_register_id)
    - name: "Total Financial Exposure Usd"
      expr: SUM(financial_exposure_usd)
    - name: "Average Financial Exposure Usd"
      expr: AVG(financial_exposure_usd)
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_partnership_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partnership Agreement business metrics"
  source: "`ngo_ecm`.`partnership`.`partnership_agreement`"
  dimensions:
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Amendment Date"
      expr: amendment_date
    - name: "Amendment Description"
      expr: amendment_description
    - name: "Amendment Number"
      expr: amendment_number
    - name: "Capacity Assessment Date"
      expr: capacity_assessment_date
    - name: "Capacity Assessment Status"
      expr: capacity_assessment_status
    - name: "Cluster Lead Agency"
      expr: cluster_lead_agency
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Resolution Mechanism"
      expr: dispute_resolution_mechanism
    - name: "Due Diligence Risk Rating"
      expr: due_diligence_risk_rating
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Execution Date"
      expr: execution_date
    - name: "Geographic Scope"
      expr: geographic_scope
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partnership Agreement"
      expr: COUNT(DISTINCT partnership_agreement_id)
    - name: "Total Funding Ceiling Amount"
      expr: SUM(funding_ceiling_amount)
    - name: "Average Funding Ceiling Amount"
      expr: AVG(funding_ceiling_amount)
    - name: "Total Indirect Cost Rate"
      expr: SUM(indirect_cost_rate)
    - name: "Average Indirect Cost Rate"
      expr: AVG(indirect_cost_rate)
$$;