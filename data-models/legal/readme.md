# Legal Lakehouse Data Models

**Version 1** | Generated on May 07, 2026 at 02:36 PM

**Industry:** legal-services

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Billing](#domain-billing)
  - [Client](#domain-client)
  - [Compliance](#domain-compliance)
  - [Conflict](#domain-conflict)
  - [Contract](#domain-contract)
  - [Court](#domain-court)
  - [Document](#domain-document)
  - [Intake](#domain-intake)
  - [Ip](#domain-ip)
  - [Knowledge](#domain-knowledge)
  - [Matter](#domain-matter)
  - [Risk](#domain-risk)
  - [Service](#domain-service)
  - [Trust](#domain-trust)
  - [Workforce](#domain-workforce)


## Business Description

Legal is a professional services industry providing advisory and representation services across corporate transactions, dispute resolution, intellectual property, employment law, and regulatory compliance for organizations and governments.

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
| Domains | 12 | 15 |
| Subdomains | 31 | 45 |
| Products (Tables) | 153 | 314 |
| Attributes (Columns) | 6405 | 12216 |
| Foreign Keys | 1377 | 2214 |
| Avg Attributes/Product | 41.9 | 38.9 |

## Domain & Product Comparison

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| invoice_generation | credit_note | ✅ | ✅ |  |
| invoice_generation | invoice | ✅ | ✅ |  |
| invoice_generation | invoice_dispute | ✅ | ✅ |  |
| invoice_generation | invoice_line | ✅ | ✅ |  |
| invoice_generation | ledes_submission | ✅ | ❌ | Excluded from MVM |
| invoice_generation | prebill | ✅ | ✅ |  |
| invoice_management | fee_arrangement | ❌ | ✅ | MVM only (stub or new) |
| payment_collections | ar_balance | ✅ | ✅ |  |
| payment_collections | billing_payment | ✅ | ✅ |  |
| payment_collections | collection_action | ✅ | ❌ | Excluded from MVM |
| payment_collections | payment_allocation | ✅ | ✅ |  |
| payment_collections | write_off | ✅ | ✅ |  |
| rate_management | billing_fee_arrangement | ✅ | ❌ | Excluded from MVM |
| rate_management | billing_office | ✅ | ❌ | Excluded from MVM |
| rate_management | guideline | ✅ | ✅ |  |
| rate_management | rate_schedule | ✅ | ❌ | Excluded from MVM |
| rate_management | retainer | ✅ | ✅ |  |
| rate_management | timekeeper_rate | ✅ | ✅ |  |
| time_capture | billing_disbursement | ✅ | ✅ |  |
| time_capture | billing_period | ✅ | ❌ | Excluded from MVM |
| time_capture | time_entry | ✅ | ✅ |  |
| time_capture | wip_ledger | ✅ | ✅ |  |

<a id="domain-client"></a>
### client

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| client_identity | contact | ❌ | ✅ | MVM only (stub or new) |
| compliance_verification | beneficial_owner | ✅ | ✅ |  |
| compliance_verification | document_access | ✅ | ❌ | Excluded from MVM |
| compliance_verification | ip_beneficial_ownership | ✅ | ❌ | Excluded from MVM |
| compliance_verification | kyc_document | ✅ | ❌ | Excluded from MVM |
| compliance_verification | kyc_document_verification | ✅ | ❌ | Excluded from MVM |
| compliance_verification | kyc_record | ✅ | ✅ |  |
| compliance_verification | vendor | ✅ | ❌ | Excluded from MVM |
| entity_management | address | ✅ | ✅ |  |
| entity_management | client_contact | ✅ | ❌ | Excluded from MVM |
| entity_management | corporate_hierarchy | ✅ | ✅ |  |
| entity_management | individual | ✅ | ✅ |  |
| entity_management | organisation | ✅ | ✅ |  |
| entity_management | profile | ✅ | ✅ |  |
| entity_management | segment | ✅ | ✅ |  |
| relationship_governance | client_engagement_scope | ✅ | ❌ | Excluded from MVM |
| relationship_governance | client_status_history | ✅ | ❌ | Excluded from MVM |
| relationship_governance | credit_standing | ✅ | ❌ | Excluded from MVM |
| relationship_governance | outside_counsel_guideline | ✅ | ✅ |  |
| relationship_governance | relationship_team | ✅ | ✅ |  |
| relationship_governance | service_engagement | ✅ | ❌ | Excluded from MVM |
| relationship_governance | subscription | ✅ | ❌ | Excluded from MVM |
| relationship_management | engagement_scope | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_assurance | audit_engagement | ✅ | ❌ | Excluded from MVM |
| audit_assurance | audit_finding | ✅ | ❌ | Excluded from MVM |
| audit_assurance | audit_program | ✅ | ❌ | Excluded from MVM |
| audit_assurance | audit_scope | ✅ | ❌ | Excluded from MVM |
| audit_assurance | indemnity_claim | ✅ | ✅ |  |
| audit_assurance | indemnity_policy | ✅ | ✅ |  |
| audit_assurance | training_programme | ✅ | ❌ | Excluded from MVM |
| control_management | control_test | ❌ | ✅ | MVM only (stub or new) |
| financial_crime | aml_kyc_program | ✅ | ✅ |  |
| financial_crime | aml_risk_assessment | ✅ | ❌ | Excluded from MVM |
| financial_crime | sanctions_check | ✅ | ❌ | Excluded from MVM |
| financial_crime | sar_filing | ✅ | ✅ |  |
| privacy_protection | data_privacy_register | ✅ | ✅ |  |
| privacy_protection | data_subject_request | ✅ | ❌ | Excluded from MVM |
| privacy_protection | dpia | ✅ | ❌ | Excluded from MVM |
| privacy_protection | privacy_breach | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | compliance_control | ✅ | ✅ |  |
| regulatory_oversight | compliance_control_test | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | control_framework | ✅ | ✅ |  |
| regulatory_oversight | policy | ✅ | ✅ |  |
| regulatory_oversight | policy_acknowledgement | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | regulatory_breach | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | regulatory_change | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | regulatory_obligation | ✅ | ✅ |  |
| regulatory_oversight | regulatory_return | ✅ | ❌ | Excluded from MVM |

<a id="domain-conflict"></a>
### conflict

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| ethical_compliance | conflict_exception | ✅ | ❌ | Excluded from MVM |
| ethical_compliance | ethical_wall | ✅ | ✅ |  |
| ethical_compliance | rule | ✅ | ✅ |  |
| ethical_compliance | waiver | ✅ | ✅ |  |
| ethical_compliance | wall_enforcement | ✅ | ❌ | Excluded from MVM |
| ethical_compliance | wall_membership | ✅ | ✅ |  |
| party_registry | conflict_party | ✅ | ✅ |  |
| party_registry | matter_party_role | ✅ | ❌ | Excluded from MVM |
| party_registry | party_alias | ✅ | ✅ |  |
| party_registry | party_judge_appearance | ✅ | ❌ | Excluded from MVM |
| party_registry | party_practice_conflict | ✅ | ❌ | Excluded from MVM |
| party_registry | relationship_map | ✅ | ❌ | Excluded from MVM |
| screening_operations | audit_log | ✅ | ❌ | Excluded from MVM |
| screening_operations | audit_session | ✅ | ❌ | Excluded from MVM |
| screening_operations | check | ✅ | ✅ |  |
| screening_operations | clearance | ✅ | ✅ |  |
| screening_operations | lateral_screening | ✅ | ❌ | Excluded from MVM |
| screening_operations | search_execution | ✅ | ✅ |  |
| screening_operations | search_hit | ✅ | ✅ |  |

<a id="domain-contract"></a>
### contract

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agreement_lifecycle | agreement_type | ✅ | ✅ |  |
| agreement_lifecycle | amendment | ✅ | ✅ |  |
| agreement_lifecycle | contract_agreement | ✅ | ❌ | Excluded from MVM |
| agreement_lifecycle | contract_party | ✅ | ✅ |  |
| agreement_lifecycle | execution_record | ✅ | ✅ |  |
| agreement_lifecycle | milestone | ✅ | ✅ |  |
| agreement_lifecycle | negotiation_round | ✅ | ❌ | Excluded from MVM |
| agreement_lifecycle | obligation | ✅ | ✅ |  |
| agreement_lifecycle | obligation_event | ✅ | ✅ |  |
| agreement_lifecycle | renewal | ✅ | ✅ |  |
| agreement_lifecycle | template | ✅ | ✅ |  |
| agreement_lifecycle | termination | ✅ | ✅ |  |
| agreement_management | agreement | ❌ | ✅ | MVM only (stub or new) |
| agreement_management | template_clause_assignment | ❌ | ✅ | MVM only (stub or new) |
| knowledge_management | afa_arrangement | ✅ | ❌ | Excluded from MVM |
| knowledge_management | agreement_type_clause_policy | ✅ | ❌ | Excluded from MVM |
| knowledge_management | clause_deviation | ✅ | ❌ | Excluded from MVM |
| knowledge_management | clause_library | ✅ | ✅ |  |
| knowledge_management | template_clause | ✅ | ❌ | Excluded from MVM |

<a id="domain-court"></a>
### court

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| court_core | adr_proceeding | ✅ | ❌ | Domain not in MVM |
| court_core | arbitral_award | ✅ | ❌ | Domain not in MVM |
| court_core | service_of_process | ✅ | ❌ | Domain not in MVM |

<a id="domain-document"></a>
### document

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| content_management | doc_access_event | ✅ | ❌ | Excluded from MVM |
| content_management | doc_folder | ✅ | ✅ |  |
| content_management | doc_relationship | ✅ | ❌ | Excluded from MVM |
| content_management | doc_template | ✅ | ✅ |  |
| content_management | doc_type | ✅ | ✅ |  |
| content_management | doc_version | ✅ | ✅ |  |
| content_management | legal_document | ✅ | ✅ |  |
| content_management | retention_schedule | ✅ | ✅ |  |
| content_management | template_clause_usage | ✅ | ❌ | Excluded from MVM |
| content_management | workspace | ✅ | ❌ | Excluded from MVM |
| discovery_review | custodian_hold | ✅ | ❌ | Excluded from MVM |
| discovery_review | doc_annotation | ✅ | ❌ | Excluded from MVM |
| discovery_review | doc_production | ✅ | ✅ |  |
| discovery_review | doc_review_assignment | ✅ | ✅ |  |
| discovery_review | esi_collection | ✅ | ✅ |  |
| discovery_review | esi_custodian | ✅ | ✅ |  |
| discovery_review | family_group | ✅ | ❌ | Excluded from MVM |
| discovery_review | legal_hold | ✅ | ✅ |  |
| discovery_review | privilege_log | ✅ | ✅ |  |
| discovery_review | processing_batch | ✅ | ❌ | Excluded from MVM |
| discovery_review | production_batch | ✅ | ❌ | Excluded from MVM |
| discovery_review | production_set | ✅ | ✅ |  |
| discovery_review | production_source | ✅ | ❌ | Excluded from MVM |
| discovery_review | production_specification | ✅ | ❌ | Excluded from MVM |
| discovery_review | review_batch | ✅ | ❌ | Excluded from MVM |
| discovery_review | review_project | ✅ | ❌ | Excluded from MVM |
| discovery_review | review_protocol | ✅ | ❌ | Excluded from MVM |
| discovery_review | review_session | ✅ | ❌ | Excluded from MVM |
| discovery_review | review_set | ✅ | ❌ | Excluded from MVM |
| discovery_review | tar_model | ✅ | ❌ | Excluded from MVM |
| execution_workflow | doc_execution | ✅ | ✅ |  |
| execution_workflow | execution_workflow | ✅ | ❌ | Excluded from MVM |

<a id="domain-intake"></a>
### intake

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| client_acquisition | engagement_opportunity | ✅ | ✅ |  |
| client_acquisition | panel_appointment | ✅ | ❌ | Excluded from MVM |
| client_acquisition | pitch | ✅ | ✅ |  |
| client_acquisition | prospect | ✅ | ✅ |  |
| client_acquisition | referral_source | ✅ | ✅ |  |
| client_acquisition | rfp_submission | ✅ | ✅ |  |
| engagement_setup | client_onboarding_task | ✅ | ❌ | Excluded from MVM |
| engagement_setup | intake_engagement_scope | ✅ | ❌ | Excluded from MVM |
| engagement_setup | intake_fee_arrangement | ✅ | ❌ | Excluded from MVM |
| engagement_setup | intake_party | ✅ | ✅ |  |
| engagement_setup | letter_of_engagement | ✅ | ✅ |  |
| engagement_setup | matter_opening_request | ✅ | ✅ |  |
| engagement_setup | origination_credit | ✅ | ✅ |  |
| engagement_setup | request | ✅ | ✅ |  |
| risk_screening | conflict_hit | ✅ | ❌ | Excluded from MVM |
| risk_screening | conflict_search | ✅ | ✅ |  |
| risk_screening | kyc_screening | ✅ | ✅ |  |
| risk_screening | opportunity_risk_assessment | ✅ | ❌ | Excluded from MVM |
| risk_screening | risk_action | ✅ | ❌ | Excluded from MVM |

<a id="domain-ip"></a>
### ip

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_registry | asset | ❌ | ✅ | MVM only (stub or new) |
| asset_registry | copyright | ✅ | ✅ |  |
| asset_registry | inventor | ✅ | ✅ |  |
| asset_registry | ip_asset | ✅ | ❌ | Excluded from MVM |
| asset_registry | ownership | ✅ | ✅ |  |
| asset_registry | patent | ✅ | ✅ |  |
| asset_registry | patent_family | ✅ | ✅ |  |
| asset_registry | trade_secret | ✅ | ❌ | Excluded from MVM |
| asset_registry | trademark | ✅ | ✅ |  |
| commercial_licensing | ip_agreement | ✅ | ❌ | Excluded from MVM |
| commercial_licensing | ip_payment | ✅ | ✅ |  |
| commercial_licensing | license_agreement | ✅ | ✅ |  |
| commercial_licensing | royalty_payment | ✅ | ✅ |  |
| commercial_licensing | royalty_report | ✅ | ❌ | Excluded from MVM |
| commercial_licensing | valuation | ✅ | ❌ | Excluded from MVM |
| prosecution_management | asset_contact_assignment | ✅ | ❌ | Excluded from MVM |
| prosecution_management | asset_precedent_usage | ✅ | ❌ | Excluded from MVM |
| prosecution_management | docket_deadline | ✅ | ✅ |  |
| prosecution_management | enforcement_action | ✅ | ❌ | Excluded from MVM |
| prosecution_management | opposition_proceeding | ✅ | ❌ | Excluded from MVM |
| prosecution_management | patent_prosecution_assignment | ✅ | ❌ | Excluded from MVM |
| prosecution_management | prosecution_event | ✅ | ✅ |  |

<a id="domain-knowledge"></a>
### knowledge

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| activity_tracking | asset_usage | ✅ | ❌ | Domain not in MVM |
| activity_tracking | contribution | ✅ | ❌ | Domain not in MVM |
| activity_tracking | control_mapping | ✅ | ❌ | Domain not in MVM |
| activity_tracking | impact_assessment | ✅ | ❌ | Domain not in MVM |
| activity_tracking | legal_update | ✅ | ❌ | Domain not in MVM |
| activity_tracking | precedent_impact_assessment | ✅ | ❌ | Domain not in MVM |
| activity_tracking | precedent_risk_mitigation | ✅ | ❌ | Domain not in MVM |
| activity_tracking | precedent_update | ✅ | ❌ | Domain not in MVM |
| activity_tracking | research_request | ✅ | ❌ | Domain not in MVM |
| content_repository | checklist | ✅ | ❌ | Domain not in MVM |
| content_repository | clause | ✅ | ❌ | Domain not in MVM |
| content_repository | expertise_directory | ✅ | ❌ | Domain not in MVM |
| content_repository | external_source | ✅ | ❌ | Domain not in MVM |
| content_repository | form_template | ✅ | ❌ | Domain not in MVM |
| content_repository | knowledge_asset | ✅ | ❌ | Domain not in MVM |
| content_repository | practice_note | ✅ | ❌ | Domain not in MVM |
| content_repository | precedent | ✅ | ❌ | Domain not in MVM |
| content_repository | research_memo | ✅ | ❌ | Domain not in MVM |
| content_repository | taxonomy | ✅ | ❌ | Domain not in MVM |

<a id="domain-matter"></a>
### matter

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| case_management | assignment | ✅ | ✅ |  |
| case_management | budget | ✅ | ✅ |  |
| case_management | counsel | ✅ | ❌ | Excluded from MVM |
| case_management | deadline | ✅ | ✅ |  |
| case_management | event | ✅ | ❌ | Excluded from MVM |
| case_management | hold | ✅ | ✅ |  |
| case_management | hold_custodian | ✅ | ❌ | Excluded from MVM |
| case_management | jurisdiction_practice_coverage | ✅ | ❌ | Excluded from MVM |
| case_management | lateral_conflict | ✅ | ❌ | Excluded from MVM |
| case_management | matter | ✅ | ✅ |  |
| case_management | matter_contact | ✅ | ❌ | Excluded from MVM |
| case_management | matter_control | ✅ | ❌ | Excluded from MVM |
| case_management | matter_disbursement | ✅ | ❌ | Excluded from MVM |
| case_management | matter_party | ✅ | ✅ |  |
| case_management | matter_risk | ✅ | ❌ | Excluded from MVM |
| case_management | matter_status_history | ✅ | ❌ | Excluded from MVM |
| case_management | outcome | ✅ | ✅ |  |
| case_management | phase | ✅ | ✅ |  |
| case_management | rate | ✅ | ❌ | Excluded from MVM |
| case_management | risk_assessment | ✅ | ❌ | Excluded from MVM |
| case_management | task | ✅ | ✅ |  |
| case_management | team | ✅ | ✅ |  |
| litigation_proceedings | appeal | ✅ | ❌ | Excluded from MVM |
| litigation_proceedings | appearance | ✅ | ✅ |  |
| litigation_proceedings | assertion | ✅ | ❌ | Excluded from MVM |
| litigation_proceedings | court_filing | ✅ | ❌ | Excluded from MVM |
| litigation_proceedings | court_rule | ✅ | ✅ |  |
| litigation_proceedings | docket | ✅ | ✅ |  |
| litigation_proceedings | filing | ✅ | ✅ |  |
| litigation_proceedings | hearing | ✅ | ✅ |  |
| litigation_proceedings | judge | ✅ | ✅ |  |
| litigation_proceedings | judgment | ✅ | ✅ |  |
| litigation_proceedings | jurisdiction | ✅ | ✅ |  |
| litigation_proceedings | matter_deadline | ✅ | ❌ | Excluded from MVM |
| litigation_proceedings | order | ✅ | ✅ |  |
| litigation_proceedings | tribunal | ✅ | ✅ |  |

<a id="domain-risk"></a>
### risk

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_screening | matter_risk_profile | ✅ | ✅ |  |
| compliance_screening | reputational_risk | ✅ | ❌ | Excluded from MVM |
| compliance_screening | sanctions_screening | ✅ | ❌ | Excluded from MVM |
| compliance_screening | third_party_risk | ✅ | ❌ | Excluded from MVM |
| incident_management | cyber_risk_event | ✅ | ❌ | Excluded from MVM |
| incident_management | data_breach_incident | ✅ | ✅ |  |
| professional_indemnity | indemnity_exposure | ✅ | ✅ |  |
| professional_indemnity | pi_claim | ✅ | ✅ |  |
| risk_governance | appetite | ✅ | ❌ | Excluded from MVM |
| risk_governance | assessment | ✅ | ✅ |  |
| risk_governance | category | ✅ | ✅ |  |
| risk_governance | escalation | ✅ | ❌ | Excluded from MVM |
| risk_governance | mitigation_action | ✅ | ✅ |  |
| risk_governance | register | ✅ | ✅ |  |
| risk_governance | risk_control | ✅ | ✅ |  |

<a id="domain-service"></a>
### service

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| commercial_terms | eligibility_rule | ✅ | ✅ |  |
| commercial_terms | pricing_model | ✅ | ✅ |  |
| commercial_terms | rate_card | ✅ | ✅ |  |
| commercial_terms | sla_template | ✅ | ✅ |  |
| engagement_execution | lpm_template | ✅ | ✅ |  |
| engagement_execution | matter_service_mapping | ✅ | ❌ | Excluded from MVM |
| engagement_execution | scope_amendment | ✅ | ❌ | Excluded from MVM |
| offering_catalog | delivery_configuration | ✅ | ❌ | Excluded from MVM |
| offering_catalog | delivery_model | ✅ | ✅ |  |
| offering_catalog | jurisdiction_coverage | ✅ | ✅ |  |
| offering_catalog | legal_service | ✅ | ✅ |  |
| offering_catalog | line | ✅ | ✅ |  |
| offering_catalog | offering_version | ✅ | ❌ | Excluded from MVM |
| offering_catalog | office | ✅ | ❌ | Excluded from MVM |
| offering_catalog | package | ✅ | ✅ |  |
| offering_catalog | practice_area | ✅ | ✅ |  |
| offering_catalog | practice_area_delivery_configuration | ✅ | ❌ | Excluded from MVM |
| offering_catalog | tier | ✅ | ✅ |  |
| service_catalog | package_service_inclusion | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-trust"></a>
### trust

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | account | ✅ | ✅ |  |
| account_management | client_trust_balance | ✅ | ✅ |  |
| account_management | ledger_entry | ✅ | ✅ |  |
| client_arrangements | escrow_arrangement | ✅ | ✅ |  |
| client_arrangements | escrow_release | ✅ | ❌ | Excluded from MVM |
| client_arrangements | retainer_agreement | ✅ | ✅ |  |
| client_arrangements | retainer_replenishment | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | account_audit | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | bank_statement | ✅ | ✅ |  |
| compliance_oversight | bank_statement_line | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | iolta_interest_remittance | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | reconciliation_item | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | reconciliation_period | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | regulatory_report | ✅ | ✅ |  |
| compliance_oversight | three_way_reconciliation | ✅ | ✅ |  |
| compliance_oversight | trust_control_test | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | trust_exception | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | unclaimed_funds_record | ✅ | ❌ | Excluded from MVM |
| transaction_processing | disbursement_authorization | ✅ | ✅ |  |
| transaction_processing | receipt | ✅ | ✅ |  |
| transaction_processing | transfer | ✅ | ✅ |  |
| transaction_processing | trust_disbursement | ✅ | ✅ |  |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| engagement_operations | matter_assignment | ✅ | ❌ | Domain not in MVM |
| engagement_operations | rfp_team_assignment | ✅ | ❌ | Domain not in MVM |
| engagement_operations | secondment | ✅ | ❌ | Domain not in MVM |
| professional_identity | attorney_profile | ✅ | ❌ | Domain not in MVM |
| professional_identity | bar_admission | ✅ | ❌ | Domain not in MVM |
| professional_identity | billing_rate | ✅ | ❌ | Domain not in MVM |
| professional_identity | cle_completion | ✅ | ❌ | Domain not in MVM |
| professional_identity | cle_requirement | ✅ | ❌ | Domain not in MVM |
| professional_identity | diversity_record | ✅ | ❌ | Domain not in MVM |
| professional_identity | practice_group | ✅ | ❌ | Domain not in MVM |
| professional_identity | timekeeper | ✅ | ❌ | Domain not in MVM |
| reference_data | department | ✅ | ❌ | Domain not in MVM |
| reference_data | employee | ✅ | ❌ | Domain not in MVM |
| reference_data | learning_item | ✅ | ❌ | Domain not in MVM |
| reference_data | office | ✅ | ❌ | Domain not in MVM |
| reference_data | user | ✅ | ❌ | Domain not in MVM |
| talent_management | calibration_session | ✅ | ❌ | Domain not in MVM |
| talent_management | compensation_plan | ✅ | ❌ | Domain not in MVM |
| talent_management | compensation_record | ✅ | ❌ | Domain not in MVM |
| talent_management | disciplinary_record | ✅ | ❌ | Domain not in MVM |
| talent_management | lateral_candidate | ✅ | ❌ | Domain not in MVM |
| talent_management | leave_record | ✅ | ❌ | Domain not in MVM |
| talent_management | performance_review | ✅ | ❌ | Domain not in MVM |
| talent_management | rating_scale | ✅ | ❌ | Domain not in MVM |
| talent_management | recruitment_requisition | ✅ | ❌ | Domain not in MVM |
| talent_management | review_cycle | ✅ | ❌ | Domain not in MVM |
| talent_management | succession_plan | ✅ | ❌ | Domain not in MVM |
