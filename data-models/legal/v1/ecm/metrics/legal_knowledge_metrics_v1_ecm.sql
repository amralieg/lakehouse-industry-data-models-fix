-- Metric views for domain: knowledge | Business: Legal | Version: 1 | Generated on: 2026-05-07 11:55:51

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`knowledge_asset_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset Usage business metrics"
  source: "`legal_ecm`.`knowledge`.`asset_usage`"
  dimensions:
    - name: "Access Method"
      expr: access_method
    - name: "Adaptation Type"
      expr: adaptation_type
    - name: "Billable Flag"
      expr: billable_flag
    - name: "Citation Location"
      expr: citation_location
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Device Type"
      expr: device_type
    - name: "Duration Seconds"
      expr: duration_seconds
    - name: "Error Code"
      expr: error_code
    - name: "Error Message"
      expr: error_message
    - name: "Feedback Comment"
      expr: feedback_comment
    - name: "Ip Address"
      expr: ip_address
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Practice Area"
      expr: practice_area
    - name: "Relevance Rating"
      expr: relevance_rating
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Asset Usage"
      expr: COUNT(DISTINCT asset_usage_id)
    - name: "Total Cost Savings Amount"
      expr: SUM(cost_savings_amount)
    - name: "Average Cost Savings Amount"
      expr: AVG(cost_savings_amount)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`knowledge_checklist`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Checklist business metrics"
  source: "`legal_ecm`.`knowledge`.`checklist`"
  dimensions:
    - name: "Access Level"
      expr: access_level
    - name: "Author Name"
      expr: author_name
    - name: "Checklist Code"
      expr: checklist_code
    - name: "Checklist Description"
      expr: checklist_description
    - name: "Checklist Name"
      expr: checklist_name
    - name: "Checklist Status"
      expr: checklist_status
    - name: "Checklist Type"
      expr: checklist_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Is Template"
      expr: is_template
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Language Code"
      expr: language_code
    - name: "Last Used Date"
      expr: last_used_date
    - name: "Mandatory Steps Count"
      expr: mandatory_steps_count
    - name: "Matter Type"
      expr: matter_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Checklist"
      expr: COUNT(DISTINCT checklist_id)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`knowledge_clause`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clause business metrics"
  source: "`legal_ecm`.`knowledge`.`clause`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Clause Category"
      expr: clause_category
    - name: "Clause Text"
      expr: clause_text
    - name: "Clause Type"
      expr: clause_type
    - name: "Clm System Reference"
      expr: clm_system_reference
    - name: "Contract Type Applicability"
      expr: contract_type_applicability
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deprecated Timestamp"
      expr: deprecated_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fallback Position Text"
      expr: fallback_position_text
    - name: "Governing Law Reference"
      expr: governing_law_reference
    - name: "Identifier"
      expr: identifier
    - name: "Industry Applicability"
      expr: industry_applicability
    - name: "Is Standard Form"
      expr: is_standard_form
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Clause"
      expr: COUNT(DISTINCT clause_id)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`knowledge_contribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contribution business metrics"
  source: "`legal_ecm`.`knowledge`.`contribution`"
  dimensions:
    - name: "Approval Outcome"
      expr: approval_outcome
    - name: "Cle Credit Eligible"
      expr: cle_credit_eligible
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Contribution Type"
      expr: contribution_type
    - name: "Contributor Notes"
      expr: contributor_notes
    - name: "Cpd Credit Eligible"
      expr: cpd_credit_eligible
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Reference Code"
      expr: document_reference_code
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Innovation Flag"
      expr: innovation_flag
    - name: "Is Cpd Eligible"
      expr: is_cpd_eligible
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Language Code"
      expr: language_code
    - name: "Last Used Date"
      expr: last_used_date
    - name: "Matter Type"
      expr: matter_type
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contribution"
      expr: COUNT(DISTINCT contribution_id)
    - name: "Total Cle Credit Hours"
      expr: SUM(cle_credit_hours)
    - name: "Average Cle Credit Hours"
      expr: AVG(cle_credit_hours)
    - name: "Total Cpd Credit Hours"
      expr: SUM(cpd_credit_hours)
    - name: "Average Cpd Credit Hours"
      expr: AVG(cpd_credit_hours)
    - name: "Total Quality Score"
      expr: SUM(quality_score)
    - name: "Average Quality Score"
      expr: AVG(quality_score)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`knowledge_control_mapping`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Control Mapping business metrics"
  source: "`legal_ecm`.`knowledge`.`control_mapping`"
  dimensions:
    - name: "Applicability Scope"
      expr: applicability_scope
    - name: "Control Mapping Status"
      expr: control_mapping_status
    - name: "Control Type"
      expr: control_type
    - name: "Deployment Frequency"
      expr: deployment_frequency
    - name: "Effectiveness Rating"
      expr: effectiveness_rating
    - name: "Last Deployment Date"
      expr: last_deployment_date
    - name: "Last Effectiveness Review Date"
      expr: last_effectiveness_review_date
    - name: "Mapped Date"
      expr: mapped_date
    - name: "Next Effectiveness Review Date"
      expr: next_effectiveness_review_date
    - name: "Notes"
      expr: notes
    - name: "Regulatory Mapping Reference"
      expr: regulatory_mapping_reference
    - name: "Last Deployment Date Month"
      expr: DATE_TRUNC('MONTH', last_deployment_date)
    - name: "Last Effectiveness Review Date Month"
      expr: DATE_TRUNC('MONTH', last_effectiveness_review_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Control Mapping"
      expr: COUNT(DISTINCT control_mapping_id)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`knowledge_expertise_directory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Expertise Directory business metrics"
  source: "`legal_ecm`.`knowledge`.`expertise_directory`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Expert Identification Rank"
      expr: expert_identification_rank
    - name: "Expertise Level"
      expr: expertise_level
    - name: "Industry Sector Expertise"
      expr: industry_sector_expertise
    - name: "Jurisdiction Admissions"
      expr: jurisdiction_admissions
    - name: "Knowledge Asset Count"
      expr: knowledge_asset_count
    - name: "Language Capabilities"
      expr: language_capabilities
    - name: "Last Cle Completion Date"
      expr: last_cle_completion_date
    - name: "Last Profile Update Date"
      expr: last_profile_update_date
    - name: "Matter Type Expertise"
      expr: matter_type_expertise
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Nlp Expertise Tags"
      expr: nlp_expertise_tags
    - name: "Notable Matters"
      expr: notable_matters
    - name: "Primary Practice Area"
      expr: primary_practice_area
    - name: "Professional Certifications"
      expr: professional_certifications
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Expertise Directory"
      expr: COUNT(DISTINCT expertise_directory_id)
    - name: "Total Cle Hours Completed"
      expr: SUM(cle_hours_completed)
    - name: "Average Cle Hours Completed"
      expr: AVG(cle_hours_completed)
    - name: "Total Client Feedback Score"
      expr: SUM(client_feedback_score)
    - name: "Average Client Feedback Score"
      expr: AVG(client_feedback_score)
    - name: "Total Cpd Hours Completed"
      expr: SUM(cpd_hours_completed)
    - name: "Average Cpd Hours Completed"
      expr: AVG(cpd_hours_completed)
    - name: "Total Expertise Taxonomy Alignment"
      expr: SUM(expertise_taxonomy_alignment)
    - name: "Average Expertise Taxonomy Alignment"
      expr: AVG(expertise_taxonomy_alignment)
    - name: "Total Expertise To Taxonomy"
      expr: SUM(expertise_to_taxonomy)
    - name: "Average Expertise To Taxonomy"
      expr: AVG(expertise_to_taxonomy)
    - name: "Total Matter Staffing Score"
      expr: SUM(matter_staffing_score)
    - name: "Average Matter Staffing Score"
      expr: AVG(matter_staffing_score)
    - name: "Total Peer Recognition Score"
      expr: SUM(peer_recognition_score)
    - name: "Average Peer Recognition Score"
      expr: AVG(peer_recognition_score)
    - name: "Total Profile Completeness Percentage"
      expr: SUM(profile_completeness_percentage)
    - name: "Average Profile Completeness Percentage"
      expr: AVG(profile_completeness_percentage)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`knowledge_external_source`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "External Source business metrics"
  source: "`legal_ecm`.`knowledge`.`external_source`"
  dimensions:
    - name: "Access Url"
      expr: access_url
    - name: "Api Endpoint Url"
      expr: api_endpoint_url
    - name: "Api Integration Status"
      expr: api_integration_status
    - name: "Authentication Method"
      expr: authentication_method
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Compliance Review Date"
      expr: compliance_review_date
    - name: "Content Categories"
      expr: content_categories
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Cost Centre Code"
      expr: cost_centre_code
    - name: "Coverage Jurisdictions"
      expr: coverage_jurisdictions
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Classification Level"
      expr: data_classification_level
    - name: "External Source Description"
      expr: external_source_description
    - name: "Gdpr Compliant Flag"
      expr: gdpr_compliant_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct External Source"
      expr: COUNT(DISTINCT external_source_id)
    - name: "Total Annual Cost"
      expr: SUM(annual_cost)
    - name: "Average Annual Cost"
      expr: AVG(annual_cost)
    - name: "Total Sla Uptime Percentage"
      expr: SUM(sla_uptime_percentage)
    - name: "Average Sla Uptime Percentage"
      expr: AVG(sla_uptime_percentage)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`knowledge_form_template`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Form Template business metrics"
  source: "`legal_ecm`.`knowledge`.`form_template`"
  dimensions:
    - name: "Applicable Statute"
      expr: applicable_statute
    - name: "Approval Date"
      expr: approval_date
    - name: "Author Name"
      expr: author_name
    - name: "Court Tribunal Name"
      expr: court_tribunal_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Format"
      expr: document_format
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "External Reference Url"
      expr: external_reference_url
    - name: "File Path"
      expr: file_path
    - name: "Filing Fee Currency"
      expr: filing_fee_currency
    - name: "Filing Instructions"
      expr: filing_instructions
    - name: "Form Category"
      expr: form_category
    - name: "Form Code"
      expr: form_code
    - name: "Form Template Status"
      expr: form_template_status
    - name: "Form Title"
      expr: form_title
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Form Template"
      expr: COUNT(DISTINCT form_template_id)
    - name: "Total Filing Fee Amount"
      expr: SUM(filing_fee_amount)
    - name: "Average Filing Fee Amount"
      expr: AVG(filing_fee_amount)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`knowledge_impact_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Impact Assessment business metrics"
  source: "`legal_ecm`.`knowledge`.`impact_assessment`"
  dimensions:
    - name: "Action Taken"
      expr: action_taken
    - name: "Assigned Knowledge Manager"
      expr: assigned_knowledge_manager
    - name: "Content Sections Modified"
      expr: content_sections_modified
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Impact Assessment Text"
      expr: impact_assessment_text
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Review Completion Date"
      expr: review_completion_date
    - name: "Review Priority"
      expr: review_priority
    - name: "Review Start Date"
      expr: review_start_date
    - name: "Review Status"
      expr: review_status
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Last Modified Timestamp Month"
      expr: DATE_TRUNC('MONTH', last_modified_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Impact Assessment"
      expr: COUNT(DISTINCT impact_assessment_id)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`knowledge_knowledge_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Knowledge Asset business metrics"
  source: "`legal_ecm`.`knowledge`.`knowledge_asset`"
  dimensions:
    - name: "Access Classification"
      expr: access_classification
    - name: "Approval Outcome"
      expr: approval_outcome
    - name: "Asset Code"
      expr: asset_code
    - name: "Asset Name"
      expr: asset_name
    - name: "Asset Type"
      expr: asset_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Is Lpp Protected"
      expr: is_lpp_protected
    - name: "Is Template"
      expr: is_template
    - name: "Is Work Product"
      expr: is_work_product
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Knowledge Asset Description"
      expr: knowledge_asset_description
    - name: "Language Code"
      expr: language_code
    - name: "Last Used Date"
      expr: last_used_date
    - name: "Lifecycle Status"
      expr: lifecycle_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Knowledge Asset"
      expr: COUNT(DISTINCT knowledge_asset_id)
    - name: "Total Asset Taxonomy Node"
      expr: SUM(asset_taxonomy_node)
    - name: "Average Asset Taxonomy Node"
      expr: AVG(asset_taxonomy_node)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`knowledge_legal_update`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Legal Update business metrics"
  source: "`legal_ecm`.`knowledge`.`legal_update`"
  dimensions:
    - name: "Access Level"
      expr: access_level
    - name: "Client Notification Required"
      expr: client_notification_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Impact Assessment"
      expr: impact_assessment
    - name: "Impacted Checklists"
      expr: impacted_checklists
    - name: "Impacted Practice Notes"
      expr: impacted_practice_notes
    - name: "Impacted Precedents"
      expr: impacted_precedents
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Keywords"
      expr: keywords
    - name: "Language Code"
      expr: language_code
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Multi Jurisdiction Flag"
      expr: multi_jurisdiction_flag
    - name: "Notification Sent Date"
      expr: notification_sent_date
    - name: "Publication Date"
      expr: publication_date
    - name: "Regulatory Framework"
      expr: regulatory_framework
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Legal Update"
      expr: COUNT(DISTINCT legal_update_id)
    - name: "Total To Taxonomy"
      expr: SUM(to_taxonomy)
    - name: "Average To Taxonomy"
      expr: AVG(to_taxonomy)
    - name: "Total Update To Taxonomy"
      expr: SUM(update_to_taxonomy)
    - name: "Average Update To Taxonomy"
      expr: AVG(update_to_taxonomy)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`knowledge_practice_note`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Practice Note business metrics"
  source: "`legal_ecm`.`knowledge`.`practice_note`"
  dimensions:
    - name: "Abstract"
      expr: abstract
    - name: "Access Level"
      expr: access_level
    - name: "Archived Timestamp"
      expr: archived_timestamp
    - name: "Author Email"
      expr: author_email
    - name: "Author Name"
      expr: author_name
    - name: "Case Law References"
      expr: case_law_references
    - name: "Compliance Framework"
      expr: compliance_framework
    - name: "Content Type"
      expr: content_type
    - name: "Contributing Authors"
      expr: contributing_authors
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Date"
      expr: currency_date
    - name: "Document Format"
      expr: document_format
    - name: "Document Number"
      expr: document_number
    - name: "Download Count"
      expr: download_count
    - name: "External Url"
      expr: external_url
    - name: "File Size Kb"
      expr: file_size_kb
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Practice Note"
      expr: COUNT(DISTINCT practice_note_id)
    - name: "Total Average Rating"
      expr: SUM(average_rating)
    - name: "Average Average Rating"
      expr: AVG(average_rating)
    - name: "Total Taxonomy Classification"
      expr: SUM(taxonomy_classification)
    - name: "Average Taxonomy Classification"
      expr: AVG(taxonomy_classification)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`knowledge_precedent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Precedent business metrics"
  source: "`legal_ecm`.`knowledge`.`precedent`"
  dimensions:
    - name: "Access Restriction"
      expr: access_restriction
    - name: "Amendment Summary"
      expr: amendment_summary
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Author Name"
      expr: author_name
    - name: "Author Practice Group"
      expr: author_practice_group
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Number"
      expr: document_number
    - name: "Document Title"
      expr: document_title
    - name: "Document Type"
      expr: document_type
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "File Format"
      expr: file_format
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Key Clauses"
      expr: key_clauses
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Precedent"
      expr: COUNT(DISTINCT precedent_id)
    - name: "Total File Size Kb"
      expr: SUM(file_size_kb)
    - name: "Average File Size Kb"
      expr: AVG(file_size_kb)
    - name: "Total Taxonomy Classification"
      expr: SUM(taxonomy_classification)
    - name: "Average Taxonomy Classification"
      expr: AVG(taxonomy_classification)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`knowledge_precedent_impact_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Precedent Impact Assessment business metrics"
  source: "`legal_ecm`.`knowledge`.`precedent_impact_assessment`"
  dimensions:
    - name: "Action Taken"
      expr: action_taken
    - name: "Assigned Knowledge Manager"
      expr: assigned_knowledge_manager
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Impact Assessment"
      expr: impact_assessment
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Review Completion Date"
      expr: review_completion_date
    - name: "Review Priority"
      expr: review_priority
    - name: "Review Start Date"
      expr: review_start_date
    - name: "Review Status"
      expr: review_status
    - name: "Reviewer Notes"
      expr: reviewer_notes
    - name: "Sections Modified"
      expr: sections_modified
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Last Modified Timestamp Month"
      expr: DATE_TRUNC('MONTH', last_modified_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Precedent Impact Assessment"
      expr: COUNT(DISTINCT precedent_impact_assessment_id)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`knowledge_precedent_risk_mitigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Precedent Risk Mitigation business metrics"
  source: "`legal_ecm`.`knowledge`.`precedent_risk_mitigation`"
  dimensions:
    - name: "Key Mitigating Clauses"
      expr: key_mitigating_clauses
    - name: "Last Risk Review Date"
      expr: last_risk_review_date
    - name: "Mapped By"
      expr: mapped_by
    - name: "Mapped Date"
      expr: mapped_date
    - name: "Mapping Status"
      expr: mapping_status
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Notes"
      expr: notes
    - name: "Risk Mitigation Effectiveness"
      expr: risk_mitigation_effectiveness
    - name: "Risk Rating When Used"
      expr: risk_rating_when_used
    - name: "Last Risk Review Date Month"
      expr: DATE_TRUNC('MONTH', last_risk_review_date)
    - name: "Mapped Date Month"
      expr: DATE_TRUNC('MONTH', mapped_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Precedent Risk Mitigation"
      expr: COUNT(DISTINCT precedent_risk_mitigation_id)
    - name: "Total Clause Coverage Percentage"
      expr: SUM(clause_coverage_percentage)
    - name: "Average Clause Coverage Percentage"
      expr: AVG(clause_coverage_percentage)
    - name: "Total Usage In Risk Context Count"
      expr: SUM(usage_in_risk_context_count)
    - name: "Average Usage In Risk Context Count"
      expr: AVG(usage_in_risk_context_count)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`knowledge_precedent_update`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Precedent Update business metrics"
  source: "`legal_ecm`.`knowledge`.`precedent_update`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approver Name"
      expr: approver_name
    - name: "Change Detail"
      expr: change_detail
    - name: "Change Summary"
      expr: change_summary
    - name: "Comments"
      expr: comments
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Impact Assessment"
      expr: impact_assessment
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Matter Type"
      expr: matter_type
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "New Version Number"
      expr: new_version_number
    - name: "Notification Date"
      expr: notification_date
    - name: "Notification Method"
      expr: notification_method
    - name: "Notification Sent"
      expr: notification_sent
    - name: "Practice Area"
      expr: practice_area
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Precedent Update"
      expr: COUNT(DISTINCT precedent_update_id)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`knowledge_research_memo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research Memo business metrics"
  source: "`legal_ecm`.`knowledge`.`research_memo`"
  dimensions:
    - name: "Access Control List"
      expr: access_control_list
    - name: "Approval Date"
      expr: approval_date
    - name: "Archived Date"
      expr: archived_date
    - name: "Case Law Citations"
      expr: case_law_citations
    - name: "Conclusion"
      expr: conclusion
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Created Date"
      expr: created_date
    - name: "Document Storage Path"
      expr: document_storage_path
    - name: "Is Precedent"
      expr: is_precedent
    - name: "Is Published To Knowledge Base"
      expr: is_published_to_knowledge_base
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Key Legal Concepts"
      expr: key_legal_concepts
    - name: "Language Code"
      expr: language_code
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "Lexisnexis Source Citations"
      expr: lexisnexis_source_citations
    - name: "Lpp Classification"
      expr: lpp_classification
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Research Memo"
      expr: COUNT(DISTINCT research_memo_id)
    - name: "Total Quality Rating"
      expr: SUM(quality_rating)
    - name: "Average Quality Rating"
      expr: AVG(quality_rating)
    - name: "Total Research Hours"
      expr: SUM(research_hours)
    - name: "Average Research Hours"
      expr: AVG(research_hours)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`knowledge_research_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research Request business metrics"
  source: "`legal_ecm`.`knowledge`.`research_request`"
  dimensions:
    - name: "Assigned Date"
      expr: assigned_date
    - name: "Client Billable Flag"
      expr: client_billable_flag
    - name: "Completed Date"
      expr: completed_date
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Due Date"
      expr: due_date
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Key Terms"
      expr: key_terms
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Practice Area"
      expr: practice_area
    - name: "Quality Review Flag"
      expr: quality_review_flag
    - name: "Related Case Law"
      expr: related_case_law
    - name: "Related Statutes"
      expr: related_statutes
    - name: "Request Number"
      expr: request_number
    - name: "Request Status"
      expr: request_status
    - name: "Request Title"
      expr: request_title
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Research Request"
      expr: COUNT(DISTINCT research_request_id)
    - name: "Total Research Request To Resulting Memo"
      expr: SUM(research_request_to_resulting_memo)
    - name: "Average Research Request To Resulting Memo"
      expr: AVG(research_request_to_resulting_memo)
    - name: "Total Actual Hours"
      expr: SUM(actual_hours)
    - name: "Average Actual Hours"
      expr: AVG(actual_hours)
    - name: "Total Estimated Hours"
      expr: SUM(estimated_hours)
    - name: "Average Estimated Hours"
      expr: AVG(estimated_hours)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`knowledge_taxonomy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Taxonomy business metrics"
  source: "`legal_ecm`.`knowledge`.`taxonomy`"
  dimensions:
    - name: "Access Level"
      expr: access_level
    - name: "Alternate Terms"
      expr: alternate_terms
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Display Order"
      expr: display_order
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "External Taxonomy Mapping"
      expr: external_taxonomy_mapping
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Hierarchy Path"
      expr: hierarchy_path
    - name: "Is Deprecated"
      expr: is_deprecated
    - name: "Is Leaf Node"
      expr: is_leaf_node
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Language Code"
      expr: language_code
    - name: "Last Used Date"
      expr: last_used_date
    - name: "Matter Type"
      expr: matter_type
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Taxonomy"
      expr: COUNT(DISTINCT taxonomy_id)
$$;