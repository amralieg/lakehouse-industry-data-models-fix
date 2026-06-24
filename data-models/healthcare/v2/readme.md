# Healthcare Lakehouse Data Models

**Version 2** | Generated on June 23, 2026 at 04:10 PM

**Industry:** 

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v2_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v2_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Behavioral_health](#domain-behavioral_health)
  - [Billing](#domain-billing)
  - [Claim](#domain-claim)
  - [Clinical](#domain-clinical)
  - [Clinical_ai](#domain-clinical_ai)
  - [Compliance](#domain-compliance)
  - [Consent](#domain-consent)
  - [Digital_health](#domain-digital_health)
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

healthcare industry enterprise data model.

## Model Scope Variations

This data model is available in **two scope variations** — the **MVM (Minimum Viable Model)** and the **ECM (Expanded Coverage Model)** — each designed for different organizational needs and use cases. Both models share the same attribute depth per table; the difference is in breadth (number of domains and tables).

### MVM (Minimum Viable Model) — `v2_mvm`

The **MVM** is a production-ready, core data model that covers all essential business functions with full attribute depth. It is the recommended starting point for organizations that want to deploy quickly and expand incrementally. The MVM is ideal for:

- **Small-to-Mid Businesses** — A thin, efficient model for organizations that need a complete but focused data platform without the overhead of corporate back-office domains
- **Production-Ready Foundation** — Deploy to production from day one and grow by adding domains as business needs evolve
- **Proof-of-Concept & Demos** — Quick deployment for stakeholder presentations and proof-of-concept engagements
- **Targeted Analytics** — Focused analytical workloads centered on core business processes
- **Rapid Onboarding** — Simplified structure for teams getting started with the data platform
- **Development & Testing** — Lightweight model for development environments and integration testing

The MVM prioritizes **Operations** and **Business** division domains, excludes corporate/back-office functions, minimizes association (many-to-many bridge) tables, and relies on direct foreign key relationships for simplicity. Every table in the MVM has the **same attribute depth** as the ECM.

### ECM (Expanded Coverage Model) — `v2_ecm`

The **ECM** is a comprehensive, full-coverage data model that covers the complete breadth of business operations, including corporate functions, detailed audit trails, association tables, and granular reference data. It is designed for:

- **Enterprise-Scale Organizations** — Complete data platform for large-scale enterprises with complex operations
- **Full-Coverage Data Warehousing** — Lakehouse model supporting all business units and divisions
- **Regulatory & Compliance** — Includes audit, legal, and compliance domains required for governance
- **Cross-Functional Analytics** — Enables analysis across all divisions including HR, Finance, IT, and more

The ECM includes all domains from the MVM plus additional **Corporate/Supporting** division domains, many-to-many association tables, helper/lookup tables, and expanded attribute coverage.


## Head-to-Head Comparison

| Dimension | MVM (Minimum Viable Model) | ECM (Expanded Coverage Model) |
|---|---|---|
| **Folder Convention** | `v2/mvm` | `v2/ecm` |
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
| Domains | 13 | 25 |
| Subdomains | 33 | 94 |
| Products (Tables) | 134 | 583 |
| Attributes (Columns) | 5830 | 24013 |
| Foreign Keys | 1041 | 4045 |
| Avg Attributes/Product | 43.5 | 41.2 |

## Domain & Product Comparison

<a id="domain-behavioral_health"></a>
### behavioral_health

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | crisis_episode | ✅ | ❌ | Domain not in MVM |
|  | mat_treatment | ✅ | ❌ | Domain not in MVM |
|  | otp_enrollment | ✅ | ❌ | Domain not in MVM |
|  | part2_consent | ✅ | ❌ | Domain not in MVM |
|  | part2_consent_disclosure | ✅ | ❌ | Domain not in MVM |
|  | psychiatric_assessment | ✅ | ❌ | Domain not in MVM |
|  | sud_episode | ✅ | ❌ | Domain not in MVM |

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| charge_capture | cdm_entry | ✅ | ✅ |  |
| charge_capture | charge | ✅ | ✅ |  |
| charge_capture | coding_assignment | ✅ | ✅ |  |
| charge_capture | site_cdm_pricing | ✅ | ❌ | Excluded from MVM |
| coverage_compliance | billing_coverage | ✅ | ❌ | Excluded from MVM |
| coverage_compliance | billing_network_participation | ✅ | ❌ | Excluded from MVM |
| coverage_compliance | charity_care_application | ✅ | ❌ | Excluded from MVM |
| coverage_compliance | rac_audit | ✅ | ❌ | Excluded from MVM |
| coverage_compliance | study_service_coverage | ✅ | ❌ | Excluded from MVM |
| patient_billing | invoice | ✅ | ✅ |  |
| patient_billing | invoice_coverage_billing | ✅ | ❌ | Excluded from MVM |
| patient_billing | invoice_line | ✅ | ✅ |  |
| patient_billing | invoice_line_item | ✅ | ❌ | Excluded from MVM |
| patient_billing | patient_account | ✅ | ✅ |  |
| patient_billing | statement | ✅ | ✅ |  |
| revenue_collections | adjustment | ✅ | ✅ |  |
| revenue_collections | collection_account | ✅ | ❌ | Excluded from MVM |
| revenue_collections | payment | ✅ | ✅ |  |
| revenue_collections | payment_plan | ✅ | ✅ |  |
| revenue_collections | refund | ✅ | ❌ | Excluded from MVM |
| revenue_collections | write_off | ✅ | ❌ | Excluded from MVM |

<a id="domain-claim"></a>
### claim

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| authorization_eligibility | authorization_service | ✅ | ❌ | Excluded from MVM |
| authorization_eligibility | eligibility | ✅ | ✅ |  |
| authorization_eligibility | prior_authorization | ✅ | ✅ |  |
| claim_submission | attachment | ✅ | ❌ | Excluded from MVM |
| claim_submission | claim | ✅ | ✅ |  |
| claim_submission | diagnosis_link | ✅ | ✅ |  |
| claim_submission | line | ✅ | ✅ |  |
| claim_submission | status_history | ✅ | ✅ |  |
| claim_submission | submission | ✅ | ✅ |  |
| denial_audit | appeal | ✅ | ✅ |  |
| denial_audit | audit_sample | ✅ | ❌ | Excluded from MVM |
| denial_audit | denial | ✅ | ✅ |  |
| denial_audit | study_attribution | ✅ | ❌ | Excluded from MVM |
| payment_reconciliation | cob | ✅ | ✅ |  |
| payment_reconciliation | remittance | ✅ | ✅ |  |
| payment_reconciliation | remittance_line | ✅ | ✅ |  |

<a id="domain-clinical"></a>
### clinical

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| clinical_assessment | cdi_query | ✅ | ❌ | Excluded from MVM |
| clinical_assessment | cdi_worksheet | ✅ | ❌ | Excluded from MVM |
| clinical_assessment | clinical_finding | ✅ | ❌ | Excluded from MVM |
| clinical_assessment | diagnosis | ✅ | ✅ |  |
| clinical_assessment | flowsheet_row | ✅ | ❌ | Excluded from MVM |
| clinical_assessment | flowsheet_template | ✅ | ❌ | Excluded from MVM |
| clinical_assessment | functional_status | ✅ | ❌ | Excluded from MVM |
| clinical_assessment | note | ✅ | ✅ |  |
| clinical_assessment | note_template | ✅ | ❌ | Excluded from MVM |
| clinical_assessment | nursing_assessment | ✅ | ❌ | Excluded from MVM |
| clinical_assessment | observation | ✅ | ✅ |  |
| clinical_assessment | problem | ✅ | ✅ |  |
| clinical_assessment | vital_sign | ✅ | ✅ |  |
| infection_surveillance | hai_event | ✅ | ❌ | Excluded from MVM |
| infection_surveillance | outbreak | ✅ | ❌ | Excluded from MVM |
| intelligence_analytics | care_gap | ✅ | ❌ | Excluded from MVM |
| intelligence_analytics | clinical_nlp_result | ✅ | ❌ | Excluded from MVM |
| intelligence_analytics | feature_store_entity | ✅ | ❌ | Excluded from MVM |
| intelligence_analytics | genetic_variant | ✅ | ❌ | Excluded from MVM |
| intelligence_analytics | ml_model | ✅ | ❌ | Excluded from MVM |
| intelligence_analytics | model_inference_log | ✅ | ❌ | Excluded from MVM |
| intelligence_analytics | patient_risk_score | ✅ | ❌ | Excluded from MVM |
| patient_care | advance_directive | ✅ | ❌ | Excluded from MVM |
| patient_care | allergy | ✅ | ✅ |  |
| patient_care | care_plan | ✅ | ✅ |  |
| patient_care | care_plan_goal | ✅ | ✅ |  |
| patient_care | care_team | ✅ | ✅ |  |
| patient_care | care_team_member | ✅ | ✅ |  |
| patient_care | immunization | ✅ | ✅ |  |
| patient_care | plan_care_coordination | ✅ | ❌ | Excluded from MVM |
| patient_care | procedure_equipment_usage | ✅ | ❌ | Excluded from MVM |
| patient_care | procedure_event | ✅ | ✅ |  |

<a id="domain-clinical_ai"></a>
### clinical_ai

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | care_gap | ✅ | ❌ | Domain not in MVM |
|  | clinical_nlp_result | ✅ | ❌ | Domain not in MVM |
|  | feature_store_entity | ✅ | ❌ | Domain not in MVM |
|  | model_inference_log | ✅ | ❌ | Domain not in MVM |
|  | patient_risk_score | ✅ | ❌ | Domain not in MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_investigation | audit | ✅ | ❌ | Domain not in MVM |
| audit_investigation | audit_finding | ✅ | ❌ | Domain not in MVM |
| audit_investigation | corrective_action_plan | ✅ | ❌ | Domain not in MVM |
| audit_investigation | exclusion_screening | ✅ | ❌ | Domain not in MVM |
| audit_investigation | hotline_report | ✅ | ❌ | Domain not in MVM |
| audit_investigation | investigation | ✅ | ❌ | Domain not in MVM |
| audit_investigation | monitoring_activity | ✅ | ❌ | Domain not in MVM |
| privacy_security | business_associate_agreement | ✅ | ❌ | Domain not in MVM |
| privacy_security | hipaa_privacy_incident | ✅ | ❌ | Domain not in MVM |
| privacy_security | hipaa_security_risk | ✅ | ❌ | Domain not in MVM |
| privacy_security | notice_of_privacy_practices | ✅ | ❌ | Domain not in MVM |
| privacy_security | osha_exposure_incident | ✅ | ❌ | Domain not in MVM |
| privacy_security | osha_safety_program | ✅ | ❌ | Domain not in MVM |
| privacy_security | phi_access_log | ✅ | ❌ | Domain not in MVM |
| program_governance | compliance_policy | ✅ | ❌ | Domain not in MVM |
| program_governance | compliance_program | ✅ | ❌ | Domain not in MVM |
| program_governance | conflict_of_interest | ✅ | ❌ | Domain not in MVM |
| program_governance | databricks_governance | ✅ | ❌ | Domain not in MVM |
| program_governance | obligation | ✅ | ❌ | Domain not in MVM |
| program_governance | policy_payer_applicability | ✅ | ❌ | Domain not in MVM |
| program_governance | policy_version | ✅ | ❌ | Domain not in MVM |
| program_governance | program_policy_assignment | ✅ | ❌ | Domain not in MVM |
| program_governance | stark_arrangement | ✅ | ❌ | Domain not in MVM |
| regulatory_accreditation | accreditation_status | ✅ | ❌ | Domain not in MVM |
| regulatory_accreditation | attestation | ✅ | ❌ | Domain not in MVM |
| regulatory_accreditation | cms_condition_status | ✅ | ❌ | Domain not in MVM |
| regulatory_accreditation | compliance_regulatory_submission | ✅ | ❌ | Domain not in MVM |
| regulatory_accreditation | policy_regulatory_impact | ✅ | ❌ | Domain not in MVM |
| regulatory_accreditation | regulatory_change | ✅ | ❌ | Domain not in MVM |
| regulatory_accreditation | regulatory_requirement | ✅ | ❌ | Domain not in MVM |
| training_attestation | training | ✅ | ❌ | Domain not in MVM |
| training_attestation | training_completion | ✅ | ❌ | Domain not in MVM |

<a id="domain-consent"></a>
### consent

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_governance | consent_policy | ✅ | ❌ | Excluded from MVM |
| compliance_governance | deficiency | ✅ | ❌ | Excluded from MVM |
| compliance_governance | expiration_alert | ✅ | ❌ | Excluded from MVM |
| compliance_governance | workflow | ✅ | ❌ | Excluded from MVM |
| consent_documentation | record | ❌ | ✅ | MVM only (stub or new) |
| privacy_rights | amendment_request | ✅ | ❌ | Excluded from MVM |
| privacy_rights | capacity_assessment | ✅ | ❌ | Excluded from MVM |
| privacy_rights | delegation | ✅ | ❌ | Excluded from MVM |
| privacy_rights | disclosure_log | ✅ | ✅ |  |
| privacy_rights | npp_acknowledgment | ✅ | ✅ |  |
| privacy_rights | restriction_request | ✅ | ✅ |  |
| privacy_rights | revocation | ✅ | ✅ |  |
| specialized_consent | behavioral_health_consent | ✅ | ❌ | Excluded from MVM |
| specialized_consent | consent_record | ✅ | ❌ | Excluded from MVM |
| specialized_consent | consent_session | ✅ | ❌ | Excluded from MVM |
| specialized_consent | form_template | ✅ | ✅ |  |
| specialized_consent | genetic_testing_consent | ✅ | ❌ | Excluded from MVM |
| specialized_consent | hie_directive | ✅ | ❌ | Excluded from MVM |
| specialized_consent | hipaa_authorization | ✅ | ✅ |  |
| specialized_consent | minor_consent | ✅ | ❌ | Excluded from MVM |
| specialized_consent | photography_media_consent | ✅ | ❌ | Excluded from MVM |
| specialized_consent | research_consent | ✅ | ❌ | Excluded from MVM |
| specialized_consent | substance_use_consent | ✅ | ❌ | Excluded from MVM |
| specialized_consent | telehealth_consent | ✅ | ❌ | Excluded from MVM |
| specialized_consent | treatment_consent | ✅ | ✅ |  |

<a id="domain-digital_health"></a>
### digital_health

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| patient_engagement | digital_health_portal_engagement_event | ✅ | ❌ | Domain not in MVM |
| patient_engagement | digital_health_prom_response | ✅ | ❌ | Domain not in MVM |
| patient_engagement | portal_session | ✅ | ❌ | Domain not in MVM |
| patient_engagement | secure_message_thread | ✅ | ❌ | Domain not in MVM |
| remote_monitoring | digital_health_rpm_alert_threshold | ✅ | ❌ | Domain not in MVM |
| remote_monitoring | digital_health_rpm_device_reading | ✅ | ❌ | Domain not in MVM |
| remote_monitoring | digital_health_rpm_program_enrollment | ✅ | ❌ | Domain not in MVM |
| remote_monitoring | rpm_enrollment | ✅ | ❌ | Domain not in MVM |

<a id="domain-encounter"></a>
### encounter

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| billing_authorization | authorization | ❌ | ✅ | MVM only (stub or new) |
| clinical_documentation | discharge_summary | ✅ | ✅ |  |
| clinical_documentation | readmission | ✅ | ✅ |  |
| clinical_documentation | triage_assessment | ✅ | ✅ |  |
| clinical_documentation | visit_diagnosis | ✅ | ✅ |  |
| clinical_documentation | visit_procedure | ✅ | ✅ |  |
| coverage_reimbursement | drg_assignment | ✅ | ✅ |  |
| coverage_reimbursement | encounter_authorization | ✅ | ❌ | Excluded from MVM |
| coverage_reimbursement | visit_coverage | ✅ | ❌ | Excluded from MVM |
| coverage_reimbursement | visit_insurance | ✅ | ✅ |  |
| patient_movement | adt_event | ✅ | ✅ |  |
| patient_movement | bed_assignment | ✅ | ✅ |  |
| patient_movement | transfer_request | ✅ | ❌ | Excluded from MVM |
| visit_management | visit | ✅ | ✅ |  |
| visit_management | visit_provider | ✅ | ✅ |  |
| visit_management | visit_recall_impact | ✅ | ❌ | Excluded from MVM |
| visit_management | visit_status_history | ✅ | ❌ | Excluded from MVM |

<a id="domain-facility"></a>
### facility

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| capacity_operations | bed_status_event | ✅ | ❌ | Domain not in MVM |
| capacity_operations | block_assignment | ✅ | ❌ | Domain not in MVM |
| capacity_operations | capacity_snapshot | ✅ | ❌ | Domain not in MVM |
| capacity_operations | environmental_service_request | ✅ | ❌ | Domain not in MVM |
| compliance_safety | hazardous_material | ✅ | ❌ | Domain not in MVM |
| compliance_safety | inspection | ✅ | ❌ | Domain not in MVM |
| compliance_safety | inspection_finding | ✅ | ❌ | Domain not in MVM |
| compliance_safety | license_accreditation | ✅ | ❌ | Domain not in MVM |
| compliance_safety | safety_incident | ✅ | ❌ | Domain not in MVM |
| equipment_maintenance | equipment_asset | ✅ | ❌ | Domain not in MVM |
| equipment_maintenance | equipment_authorization | ✅ | ❌ | Domain not in MVM |
| equipment_maintenance | maintenance_order | ✅ | ❌ | Domain not in MVM |
| equipment_maintenance | pm_schedule | ✅ | ❌ | Domain not in MVM |
| site_infrastructure | bed | ✅ | ❌ | Domain not in MVM |
| site_infrastructure | building | ✅ | ❌ | Domain not in MVM |
| site_infrastructure | care_site | ✅ | ❌ | Domain not in MVM |
| site_infrastructure | or_suite | ✅ | ❌ | Domain not in MVM |
| site_infrastructure | organization | ✅ | ❌ | Domain not in MVM |
| site_infrastructure | room | ✅ | ❌ | Domain not in MVM |
| site_infrastructure | site_hierarchy | ✅ | ❌ | Domain not in MVM |
| site_infrastructure | space_allocation | ✅ | ❌ | Domain not in MVM |
| site_infrastructure | unit | ✅ | ❌ | Domain not in MVM |
| vendor_contracting | contract | ✅ | ❌ | Domain not in MVM |
| vendor_contracting | facility_program_participation | ✅ | ❌ | Domain not in MVM |
| vendor_contracting | network_contract | ✅ | ❌ | Domain not in MVM |
| vendor_contracting | service | ✅ | ❌ | Domain not in MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| budget_planning | budget | ✅ | ❌ | Domain not in MVM |
| budget_planning | budget_line | ✅ | ❌ | Domain not in MVM |
| budget_planning | budget_transfer | ✅ | ❌ | Domain not in MVM |
| budget_planning | donor | ✅ | ❌ | Domain not in MVM |
| budget_planning | financial_forecast | ✅ | ❌ | Domain not in MVM |
| budget_planning | forecast_line | ✅ | ❌ | Domain not in MVM |
| budget_planning | fund | ✅ | ❌ | Domain not in MVM |
| budget_planning | fund_allocation | ✅ | ❌ | Domain not in MVM |
| capital_assets | asset_book | ✅ | ❌ | Domain not in MVM |
| capital_assets | capital_expenditure | ✅ | ❌ | Domain not in MVM |
| capital_assets | capital_project | ✅ | ❌ | Domain not in MVM |
| capital_assets | depreciation_run | ✅ | ❌ | Domain not in MVM |
| capital_assets | depreciation_schedule | ✅ | ❌ | Domain not in MVM |
| capital_assets | fixed_asset | ✅ | ❌ | Domain not in MVM |
| cost_accounting | allocation_method | ✅ | ❌ | Domain not in MVM |
| cost_accounting | allocation_run | ✅ | ❌ | Domain not in MVM |
| cost_accounting | cost_allocation | ✅ | ❌ | Domain not in MVM |
| general_ledger | chart_of_accounts | ✅ | ❌ | Domain not in MVM |
| general_ledger | cost_center | ✅ | ❌ | Domain not in MVM |
| general_ledger | financial_entity | ✅ | ❌ | Domain not in MVM |
| general_ledger | financial_period_close | ✅ | ❌ | Domain not in MVM |
| general_ledger | fiscal_period | ✅ | ❌ | Domain not in MVM |
| general_ledger | general_ledger | ✅ | ❌ | Domain not in MVM |
| general_ledger | intercompany_agreement | ✅ | ❌ | Domain not in MVM |
| general_ledger | intercompany_transaction | ✅ | ❌ | Domain not in MVM |
| general_ledger | journal_entry | ✅ | ❌ | Domain not in MVM |
| general_ledger | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| general_ledger | recurring_schedule | ✅ | ❌ | Domain not in MVM |
| general_ledger | transaction_batch | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_invoice | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_invoice_line | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_payment | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ar_account | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ar_transaction | ✅ | ❌ | Domain not in MVM |
| payables_receivables | bank_account | ✅ | ❌ | Domain not in MVM |
| payables_receivables | bank_reconciliation | ✅ | ❌ | Domain not in MVM |
| payables_receivables | invoice_payment_application | ✅ | ❌ | Domain not in MVM |
| payables_receivables | payment_batch | ✅ | ❌ | Domain not in MVM |

<a id="domain-insurance"></a>
### insurance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | network_participation | ✅ | ❌ | Excluded from MVM |
| member_coverage | accumulator | ✅ | ❌ | Excluded from MVM |
| member_coverage | coordination_of_benefits | ✅ | ❌ | Excluded from MVM |
| member_coverage | dependent | ✅ | ✅ |  |
| member_coverage | eligibility_span | ✅ | ❌ | Excluded from MVM |
| member_coverage | employer_group | ✅ | ❌ | Excluded from MVM |
| member_coverage | member_enrollment | ✅ | ✅ |  |
| member_coverage | premium_billing | ✅ | ❌ | Excluded from MVM |
| member_coverage | subscriber | ✅ | ✅ |  |
| network_contracting | fee_schedule | ✅ | ✅ |  |
| network_contracting | fee_schedule_line | ✅ | ✅ |  |
| network_contracting | insurance_network_participation | ✅ | ❌ | Excluded from MVM |
| network_contracting | insurance_network_participation2 | ✅ | ❌ | Excluded from MVM |
| network_contracting | insurance_payer_enrollment | ✅ | ❌ | Excluded from MVM |
| network_contracting | network_adequacy | ✅ | ❌ | Excluded from MVM |
| network_contracting | payer_contract | ✅ | ✅ |  |
| network_contracting | plan_network | ✅ | ❌ | Excluded from MVM |
| network_contracting | provider_network | ✅ | ✅ |  |
| plan_management | benefit | ✅ | ✅ |  |
| plan_management | broker | ✅ | ❌ | Excluded from MVM |
| plan_management | coverage_policy | ✅ | ✅ |  |
| plan_management | formulary_tier | ✅ | ❌ | Excluded from MVM |
| plan_management | health_plan | ✅ | ✅ |  |
| plan_management | payer | ✅ | ✅ |  |
| plan_management | payer_contact | ✅ | ❌ | Excluded from MVM |
| plan_management | third_party_administrator | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | payer_compliance_requirement | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | plan_consent_requirement | ✅ | ❌ | Excluded from MVM |
| utilization_authorization | prior_auth_rule | ✅ | ✅ |  |
| utilization_authorization | utilization_review | ✅ | ❌ | Excluded from MVM |
| value_performance | accountable_care_organization | ✅ | ❌ | Excluded from MVM |
| value_performance | capitation_contract | ✅ | ❌ | Excluded from MVM |
| value_performance | capitation_payment | ✅ | ❌ | Excluded from MVM |
| value_performance | member_attribution | ✅ | ❌ | Excluded from MVM |
| value_performance | risk_adjustment | ✅ | ❌ | Excluded from MVM |
| value_performance | vbc_performance | ✅ | ❌ | Excluded from MVM |

<a id="domain-interoperability"></a>
### interoperability

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| data_exchange | care_transition_notification | ✅ | ❌ | Domain not in MVM |
| data_exchange | cda_document | ✅ | ❌ | Domain not in MVM |
| data_exchange | cda_validation_result | ✅ | ❌ | Domain not in MVM |
| data_exchange | conformance_test | ✅ | ❌ | Domain not in MVM |
| data_exchange | direct_address | ✅ | ❌ | Domain not in MVM |
| data_exchange | direct_message | ✅ | ❌ | Domain not in MVM |
| data_exchange | exchange_standard | ✅ | ❌ | Domain not in MVM |
| data_exchange | fhir_endpoint | ✅ | ❌ | Domain not in MVM |
| data_exchange | fhir_resource_log | ✅ | ❌ | Domain not in MVM |
| data_exchange | mapping_definition | ✅ | ❌ | Domain not in MVM |
| data_exchange | mapping_rule | ✅ | ❌ | Domain not in MVM |
| data_exchange | patient_identity_match | ✅ | ❌ | Domain not in MVM |
| data_exchange | promoting_interoperability | ✅ | ❌ | Domain not in MVM |
| data_exchange | public_health_report | ✅ | ❌ | Domain not in MVM |
| data_exchange | subscription_notification | ✅ | ❌ | Domain not in MVM |
| data_exchange | subscription_topic | ✅ | ❌ | Domain not in MVM |
| data_exchange | terminology_mapping | ✅ | ❌ | Domain not in MVM |
| interface_operations | interface_channel | ✅ | ❌ | Domain not in MVM |
| interface_operations | interface_downtime | ✅ | ❌ | Domain not in MVM |
| interface_operations | interface_engine | ✅ | ❌ | Domain not in MVM |
| interface_operations | interface_sla | ✅ | ❌ | Domain not in MVM |
| interface_operations | message_error | ✅ | ❌ | Domain not in MVM |
| interface_operations | message_log | ✅ | ❌ | Domain not in MVM |
| partner_governance | data_sharing_agreement | ✅ | ❌ | Domain not in MVM |
| partner_governance | data_use_agreement | ✅ | ❌ | Domain not in MVM |
| partner_governance | hie_organization | ✅ | ❌ | Domain not in MVM |
| partner_governance | hie_participation | ✅ | ❌ | Domain not in MVM |
| partner_governance | hie_query | ✅ | ❌ | Domain not in MVM |
| partner_governance | hie_transaction | ✅ | ❌ | Domain not in MVM |
| partner_governance | onboarding_project | ✅ | ❌ | Domain not in MVM |
| partner_governance | trading_partner | ✅ | ❌ | Domain not in MVM |

<a id="domain-laboratory"></a>
### laboratory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| diagnostic_results | microbiology_culture | ✅ | ✅ |  |
| diagnostic_results | molecular_test | ✅ | ❌ | Excluded from MVM |
| diagnostic_results | organism | ✅ | ❌ | Excluded from MVM |
| diagnostic_results | pathology_report | ✅ | ✅ |  |
| diagnostic_results | point_of_care_test | ✅ | ❌ | Excluded from MVM |
| diagnostic_results | reference_range | ✅ | ✅ |  |
| diagnostic_results | susceptibility_result | ✅ | ❌ | Excluded from MVM |
| diagnostic_results | test_result | ✅ | ✅ |  |
| quality_compliance | clia_certificate | ✅ | ❌ | Excluded from MVM |
| quality_compliance | instrument | ✅ | ✅ |  |
| quality_compliance | instrument_policy_compliance | ✅ | ❌ | Excluded from MVM |
| quality_compliance | qc_run | ✅ | ❌ | Excluded from MVM |
| quality_compliance | reagent_lot | ✅ | ❌ | Excluded from MVM |
| reimbursement_finance | lab_charge | ✅ | ❌ | Excluded from MVM |
| reimbursement_finance | lab_fee_schedule_line | ✅ | ❌ | Excluded from MVM |
| reimbursement_finance | test_coverage_policy | ✅ | ❌ | Excluded from MVM |
| test_ordering | lab_order | ✅ | ✅ |  |
| test_ordering | specimen | ✅ | ✅ |  |
| test_ordering | study_test_requirement | ✅ | ❌ | Excluded from MVM |
| test_ordering | test_catalog | ✅ | ✅ |  |
| transfusion_services | blood_bank_unit | ✅ | ❌ | Excluded from MVM |
| transfusion_services | transfusion_event | ✅ | ❌ | Excluded from MVM |

<a id="domain-order"></a>
### order

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| decision_support | alert_rule | ✅ | ❌ | Excluded from MVM |
| decision_support | cpoe_alert | ✅ | ❌ | Excluded from MVM |
| decision_support | order_authorization | ✅ | ❌ | Excluded from MVM |
| decision_support | reconciliation | ✅ | ✅ |  |
| fulfillment_routing | fulfillment | ✅ | ✅ |  |
| fulfillment_routing | order_status_history | ✅ | ❌ | Excluded from MVM |
| fulfillment_routing | routing | ✅ | ✅ |  |
| fulfillment_routing | routing_rule | ✅ | ❌ | Excluded from MVM |
| order_entry | clinical_order | ✅ | ✅ |  |
| order_entry | diet_order | ✅ | ❌ | Excluded from MVM |
| order_entry | referral_order | ✅ | ✅ |  |
| order_entry | set | ✅ | ✅ |  |
| order_entry | set_item | ✅ | ✅ |  |
| order_entry | standing_order | ✅ | ✅ |  |
| order_entry | therapy_order | ✅ | ❌ | Excluded from MVM |
| order_entry | verbal_order | ✅ | ❌ | Excluded from MVM |

<a id="domain-patient"></a>
### patient

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| coverage_eligibility | consent_reference | ✅ | ✅ |  |
| coverage_eligibility | eligibility_check | ✅ | ✅ |  |
| coverage_eligibility | financial_assistance | ✅ | ❌ | Excluded from MVM |
| coverage_eligibility | insurance_coverage | ✅ | ✅ |  |
| coverage_eligibility | patient_coverage | ✅ | ❌ | Excluded from MVM |
| identity_management | address | ✅ | ✅ |  |
| identity_management | demographics | ✅ | ✅ |  |
| identity_management | emergency_contact | ✅ | ✅ |  |
| identity_management | flag | ✅ | ❌ | Excluded from MVM |
| identity_management | guarantor | ✅ | ✅ |  |
| identity_management | identity_merge_history | ✅ | ❌ | Excluded from MVM |
| identity_management | mpi_record | ✅ | ✅ |  |
| identity_management | mrn_crosswalk | ✅ | ✅ |  |
| identity_management | preference | ✅ | ❌ | Excluded from MVM |
| identity_management | proxy_access | ✅ | ❌ | Excluded from MVM |
| identity_management | registration_event | ✅ | ✅ |  |
| patient_engagement | communication_campaign | ✅ | ❌ | Excluded from MVM |
| patient_engagement | communication_log | ✅ | ❌ | Excluded from MVM |
| patient_engagement | message_template | ✅ | ❌ | Excluded from MVM |
| patient_engagement | patient_portal_engagement_event | ✅ | ❌ | Excluded from MVM |
| patient_engagement | portal_account | ✅ | ✅ |  |
| population_health | attribution_panel | ✅ | ❌ | Excluded from MVM |
| population_health | care_program | ✅ | ❌ | Excluded from MVM |
| population_health | care_program_enrollment | ✅ | ❌ | Excluded from MVM |
| population_health | patient_prom_response | ✅ | ❌ | Excluded from MVM |
| population_health | patient_rpm_alert_threshold | ✅ | ❌ | Excluded from MVM |
| population_health | patient_rpm_device_reading | ✅ | ❌ | Excluded from MVM |
| population_health | patient_rpm_program_enrollment | ✅ | ❌ | Excluded from MVM |
| population_health | pcp_attribution | ✅ | ✅ |  |
| population_health | population_segment | ✅ | ❌ | Excluded from MVM |
| population_health | program_enrollment | ✅ | ❌ | Excluded from MVM |
| population_health | quality_measure_evaluation | ✅ | ❌ | Excluded from MVM |
| social_determinants | chw_intervention | ✅ | ❌ | Excluded from MVM |
| social_determinants | community_resource | ✅ | ❌ | Excluded from MVM |
| social_determinants | sdoh_assessment | ✅ | ❌ | Excluded from MVM |
| social_determinants | sdoh_need_closure | ✅ | ❌ | Excluded from MVM |
| social_determinants | sdoh_referral | ✅ | ❌ | Excluded from MVM |
| social_determinants | sdoh_risk_stratification | ✅ | ❌ | Excluded from MVM |
| social_determinants | sdoh_zcode_mapping | ✅ | ❌ | Excluded from MVM |

<a id="domain-pharmacy"></a>
### pharmacy

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| benefit_reimbursement | medication_pa_request | ✅ | ❌ | Excluded from MVM |
| benefit_reimbursement | pharmacy_network_participation | ✅ | ❌ | Excluded from MVM |
| benefit_reimbursement | rx_claim | ✅ | ❌ | Excluded from MVM |
| clinical_services | medication_review | ✅ | ❌ | Excluded from MVM |
| clinical_services | medication_therapy_mgmt | ✅ | ❌ | Excluded from MVM |
| clinical_services | study_drug_assignment | ✅ | ❌ | Excluded from MVM |
| dispensing_operations | dispense_event | ✅ | ✅ |  |
| dispensing_operations | inventory | ✅ | ✅ |  |
| dispensing_operations | mar_record | ✅ | ✅ |  |
| dispensing_operations | prescription | ✅ | ✅ |  |
| drug_catalog | compounding_record | ✅ | ❌ | Excluded from MVM |
| drug_catalog | drug_master | ✅ | ✅ |  |
| drug_catalog | formulary | ✅ | ✅ |  |
| drug_catalog | pharmacy_location | ✅ | ❌ | Excluded from MVM |
| drug_formulary | lasa_pair | ❌ | ✅ | MVM only (stub or new) |
| safety_compliance | adverse_drug_event | ✅ | ✅ |  |
| safety_compliance | controlled_substance_log | ✅ | ✅ |  |
| safety_compliance | drug_recall | ✅ | ❌ | Excluded from MVM |
| safety_compliance | rems_compliance | ✅ | ❌ | Excluded from MVM |

<a id="domain-provider"></a>
### provider

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| credentialing_privileging | board_certification | ✅ | ✅ |  |
| credentialing_privileging | cme_activity | ✅ | ❌ | Excluded from MVM |
| credentialing_privileging | committee | ✅ | ❌ | Excluded from MVM |
| credentialing_privileging | credential | ✅ | ✅ |  |
| credentialing_privileging | credentialing_application | ✅ | ❌ | Excluded from MVM |
| credentialing_privileging | credentialing_file | ✅ | ❌ | Excluded from MVM |
| credentialing_privileging | dea_registration | ✅ | ✅ |  |
| credentialing_privileging | education_training | ✅ | ❌ | Excluded from MVM |
| credentialing_privileging | malpractice_coverage | ✅ | ❌ | Excluded from MVM |
| credentialing_privileging | npdb_query | ✅ | ❌ | Excluded from MVM |
| credentialing_privileging | peer_reference | ✅ | ❌ | Excluded from MVM |
| credentialing_privileging | privileging | ✅ | ✅ |  |
| credentialing_privileging | reappointment | ✅ | ❌ | Excluded from MVM |
| credentialing_privileging | sanction | ✅ | ❌ | Excluded from MVM |
| credentialing_privileging | survey_participation | ✅ | ❌ | Excluded from MVM |
| credentialing_privileging | telehealth_authorization | ✅ | ❌ | Excluded from MVM |
| network_enrollment | affiliation_history | ✅ | ❌ | Excluded from MVM |
| network_enrollment | network_affiliation | ✅ | ✅ |  |
| network_enrollment | preference_card | ✅ | ❌ | Excluded from MVM |
| network_enrollment | provider_network_participation | ✅ | ❌ | Excluded from MVM |
| network_enrollment | provider_payer_enrollment | ✅ | ❌ | Excluded from MVM |
| network_enrollment | study_team_member | ✅ | ❌ | Excluded from MVM |
| provider_master | affiliation | ✅ | ❌ | Excluded from MVM |
| provider_master | assignment | ✅ | ❌ | Excluded from MVM |
| provider_master | clinician | ✅ | ✅ |  |
| provider_master | group | ✅ | ✅ |  |
| provider_master | group_membership | ✅ | ✅ |  |
| provider_master | org_provider | ✅ | ✅ |  |
| provider_master | provider_location | ✅ | ❌ | Excluded from MVM |
| provider_master | specialty | ✅ | ✅ |  |
| provider_master | taxonomy | ✅ | ✅ |  |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| accreditation_compliance | accreditation_program | ✅ | ❌ | Domain not in MVM |
| accreditation_compliance | accreditation_survey | ✅ | ❌ | Domain not in MVM |
| accreditation_compliance | corrective_action | ✅ | ❌ | Domain not in MVM |
| accreditation_compliance | quality_committee | ✅ | ❌ | Domain not in MVM |
| accreditation_compliance | standard_finding | ✅ | ❌ | Domain not in MVM |
| measure_reporting | hedis_measure | ✅ | ❌ | Domain not in MVM |
| measure_reporting | hedis_result | ✅ | ❌ | Domain not in MVM |
| measure_reporting | measure | ✅ | ❌ | Domain not in MVM |
| measure_reporting | measure_result | ✅ | ❌ | Domain not in MVM |
| measure_reporting | program_measure_assignment | ✅ | ❌ | Domain not in MVM |
| measure_reporting | raf_score | ✅ | ❌ | Domain not in MVM |
| measure_reporting | vbp_program | ✅ | ❌ | Domain not in MVM |
| patient_experience | cahps_response | ✅ | ❌ | Domain not in MVM |
| patient_experience | cahps_survey | ✅ | ❌ | Domain not in MVM |
| patient_experience | care_gap_closure | ✅ | ❌ | Domain not in MVM |
| patient_experience | chw_intervention | ✅ | ❌ | Domain not in MVM |
| patient_experience | population_health_gap | ✅ | ❌ | Domain not in MVM |
| patient_experience | sdoh_risk_stratification | ✅ | ❌ | Domain not in MVM |
| patient_experience | sdoh_screening | ✅ | ❌ | Domain not in MVM |
| program_governance | contract_initiative | ✅ | ❌ | Domain not in MVM |
| program_governance | improvement_initiative | ✅ | ❌ | Domain not in MVM |
| program_governance | initiative_measure_target | ✅ | ❌ | Domain not in MVM |
| program_governance | measure_budget_allocation | ✅ | ❌ | Domain not in MVM |
| program_governance | program_study_participation | ✅ | ❌ | Domain not in MVM |
| program_governance | quality_program | ✅ | ❌ | Domain not in MVM |
| program_governance | quality_program_participation | ✅ | ❌ | Domain not in MVM |
| safety_review | cdi_review | ✅ | ❌ | Domain not in MVM |
| safety_review | mortality_review | ✅ | ❌ | Domain not in MVM |
| safety_review | patient_safety_event | ✅ | ❌ | Domain not in MVM |
| safety_review | quality_peer_review | ✅ | ❌ | Domain not in MVM |
| safety_review | safety_event_review | ✅ | ❌ | Domain not in MVM |

<a id="domain-radiology"></a>
### radiology

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| imaging_acquisition | contrast_admin | ✅ | ❌ | Domain not in MVM |
| imaging_acquisition | dicom_series | ✅ | ❌ | Domain not in MVM |
| imaging_acquisition | dose_record | ✅ | ❌ | Domain not in MVM |
| imaging_acquisition | imaging_order | ✅ | ❌ | Domain not in MVM |
| imaging_acquisition | interventional_procedure | ✅ | ❌ | Domain not in MVM |
| imaging_acquisition | modality | ✅ | ❌ | Domain not in MVM |
| imaging_acquisition | protocol | ✅ | ❌ | Domain not in MVM |
| imaging_acquisition | radiology_appointment | ✅ | ❌ | Domain not in MVM |
| imaging_acquisition | radiology_order_status_history | ✅ | ❌ | Domain not in MVM |
| imaging_acquisition | radiology_study | ✅ | ❌ | Domain not in MVM |
| interpretation_reporting | critical_result | ✅ | ❌ | Domain not in MVM |
| interpretation_reporting | follow_up | ✅ | ❌ | Domain not in MVM |
| interpretation_reporting | radiology_finding | ✅ | ❌ | Domain not in MVM |
| interpretation_reporting | radiology_peer_review | ✅ | ❌ | Domain not in MVM |
| interpretation_reporting | reader_assignment | ✅ | ❌ | Domain not in MVM |
| interpretation_reporting | report | ✅ | ❌ | Domain not in MVM |
| interpretation_reporting | report_addendum | ✅ | ❌ | Domain not in MVM |
| interpretation_reporting | teleradiology_case | ✅ | ❌ | Domain not in MVM |
| result_distribution | distribution_rule | ✅ | ❌ | Domain not in MVM |
| result_distribution | network_modality_participation | ✅ | ❌ | Domain not in MVM |
| result_distribution | report_distribution | ✅ | ❌ | Domain not in MVM |
| result_distribution | transmission | ✅ | ❌ | Domain not in MVM |

<a id="domain-reference"></a>
### reference

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| billing_codes | condition_code | ✅ | ❌ | Excluded from MVM |
| billing_codes | cpt_code | ✅ | ✅ |  |
| billing_codes | drg | ✅ | ✅ |  |
| billing_codes | hcpcs_code | ✅ | ✅ |  |
| billing_codes | major_diagnostic_category | ✅ | ❌ | Excluded from MVM |
| catalog_governance | code_set_version | ✅ | ✅ |  |
| catalog_governance | crosswalk | ✅ | ✅ |  |
| catalog_governance | output_format_readme | ✅ | ❌ | Excluded from MVM |
| catalog_governance | readme_databricks_section | ✅ | ❌ | Excluded from MVM |
| clinical_terminology | fhir_value_set | ✅ | ❌ | Excluded from MVM |
| clinical_terminology | icd_code | ✅ | ✅ |  |
| clinical_terminology | loinc_code | ✅ | ✅ |  |
| clinical_terminology | ndc_drug | ✅ | ✅ |  |
| clinical_terminology | snomed_concept | ✅ | ✅ |  |
| registry_geography | geographic_region | ✅ | ❌ | Excluded from MVM |
| registry_geography | npi_registry | ✅ | ✅ |  |
| registry_geography | sdoh_zcode_mapping | ✅ | ❌ | Excluded from MVM |

<a id="domain-research"></a>
### research

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| data_governance | data_access_request | ✅ | ❌ | Domain not in MVM |
| data_governance | data_governance_committee | ✅ | ❌ | Domain not in MVM |
| data_governance | deidentified_dataset | ✅ | ❌ | Domain not in MVM |
| data_governance | dua_document | ✅ | ❌ | Domain not in MVM |
| data_governance | study_partner_agreement | ✅ | ❌ | Domain not in MVM |
| grant_finance | billing_event | ✅ | ❌ | Domain not in MVM |
| grant_finance | coverage_analysis | ✅ | ❌ | Domain not in MVM |
| grant_finance | grant | ✅ | ❌ | Domain not in MVM |
| grant_finance | grant_expenditure | ✅ | ❌ | Domain not in MVM |
| grant_finance | grant_personnel | ✅ | ❌ | Domain not in MVM |
| grant_finance | study_budget | ✅ | ❌ | Domain not in MVM |
| grant_finance | study_sponsor | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | irb_submission | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | research_regulatory_submission | ✅ | ❌ | Domain not in MVM |
| safety_compliance | adverse_event | ✅ | ❌ | Domain not in MVM |
| safety_compliance | data_safety_monitoring | ✅ | ❌ | Domain not in MVM |
| safety_compliance | dsmb_committee | ✅ | ❌ | Domain not in MVM |
| safety_compliance | investigational_product_training | ✅ | ❌ | Domain not in MVM |
| safety_compliance | monitoring_visit | ✅ | ❌ | Domain not in MVM |
| safety_compliance | protocol_deviation | ✅ | ❌ | Domain not in MVM |
| study_management | protocol_amendment | ✅ | ❌ | Domain not in MVM |
| study_management | research_document | ✅ | ❌ | Domain not in MVM |
| study_management | research_study | ✅ | ❌ | Domain not in MVM |
| study_management | study_arm | ✅ | ❌ | Domain not in MVM |
| study_management | study_site | ✅ | ❌ | Domain not in MVM |
| subject_participation | biospecimen | ✅ | ❌ | Domain not in MVM |
| subject_participation | consent_template | ✅ | ❌ | Domain not in MVM |
| subject_participation | informed_consent | ✅ | ❌ | Domain not in MVM |
| subject_participation | investigational_product | ✅ | ❌ | Domain not in MVM |
| subject_participation | ip_dispensation | ✅ | ❌ | Domain not in MVM |
| subject_participation | study_visit | ✅ | ❌ | Domain not in MVM |
| subject_participation | subject_enrollment | ✅ | ❌ | Domain not in MVM |

<a id="domain-scheduling"></a>
### scheduling

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| booking_rules | appointment_prior_auth_requirement | ✅ | ❌ | Excluded from MVM |
| booking_rules | appointment_status_history | ✅ | ❌ | Excluded from MVM |
| booking_rules | appointment_type | ✅ | ✅ |  |
| booking_rules | booking_queue | ✅ | ❌ | Excluded from MVM |
| booking_rules | booking_rule | ✅ | ❌ | Excluded from MVM |
| booking_rules | open_slot | ✅ | ✅ |  |
| booking_rules | scheduling_appointment | ✅ | ❌ | Excluded from MVM |
| booking_rules | waitlist_entry | ✅ | ✅ |  |
| patient_engagement | appointment_reminder | ✅ | ✅ |  |
| patient_engagement | patient_preference | ✅ | ❌ | Excluded from MVM |
| patient_engagement | recall_list | ✅ | ❌ | Excluded from MVM |
| patient_engagement | reminder_template | ✅ | ❌ | Excluded from MVM |
| patient_engagement | telehealth_session | ✅ | ✅ |  |
| resource_capacity | capacity_utilization | ✅ | ❌ | Excluded from MVM |
| resource_capacity | provider_availability | ✅ | ✅ |  |
| resource_capacity | resource_assignment | ✅ | ✅ |  |
| resource_capacity | schedulable_resource | ✅ | ✅ |  |
| resource_capacity | schedule_template | ✅ | ✅ |  |
| surgical_scheduling | block_utilization | ✅ | ❌ | Excluded from MVM |
| surgical_scheduling | case_material_usage | ✅ | ❌ | Excluded from MVM |
| surgical_scheduling | equipment_reservation | ✅ | ❌ | Excluded from MVM |
| surgical_scheduling | or_block | ✅ | ❌ | Excluded from MVM |
| surgical_scheduling | surgical_case | ✅ | ✅ |  |
| surgical_scheduling | surgical_case_team | ✅ | ❌ | Excluded from MVM |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_recall | material_policy_governance | ✅ | ❌ | Domain not in MVM |
| compliance_recall | recall_notice | ✅ | ❌ | Domain not in MVM |
| compliance_recall | udi_record | ✅ | ❌ | Domain not in MVM |
| inventory_management | inventory_location | ✅ | ❌ | Domain not in MVM |
| inventory_management | location_audit | ✅ | ❌ | Domain not in MVM |
| procurement_purchasing | goods_receipt | ✅ | ❌ | Domain not in MVM |
| procurement_purchasing | purchase_order | ✅ | ❌ | Domain not in MVM |
| procurement_purchasing | purchase_order_line | ✅ | ❌ | Domain not in MVM |
| procurement_purchasing | requisition | ✅ | ❌ | Domain not in MVM |
| surgical_supply | case_cart | ✅ | ❌ | Domain not in MVM |
| surgical_supply | surgical_bom | ✅ | ❌ | Domain not in MVM |
| vendor_sourcing | material_master | ✅ | ❌ | Domain not in MVM |
| vendor_sourcing | vendor | ✅ | ❌ | Domain not in MVM |
| vendor_sourcing | vendor_contract | ✅ | ❌ | Domain not in MVM |
| vendor_sourcing | vendor_site | ✅ | ❌ | Domain not in MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| credentialing_compliance | clinical_privilege | ✅ | ❌ | Domain not in MVM |
| credentialing_compliance | competency_assessment | ✅ | ❌ | Domain not in MVM |
| credentialing_compliance | education_program | ✅ | ❌ | Domain not in MVM |
| credentialing_compliance | employment_competency | ✅ | ❌ | Domain not in MVM |
| credentialing_compliance | osha_incident | ✅ | ❌ | Domain not in MVM |
| credentialing_compliance | position_procedure_authorization | ✅ | ❌ | Domain not in MVM |
| credentialing_compliance | workforce_provider_network_participation | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | benefit_plan | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_calendar | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_run | ✅ | ❌ | Domain not in MVM |
| talent_performance | applicant | ✅ | ❌ | Domain not in MVM |
| talent_performance | performance_review | ✅ | ❌ | Domain not in MVM |
| talent_performance | recruitment | ✅ | ❌ | Domain not in MVM |
| talent_performance | review_template | ✅ | ❌ | Domain not in MVM |
| time_scheduling | channel_support_assignment | ✅ | ❌ | Domain not in MVM |
| time_scheduling | leave_request | ✅ | ❌ | Domain not in MVM |
| time_scheduling | shift_schedule | ✅ | ❌ | Domain not in MVM |
| time_scheduling | time_attendance | ✅ | ❌ | Domain not in MVM |
| workforce_administration | employee | ✅ | ❌ | Domain not in MVM |
| workforce_administration | fte_budget | ✅ | ❌ | Domain not in MVM |
| workforce_administration | job_profile | ✅ | ❌ | Domain not in MVM |
| workforce_administration | org_unit | ✅ | ❌ | Domain not in MVM |
| workforce_administration | position | ✅ | ❌ | Domain not in MVM |
