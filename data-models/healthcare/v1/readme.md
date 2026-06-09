# Healthcare Lakehouse Data Models

**Version 1** | Generated on May 04, 2026 at 07:04 PM

**Industry:** healthcare

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Billing](#domain-billing)
  - [Claim](#domain-claim)
  - [Clinical](#domain-clinical)
  - [Compliance](#domain-compliance)
  - [Consent](#domain-consent)
  - [Encounter](#domain-encounter)
  - [Facility](#domain-facility)
  - [Finance](#domain-finance)
  - [Insurance](#domain-insurance)
  - [Interoperability](#domain-interoperability)
  - [Laboratory](#domain-laboratory)
  - [Order](#domain-order)
  - [Patient](#domain-patient)
  - [Pharmacy](#domain-pharmacy)
  - [Provider](#domain-provider)
  - [Quality](#domain-quality)
  - [Radiology](#domain-radiology)
  - [Reference](#domain-reference)
  - [Research](#domain-research)
  - [Scheduling](#domain-scheduling)
  - [Supply](#domain-supply)
  - [Workforce](#domain-workforce)


## Business Description

Healthcare is a vast industry operating hospitals, clinics, outpatient facilities, and integrated care systems, delivering patient care, medical research, diagnostics, and health education across diverse populations and regions.

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
| **Folder Convention** | `v1/mvm` | `v1/ecm` |
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
| Domains | 16 | 22 |
| Subdomains | 43 | 76 |
| Products (Tables) | 189 | 541 |
| Attributes (Columns) | 8502 | 22423 |
| Foreign Keys | 1940 | 4093 |
| Avg Attributes/Product | 45.0 | 41.4 |

## Domain & Product Comparison

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| financial_resolution | charity_care_application | ✅ | ❌ | Excluded from MVM |
| financial_resolution | collection_account | ✅ | ❌ | Excluded from MVM |
| financial_resolution | rac_audit | ✅ | ❌ | Excluded from MVM |
| financial_resolution | write_off | ✅ | ❌ | Excluded from MVM |
| payment_collections | coverage | ❌ | ✅ | MVM only (stub or new) |
| payment_processing | adjustment | ✅ | ✅ |  |
| payment_processing | billing_coverage | ✅ | ❌ | Excluded from MVM |
| payment_processing | patient_account | ✅ | ✅ |  |
| payment_processing | payment | ✅ | ✅ |  |
| payment_processing | payment_plan | ✅ | ✅ |  |
| payment_processing | refund | ✅ | ❌ | Excluded from MVM |
| payment_processing | statement | ✅ | ✅ |  |
| revenue_capture | billing_network_participation | ✅ | ❌ | Excluded from MVM |
| revenue_capture | cdm_entry | ✅ | ✅ |  |
| revenue_capture | charge | ✅ | ✅ |  |
| revenue_capture | coding_assignment | ✅ | ✅ |  |
| revenue_capture | invoice | ✅ | ✅ |  |
| revenue_capture | invoice_coverage_billing | ✅ | ❌ | Excluded from MVM |
| revenue_capture | invoice_line | ✅ | ✅ |  |
| revenue_capture | invoice_line_item | ✅ | ❌ | Excluded from MVM |
| revenue_capture | site_cdm_pricing | ✅ | ❌ | Excluded from MVM |
| revenue_capture | study_service_coverage | ✅ | ❌ | Excluded from MVM |

<a id="domain-claim"></a>
### claim

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| claim_processing | claim | ✅ | ✅ |  |
| claim_processing | claim_status_history | ❌ | ✅ | MVM only (stub or new) |
| claim_processing | diagnosis_link | ✅ | ✅ |  |
| claim_processing | line | ✅ | ✅ |  |
| claim_processing | status_history | ✅ | ❌ | Excluded from MVM |
| claim_processing | submission | ✅ | ✅ |  |
| coverage_verification | authorization_service | ✅ | ❌ | Excluded from MVM |
| coverage_verification | cob | ✅ | ❌ | Excluded from MVM |
| coverage_verification | eligibility | ✅ | ✅ |  |
| coverage_verification | prior_authorization | ✅ | ✅ |  |
| documentation_management | attachment | ✅ | ❌ | Excluded from MVM |
| documentation_management | audit_sample | ✅ | ❌ | Excluded from MVM |
| documentation_management | study_attribution | ✅ | ❌ | Excluded from MVM |
| payment_reconciliation | appeal | ✅ | ✅ |  |
| payment_reconciliation | denial | ✅ | ✅ |  |
| payment_reconciliation | remittance | ✅ | ✅ |  |
| payment_reconciliation | remittance_line | ✅ | ✅ |  |

<a id="domain-clinical"></a>
### clinical

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| care_coordination | advance_directive | ✅ | ✅ |  |
| care_coordination | care_plan | ✅ | ✅ |  |
| care_coordination | care_plan_goal | ✅ | ✅ |  |
| care_coordination | care_team | ✅ | ✅ |  |
| care_coordination | care_team_member | ✅ | ✅ |  |
| care_coordination | functional_status | ✅ | ❌ | Excluded from MVM |
| care_coordination | nursing_assessment | ✅ | ❌ | Excluded from MVM |
| care_coordination | plan_care_coordination | ✅ | ❌ | Excluded from MVM |
| patient_documentation | allergy | ✅ | ✅ |  |
| patient_documentation | clinical_finding | ✅ | ❌ | Excluded from MVM |
| patient_documentation | diagnosis | ✅ | ✅ |  |
| patient_documentation | immunization | ✅ | ✅ |  |
| patient_documentation | note | ✅ | ✅ |  |
| patient_documentation | note_template | ✅ | ❌ | Excluded from MVM |
| patient_documentation | observation | ✅ | ✅ |  |
| patient_documentation | problem | ✅ | ✅ |  |
| patient_documentation | procedure_event | ✅ | ✅ |  |
| patient_documentation | vital_sign | ✅ | ✅ |  |
| quality_improvement | cdi_query | ✅ | ❌ | Excluded from MVM |
| quality_improvement | cdi_worksheet | ✅ | ❌ | Excluded from MVM |
| quality_improvement | hai_event | ✅ | ❌ | Excluded from MVM |
| quality_improvement | outbreak | ✅ | ❌ | Excluded from MVM |
| resource_management | flowsheet_row | ✅ | ❌ | Excluded from MVM |
| resource_management | flowsheet_template | ✅ | ❌ | Excluded from MVM |
| resource_management | procedure_equipment_usage | ✅ | ❌ | Excluded from MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_oversight | attestation | ✅ | ❌ | Excluded from MVM |
| audit_oversight | audit | ✅ | ✅ |  |
| audit_oversight | audit_finding | ✅ | ✅ |  |
| audit_oversight | corrective_action_plan | ✅ | ✅ |  |
| audit_oversight | investigation | ✅ | ❌ | Excluded from MVM |
| audit_oversight | monitoring_activity | ✅ | ❌ | Excluded from MVM |
| privacy_security | business_associate_agreement | ✅ | ❌ | Excluded from MVM |
| privacy_security | hipaa_privacy_incident | ✅ | ✅ |  |
| privacy_security | hipaa_security_risk | ✅ | ❌ | Excluded from MVM |
| privacy_security | notice_of_privacy_practices | ✅ | ❌ | Excluded from MVM |
| privacy_security | phi_access_log | ✅ | ❌ | Excluded from MVM |
| program_governance | compliance_policy | ✅ | ❌ | Excluded from MVM |
| program_governance | compliance_program | ✅ | ❌ | Excluded from MVM |
| program_governance | obligation | ✅ | ✅ |  |
| program_governance | policy_payer_applicability | ✅ | ❌ | Excluded from MVM |
| program_governance | policy_regulatory_impact | ✅ | ❌ | Excluded from MVM |
| program_governance | policy_version | ✅ | ✅ |  |
| program_governance | program_policy_assignment | ✅ | ❌ | Excluded from MVM |
| program_governance | regulatory_change | ✅ | ❌ | Excluded from MVM |
| program_governance | regulatory_requirement | ✅ | ❌ | Excluded from MVM |
| regulatory_governance | policy | ❌ | ✅ | MVM only (stub or new) |
| regulatory_governance | program | ❌ | ✅ | MVM only (stub or new) |
| workforce_management | accreditation_status | ✅ | ✅ |  |
| workforce_management | cms_condition_status | ✅ | ❌ | Excluded from MVM |
| workforce_management | compliance_regulatory_submission | ✅ | ❌ | Excluded from MVM |
| workforce_management | conflict_of_interest | ✅ | ❌ | Excluded from MVM |
| workforce_management | exclusion_screening | ✅ | ✅ |  |
| workforce_management | hotline_report | ✅ | ❌ | Excluded from MVM |
| workforce_management | osha_exposure_incident | ✅ | ❌ | Excluded from MVM |
| workforce_management | osha_safety_program | ✅ | ❌ | Excluded from MVM |
| workforce_management | stark_arrangement | ✅ | ❌ | Excluded from MVM |
| workforce_management | training | ✅ | ✅ |  |
| workforce_management | training_completion | ✅ | ✅ |  |

<a id="domain-consent"></a>
### consent

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| authorization_management | behavioral_health_consent | ✅ | ❌ | Domain not in MVM |
| authorization_management | consent_policy | ✅ | ❌ | Domain not in MVM |
| authorization_management | consent_session | ✅ | ❌ | Domain not in MVM |
| authorization_management | delegation | ✅ | ❌ | Domain not in MVM |
| authorization_management | event | ✅ | ❌ | Domain not in MVM |
| authorization_management | form_template | ✅ | ❌ | Domain not in MVM |
| authorization_management | genetic_testing_consent | ✅ | ❌ | Domain not in MVM |
| authorization_management | hie_directive | ✅ | ❌ | Domain not in MVM |
| authorization_management | hipaa_authorization | ✅ | ❌ | Domain not in MVM |
| authorization_management | minor_consent | ✅ | ❌ | Domain not in MVM |
| authorization_management | photography_media_consent | ✅ | ❌ | Domain not in MVM |
| authorization_management | record | ✅ | ❌ | Domain not in MVM |
| authorization_management | research_consent | ✅ | ❌ | Domain not in MVM |
| authorization_management | restriction_request | ✅ | ❌ | Domain not in MVM |
| authorization_management | substance_use_consent | ✅ | ❌ | Domain not in MVM |
| authorization_management | telehealth_consent | ✅ | ❌ | Domain not in MVM |
| authorization_management | translation | ✅ | ❌ | Domain not in MVM |
| authorization_management | treatment_consent | ✅ | ❌ | Domain not in MVM |
| authorization_management | workflow | ✅ | ❌ | Domain not in MVM |
| compliance_tracking | amendment_request | ✅ | ❌ | Domain not in MVM |
| compliance_tracking | capacity_assessment | ✅ | ❌ | Domain not in MVM |
| compliance_tracking | deficiency | ✅ | ❌ | Domain not in MVM |
| compliance_tracking | disclosure_log | ✅ | ❌ | Domain not in MVM |
| compliance_tracking | exception | ✅ | ❌ | Domain not in MVM |
| compliance_tracking | expiration_alert | ✅ | ❌ | Domain not in MVM |
| compliance_tracking | npp_acknowledgment | ✅ | ❌ | Domain not in MVM |
| compliance_tracking | revocation | ✅ | ❌ | Domain not in MVM |
| compliance_tracking | verification | ✅ | ❌ | Domain not in MVM |

<a id="domain-encounter"></a>
### encounter

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| billing_authorization | authorization | ❌ | ✅ | MVM only (stub or new) |
| operational_resources | bed_assignment | ✅ | ✅ |  |
| operational_resources | readmission | ✅ | ✅ |  |
| operational_resources | visit_recall_impact | ✅ | ❌ | Excluded from MVM |
| patient_encounters | adt_event | ✅ | ✅ |  |
| patient_encounters | discharge_summary | ✅ | ✅ |  |
| patient_encounters | transfer_request | ✅ | ❌ | Excluded from MVM |
| patient_encounters | triage_assessment | ✅ | ✅ |  |
| patient_encounters | visit | ✅ | ✅ |  |
| patient_encounters | visit_diagnosis | ✅ | ✅ |  |
| patient_encounters | visit_procedure | ✅ | ✅ |  |
| patient_encounters | visit_provider | ✅ | ✅ |  |
| patient_encounters | visit_status_history | ✅ | ❌ | Excluded from MVM |
| reimbursement_coverage | drg_assignment | ✅ | ✅ |  |
| reimbursement_coverage | encounter_authorization | ✅ | ❌ | Excluded from MVM |
| reimbursement_coverage | visit_coverage | ✅ | ❌ | Excluded from MVM |
| reimbursement_coverage | visit_insurance | ✅ | ✅ |  |

<a id="domain-facility"></a>
### facility

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_maintenance | contract | ✅ | ❌ | Excluded from MVM |
| asset_maintenance | equipment_asset | ✅ | ✅ |  |
| asset_maintenance | equipment_authorization | ✅ | ❌ | Excluded from MVM |
| asset_maintenance | maintenance_order | ✅ | ✅ |  |
| asset_maintenance | pm_schedule | ✅ | ✅ |  |
| capacity_management | bed_status_event | ✅ | ✅ |  |
| capacity_management | block_assignment | ✅ | ❌ | Excluded from MVM |
| capacity_management | capacity_snapshot | ✅ | ❌ | Excluded from MVM |
| capacity_management | environmental_service_request | ✅ | ❌ | Excluded from MVM |
| capacity_management | network_contract | ✅ | ❌ | Excluded from MVM |
| compliance_safety | facility_program_participation | ✅ | ❌ | Excluded from MVM |
| compliance_safety | hazardous_material | ✅ | ❌ | Excluded from MVM |
| compliance_safety | inspection | ✅ | ❌ | Excluded from MVM |
| compliance_safety | inspection_finding | ✅ | ❌ | Excluded from MVM |
| compliance_safety | license_accreditation | ✅ | ✅ |  |
| compliance_safety | safety_incident | ✅ | ❌ | Excluded from MVM |
| site_operations | bed | ✅ | ✅ |  |
| site_operations | building | ✅ | ✅ |  |
| site_operations | care_site | ✅ | ✅ |  |
| site_operations | or_suite | ✅ | ✅ |  |
| site_operations | organization | ✅ | ✅ |  |
| site_operations | room | ✅ | ✅ |  |
| site_operations | service | ✅ | ✅ |  |
| site_operations | site_hierarchy | ✅ | ❌ | Excluded from MVM |
| site_operations | space_allocation | ✅ | ❌ | Excluded from MVM |
| site_operations | unit | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | asset_book | ✅ | ❌ | Domain not in MVM |
| asset_management | capital_expenditure | ✅ | ❌ | Domain not in MVM |
| asset_management | capital_project | ✅ | ❌ | Domain not in MVM |
| asset_management | depreciation_run | ✅ | ❌ | Domain not in MVM |
| asset_management | depreciation_schedule | ✅ | ❌ | Domain not in MVM |
| asset_management | donor | ✅ | ❌ | Domain not in MVM |
| asset_management | fixed_asset | ✅ | ❌ | Domain not in MVM |
| general_accounting | bank_account | ✅ | ❌ | Domain not in MVM |
| general_accounting | bank_reconciliation | ✅ | ❌ | Domain not in MVM |
| general_accounting | chart_of_accounts | ✅ | ❌ | Domain not in MVM |
| general_accounting | cost_center | ✅ | ❌ | Domain not in MVM |
| general_accounting | financial_entity | ✅ | ❌ | Domain not in MVM |
| general_accounting | financial_period_close | ✅ | ❌ | Domain not in MVM |
| general_accounting | fiscal_period | ✅ | ❌ | Domain not in MVM |
| general_accounting | fund | ✅ | ❌ | Domain not in MVM |
| general_accounting | fund_allocation | ✅ | ❌ | Domain not in MVM |
| general_accounting | general_ledger | ✅ | ❌ | Domain not in MVM |
| general_accounting | intercompany_agreement | ✅ | ❌ | Domain not in MVM |
| general_accounting | intercompany_transaction | ✅ | ❌ | Domain not in MVM |
| general_accounting | journal_entry | ✅ | ❌ | Domain not in MVM |
| general_accounting | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| general_accounting | transaction_batch | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_invoice | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_invoice_line | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_payment | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ar_account | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ar_transaction | ✅ | ❌ | Domain not in MVM |
| payables_receivables | invoice_payment_application | ✅ | ❌ | Domain not in MVM |
| payables_receivables | payment_batch | ✅ | ❌ | Domain not in MVM |
| planning_forecasting | allocation_method | ✅ | ❌ | Domain not in MVM |
| planning_forecasting | allocation_run | ✅ | ❌ | Domain not in MVM |
| planning_forecasting | budget | ✅ | ❌ | Domain not in MVM |
| planning_forecasting | budget_line | ✅ | ❌ | Domain not in MVM |
| planning_forecasting | budget_transfer | ✅ | ❌ | Domain not in MVM |
| planning_forecasting | cost_allocation | ✅ | ❌ | Domain not in MVM |
| planning_forecasting | financial_forecast | ✅ | ❌ | Domain not in MVM |
| planning_forecasting | forecast_line | ✅ | ❌ | Domain not in MVM |
| planning_forecasting | recurring_schedule | ✅ | ❌ | Domain not in MVM |

<a id="domain-insurance"></a>
### insurance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_reimbursement | capitation_contract | ✅ | ✅ |  |
| contract_reimbursement | capitation_payment | ✅ | ✅ |  |
| contract_reimbursement | fee_schedule | ✅ | ✅ |  |
| contract_reimbursement | fee_schedule_line | ✅ | ✅ |  |
| contract_reimbursement | payer_compliance_requirement | ✅ | ❌ | Excluded from MVM |
| contract_reimbursement | payer_contract | ✅ | ✅ |  |
| contract_reimbursement | prior_auth_rule | ✅ | ✅ |  |
| contract_reimbursement | utilization_review | ✅ | ✅ |  |
| member_coverage | accumulator | ✅ | ✅ |  |
| member_coverage | coordination_of_benefits | ✅ | ✅ |  |
| member_coverage | dependent | ✅ | ✅ |  |
| member_coverage | eligibility_span | ✅ | ✅ |  |
| member_coverage | employer_group | ✅ | ✅ |  |
| member_coverage | insurance_payer_enrollment | ✅ | ❌ | Excluded from MVM |
| member_coverage | member_enrollment | ✅ | ✅ |  |
| member_coverage | plan_consent_requirement | ✅ | ❌ | Excluded from MVM |
| member_coverage | premium_billing | ✅ | ❌ | Excluded from MVM |
| member_coverage | subscriber | ✅ | ✅ |  |
| member_enrollment | group_plan_offering | ❌ | ✅ | MVM only (stub or new) |
| payer_administration | accountable_care_organization | ✅ | ❌ | Excluded from MVM |
| payer_administration | benefit | ✅ | ✅ |  |
| payer_administration | broker | ✅ | ❌ | Excluded from MVM |
| payer_administration | coverage_policy | ✅ | ✅ |  |
| payer_administration | formulary_tier | ✅ | ❌ | Excluded from MVM |
| payer_administration | health_plan | ✅ | ✅ |  |
| payer_administration | insurance_network_participation | ✅ | ❌ | Excluded from MVM |
| payer_administration | network_adequacy | ✅ | ❌ | Excluded from MVM |
| payer_administration | payer | ✅ | ✅ |  |
| payer_administration | payer_contact | ✅ | ❌ | Excluded from MVM |
| payer_administration | plan_network | ✅ | ❌ | Excluded from MVM |
| payer_administration | provider_network | ✅ | ✅ |  |
| payer_administration | third_party_administrator | ✅ | ❌ | Excluded from MVM |
| value_performance | member_attribution | ✅ | ❌ | Excluded from MVM |
| value_performance | risk_adjustment | ✅ | ✅ |  |
| value_performance | vbc_performance | ✅ | ❌ | Excluded from MVM |

<a id="domain-interoperability"></a>
### interoperability

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_reporting | promoting_interoperability | ✅ | ❌ | Domain not in MVM |
| compliance_reporting | public_health_report | ✅ | ❌ | Domain not in MVM |
| integration_infrastructure | exchange_standard | ✅ | ❌ | Domain not in MVM |
| integration_infrastructure | fhir_endpoint | ✅ | ❌ | Domain not in MVM |
| integration_infrastructure | interface_channel | ✅ | ❌ | Domain not in MVM |
| integration_infrastructure | interface_engine | ✅ | ❌ | Domain not in MVM |
| integration_infrastructure | interface_sla | ✅ | ❌ | Domain not in MVM |
| integration_infrastructure | mapping_definition | ✅ | ❌ | Domain not in MVM |
| integration_infrastructure | mapping_rule | ✅ | ❌ | Domain not in MVM |
| integration_infrastructure | onboarding_project | ✅ | ❌ | Domain not in MVM |
| integration_infrastructure | subscription_topic | ✅ | ❌ | Domain not in MVM |
| integration_infrastructure | terminology_mapping | ✅ | ❌ | Domain not in MVM |
| integration_infrastructure | trading_partner | ✅ | ❌ | Domain not in MVM |
| message_processing | care_transition_notification | ✅ | ❌ | Domain not in MVM |
| message_processing | cda_validation_result | ✅ | ❌ | Domain not in MVM |
| message_processing | conformance_test | ✅ | ❌ | Domain not in MVM |
| message_processing | fhir_resource_log | ✅ | ❌ | Domain not in MVM |
| message_processing | interface_downtime | ✅ | ❌ | Domain not in MVM |
| message_processing | message_error | ✅ | ❌ | Domain not in MVM |
| message_processing | message_log | ✅ | ❌ | Domain not in MVM |
| message_processing | patient_identity_match | ✅ | ❌ | Domain not in MVM |
| message_processing | subscription_notification | ✅ | ❌ | Domain not in MVM |
| network_exchange | cda_document | ✅ | ❌ | Domain not in MVM |
| network_exchange | data_sharing_agreement | ✅ | ❌ | Domain not in MVM |
| network_exchange | data_use_agreement | ✅ | ❌ | Domain not in MVM |
| network_exchange | direct_address | ✅ | ❌ | Domain not in MVM |
| network_exchange | direct_message | ✅ | ❌ | Domain not in MVM |
| network_exchange | hie_organization | ✅ | ❌ | Domain not in MVM |
| network_exchange | hie_participation | ✅ | ❌ | Domain not in MVM |
| network_exchange | hie_query | ✅ | ❌ | Domain not in MVM |
| network_exchange | hie_transaction | ✅ | ❌ | Domain not in MVM |

<a id="domain-laboratory"></a>
### laboratory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| diagnostic_testing | lab_order | ✅ | ✅ |  |
| diagnostic_testing | microbiology_culture | ✅ | ✅ |  |
| diagnostic_testing | molecular_test | ✅ | ❌ | Excluded from MVM |
| diagnostic_testing | pathology_report | ✅ | ✅ |  |
| diagnostic_testing | point_of_care_test | ✅ | ❌ | Excluded from MVM |
| diagnostic_testing | reference_range | ✅ | ✅ |  |
| diagnostic_testing | specimen | ✅ | ✅ |  |
| diagnostic_testing | study_test_requirement | ✅ | ❌ | Excluded from MVM |
| diagnostic_testing | susceptibility_result | ✅ | ✅ |  |
| diagnostic_testing | test_catalog | ✅ | ✅ |  |
| diagnostic_testing | test_coverage_policy | ✅ | ❌ | Excluded from MVM |
| diagnostic_testing | test_result | ✅ | ✅ |  |
| quality_operations | clia_certificate | ✅ | ❌ | Excluded from MVM |
| quality_operations | instrument | ✅ | ✅ |  |
| quality_operations | instrument_policy_compliance | ✅ | ❌ | Excluded from MVM |
| quality_operations | organism | ✅ | ✅ |  |
| quality_operations | qc_run | ✅ | ❌ | Excluded from MVM |
| quality_operations | reagent_lot | ✅ | ❌ | Excluded from MVM |
| revenue_management | lab_charge | ✅ | ❌ | Excluded from MVM |
| revenue_management | lab_fee_schedule_line | ✅ | ❌ | Excluded from MVM |
| transfusion_services | blood_bank_unit | ✅ | ✅ |  |
| transfusion_services | transfusion_event | ✅ | ✅ |  |

<a id="domain-order"></a>
### order

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| authorization_compliance | alert_rule | ✅ | ❌ | Excluded from MVM |
| authorization_compliance | cpoe_alert | ✅ | ❌ | Excluded from MVM |
| authorization_compliance | order_authorization | ✅ | ❌ | Excluded from MVM |
| authorization_compliance | reconciliation | ✅ | ❌ | Excluded from MVM |
| authorization_compliance | verbal_order | ✅ | ❌ | Excluded from MVM |
| fulfillment_operations | fulfillment | ✅ | ✅ |  |
| fulfillment_operations | routing | ✅ | ✅ |  |
| fulfillment_operations | routing_rule | ✅ | ❌ | Excluded from MVM |
| order_management | clinical_order | ✅ | ✅ |  |
| order_management | order_status_history | ✅ | ✅ |  |
| order_management | referral_order | ✅ | ✅ |  |
| order_management | set | ✅ | ✅ |  |
| order_management | set_item | ✅ | ✅ |  |
| order_management | standing_order | ✅ | ✅ |  |
| specialty_requests | diet_order | ✅ | ❌ | Excluded from MVM |
| specialty_requests | therapy_order | ✅ | ❌ | Excluded from MVM |

<a id="domain-patient"></a>
### patient

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| care_coordination | attribution_panel | ✅ | ❌ | Excluded from MVM |
| care_coordination | care_program | ✅ | ❌ | Excluded from MVM |
| care_coordination | care_program_enrollment | ✅ | ✅ |  |
| care_coordination | communication_campaign | ✅ | ❌ | Excluded from MVM |
| care_coordination | communication_log | ✅ | ❌ | Excluded from MVM |
| care_coordination | message_template | ✅ | ❌ | Excluded from MVM |
| care_coordination | pcp_attribution | ✅ | ✅ |  |
| care_coordination | population_segment | ✅ | ❌ | Excluded from MVM |
| care_coordination | portal_account | ✅ | ✅ |  |
| care_coordination | program_enrollment | ✅ | ❌ | Excluded from MVM |
| care_coordination | proxy_access | ✅ | ❌ | Excluded from MVM |
| care_coordination | quality_measure_evaluation | ✅ | ❌ | Excluded from MVM |
| care_coordination | sdoh_assessment | ✅ | ❌ | Excluded from MVM |
| financial_services | eligibility_check | ✅ | ✅ |  |
| financial_services | financial_assistance | ✅ | ❌ | Excluded from MVM |
| financial_services | guarantor | ✅ | ✅ |  |
| financial_services | insurance_coverage | ✅ | ✅ |  |
| financial_services | patient_coverage | ✅ | ❌ | Excluded from MVM |
| identity_management | address | ✅ | ✅ |  |
| identity_management | consent_reference | ✅ | ✅ |  |
| identity_management | demographics | ✅ | ✅ |  |
| identity_management | emergency_contact | ✅ | ✅ |  |
| identity_management | flag | ✅ | ❌ | Excluded from MVM |
| identity_management | identity_merge_history | ✅ | ❌ | Excluded from MVM |
| identity_management | mpi_record | ✅ | ✅ |  |
| identity_management | mrn_crosswalk | ✅ | ❌ | Excluded from MVM |
| identity_management | preference | ✅ | ✅ |  |
| identity_management | registration_event | ✅ | ✅ |  |

<a id="domain-pharmacy"></a>
### pharmacy

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| clinical_services | adverse_drug_event | ✅ | ✅ |  |
| clinical_services | medication_review | ✅ | ❌ | Excluded from MVM |
| clinical_services | medication_therapy_mgmt | ✅ | ❌ | Excluded from MVM |
| clinical_services | rems_compliance | ✅ | ❌ | Excluded from MVM |
| clinical_services | study_drug_assignment | ✅ | ❌ | Excluded from MVM |
| dispensing_operations | controlled_substance_log | ✅ | ❌ | Excluded from MVM |
| dispensing_operations | dispense_event | ✅ | ✅ |  |
| dispensing_operations | drug_recall | ✅ | ❌ | Excluded from MVM |
| dispensing_operations | mar_record | ✅ | ✅ |  |
| dispensing_operations | prescription | ✅ | ✅ |  |
| product_catalog | compounding_record | ✅ | ❌ | Excluded from MVM |
| product_catalog | drug_master | ✅ | ✅ |  |
| product_catalog | formulary | ✅ | ✅ |  |
| product_catalog | inventory | ✅ | ✅ |  |
| product_catalog | pharmacy_location | ✅ | ❌ | Excluded from MVM |
| reimbursement_processing | medication_pa_request | ✅ | ❌ | Excluded from MVM |
| reimbursement_processing | pharmacy_network_participation | ✅ | ❌ | Excluded from MVM |
| reimbursement_processing | rx_claim | ✅ | ❌ | Excluded from MVM |

<a id="domain-provider"></a>
### provider

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| credentialing_operations | cme_activity | ✅ | ❌ | Excluded from MVM |
| credentialing_operations | credentialing_application | ✅ | ❌ | Excluded from MVM |
| credentialing_operations | malpractice_coverage | ✅ | ✅ |  |
| credentialing_operations | npdb_query | ✅ | ❌ | Excluded from MVM |
| credentialing_operations | peer_reference | ✅ | ❌ | Excluded from MVM |
| credentialing_operations | privileging | ✅ | ✅ |  |
| credentialing_operations | reappointment | ✅ | ❌ | Excluded from MVM |
| credentialing_operations | sanction | ✅ | ❌ | Excluded from MVM |
| credentialing_operations | telehealth_authorization | ✅ | ❌ | Excluded from MVM |
| facility_network | location | ❌ | ✅ | MVM only (stub or new) |
| facility_network | location_specialty | ❌ | ✅ | MVM only (stub or new) |
| network_management | affiliation | ✅ | ✅ |  |
| network_management | affiliation_history | ✅ | ❌ | Excluded from MVM |
| network_management | assignment | ✅ | ❌ | Excluded from MVM |
| network_management | group_membership | ✅ | ✅ |  |
| network_management | network_affiliation | ✅ | ✅ |  |
| network_management | preference_card | ✅ | ❌ | Excluded from MVM |
| network_management | provider_network_participation | ✅ | ❌ | Excluded from MVM |
| network_management | provider_payer_enrollment | ✅ | ❌ | Excluded from MVM |
| network_management | study_team_member | ✅ | ❌ | Excluded from MVM |
| network_management | survey_participation | ✅ | ❌ | Excluded from MVM |
| professional_registry | board_certification | ✅ | ✅ |  |
| professional_registry | clinician | ✅ | ✅ |  |
| professional_registry | committee | ✅ | ❌ | Excluded from MVM |
| professional_registry | credential | ✅ | ✅ |  |
| professional_registry | credentialing_file | ✅ | ❌ | Excluded from MVM |
| professional_registry | dea_registration | ✅ | ✅ |  |
| professional_registry | education_training | ✅ | ❌ | Excluded from MVM |
| professional_registry | group | ✅ | ✅ |  |
| professional_registry | org_provider | ✅ | ✅ |  |
| professional_registry | provider_location | ✅ | ❌ | Excluded from MVM |
| professional_registry | specialty | ✅ | ✅ |  |
| professional_registry | taxonomy | ✅ | ❌ | Excluded from MVM |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| documentation_improvement | cdi_review | ✅ | ❌ | Domain not in MVM |
| documentation_improvement | committee | ✅ | ❌ | Domain not in MVM |
| documentation_improvement | contract_initiative | ✅ | ❌ | Domain not in MVM |
| documentation_improvement | improvement_initiative | ✅ | ❌ | Domain not in MVM |
| documentation_improvement | population_health_gap | ✅ | ❌ | Domain not in MVM |
| documentation_improvement | sdoh_screening | ✅ | ❌ | Domain not in MVM |
| performance_measurement | cahps_response | ✅ | ❌ | Domain not in MVM |
| performance_measurement | cahps_survey | ✅ | ❌ | Domain not in MVM |
| performance_measurement | hedis_measure | ✅ | ❌ | Domain not in MVM |
| performance_measurement | hedis_result | ✅ | ❌ | Domain not in MVM |
| performance_measurement | initiative_measure_target | ✅ | ❌ | Domain not in MVM |
| performance_measurement | measure | ✅ | ❌ | Domain not in MVM |
| performance_measurement | measure_budget_allocation | ✅ | ❌ | Domain not in MVM |
| performance_measurement | measure_result | ✅ | ❌ | Domain not in MVM |
| performance_measurement | program_measure_assignment | ✅ | ❌ | Domain not in MVM |
| performance_measurement | program_study_participation | ✅ | ❌ | Domain not in MVM |
| performance_measurement | quality_program | ✅ | ❌ | Domain not in MVM |
| performance_measurement | quality_program_participation | ✅ | ❌ | Domain not in MVM |
| performance_measurement | vbp_program | ✅ | ❌ | Domain not in MVM |
| safety_compliance | accreditation_program | ✅ | ❌ | Domain not in MVM |
| safety_compliance | accreditation_survey | ✅ | ❌ | Domain not in MVM |
| safety_compliance | corrective_action | ✅ | ❌ | Domain not in MVM |
| safety_compliance | mortality_review | ✅ | ❌ | Domain not in MVM |
| safety_compliance | patient_safety_event | ✅ | ❌ | Domain not in MVM |
| safety_compliance | quality_peer_review | ✅ | ❌ | Domain not in MVM |
| safety_compliance | safety_event_review | ✅ | ❌ | Domain not in MVM |
| safety_compliance | standard_finding | ✅ | ❌ | Domain not in MVM |

<a id="domain-radiology"></a>
### radiology

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| clinical_interpretation | critical_result | ✅ | ✅ |  |
| clinical_interpretation | follow_up | ✅ | ❌ | Excluded from MVM |
| clinical_interpretation | radiology_finding | ✅ | ❌ | Excluded from MVM |
| clinical_interpretation | reader_assignment | ✅ | ❌ | Excluded from MVM |
| clinical_interpretation | report | ✅ | ✅ |  |
| clinical_interpretation | report_addendum | ✅ | ❌ | Excluded from MVM |
| clinical_interpretation | report_distribution | ✅ | ❌ | Excluded from MVM |
| clinical_interpretation | teleradiology_case | ✅ | ❌ | Excluded from MVM |
| diagnostic_imaging | contrast_admin | ✅ | ✅ |  |
| diagnostic_imaging | dicom_series | ✅ | ✅ |  |
| diagnostic_imaging | dose_record | ✅ | ✅ |  |
| diagnostic_imaging | interventional_procedure | ✅ | ❌ | Excluded from MVM |
| diagnostic_imaging | modality | ✅ | ✅ |  |
| diagnostic_imaging | protocol | ✅ | ✅ |  |
| diagnostic_imaging | radiology_study | ✅ | ❌ | Excluded from MVM |
| diagnostic_imaging | transmission | ✅ | ❌ | Excluded from MVM |
| imaging_workflow | study | ❌ | ✅ | MVM only (stub or new) |
| order_management | imaging_order | ✅ | ✅ |  |
| order_management | radiology_appointment | ✅ | ❌ | Excluded from MVM |
| order_management | radiology_order_status_history | ✅ | ❌ | Excluded from MVM |
| quality_assurance | network_modality_participation | ✅ | ❌ | Excluded from MVM |
| quality_assurance | radiology_peer_review | ✅ | ❌ | Excluded from MVM |

<a id="domain-reference"></a>
### reference

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| billing_codes | condition_code | ✅ | ❌ | Excluded from MVM |
| billing_codes | cpt_code | ✅ | ✅ |  |
| billing_codes | drg | ✅ | ✅ |  |
| billing_codes | hcpcs_code | ✅ | ✅ |  |
| billing_codes | major_diagnostic_category | ✅ | ❌ | Excluded from MVM |
| clinical_terminology | fhir_value_set | ✅ | ❌ | Excluded from MVM |
| clinical_terminology | icd_code | ✅ | ✅ |  |
| clinical_terminology | loinc_code | ✅ | ✅ |  |
| clinical_terminology | ndc_drug | ✅ | ✅ |  |
| clinical_terminology | snomed_concept | ✅ | ✅ |  |
| metadata_management | code_set_version | ✅ | ✅ |  |
| metadata_management | crosswalk | ✅ | ✅ |  |
| provider_geography | geographic_region | ✅ | ❌ | Excluded from MVM |
| provider_geography | npi_registry | ✅ | ✅ |  |

<a id="domain-research"></a>
### research

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| financial_oversight | billing_event | ✅ | ❌ | Domain not in MVM |
| financial_oversight | coverage_analysis | ✅ | ❌ | Domain not in MVM |
| financial_oversight | grant | ✅ | ❌ | Domain not in MVM |
| financial_oversight | grant_expenditure | ✅ | ❌ | Domain not in MVM |
| financial_oversight | grant_personnel | ✅ | ❌ | Domain not in MVM |
| financial_oversight | study_budget | ✅ | ❌ | Domain not in MVM |
| financial_oversight | study_sponsor | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | adverse_event | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | biospecimen | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | consent_template | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | data_governance_committee | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | data_safety_monitoring | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | dsmb_committee | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | informed_consent | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | investigational_product | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | investigational_product_training | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | ip_dispensation | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | irb_submission | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | monitoring_visit | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | protocol_deviation | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | research_regulatory_submission | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | study_visit | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | subject_enrollment | ✅ | ❌ | Domain not in MVM |
| study_management | data_access_request | ✅ | ❌ | Domain not in MVM |
| study_management | deidentified_dataset | ✅ | ❌ | Domain not in MVM |
| study_management | dua_document | ✅ | ❌ | Domain not in MVM |
| study_management | protocol_amendment | ✅ | ❌ | Domain not in MVM |
| study_management | research_document | ✅ | ❌ | Domain not in MVM |
| study_management | research_study | ✅ | ❌ | Domain not in MVM |
| study_management | study_arm | ✅ | ❌ | Domain not in MVM |
| study_management | study_partner_agreement | ✅ | ❌ | Domain not in MVM |
| study_management | study_site | ✅ | ❌ | Domain not in MVM |

<a id="domain-scheduling"></a>
### scheduling

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| appointment_management | appointment | ❌ | ✅ | MVM only (stub or new) |
| appointment_management | appointment_prior_auth_requirement | ✅ | ❌ | Excluded from MVM |
| appointment_management | appointment_reminder | ✅ | ❌ | Excluded from MVM |
| appointment_management | appointment_status_history | ✅ | ❌ | Excluded from MVM |
| appointment_management | appointment_type | ✅ | ✅ |  |
| appointment_management | booking_queue | ✅ | ❌ | Excluded from MVM |
| appointment_management | booking_rule | ✅ | ❌ | Excluded from MVM |
| appointment_management | open_slot | ✅ | ✅ |  |
| appointment_management | patient_preference | ✅ | ❌ | Excluded from MVM |
| appointment_management | provider_availability | ✅ | ❌ | Excluded from MVM |
| appointment_management | recall_list | ✅ | ❌ | Excluded from MVM |
| appointment_management | reminder_template | ✅ | ❌ | Excluded from MVM |
| appointment_management | schedule_template | ✅ | ✅ |  |
| appointment_management | scheduling_appointment | ✅ | ❌ | Excluded from MVM |
| appointment_management | telehealth_session | ✅ | ❌ | Excluded from MVM |
| resource_capacity | capacity_utilization | ✅ | ❌ | Excluded from MVM |
| resource_capacity | resource_assignment | ✅ | ✅ |  |
| resource_capacity | schedulable_resource | ✅ | ✅ |  |
| resource_capacity | waitlist_entry | ✅ | ✅ |  |
| surgical_operations | block_utilization | ✅ | ❌ | Excluded from MVM |
| surgical_operations | case_material_usage | ✅ | ❌ | Excluded from MVM |
| surgical_operations | equipment_reservation | ✅ | ❌ | Excluded from MVM |
| surgical_operations | or_block | ✅ | ✅ |  |
| surgical_operations | surgical_case | ✅ | ✅ |  |
| surgical_operations | surgical_case_team | ✅ | ✅ |  |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| procurement_operations | goods_receipt | ✅ | ✅ |  |
| procurement_operations | material_master | ✅ | ✅ |  |
| procurement_operations | purchase_order | ✅ | ✅ |  |
| procurement_operations | purchase_order_line | ✅ | ✅ |  |
| procurement_operations | vendor | ✅ | ✅ |  |
| procurement_operations | vendor_contract | ✅ | ✅ |  |
| procurement_operations | vendor_site | ✅ | ❌ | Excluded from MVM |
| procurement_sourcing | vendor_contract_item | ❌ | ✅ | MVM only (stub or new) |
| procurement_sourcing | vendor_item | ❌ | ✅ | MVM only (stub or new) |
| surgical_services | case_cart | ✅ | ❌ | Excluded from MVM |
| surgical_services | sterile_processing_record | ✅ | ❌ | Excluded from MVM |
| surgical_services | surgical_bom | ✅ | ❌ | Excluded from MVM |
| surgical_services | udi_record | ✅ | ✅ |  |
| warehouse_management | inventory_balance | ✅ | ✅ |  |
| warehouse_management | inventory_location | ✅ | ✅ |  |
| warehouse_management | inventory_transaction | ✅ | ✅ |  |
| warehouse_management | location_audit | ✅ | ❌ | Excluded from MVM |
| warehouse_management | material_policy_governance | ✅ | ❌ | Excluded from MVM |
| warehouse_management | recall_notice | ✅ | ❌ | Excluded from MVM |
| warehouse_management | requisition | ✅ | ✅ |  |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| clinical_credentialing | clinical_privilege | ✅ | ❌ | Domain not in MVM |
| clinical_credentialing | competency_assessment | ✅ | ❌ | Domain not in MVM |
| clinical_credentialing | employment_competency | ✅ | ❌ | Domain not in MVM |
| clinical_credentialing | position_procedure_authorization | ✅ | ❌ | Domain not in MVM |
| clinical_credentialing | workforce_provider_network_participation | ✅ | ❌ | Domain not in MVM |
| employee_relations | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| employee_relations | benefit_plan | ✅ | ❌ | Domain not in MVM |
| employee_relations | education_program | ✅ | ❌ | Domain not in MVM |
| employee_relations | fte_budget | ✅ | ❌ | Domain not in MVM |
| employee_relations | leave_request | ✅ | ❌ | Domain not in MVM |
| employee_relations | osha_incident | ✅ | ❌ | Domain not in MVM |
| employee_relations | performance_review | ✅ | ❌ | Domain not in MVM |
| employee_relations | recruitment | ✅ | ❌ | Domain not in MVM |
| employee_relations | review_template | ✅ | ❌ | Domain not in MVM |
| operational_scheduling | channel_support_assignment | ✅ | ❌ | Domain not in MVM |
| operational_scheduling | payroll_calendar | ✅ | ❌ | Domain not in MVM |
| operational_scheduling | payroll_run | ✅ | ❌ | Domain not in MVM |
| operational_scheduling | shift_schedule | ✅ | ❌ | Domain not in MVM |
| operational_scheduling | time_attendance | ✅ | ❌ | Domain not in MVM |
| personnel_administration | applicant | ✅ | ❌ | Domain not in MVM |
| personnel_administration | employee | ✅ | ❌ | Domain not in MVM |
| personnel_administration | job_profile | ✅ | ❌ | Domain not in MVM |
| personnel_administration | org_unit | ✅ | ❌ | Domain not in MVM |
| personnel_administration | position | ✅ | ❌ | Domain not in MVM |
