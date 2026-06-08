# Clinical Trials Lakehouse Data Models

**Version 1** | Generated on May 07, 2026 at 02:33 AM

**Industry:** clinical-research

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Agreement](#domain-agreement)
  - [Biostatistics](#domain-biostatistics)
  - [Compliance](#domain-compliance)
  - [Consent](#domain-consent)
  - [Data](#domain-data)
  - [Document](#domain-document)
  - [Finance](#domain-finance)
  - [Laboratory](#domain-laboratory)
  - [Monitoring](#domain-monitoring)
  - [Program](#domain-program)
  - [Randomization](#domain-randomization)
  - [Regulatory](#domain-regulatory)
  - [Safety](#domain-safety)
  - [Site](#domain-site)
  - [Sponsor](#domain-sponsor)
  - [Study](#domain-study)
  - [Subject](#domain-subject)
  - [Supply](#domain-supply)
  - [Workforce](#domain-workforce)


## Business Description

Clinical Trials is a specialized industry that designs, manages, and monitors clinical research studies for pharmaceutical and biotech sponsors, providing data analytics, regulatory expertise, and patient recruitment to accelerate drug development.

## Model Scope Variations

This data model is available in **two scope variations** — the **MVM (Minimum Viable Model)** and the **ECM (Expanded Coverage Model)** — each designed for different organizational needs and use cases. Both models share the same attribute depth per table; the difference is in breadth (number of domains and tables).

### MVM (Minimum Viable Model) — `v1_mvm`

The **MVM** is a production-ready, core data model that covers all essential business functions with full attribute depth. It is the recommended starting point for organizations that want to deploy quickly and expand incrementally. The MVM is ideal for:

- **Small-to-Mid Businesses** — A thin, efficient model for organizations that need a complete but focused data platform without the overhead of corporate back-office domains
- **Production-Ready Foundation** — Deploy to production from day one and grow by adding domains as business needs evolve
- **Proof-of-Concept & Demos** — Quick deployment for stakeholder presentations and proof-of-concept engagements
- **Targeted Analytics** — Focused analytical workloads centered on core business processes
- **Rapid Onboarding** — Simplified structure for teams getting started with the data platform
- **Development & Testing** — Lightweight model for development environments and integration testing

The MVM prioritizes **Operations** and **Business** division domains, excludes corporate/back-office functions, minimizes association (many-to-many bridge) tables, and relies on direct foreign key relationships for simplicity. Every table in the MVM has the **same attribute depth** as the ECM.

### ECM (Expanded Coverage Model) — `v1_ecm`

The **ECM** is a comprehensive, full-coverage data model that covers the complete breadth of business operations, including corporate functions, detailed audit trails, association tables, and granular reference data. It is designed for:

- **Enterprise-Scale Organizations** — Complete data platform for large-scale enterprises with complex operations
- **Full-Coverage Data Warehousing** — Lakehouse model supporting all business units and divisions
- **Regulatory & Compliance** — Includes audit, legal, and compliance domains required for governance
- **Cross-Functional Analytics** — Enables analysis across all divisions including HR, Finance, IT, and more

The ECM includes all domains from the MVM plus additional **Corporate/Supporting** division domains, many-to-many association tables, helper/lookup tables, and expanded attribute coverage.


## Head-to-Head Comparison

| Dimension | MVM (Minimum Viable Model) | ECM (Expanded Coverage Model) |
|---|---|---|
| **Folder Convention** | `mvm_v1` | `ecm_v1` |
| **Target Organization** | Small-to-mid businesses, startups, focused teams | Large enterprises, complex multi-division organizations |
| **Domain Coverage** | Core operations + business domains | All domains including corporate back-office |
| **Divisions Included** | Operations, Business | Operations, Business, Corporate |
| **Attribute Depth** | Full (same as ECM) | Full |
| **M:N Associations** | Minimized (direct FKs preferred) | Comprehensive junction tables |
| **Growth Path** | Start here, enlarge to ECM as needed | Complete from day one |
| **Best For** | Quick production deployments, focused analytics, POC, growing businesses | Organization-wide analytics, compliance, global operations |

## Model Metrics Comparison

| Metric | MVM (Minimum Viable Model) | ECM (Expanded Coverage Model) |
|---|---|---|
| Domains | 13 | 19 |
| Subdomains | 36 | 67 |
| Products (Tables) | 193 | 379 |
| Attributes (Columns) | 8719 | 15530 |
| Foreign Keys | 1991 | 3128 |
| Avg Attributes/Product | 45.2 | 41.0 |

## Domain & Product Comparison

<a id="domain-agreement"></a>
### agreement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| commercial_terms | agreement_billing_milestone | ✅ | ❌ | Domain not in MVM |
| commercial_terms | investigator_grant | ✅ | ❌ | Domain not in MVM |
| commercial_terms | rate_card | ✅ | ❌ | Domain not in MVM |
| commercial_terms | service_level_agreement | ✅ | ❌ | Domain not in MVM |
| contract_structure | change_order | ✅ | ❌ | Domain not in MVM |
| contract_structure | confidentiality_agreement | ✅ | ❌ | Domain not in MVM |
| contract_structure | contract_amendment | ✅ | ❌ | Domain not in MVM |
| contract_structure | master_service_agreement | ✅ | ❌ | Domain not in MVM |
| contract_structure | preferred_provider_agreement | ✅ | ❌ | Domain not in MVM |
| contract_structure | scope_of_work | ✅ | ❌ | Domain not in MVM |
| contract_structure | study_contract | ✅ | ❌ | Domain not in MVM |
| contract_structure | subcontract | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | contract_negotiation | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | contract_obligation | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | deliverable | ✅ | ❌ | Domain not in MVM |
| obligation_compliance | obligation_fulfillment | ✅ | ❌ | Domain not in MVM |

<a id="domain-biostatistics"></a>
### biostatistics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| analysis_planning | analysis_population | ✅ | ✅ |  |
| analysis_planning | estimand | ✅ | ✅ |  |
| analysis_planning | pk_analysis_spec | ✅ | ❌ | Excluded from MVM |
| analysis_planning | sample_size_calc | ✅ | ✅ |  |
| analysis_planning | sap | ✅ | ✅ |  |
| analysis_planning | sap_amendment | ✅ | ✅ |  |
| analysis_planning | statistical_endpoint | ✅ | ✅ |  |
| output_production | adam_dataset_spec | ✅ | ✅ |  |
| output_production | adam_variable_spec | ✅ | ✅ |  |
| output_production | database_lock_event | ✅ | ✅ |  |
| output_production | tlf_output | ✅ | ✅ |  |
| output_production | tlf_shell | ✅ | ✅ |  |
| safety_oversight | dsmb_charter | ✅ | ❌ | Excluded from MVM |
| safety_oversight | dsmb_meeting | ✅ | ❌ | Excluded from MVM |
| safety_oversight | interim_analysis | ✅ | ✅ |  |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| corrective_actions | capa | ❌ | ✅ | MVM only (stub or new) |
| corrective_actions | capa_action_item | ✅ | ✅ |  |
| corrective_actions | compliance_capa | ✅ | ❌ | Excluded from MVM |
| corrective_actions | deviation_classification | ✅ | ✅ |  |
| corrective_actions | protocol_deviation | ✅ | ✅ |  |
| corrective_actions | quality_event | ✅ | ✅ |  |
| corrective_actions | risk_assessment | ✅ | ✅ |  |
| ethics_oversight | continuing_review | ✅ | ❌ | Excluded from MVM |
| ethics_oversight | ethics_approval | ✅ | ✅ |  |
| ethics_oversight | ethics_committee | ✅ | ✅ |  |
| ethics_oversight | ethics_correspondence | ✅ | ❌ | Excluded from MVM |
| ethics_oversight | ethics_submission | ✅ | ✅ |  |
| ethics_oversight | irb_reliance | ✅ | ❌ | Excluded from MVM |
| ethics_oversight | obligation | ✅ | ❌ | Excluded from MVM |
| ethics_oversight | regulatory_commitment | ✅ | ✅ |  |
| ethics_oversight | vulnerable_population | ✅ | ❌ | Excluded from MVM |
| quality_auditing | audit | ✅ | ✅ |  |
| quality_auditing | audit_finding | ✅ | ✅ |  |
| quality_auditing | compliance_inspection | ✅ | ✅ |  |
| quality_auditing | inspection_finding | ✅ | ✅ |  |
| training_procedures | compliance_sop | ✅ | ✅ |  |
| training_procedures | sop_training_record | ✅ | ✅ |  |
| training_procedures | sop_training_requirement | ✅ | ✅ |  |
| training_procedures | training_plan | ✅ | ❌ | Excluded from MVM |

<a id="domain-consent"></a>
### consent

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_oversight | audit_entry | ✅ | ❌ | Domain not in MVM |
| compliance_oversight | consent_delegation_log | ✅ | ❌ | Domain not in MVM |
| compliance_oversight | consent_deviation | ✅ | ❌ | Domain not in MVM |
| compliance_oversight | gdpr_data_consent | ✅ | ❌ | Domain not in MVM |
| compliance_oversight | waiver | ✅ | ❌ | Domain not in MVM |
| document_management | consent_icf_version | ✅ | ❌ | Domain not in MVM |
| document_management | icf_amendment | ✅ | ❌ | Domain not in MVM |
| document_management | translation | ✅ | ❌ | Domain not in MVM |
| subject_authorization | assent_record | ✅ | ❌ | Domain not in MVM |
| subject_authorization | capacity_assessment | ✅ | ❌ | Domain not in MVM |
| subject_authorization | econsent_session | ✅ | ❌ | Domain not in MVM |
| subject_authorization | lar_representative | ✅ | ❌ | Domain not in MVM |
| subject_authorization | reconsent_trigger | ✅ | ❌ | Domain not in MVM |
| subject_authorization | subject_consent | ✅ | ❌ | Domain not in MVM |
| subject_authorization | withdrawal | ✅ | ❌ | Domain not in MVM |

<a id="domain-data"></a>
### data

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| collection_entry | alcoa_audit_entry | ✅ | ❌ | Excluded from MVM |
| collection_entry | data_entry_session | ✅ | ❌ | Excluded from MVM |
| collection_entry | discrepancy_query | ✅ | ✅ |  |
| collection_entry | field_entry | ✅ | ✅ |  |
| collection_entry | subject_visit_data | ✅ | ✅ |  |
| form_design | ecrf_field | ✅ | ✅ |  |
| form_design | ecrf_form | ✅ | ✅ |  |
| form_design | edc_study_build | ✅ | ✅ |  |
| form_design | validation_rule | ✅ | ✅ |  |
| standards_submission | coding_assignment | ✅ | ✅ |  |
| standards_submission | dmp | ✅ | ✅ |  |
| standards_submission | external_transfer | ✅ | ✅ |  |
| standards_submission | reconciliation | ✅ | ✅ |  |
| standards_submission | sdtm_dataset | ✅ | ✅ |  |
| standards_submission | sdtm_mapping | ✅ | ✅ |  |

<a id="domain-document"></a>
### document

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_governance | access_log | ✅ | ❌ | Excluded from MVM |
| compliance_governance | distribution | ✅ | ✅ |  |
| compliance_governance | signature | ✅ | ✅ |  |
| compliance_governance | workflow | ✅ | ✅ |  |
| controlled_authoring | delegation_of_authority | ✅ | ❌ | Excluded from MVM |
| controlled_authoring | document_icf_version | ✅ | ❌ | Excluded from MVM |
| controlled_authoring | document_sop | ✅ | ✅ |  |
| controlled_authoring | template | ✅ | ❌ | Excluded from MVM |
| controlled_authoring | version | ✅ | ✅ |  |
| trial_files | site_filing | ❌ | ✅ | MVM only (stub or new) |
| trial_filing | archival_record | ✅ | ✅ |  |
| trial_filing | binder_document | ✅ | ❌ | Excluded from MVM |
| trial_filing | etmf_exchange | ✅ | ❌ | Excluded from MVM |
| trial_filing | inspection_readiness | ✅ | ✅ |  |
| trial_filing | regulatory_binder | ✅ | ✅ |  |
| trial_filing | site_file | ✅ | ✅ |  |
| trial_filing | site_file_document | ✅ | ❌ | Excluded from MVM |
| trial_filing | tmf_artifact | ✅ | ✅ |  |
| trial_filing | tmf_completeness | ✅ | ✅ |  |
| trial_filing | tmf_document | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| accounting_operations | accrual | ✅ | ❌ | Domain not in MVM |
| accounting_operations | journal_entry | ✅ | ❌ | Domain not in MVM |
| accounting_operations | revenue_recognition | ✅ | ❌ | Domain not in MVM |
| billing_collections | finance_billing_milestone | ✅ | ❌ | Domain not in MVM |
| billing_collections | invoice_line | ✅ | ❌ | Domain not in MVM |
| billing_collections | sponsor_invoice | ✅ | ❌ | Domain not in MVM |
| budget_planning | budget_line | ✅ | ❌ | Domain not in MVM |
| budget_planning | cost_center | ✅ | ❌ | Domain not in MVM |
| budget_planning | financial_forecast | ✅ | ❌ | Domain not in MVM |
| budget_planning | gl_account | ✅ | ❌ | Domain not in MVM |
| budget_planning | study_budget | ✅ | ❌ | Domain not in MVM |
| vendor_payments | patient_stipend | ✅ | ❌ | Domain not in MVM |
| vendor_payments | purchase_order | ✅ | ❌ | Domain not in MVM |
| vendor_payments | site_payment | ✅ | ❌ | Domain not in MVM |
| vendor_payments | vendor | ✅ | ❌ | Domain not in MVM |
| vendor_payments | vendor_invoice | ✅ | ❌ | Domain not in MVM |

<a id="domain-laboratory"></a>
### laboratory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| analytical_results | bioanalytical_assay | ✅ | ✅ |  |
| analytical_results | bioanalytical_result | ✅ | ✅ |  |
| analytical_results | lab_query | ✅ | ✅ |  |
| analytical_results | lab_result | ✅ | ✅ |  |
| facility_compliance | lab_accreditation | ✅ | ✅ |  |
| facility_compliance | lab_certification | ✅ | ❌ | Excluded from MVM |
| facility_compliance | lab_facility | ✅ | ✅ |  |
| facility_compliance | lab_qualification | ✅ | ❌ | Excluded from MVM |
| facility_compliance | lab_service_contract | ✅ | ❌ | Excluded from MVM |
| facility_management | panel_facility_qualification | ❌ | ✅ | MVM only (stub or new) |
| specimen_operations | lab_kit | ✅ | ✅ |  |
| specimen_operations | pk_sample | ✅ | ✅ |  |
| specimen_operations | shipment_manifest | ✅ | ❌ | Excluded from MVM |
| specimen_operations | specimen | ✅ | ✅ |  |
| specimen_operations | specimen_aliquot | ✅ | ✅ |  |
| specimen_operations | specimen_collection | ✅ | ✅ |  |
| specimen_operations | specimen_shipment | ✅ | ✅ |  |
| test_configuration | critical_value | ✅ | ✅ |  |
| test_configuration | lab_analyte | ✅ | ❌ | Excluded from MVM |
| test_configuration | lab_panel | ✅ | ✅ |  |
| test_configuration | panel_composition | ✅ | ❌ | Excluded from MVM |
| test_configuration | protocol_lab_schedule | ✅ | ❌ | Excluded from MVM |
| test_configuration | reference_range | ✅ | ✅ |  |
| test_configuration | sow_lab_panel_requirement | ✅ | ❌ | Excluded from MVM |

<a id="domain-monitoring"></a>
### monitoring

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_findings | escalation_record | ✅ | ❌ | Excluded from MVM |
| compliance_findings | ip_accountability_log | ✅ | ❌ | Excluded from MVM |
| compliance_findings | monitoring_action_item | ✅ | ✅ |  |
| compliance_findings | sdv_record | ✅ | ✅ |  |
| compliance_findings | visit_deviation_finding | ✅ | ✅ |  |
| compliance_findings | visit_finding | ✅ | ✅ |  |
| risk_surveillance | central_monitoring_alert | ✅ | ✅ |  |
| risk_surveillance | risk_indicator | ✅ | ✅ |  |
| risk_surveillance | site_risk_assessment | ✅ | ✅ |  |
| visit_operations | checklist_item | ✅ | ❌ | Excluded from MVM |
| visit_operations | monitoring_cra_assignment | ✅ | ✅ |  |
| visit_operations | monitoring_plan | ✅ | ✅ |  |
| visit_operations | monitoring_visit | ✅ | ✅ |  |
| visit_operations | monitoring_visit_schedule | ✅ | ✅ |  |
| visit_operations | visit_checklist | ✅ | ✅ |  |
| visit_operations | visit_report | ✅ | ✅ |  |

<a id="domain-program"></a>
### program

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| development_planning | amendment | ✅ | ❌ | Domain not in MVM |
| development_planning | clinical_program | ✅ | ❌ | Domain not in MVM |
| development_planning | cross_study_dependency | ✅ | ❌ | Domain not in MVM |
| development_planning | indication | ✅ | ❌ | Domain not in MVM |
| development_planning | program_plan | ✅ | ❌ | Domain not in MVM |
| development_planning | program_status_history | ✅ | ❌ | Domain not in MVM |
| development_planning | program_study | ✅ | ❌ | Domain not in MVM |
| development_planning | therapeutic_area | ✅ | ❌ | Domain not in MVM |
| oversight_decisions | competitive_intelligence | ✅ | ❌ | Domain not in MVM |
| oversight_decisions | decision | ✅ | ❌ | Domain not in MVM |
| oversight_decisions | governance | ✅ | ❌ | Domain not in MVM |
| oversight_decisions | governance_meeting | ✅ | ❌ | Domain not in MVM |
| oversight_decisions | program_communication | ✅ | ❌ | Domain not in MVM |
| oversight_decisions | team_member | ✅ | ❌ | Domain not in MVM |
| risk_performance | assumption | ✅ | ❌ | Domain not in MVM |
| risk_performance | kri | ✅ | ❌ | Domain not in MVM |
| risk_performance | kri_reading | ✅ | ❌ | Domain not in MVM |
| risk_performance | risk | ✅ | ❌ | Domain not in MVM |
| risk_performance | risk_mitigation | ✅ | ❌ | Domain not in MVM |
| timeline_tracking | budget | ✅ | ❌ | Domain not in MVM |
| timeline_tracking | program_milestone | ✅ | ❌ | Domain not in MVM |
| timeline_tracking | program_resource_plan | ✅ | ❌ | Domain not in MVM |
| timeline_tracking | timeline | ✅ | ❌ | Domain not in MVM |
| timeline_tracking | timeline_event | ✅ | ❌ | Domain not in MVM |

<a id="domain-randomization"></a>
### randomization

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| allocation_design | blinding_config | ✅ | ✅ |  |
| allocation_design | rand_code | ✅ | ✅ |  |
| allocation_design | rand_list | ✅ | ✅ |  |
| allocation_design | rand_scheme | ✅ | ✅ |  |
| allocation_design | stratification_cell | ✅ | ✅ |  |
| allocation_design | stratification_factor | ✅ | ✅ |  |
| allocation_design | treatment_arm | ✅ | ✅ |  |
| treatment_dispensing | irt_transaction | ✅ | ✅ |  |
| treatment_dispensing | kit_assignment | ✅ | ✅ |  |
| treatment_dispensing | rand_deviation | ✅ | ❌ | Excluded from MVM |
| treatment_dispensing | rand_validation_run | ✅ | ❌ | Excluded from MVM |
| treatment_dispensing | subject_randomization | ✅ | ✅ |  |
| unblinding_oversight | dsmb_unblind_package | ✅ | ❌ | Excluded from MVM |
| unblinding_oversight | unblinding_approval | ✅ | ✅ |  |
| unblinding_oversight | unblinding_request | ✅ | ✅ |  |

<a id="domain-regulatory"></a>
### regulatory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| application_lifecycle | application | ✅ | ✅ |  |
| application_lifecycle | clinical_trial_authorization | ✅ | ✅ |  |
| application_lifecycle | dossier_ethics_reference | ✅ | ❌ | Excluded from MVM |
| application_lifecycle | ind_application | ✅ | ✅ |  |
| application_lifecycle | nda_bla_application | ✅ | ❌ | Excluded from MVM |
| application_lifecycle | protocol_ethics_coverage | ✅ | ❌ | Excluded from MVM |
| application_lifecycle | regulatory_protocol_amendment | ✅ | ✅ |  |
| authority_engagement | agency_meeting | ✅ | ✅ |  |
| authority_engagement | approval | ✅ | ✅ |  |
| authority_engagement | health_authority | ✅ | ✅ |  |
| authority_engagement | regulatory_action_item | ✅ | ✅ |  |
| authority_engagement | regulatory_engagement | ✅ | ❌ | Excluded from MVM |
| authority_engagement | regulatory_inspection | ✅ | ✅ |  |
| compliance_operations | commitment | ✅ | ✅ |  |
| compliance_operations | country_registration | ✅ | ✅ |  |
| compliance_operations | label_approval | ✅ | ❌ | Excluded from MVM |
| compliance_operations | labeling_document | ✅ | ❌ | Excluded from MVM |
| compliance_operations | rems_program | ✅ | ❌ | Excluded from MVM |
| compliance_operations | safety_report_submission | ✅ | ✅ |  |
| strategy_intelligence | intelligence | ✅ | ❌ | Excluded from MVM |
| strategy_intelligence | procedure | ✅ | ✅ |  |
| strategy_intelligence | regulatory_milestone | ✅ | ✅ |  |
| strategy_intelligence | special_designation | ✅ | ✅ |  |
| strategy_intelligence | strategy | ✅ | ✅ |  |
| submission_management | binder_content_inclusion | ✅ | ❌ | Excluded from MVM |
| submission_management | binder_document_inclusion | ✅ | ❌ | Excluded from MVM |
| submission_management | correspondence | ✅ | ✅ |  |
| submission_management | ctd_dossier | ✅ | ✅ |  |
| submission_management | submission | ✅ | ✅ |  |
| submission_management | submission_content_unit | ✅ | ✅ |  |
| submission_management | submission_sequence | ✅ | ✅ |  |
| submission_management | substantial_modification_submission | ✅ | ❌ | Excluded from MVM |

<a id="domain-safety"></a>
### safety

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| event_reporting | adverse_event | ✅ | ✅ |  |
| event_reporting | ae_follow_up | ✅ | ❌ | Excluded from MVM |
| event_reporting | ae_meddra_coding | ✅ | ✅ |  |
| event_reporting | causality_assessment | ✅ | ✅ |  |
| event_reporting | ctcae_grade | ✅ | ✅ |  |
| event_reporting | meddra_term | ✅ | ✅ |  |
| event_reporting | narrative | ✅ | ✅ |  |
| event_reporting | serious_adverse_event | ✅ | ✅ |  |
| event_reporting | signal_case_contribution | ✅ | ❌ | Excluded from MVM |
| event_reporting | susar | ✅ | ✅ |  |
| regulatory_submission | dsur | ✅ | ✅ |  |
| regulatory_submission | dsur_line_listing | ✅ | ❌ | Excluded from MVM |
| regulatory_submission | expedited_report_deadline | ✅ | ✅ |  |
| regulatory_submission | icsr | ✅ | ✅ |  |
| regulatory_submission | reporting_obligation | ✅ | ✅ |  |
| regulatory_submission | safety_communication | ✅ | ❌ | Excluded from MVM |
| regulatory_submission | signal_notification | ✅ | ❌ | Excluded from MVM |
| regulatory_submission | susar_submission | ✅ | ❌ | Excluded from MVM |
| signal_governance | assessment_dataset_evidence | ✅ | ❌ | Excluded from MVM |
| signal_governance | benefit_risk_assessment | ✅ | ❌ | Excluded from MVM |
| signal_governance | committee_membership | ✅ | ❌ | Excluded from MVM |
| signal_governance | dsmb_recommendation | ✅ | ✅ |  |
| signal_governance | dsmb_review | ✅ | ✅ |  |
| signal_governance | investigator_brochure_safety | ✅ | ❌ | Excluded from MVM |
| signal_governance | review_committee | ✅ | ✅ |  |
| signal_governance | signal | ✅ | ✅ |  |
| signal_governance | signal_evaluation | ✅ | ✅ |  |
| signal_oversight | communication | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-site"></a>
### site

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| activation_operations | activation | ✅ | ✅ |  |
| activation_operations | closeout | ✅ | ✅ |  |
| activation_operations | depot_assignment | ✅ | ❌ | Excluded from MVM |
| activation_operations | enrollment_performance | ✅ | ✅ |  |
| activation_operations | initiation_visit | ✅ | ✅ |  |
| activation_operations | signal_review | ✅ | ❌ | Excluded from MVM |
| activation_operations | site_cra_assignment | ✅ | ✅ |  |
| activation_operations | study_site | ✅ | ✅ |  |
| qualification_selection | feasibility_assessment | ✅ | ✅ |  |
| qualification_selection | pi_qualification | ✅ | ❌ | Excluded from MVM |
| qualification_selection | program_site_participation | ✅ | ❌ | Excluded from MVM |
| qualification_selection | selection | ✅ | ✅ |  |
| qualification_selection | site_selection_committee | ✅ | ❌ | Excluded from MVM |
| qualification_selection | sponsor_site_qualification | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | authorization | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | ib_site_distribution | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | irb_iec_approval | ✅ | ✅ |  |
| regulatory_compliance | regulatory_submission_site | ✅ | ✅ |  |
| regulatory_compliance | site_agreement | ✅ | ❌ | Excluded from MVM |
| site_identity | agreement | ❌ | ✅ | MVM only (stub or new) |
| site_identity | capacity | ✅ | ❌ | Excluded from MVM |
| site_identity | investigational_site | ✅ | ✅ |  |
| site_identity | principal_investigator | ✅ | ✅ |  |
| site_identity | site_contact | ✅ | ✅ |  |
| site_identity | specialization | ✅ | ❌ | Excluded from MVM |
| site_identity | staff_roster | ✅ | ❌ | Excluded from MVM |

<a id="domain-sponsor"></a>
### sponsor

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| commercial_relationship | account_plan | ✅ | ❌ | Domain not in MVM |
| commercial_relationship | delivery_preference | ✅ | ❌ | Domain not in MVM |
| commercial_relationship | engagement_scope | ✅ | ❌ | Domain not in MVM |
| commercial_relationship | master_agreement | ✅ | ❌ | Domain not in MVM |
| commercial_relationship | sponsor_engagement | ✅ | ❌ | Domain not in MVM |
| corporate_structure | engagement_contact_assignment | ✅ | ❌ | Domain not in MVM |
| corporate_structure | org_hierarchy | ✅ | ❌ | Domain not in MVM |
| corporate_structure | organization | ✅ | ❌ | Domain not in MVM |
| corporate_structure | sponsor_contact | ✅ | ❌ | Domain not in MVM |
| development_pipeline | pipeline_asset | ✅ | ❌ | Domain not in MVM |
| development_pipeline | pipeline_asset_phase | ✅ | ❌ | Domain not in MVM |
| development_pipeline | regulatory_strategy | ✅ | ❌ | Domain not in MVM |
| development_pipeline | study_portfolio | ✅ | ❌ | Domain not in MVM |
| operational_governance | bid_request | ✅ | ❌ | Domain not in MVM |
| operational_governance | escalation | ✅ | ❌ | Domain not in MVM |
| operational_governance | interaction | ✅ | ❌ | Domain not in MVM |
| operational_governance | proposal | ✅ | ❌ | Domain not in MVM |
| operational_governance | proposal_line | ✅ | ❌ | Domain not in MVM |
| operational_governance | review_meeting | ✅ | ❌ | Domain not in MVM |

<a id="domain-study"></a>
### study

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| clinical_operations | amendment_site_implementation | ✅ | ❌ | Excluded from MVM |
| clinical_operations | country | ✅ | ✅ |  |
| clinical_operations | pk_sampling_schedule | ✅ | ❌ | Excluded from MVM |
| clinical_operations | study_milestone | ✅ | ✅ |  |
| clinical_operations | study_visit_schedule | ✅ | ✅ |  |
| clinical_operations | visit_procedure | ✅ | ✅ |  |
| product_regulatory | country_submission | ✅ | ❌ | Excluded from MVM |
| product_regulatory | dosing_regimen | ✅ | ✅ |  |
| product_regulatory | investigational_product | ✅ | ✅ |  |
| product_regulatory | ip_site_accountability | ✅ | ❌ | Excluded from MVM |
| product_regulatory | product_designation | ✅ | ❌ | Excluded from MVM |
| protocol_design | arm | ✅ | ✅ |  |
| protocol_design | eligibility_criterion | ✅ | ✅ |  |
| protocol_design | endpoint | ✅ | ✅ |  |
| protocol_design | epoch | ✅ | ✅ |  |
| protocol_design | objective | ✅ | ✅ |  |
| protocol_design | protocol | ✅ | ✅ |  |
| protocol_design | study | ❌ | ✅ | MVM only (stub or new) |
| protocol_design | study_protocol_amendment | ✅ | ✅ |  |
| protocol_design | study_study | ✅ | ❌ | Excluded from MVM |

<a id="domain-subject"></a>
### subject

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| clinical_oversight | concomitant_medication | ✅ | ✅ |  |
| clinical_oversight | drug_lab_interaction | ✅ | ❌ | Excluded from MVM |
| clinical_oversight | medical_history | ✅ | ✅ |  |
| clinical_oversight | stipend_payment | ✅ | ❌ | Excluded from MVM |
| clinical_oversight | subject_deviation | ✅ | ❌ | Excluded from MVM |
| participant_registration | demographic | ✅ | ✅ |  |
| participant_registration | eligibility_assessment | ✅ | ✅ |  |
| participant_registration | enrollment | ✅ | ✅ |  |
| participant_registration | subject_contact | ✅ | ✅ |  |
| participant_registration | subject_subject_consent | ✅ | ❌ | Excluded from MVM |
| participant_registration | trial_subject | ✅ | ✅ |  |
| study_lifecycle | deviation | ❌ | ✅ | MVM only (stub or new) |
| study_lifecycle | status_history | ❌ | ✅ | MVM only (stub or new) |
| study_progression | disposition | ✅ | ✅ |  |
| study_progression | population_assignment | ✅ | ✅ |  |
| study_progression | randomization_assignment | ✅ | ✅ |  |
| study_progression | sdv_review | ✅ | ❌ | Excluded from MVM |
| study_progression | subject_status_history | ✅ | ❌ | Excluded from MVM |
| study_progression | subject_visit | ✅ | ✅ |  |
| study_progression | visit_billing_reconciliation | ✅ | ❌ | Excluded from MVM |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| accountability_tracking | accountability_reconciliation | ✅ | ✅ |  |
| accountability_tracking | destruction_record | ✅ | ✅ |  |
| accountability_tracking | dispensing_record | ✅ | ✅ |  |
| accountability_tracking | return_record | ✅ | ✅ |  |
| depot_operations | depot | ✅ | ✅ |  |
| depot_operations | depot_inventory | ✅ | ✅ |  |
| depot_operations | kit_inventory | ✅ | ✅ |  |
| depot_operations | resupply_order | ✅ | ✅ |  |
| depot_operations | site_inventory | ✅ | ✅ |  |
| depot_operations | supply_plan | ✅ | ✅ |  |
| distribution_logistics | import_permit | ✅ | ✅ |  |
| distribution_logistics | shipment | ✅ | ✅ |  |
| distribution_logistics | shipment_line | ✅ | ✅ |  |
| distribution_logistics | temperature_excursion | ✅ | ✅ |  |
| governance_contracts | budget_allocation | ✅ | ❌ | Excluded from MVM |
| governance_contracts | contracted_supply_item | ✅ | ❌ | Excluded from MVM |
| governance_contracts | depot_sla_coverage | ✅ | ❌ | Excluded from MVM |
| governance_contracts | imp_authorization | ✅ | ❌ | Excluded from MVM |
| governance_contracts | imp_indication_track | ✅ | ❌ | Excluded from MVM |
| governance_contracts | imp_sop_applicability | ✅ | ❌ | Excluded from MVM |
| product_management | ancillary_supply | ✅ | ❌ | Excluded from MVM |
| product_management | comparator_drug | ✅ | ❌ | Excluded from MVM |
| product_management | imp_master | ✅ | ✅ |  |
| product_management | kit_definition | ✅ | ✅ |  |
| product_management | manufacture_batch | ✅ | ✅ |  |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| competency_development | certification | ✅ | ❌ | Domain not in MVM |
| competency_development | cra_qualification | ✅ | ❌ | Domain not in MVM |
| competency_development | gcp_training_record | ✅ | ❌ | Domain not in MVM |
| competency_development | protocol_training_record | ✅ | ❌ | Domain not in MVM |
| competency_development | training_course | ✅ | ❌ | Domain not in MVM |
| competency_development | training_curriculum | ✅ | ❌ | Domain not in MVM |
| competency_development | training_record | ✅ | ❌ | Domain not in MVM |
| personnel_administration | employee | ✅ | ❌ | Domain not in MVM |
| personnel_administration | job_profile | ✅ | ❌ | Domain not in MVM |
| personnel_administration | org_unit | ✅ | ❌ | Domain not in MVM |
| personnel_administration | payroll_record | ✅ | ❌ | Domain not in MVM |
| personnel_administration | position | ✅ | ❌ | Domain not in MVM |
| study_resourcing | program_team_member | ✅ | ❌ | Domain not in MVM |
| study_resourcing | study_assignment | ✅ | ❌ | Domain not in MVM |
| study_resourcing | workforce_capa | ✅ | ❌ | Domain not in MVM |
| study_resourcing | workforce_delegation_log | ✅ | ❌ | Domain not in MVM |
| study_resourcing | workforce_resource_plan | ✅ | ❌ | Domain not in MVM |
