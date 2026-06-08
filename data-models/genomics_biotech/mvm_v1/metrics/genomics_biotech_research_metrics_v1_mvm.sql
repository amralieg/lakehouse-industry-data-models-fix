-- Metric views for domain: research | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 15:27:46

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`research_assay_development`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assay Development business metrics"
  source: "`genomics_biotech_ecm`.`research`.`assay_development`"
  dimensions:
    - name: "Assay Code"
      expr: assay_code
    - name: "Assay Name"
      expr: assay_name
    - name: "Assay Type"
      expr: assay_type
    - name: "Commercialization Date"
      expr: commercialization_date
    - name: "Coverage Depth Target"
      expr: coverage_depth_target
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Development Phase"
      expr: development_phase
    - name: "Development Start Date"
      expr: development_start_date
    - name: "Development Status"
      expr: development_status
    - name: "Feasibility Completion Date"
      expr: feasibility_completion_date
    - name: "Intended Use"
      expr: intended_use
    - name: "Ip Status"
      expr: ip_status
    - name: "Lod Unit"
      expr: lod_unit
    - name: "Loq Unit"
      expr: loq_unit
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Multiplexing Capacity"
      expr: multiplexing_capacity
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Assay Development"
      expr: COUNT(DISTINCT assay_development_id)
    - name: "Total Analytical Sensitivity Percent"
      expr: SUM(analytical_sensitivity_percent)
    - name: "Average Analytical Sensitivity Percent"
      expr: AVG(analytical_sensitivity_percent)
    - name: "Total Analytical Specificity Percent"
      expr: SUM(analytical_specificity_percent)
    - name: "Average Analytical Specificity Percent"
      expr: AVG(analytical_specificity_percent)
    - name: "Total Estimated Cogs"
      expr: SUM(estimated_cogs)
    - name: "Average Estimated Cogs"
      expr: AVG(estimated_cogs)
    - name: "Total Lod Value"
      expr: SUM(lod_value)
    - name: "Average Lod Value"
      expr: AVG(lod_value)
    - name: "Total Loq Value"
      expr: SUM(loq_value)
    - name: "Average Loq Value"
      expr: AVG(loq_value)
    - name: "Total Precision Cv Percent"
      expr: SUM(precision_cv_percent)
    - name: "Average Precision Cv Percent"
      expr: AVG(precision_cv_percent)
    - name: "Total Rd Budget Allocated"
      expr: SUM(rd_budget_allocated)
    - name: "Average Rd Budget Allocated"
      expr: AVG(rd_budget_allocated)
    - name: "Total Rd Spend To Date"
      expr: SUM(rd_spend_to_date)
    - name: "Average Rd Spend To Date"
      expr: AVG(rd_spend_to_date)
    - name: "Total Target Asp"
      expr: SUM(target_asp)
    - name: "Average Target Asp"
      expr: AVG(target_asp)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`research_collaboration_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collaboration Agreement business metrics"
  source: "`genomics_biotech_ecm`.`research`.`collaboration_agreement`"
  dimensions:
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Title"
      expr: agreement_title
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Collaboration Agreement Status"
      expr: collaboration_agreement_status
    - name: "Confidentiality Tier"
      expr: confidentiality_tier
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Sharing Obligation"
      expr: data_sharing_obligation
    - name: "Data Use Restrictions"
      expr: data_use_restrictions
    - name: "Effective Date"
      expr: effective_date
    - name: "Exclusivity Scope"
      expr: exclusivity_scope
    - name: "Execution Date"
      expr: execution_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Grant Funding Source"
      expr: grant_funding_source
    - name: "Gxp Applicable"
      expr: gxp_applicable
    - name: "Ip Ownership Model"
      expr: ip_ownership_model
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Collaboration Agreement"
      expr: COUNT(DISTINCT collaboration_agreement_id)
    - name: "Total Total Funding Amount Usd"
      expr: SUM(total_funding_amount_usd)
    - name: "Average Total Funding Amount Usd"
      expr: AVG(total_funding_amount_usd)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`research_construct_assay_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Construct Assay Evaluation business metrics"
  source: "`genomics_biotech_ecm`.`research`.`construct_assay_evaluation`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Evaluation Date"
      expr: evaluation_date
    - name: "Inclusion Rationale"
      expr: inclusion_rationale
    - name: "Usage Role"
      expr: usage_role
    - name: "Validation Status In Assay"
      expr: validation_status_in_assay
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Evaluation Date Month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Construct Assay Evaluation"
      expr: COUNT(DISTINCT construct_assay_evaluation_id)
    - name: "Total Concentration Used"
      expr: SUM(concentration_used)
    - name: "Average Concentration Used"
      expr: AVG(concentration_used)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`research_crispr_construct`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crispr Construct business metrics"
  source: "`genomics_biotech_ecm`.`research`.`crispr_construct`"
  dimensions:
    - name: "Benchling Entity Reference"
      expr: benchling_entity_reference
    - name: "Cas Protein Variant"
      expr: cas_protein_variant
    - name: "Cell Type"
      expr: cell_type
    - name: "Construct Code"
      expr: construct_code
    - name: "Construct Length Bp"
      expr: construct_length_bp
    - name: "Construct Name"
      expr: construct_name
    - name: "Construct Type"
      expr: construct_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Format"
      expr: delivery_format
    - name: "Design Rationale"
      expr: design_rationale
    - name: "Design Status"
      expr: design_status
    - name: "Design Tool"
      expr: design_tool
    - name: "Development Stage"
      expr: development_stage
    - name: "Editing Modality"
      expr: editing_modality
    - name: "Genomic Coordinates"
      expr: genomic_coordinates
    - name: "Grna Sequence"
      expr: grna_sequence
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Crispr Construct"
      expr: COUNT(DISTINCT crispr_construct_id)
    - name: "Total Gc Content Percent"
      expr: SUM(gc_content_percent)
    - name: "Average Gc Content Percent"
      expr: AVG(gc_content_percent)
    - name: "Total Off Target Score"
      expr: SUM(off_target_score)
    - name: "Average Off Target Score"
      expr: AVG(off_target_score)
    - name: "Total On Target Efficiency Score"
      expr: SUM(on_target_efficiency_score)
    - name: "Average On Target Efficiency Score"
      expr: AVG(on_target_efficiency_score)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`research_experiment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Experiment business metrics"
  source: "`genomics_biotech_ecm`.`research`.`experiment`"
  dimensions:
    - name: "Actual End Date"
      expr: actual_end_date
    - name: "Actual Start Date"
      expr: actual_start_date
    - name: "Benchling Eln Entry Reference"
      expr: benchling_eln_entry_reference
    - name: "Contribution Type"
      expr: contribution_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crispr Guide Rna Sequence"
      expr: crispr_guide_rna_sequence
    - name: "Data Included Flag"
      expr: data_included_flag
    - name: "Data Integrity Signature"
      expr: data_integrity_signature
    - name: "Design Type"
      expr: design_type
    - name: "Eln Entry Type"
      expr: eln_entry_type
    - name: "Experiment Code"
      expr: experiment_code
    - name: "Experiment Role"
      expr: experiment_role
    - name: "Experiment Status"
      expr: experiment_status
    - name: "Experiment Type"
      expr: experiment_type
    - name: "Failure Reason"
      expr: failure_reason
    - name: "Figure Reference"
      expr: figure_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Experiment"
      expr: COUNT(DISTINCT experiment_id)
    - name: "Total Actual Cost Usd"
      expr: SUM(actual_cost_usd)
    - name: "Average Actual Cost Usd"
      expr: AVG(actual_cost_usd)
    - name: "Total Estimated Cost Usd"
      expr: SUM(estimated_cost_usd)
    - name: "Average Estimated Cost Usd"
      expr: AVG(estimated_cost_usd)
    - name: "Total Lab Location Code"
      expr: SUM(lab_location_code)
    - name: "Average Lab Location Code"
      expr: AVG(lab_location_code)
    - name: "Total Primary Result Value"
      expr: SUM(primary_result_value)
    - name: "Average Primary Result Value"
      expr: AVG(primary_result_value)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`research_grant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant business metrics"
  source: "`genomics_biotech_ecm`.`research`.`grant`"
  dimensions:
    - name: "Application Submission Date"
      expr: application_submission_date
    - name: "Award Date"
      expr: award_date
    - name: "Award Type"
      expr: award_type
    - name: "Co Investigator Names"
      expr: co_investigator_names
    - name: "Compliance Obligations"
      expr: compliance_obligations
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Current Budget Period End Date"
      expr: current_budget_period_end_date
    - name: "Current Budget Period Start Date"
      expr: current_budget_period_start_date
    - name: "Data Sharing Required"
      expr: data_sharing_required
    - name: "Final Report Due Date"
      expr: final_report_due_date
    - name: "Funding Agency"
      expr: funding_agency
    - name: "Funding Agency Division"
      expr: funding_agency_division
    - name: "Grant Number"
      expr: grant_number
    - name: "Grant Status"
      expr: grant_status
    - name: "Iacuc Approval Number"
      expr: iacuc_approval_number
    - name: "Irb Approval Number"
      expr: irb_approval_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Grant"
      expr: COUNT(DISTINCT grant_id)
    - name: "Total Actual Spend Usd"
      expr: SUM(actual_spend_usd)
    - name: "Average Actual Spend Usd"
      expr: AVG(actual_spend_usd)
    - name: "Total Current Budget Period Amount Usd"
      expr: SUM(current_budget_period_amount_usd)
    - name: "Average Current Budget Period Amount Usd"
      expr: AVG(current_budget_period_amount_usd)
    - name: "Total Direct Costs Usd"
      expr: SUM(direct_costs_usd)
    - name: "Average Direct Costs Usd"
      expr: AVG(direct_costs_usd)
    - name: "Total Indirect Cost Rate Percent"
      expr: SUM(indirect_cost_rate_percent)
    - name: "Average Indirect Cost Rate Percent"
      expr: AVG(indirect_cost_rate_percent)
    - name: "Total Indirect Costs Usd"
      expr: SUM(indirect_costs_usd)
    - name: "Average Indirect Costs Usd"
      expr: AVG(indirect_costs_usd)
    - name: "Total Remaining Balance Usd"
      expr: SUM(remaining_balance_usd)
    - name: "Average Remaining Balance Usd"
      expr: AVG(remaining_balance_usd)
    - name: "Total Total Award Amount Usd"
      expr: SUM(total_award_amount_usd)
    - name: "Average Total Award Amount Usd"
      expr: AVG(total_award_amount_usd)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`research_ip_disclosure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ip Disclosure business metrics"
  source: "`genomics_biotech_ecm`.`research`.`ip_disclosure`"
  dimensions:
    - name: "Assigned Ip Counsel"
      expr: assigned_ip_counsel
    - name: "Benchling Entry Reference"
      expr: benchling_entry_reference
    - name: "Commercial Potential"
      expr: commercial_potential
    - name: "Competitive Advantage"
      expr: competitive_advantage
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Disclosure Code"
      expr: disclosure_code
    - name: "Disclosure Date"
      expr: disclosure_date
    - name: "Disclosure Status"
      expr: disclosure_status
    - name: "Filing Decision Date"
      expr: filing_decision_date
    - name: "Filing Decision Rationale"
      expr: filing_decision_rationale
    - name: "Funding Source"
      expr: funding_source
    - name: "Government Interest Statement"
      expr: government_interest_statement
    - name: "Invention Description"
      expr: invention_description
    - name: "Invention Type"
      expr: invention_type
    - name: "Inventors"
      expr: inventors
    - name: "Ip Counsel Firm"
      expr: ip_counsel_firm
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ip Disclosure"
      expr: COUNT(DISTINCT ip_disclosure_id)
    - name: "Total Estimated Filing Cost Usd"
      expr: SUM(estimated_filing_cost_usd)
    - name: "Average Estimated Filing Cost Usd"
      expr: AVG(estimated_filing_cost_usd)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`research_irb_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Irb Submission business metrics"
  source: "`genomics_biotech_ecm`.`research`.`irb_submission`"
  dimensions:
    - name: "Adverse Event Count"
      expr: adverse_event_count
    - name: "Amendment Count"
      expr: amendment_count
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Expiration Date"
      expr: approval_expiration_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Clinical Trial Registration Number"
      expr: clinical_trial_registration_number
    - name: "Closure Date"
      expr: closure_date
    - name: "Consent Form Version"
      expr: consent_form_version
    - name: "Continuing Review Due Date"
      expr: continuing_review_due_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Privacy Impact Assessment Completed"
      expr: data_privacy_impact_assessment_completed
    - name: "Data Repository Name"
      expr: data_repository_name
    - name: "Estimated Enrollment"
      expr: estimated_enrollment
    - name: "Funding Source"
      expr: funding_source
    - name: "Gdpr Applicable"
      expr: gdpr_applicable
    - name: "Genomic Data Sharing Required"
      expr: genomic_data_sharing_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Irb Submission"
      expr: COUNT(DISTINCT irb_submission_id)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`research_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Milestone business metrics"
  source: "`genomics_biotech_ecm`.`research`.`milestone`"
  dimensions:
    - name: "Actual Completion Date"
      expr: actual_completion_date
    - name: "Advancement Criteria"
      expr: advancement_criteria
    - name: "Assessment Rationale"
      expr: assessment_rationale
    - name: "Benchling Entry Reference"
      expr: benchling_entry_reference
    - name: "Comments"
      expr: comments
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Classification"
      expr: data_classification
    - name: "Decision Rationale"
      expr: decision_rationale
    - name: "Evidence Artifact Reference"
      expr: evidence_artifact_reference
    - name: "Go No Go Decision"
      expr: go_no_go_decision
    - name: "Irb Approval Number"
      expr: irb_approval_number
    - name: "Is Gxp Relevant"
      expr: is_gxp_relevant
    - name: "Is Ip Generating"
      expr: is_ip_generating
    - name: "Is Regulatory Critical"
      expr: is_regulatory_critical
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Milestone Code"
      expr: milestone_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Milestone"
      expr: COUNT(DISTINCT milestone_id)
    - name: "Total Budget Allocated"
      expr: SUM(budget_allocated)
    - name: "Average Budget Allocated"
      expr: AVG(budget_allocated)
    - name: "Total Rd Spend Recognized"
      expr: SUM(rd_spend_recognized)
    - name: "Average Rd Spend Recognized"
      expr: AVG(rd_spend_recognized)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`research_molecular_design`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Molecular Design business metrics"
  source: "`genomics_biotech_ecm`.`research`.`molecular_design`"
  dimensions:
    - name: "Benchling Entity Reference"
      expr: benchling_entity_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Algorithm Version"
      expr: design_algorithm_version
    - name: "Design Code"
      expr: design_code
    - name: "Design Name"
      expr: design_name
    - name: "Design Rationale"
      expr: design_rationale
    - name: "Design Status"
      expr: design_status
    - name: "Design Tool"
      expr: design_tool
    - name: "Design Type"
      expr: design_type
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Genomic Coordinates"
      expr: genomic_coordinates
    - name: "Intended Application"
      expr: intended_application
    - name: "Ip Disclosure Date"
      expr: ip_disclosure_date
    - name: "Ip Status"
      expr: ip_status
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Molecular Design"
      expr: COUNT(DISTINCT molecular_design_id)
    - name: "Total Gc Content Percent"
      expr: SUM(gc_content_percent)
    - name: "Average Gc Content Percent"
      expr: AVG(gc_content_percent)
    - name: "Total Melting Temperature Celsius"
      expr: SUM(melting_temperature_celsius)
    - name: "Average Melting Temperature Celsius"
      expr: AVG(melting_temperature_celsius)
    - name: "Total Off Target Score"
      expr: SUM(off_target_score)
    - name: "Average Off Target Score"
      expr: AVG(off_target_score)
    - name: "Total On Target Efficiency Score"
      expr: SUM(on_target_efficiency_score)
    - name: "Average On Target Efficiency Score"
      expr: AVG(on_target_efficiency_score)
    - name: "Total Storage Temperature Celsius"
      expr: SUM(storage_temperature_celsius)
    - name: "Average Storage Temperature Celsius"
      expr: AVG(storage_temperature_celsius)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`research_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project business metrics"
  source: "`genomics_biotech_ecm`.`research`.`project`"
  dimensions:
    - name: "Actual End Date"
      expr: actual_end_date
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Benchling Project Reference"
      expr: benchling_project_reference
    - name: "Collaboration Type"
      expr: collaboration_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Sharing Required"
      expr: data_sharing_required
    - name: "Grant Number"
      expr: grant_number
    - name: "Gxp Applicable"
      expr: gxp_applicable
    - name: "Intended Use"
      expr: intended_use
    - name: "Ip Classification"
      expr: ip_classification
    - name: "Irb Approval Number"
      expr: irb_approval_number
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Milestone Count"
      expr: milestone_count
    - name: "Milestones Achieved Count"
      expr: milestones_achieved_count
    - name: "Patent Application Number"
      expr: patent_application_number
    - name: "Phase"
      expr: phase
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Project"
      expr: COUNT(DISTINCT project_id)
    - name: "Total Actual Spend Usd"
      expr: SUM(actual_spend_usd)
    - name: "Average Actual Spend Usd"
      expr: AVG(actual_spend_usd)
    - name: "Total Budget Amount Usd"
      expr: SUM(budget_amount_usd)
    - name: "Average Budget Amount Usd"
      expr: AVG(budget_amount_usd)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`research_publication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Publication business metrics"
  source: "`genomics_biotech_ecm`.`research`.`publication`"
  dimensions:
    - name: "Abstract"
      expr: abstract
    - name: "Acceptance Date"
      expr: acceptance_date
    - name: "Authors"
      expr: authors
    - name: "Citation Count"
      expr: citation_count
    - name: "Collaboration Type"
      expr: collaboration_type
    - name: "Conference Name"
      expr: conference_name
    - name: "Corresponding Author Email"
      expr: corresponding_author_email
    - name: "Corresponding Author Name"
      expr: corresponding_author_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Repository Url"
      expr: data_repository_url
    - name: "Data Sharing Required"
      expr: data_sharing_required
    - name: "Doi"
      expr: doi
    - name: "Embargo End Date"
      expr: embargo_end_date
    - name: "Embargo Flag"
      expr: embargo_flag
    - name: "External Author Count"
      expr: external_author_count
    - name: "First Author Name"
      expr: first_author_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Publication"
      expr: COUNT(DISTINCT publication_id)
    - name: "Total Impact Factor"
      expr: SUM(impact_factor)
    - name: "Average Impact Factor"
      expr: AVG(impact_factor)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`research_research_protocol`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research Protocol business metrics"
  source: "`genomics_biotech_ecm`.`research`.`research_protocol`"
  dimensions:
    - name: "Applicable Instruments"
      expr: applicable_instruments
    - name: "Applicable Sample Types"
      expr: applicable_sample_types
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Assay Type"
      expr: assay_type
    - name: "Authored By"
      expr: authored_by
    - name: "Benchling Protocol Reference"
      expr: benchling_protocol_reference
    - name: "Change Summary"
      expr: change_summary
    - name: "Clia Applicable"
      expr: clia_applicable
    - name: "Coverage Depth Target"
      expr: coverage_depth_target
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "External Reference Standard"
      expr: external_reference_standard
    - name: "Glp Compliant"
      expr: glp_compliant
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Research Protocol"
      expr: COUNT(DISTINCT research_protocol_id)
    - name: "Total Estimated Duration Hours"
      expr: SUM(estimated_duration_hours)
    - name: "Average Estimated Duration Hours"
      expr: AVG(estimated_duration_hours)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`research_spend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spend business metrics"
  source: "`genomics_biotech_ecm`.`research`.`spend`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Date"
      expr: approved_date
    - name: "Capitalization Eligible"
      expr: capitalization_eligible
    - name: "Capitalization Status"
      expr: capitalization_status
    - name: "Cost Category"
      expr: cost_category
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Invoice Number"
      expr: invoice_number
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Payment Date"
      expr: payment_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Spend"
      expr: COUNT(DISTINCT spend_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Amount Local"
      expr: SUM(amount_local)
    - name: "Average Amount Local"
      expr: AVG(amount_local)
    - name: "Total Budget Line Item Code"
      expr: SUM(budget_line_item_code)
    - name: "Average Budget Line Item Code"
      expr: AVG(budget_line_item_code)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Fte Allocation"
      expr: SUM(fte_allocation)
    - name: "Average Fte Allocation"
      expr: AVG(fte_allocation)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`research_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Study business metrics"
  source: "`genomics_biotech_ecm`.`research`.`study`"
  dimensions:
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Retention Period Days"
      expr: data_retention_period_days
    - name: "Data Retention Policy"
      expr: data_retention_policy
    - name: "Data Sharing Status"
      expr: data_sharing_status
    - name: "Design"
      expr: design
    - name: "Disease Area"
      expr: disease_area
    - name: "End Date"
      expr: end_date
    - name: "Funding Source"
      expr: funding_source
    - name: "Irb Approval Date"
      expr: irb_approval_date
    - name: "Is Multi Center"
      expr: is_multi_center
    - name: "Number Of Sites"
      expr: number_of_sites
    - name: "Objective"
      expr: objective
    - name: "Phase"
      expr: phase
    - name: "Principal Investigator"
      expr: principal_investigator
    - name: "Protocol Version"
      expr: protocol_version
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Study"
      expr: COUNT(DISTINCT study_id)
    - name: "Total Funding Amount"
      expr: SUM(funding_amount)
    - name: "Average Funding Amount"
      expr: AVG(funding_amount)
    - name: "Total Participant Count"
      expr: SUM(participant_count)
    - name: "Average Participant Count"
      expr: AVG(participant_count)
$$;