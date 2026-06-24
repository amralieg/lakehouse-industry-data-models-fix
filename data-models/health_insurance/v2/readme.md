# Health_Insurance Lakehouse Data Models

**Version 2** | Generated on June 23, 2026 at 01:34 AM

**Industry:** 

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v2_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v2_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Appeal](#domain-appeal)
  - [Billing](#domain-billing)
  - [Care](#domain-care)
  - [Claim](#domain-claim)
  - [Compliance](#domain-compliance)
  - [Contract](#domain-contract)
  - [Credential](#domain-credential)
  - [Employer](#domain-employer)
  - [Enrollment](#domain-enrollment)
  - [Finance](#domain-finance)
  - [Member](#domain-member)
  - [Network](#domain-network)
  - [Pharmacy](#domain-pharmacy)
  - [Plan](#domain-plan)
  - [Provider](#domain-provider)
  - [Risk](#domain-risk)
  - [Utilization](#domain-utilization)
  - [Vendor](#domain-vendor)
  - [Workforce](#domain-workforce)


## Business Description

health insurance industry enterprise data model.

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
| Domains | 12 | 19 |
| Subdomains | 27 | 76 |
| Products (Tables) | 113 | 411 |
| Attributes (Columns) | 3908 | 13420 |
| Foreign Keys | 530 | 1379 |
| Avg Attributes/Product | 34.6 | 32.7 |

## Domain & Product Comparison

<a id="domain-appeal"></a>
### appeal

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| case_management | adverse_determination | ✅ | ✅ |  |
| case_management | appeal_grievance | ✅ | ❌ | Excluded from MVM |
| case_management | case | ✅ | ✅ |  |
| case_management | coverage_dispute | ✅ | ❌ | Excluded from MVM |
| case_management | grievance | ❌ | ✅ | MVM only (stub or new) |
| case_management | outcome | ✅ | ✅ |  |
| case_management | penalty | ✅ | ❌ | Excluded from MVM |
| evidence_documentation | appeal_communication | ✅ | ❌ | Excluded from MVM |
| evidence_documentation | appeal_document | ✅ | ❌ | Excluded from MVM |
| evidence_documentation | evidence | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | appeal_regulatory_filing | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | timeline | ✅ | ❌ | Excluded from MVM |
| review_process | expedited_review | ✅ | ✅ |  |
| review_process | external_review | ✅ | ✅ |  |
| review_process | iro_organization | ✅ | ❌ | Excluded from MVM |
| review_process | review | ✅ | ✅ |  |
| review_processing | document | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_collections | account | ✅ | ✅ |  |
| account_collections | billing_dispute | ✅ | ❌ | Excluded from MVM |
| account_collections | cobra_billing | ✅ | ❌ | Excluded from MVM |
| account_collections | collection_case | ✅ | ❌ | Excluded from MVM |
| account_collections | grace_period | ✅ | ✅ |  |
| account_collections | retro_adjustment | ✅ | ❌ | Excluded from MVM |
| invoice_management | billing_calendar | ✅ | ❌ | Excluded from MVM |
| invoice_management | cycle | ✅ | ❌ | Excluded from MVM |
| invoice_management | invoice_line | ✅ | ✅ |  |
| invoice_management | premium_invoice | ✅ | ✅ |  |
| invoice_management | premium_rate | ✅ | ❌ | Excluded from MVM |
| invoice_management | premium_statement | ✅ | ❌ | Excluded from MVM |
| invoice_management | rate_schedule | ✅ | ❌ | Excluded from MVM |
| payment_processing | edi_820 | ✅ | ❌ | Excluded from MVM |
| payment_processing | payment_allocation | ✅ | ✅ |  |
| payment_processing | payment_method | ✅ | ✅ |  |
| payment_processing | premium_payment | ✅ | ✅ |  |
| payment_processing | premium_refund | ✅ | ❌ | Excluded from MVM |
| payment_processing | suspense_account | ✅ | ❌ | Excluded from MVM |
| subsidy_reconciliation | aptc_subsidy | ✅ | ✅ |  |
| subsidy_reconciliation | billing_payer | ✅ | ❌ | Excluded from MVM |
| subsidy_reconciliation | cms_remittance | ✅ | ✅ |  |
| subsidy_reconciliation | mlr_rebate | ✅ | ❌ | Excluded from MVM |
| subsidy_reconciliation | premium_reconciliation | ✅ | ❌ | Excluded from MVM |

<a id="domain-care"></a>
### care

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| clinical_coordination | care_coordinator_assignment | ✅ | ❌ | Excluded from MVM |
| clinical_coordination | care_plan | ✅ | ✅ |  |
| clinical_coordination | coordinator | ✅ | ✅ |  |
| clinical_coordination | coordinator_assignment | ✅ | ❌ | Excluded from MVM |
| clinical_coordination | dme_coordination | ✅ | ❌ | Excluded from MVM |
| clinical_coordination | plan_goal | ✅ | ✅ |  |
| clinical_coordination | snf_stay | ✅ | ❌ | Excluded from MVM |
| clinical_coordination | team | ✅ | ❌ | Excluded from MVM |
| clinical_coordination | transition | ✅ | ❌ | Excluded from MVM |
| member_engagement | barrier | ✅ | ❌ | Excluded from MVM |
| member_engagement | hra | ✅ | ❌ | Excluded from MVM |
| member_engagement | member_outreach | ✅ | ❌ | Excluded from MVM |
| member_engagement | question_set | ✅ | ❌ | Excluded from MVM |
| member_engagement | questionnaire | ✅ | ❌ | Excluded from MVM |
| member_engagement | sdoh_assessment | ✅ | ❌ | Excluded from MVM |
| population_health | condition_registry | ✅ | ✅ |  |
| population_health | member_risk_tier | ✅ | ✅ |  |
| population_health | population_segment | ✅ | ❌ | Excluded from MVM |
| program_management | care_enrollment | ✅ | ✅ |  |
| program_management | program | ✅ | ✅ |  |
| program_management | program_accreditation | ✅ | ❌ | Excluded from MVM |
| program_management | program_enrollment | ✅ | ❌ | Excluded from MVM |
| program_management | program_obligation_mapping | ✅ | ❌ | Excluded from MVM |
| quality_outcomes | cahps_survey | ✅ | ❌ | Excluded from MVM |
| quality_outcomes | gap | ✅ | ✅ |  |
| quality_outcomes | gap_obligation | ✅ | ❌ | Excluded from MVM |
| quality_outcomes | hedis_measure | ✅ | ✅ |  |
| quality_outcomes | hedis_result | ✅ | ✅ |  |
| quality_outcomes | measure_obligation_mapping | ✅ | ❌ | Excluded from MVM |
| quality_outcomes | star_rating_result | ✅ | ❌ | Excluded from MVM |

<a id="domain-claim"></a>
### claim

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| adjudication_processing | accumulator | ✅ | ✅ |  |
| adjudication_processing | adjudication | ✅ | ✅ |  |
| adjudication_processing | adjudication_rate | ✅ | ❌ | Excluded from MVM |
| adjudication_processing | denial | ✅ | ✅ |  |
| adjudication_processing | drg | ✅ | ✅ |  |
| adjudication_processing | eob | ✅ | ✅ |  |
| claim_intake | attachment | ✅ | ❌ | Excluded from MVM |
| claim_intake | diagnosis | ✅ | ✅ |  |
| claim_intake | header | ✅ | ✅ |  |
| claim_intake | line | ✅ | ✅ |  |
| claim_intake | procedure | ✅ | ✅ |  |
| claim_intake | status_event | ✅ | ❌ | Excluded from MVM |
| payment_recovery | adjustment | ✅ | ✅ |  |
| payment_recovery | claim_payer | ✅ | ❌ | Excluded from MVM |
| payment_recovery | cob | ✅ | ✅ |  |
| payment_recovery | ibnr | ✅ | ❌ | Excluded from MVM |
| payment_recovery | payment | ✅ | ✅ |  |
| payment_recovery | subrogation | ✅ | ❌ | Excluded from MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_management | audit_engagement | ✅ | ❌ | Domain not in MVM |
| audit_management | audit_finding | ✅ | ❌ | Domain not in MVM |
| audit_management | cap_milestone | ✅ | ❌ | Domain not in MVM |
| audit_management | corrective_action_plan | ✅ | ❌ | Domain not in MVM |
| fraud_integrity | fwa_case | ✅ | ❌ | Domain not in MVM |
| fraud_integrity | fwa_referral | ✅ | ❌ | Domain not in MVM |
| fraud_integrity | state_fair_hearing | ✅ | ❌ | Domain not in MVM |
| policy_governance | attestation | ✅ | ❌ | Domain not in MVM |
| policy_governance | employee_screening | ✅ | ❌ | Domain not in MVM |
| policy_governance | policy_document | ✅ | ❌ | Domain not in MVM |
| policy_governance | policy_review | ✅ | ❌ | Domain not in MVM |
| policy_governance | training_completion | ✅ | ❌ | Domain not in MVM |
| policy_governance | training_program | ✅ | ❌ | Domain not in MVM |
| privacy_protection | baa | ✅ | ❌ | Domain not in MVM |
| privacy_protection | breach_incident | ✅ | ❌ | Domain not in MVM |
| privacy_protection | breach_notification | ✅ | ❌ | Domain not in MVM |
| privacy_protection | breach_report | ✅ | ❌ | Domain not in MVM |
| privacy_protection | hipaa_privacy_request | ✅ | ❌ | Domain not in MVM |
| privacy_protection | phi_disclosure_log | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | accreditation_program | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | accreditation_survey | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | erisa_filing | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | mlr_calculation | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | regulatory_change | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | regulatory_submission | ✅ | ❌ | Domain not in MVM |

<a id="domain-contract"></a>
### contract

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | contract | ✅ | ❌ | Excluded from MVM |
| agreement_parties | amendment | ✅ | ❌ | Excluded from MVM |
| agreement_parties | contract_lifecycle_event | ✅ | ❌ | Excluded from MVM |
| agreement_parties | delegation_agreement | ✅ | ❌ | Excluded from MVM |
| agreement_parties | network_participation | ✅ | ❌ | Excluded from MVM |
| agreement_parties | party | ✅ | ✅ |  |
| agreement_parties | service_scope | ✅ | ❌ | Excluded from MVM |
| agreement_parties | term | ✅ | ✅ |  |
| compliance_oversight | contract_audit | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | contract_dispute | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | financial_summary | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | obligation | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | party_regulatory_obligation_compliance | ✅ | ❌ | Excluded from MVM |
| contract_administration | contract_network_participation | ❌ | ✅ | MVM only (stub or new) |
| reimbursement_structure | capitation_arrangement | ✅ | ✅ |  |
| reimbursement_structure | capitation_payment | ✅ | ✅ |  |
| reimbursement_structure | fee_schedule | ✅ | ✅ |  |
| reimbursement_structure | fee_schedule_rate | ✅ | ✅ |  |
| reimbursement_structure | reimbursement_policy | ✅ | ✅ |  |
| value_performance | bundled_payment_episode | ✅ | ❌ | Excluded from MVM |
| value_performance | incentive_arrangement | ✅ | ❌ | Excluded from MVM |
| value_performance | vbc_contract | ✅ | ✅ |  |
| value_performance | vbc_performance_period | ✅ | ❌ | Excluded from MVM |

<a id="domain-credential"></a>
### credential

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| committee_governance | committee | ✅ | ❌ | Domain not in MVM |
| committee_governance | committee_review | ✅ | ❌ | Domain not in MVM |
| committee_governance | committee_type | ✅ | ❌ | Domain not in MVM |
| committee_governance | decision_document | ✅ | ❌ | Domain not in MVM |
| compliance_verification | contract_link | ✅ | ❌ | Domain not in MVM |
| compliance_verification | credential_attestation | ✅ | ❌ | Domain not in MVM |
| compliance_verification | finding | ✅ | ❌ | Domain not in MVM |
| compliance_verification | obligation_mapping | ✅ | ❌ | Domain not in MVM |
| delegation_oversight | credential_outreach | ✅ | ❌ | Domain not in MVM |
| delegation_oversight | cvo_relationship | ✅ | ❌ | Domain not in MVM |
| delegation_oversight | delegated_entity | ✅ | ❌ | Domain not in MVM |
| delegation_oversight | delegation_audit | ✅ | ❌ | Domain not in MVM |
| provider_credentialing | application | ✅ | ❌ | Domain not in MVM |
| provider_credentialing | credential_appeal | ✅ | ❌ | Domain not in MVM |
| provider_credentialing | credential_document | ✅ | ❌ | Domain not in MVM |
| provider_credentialing | credential_lifecycle_event | ✅ | ❌ | Domain not in MVM |
| provider_credentialing | expedited_credential | ✅ | ❌ | Domain not in MVM |
| provider_credentialing | npdb_query | ✅ | ❌ | Domain not in MVM |
| provider_credentialing | psv_verification | ✅ | ❌ | Domain not in MVM |
| provider_credentialing | record | ✅ | ❌ | Domain not in MVM |
| provider_credentialing | recredential_cycle | ✅ | ❌ | Domain not in MVM |
| provider_credentialing | sanction_screening | ✅ | ❌ | Domain not in MVM |

<a id="domain-employer"></a>
### employer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| broker_relations | broker | ✅ | ❌ | Domain not in MVM |
| broker_relations | broker_agreement | ✅ | ❌ | Domain not in MVM |
| broker_relations | broker_assignment | ✅ | ❌ | Domain not in MVM |
| broker_relations | general_agent | ✅ | ❌ | Domain not in MVM |
| broker_relations | tpa | ✅ | ❌ | Domain not in MVM |
| broker_relations | tpa_arrangement | ✅ | ❌ | Domain not in MVM |
| group_administration | employer_contract | ✅ | ❌ | Domain not in MVM |
| group_administration | erisa_plan_document | ✅ | ❌ | Domain not in MVM |
| group_administration | group | ✅ | ❌ | Domain not in MVM |
| group_administration | group_amendment | ✅ | ❌ | Domain not in MVM |
| group_administration | group_contact | ✅ | ❌ | Domain not in MVM |
| group_administration | group_division | ✅ | ❌ | Domain not in MVM |
| group_administration | group_document | ✅ | ❌ | Domain not in MVM |
| group_administration | group_location | ✅ | ❌ | Domain not in MVM |
| group_administration | regulatory_compliance_record | ✅ | ❌ | Domain not in MVM |
| plan_benefits | cobra_administration | ✅ | ❌ | Domain not in MVM |
| plan_benefits | contribution_strategy | ✅ | ❌ | Domain not in MVM |
| plan_benefits | group_plan_offering | ✅ | ❌ | Domain not in MVM |
| plan_benefits | group_renewal | ✅ | ❌ | Domain not in MVM |
| plan_benefits | open_enrollment_window | ✅ | ❌ | Domain not in MVM |
| plan_benefits | participation_requirement | ✅ | ❌ | Domain not in MVM |
| plan_benefits | wellness_program | ✅ | ❌ | Domain not in MVM |
| underwriting_pricing | aso_fee_schedule | ✅ | ❌ | Domain not in MVM |
| underwriting_pricing | employer_underwriting_case | ✅ | ❌ | Domain not in MVM |
| underwriting_pricing | group_rating_factor | ✅ | ❌ | Domain not in MVM |
| underwriting_pricing | rate_quote | ✅ | ❌ | Domain not in MVM |
| underwriting_pricing | stop_loss_policy | ✅ | ❌ | Domain not in MVM |

<a id="domain-enrollment"></a>
### enrollment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| coverage_continuation | cobra_election | ✅ | ❌ | Excluded from MVM |
| coverage_continuation | exchange_enrollment | ✅ | ❌ | Excluded from MVM |
| coverage_continuation | plan_election | ✅ | ✅ |  |
| eligibility_management | eligibility_span | ❌ | ✅ | MVM only (stub or new) |
| eligibility_management | eligibility_verification | ✅ | ✅ |  |
| eligibility_management | enrollment_eligibility_span | ✅ | ❌ | Excluded from MVM |
| eligibility_management | open_enrollment_period | ✅ | ✅ |  |
| eligibility_management | qualifying_life_event | ✅ | ✅ |  |
| government_reporting | enrollment_cms_submission | ✅ | ❌ | Excluded from MVM |
| government_reporting | medicaid_eligibility | ✅ | ✅ |  |
| government_reporting | medicare_entitlement | ✅ | ✅ |  |
| government_reporting | submission_batch | ✅ | ❌ | Excluded from MVM |
| transaction_processing | edi_transaction | ✅ | ✅ |  |
| transaction_processing | enrollment_batch | ✅ | ❌ | Excluded from MVM |
| transaction_processing | event | ✅ | ❌ | Excluded from MVM |
| transaction_processing | pend_queue | ✅ | ❌ | Excluded from MVM |
| transaction_processing | reconciliation | ✅ | ❌ | Excluded from MVM |
| transaction_processing | transaction | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_treasury | bank_account | ✅ | ❌ | Domain not in MVM |
| asset_treasury | bank_reconciliation | ✅ | ❌ | Domain not in MVM |
| asset_treasury | depreciation_transaction | ✅ | ❌ | Domain not in MVM |
| asset_treasury | fixed_asset | ✅ | ❌ | Domain not in MVM |
| general_ledger | budget | ✅ | ❌ | Domain not in MVM |
| general_ledger | budget_line | ✅ | ❌ | Domain not in MVM |
| general_ledger | cost_center | ✅ | ❌ | Domain not in MVM |
| general_ledger | journal_entry | ✅ | ❌ | Domain not in MVM |
| general_ledger | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| general_ledger | ledger | ✅ | ❌ | Domain not in MVM |
| general_ledger | legal_entity | ✅ | ❌ | Domain not in MVM |
| insurance_reporting | actuarial_reserve | ✅ | ❌ | Domain not in MVM |
| insurance_reporting | finance_regulatory_filing | ✅ | ❌ | Domain not in MVM |
| insurance_reporting | mlr_financial_entry | ✅ | ❌ | Domain not in MVM |
| insurance_reporting | premium_revenue | ✅ | ❌ | Domain not in MVM |
| insurance_reporting | reinsurance_transaction | ✅ | ❌ | Domain not in MVM |
| insurance_reporting | tax_filing | ✅ | ❌ | Domain not in MVM |
| insurance_reporting | vbc_settlement | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_invoice | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ap_payment | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ar_invoice | ✅ | ❌ | Domain not in MVM |
| payables_receivables | ar_receipt | ✅ | ❌ | Domain not in MVM |
| payables_receivables | intercompany_transaction | ✅ | ❌ | Domain not in MVM |

<a id="domain-member"></a>
### member

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| coverage_eligibility | cob_record | ✅ | ✅ |  |
| coverage_eligibility | cobra_continuant | ✅ | ❌ | Excluded from MVM |
| coverage_eligibility | disenrollment | ✅ | ❌ | Excluded from MVM |
| coverage_eligibility | lob_assignment | ✅ | ❌ | Excluded from MVM |
| coverage_eligibility | member_eligibility_span | ✅ | ❌ | Excluded from MVM |
| coverage_eligibility | member_eligibility_span2 | ✅ | ❌ | Excluded from MVM |
| coverage_eligibility | member_enrollment | ✅ | ❌ | Excluded from MVM |
| coverage_eligibility | member_enrollment2 | ✅ | ❌ | Excluded from MVM |
| coverage_eligibility | pcp_assignment | ✅ | ✅ |  |
| coverage_enrollment | eligibility_span2 | ❌ | ✅ | MVM only (stub or new) |
| coverage_enrollment | enrollment2 | ❌ | ✅ | MVM only (stub or new) |
| engagement_communication | id_card | ✅ | ✅ |  |
| engagement_communication | member_communication | ✅ | ❌ | Excluded from MVM |
| engagement_communication | member_grievance | ✅ | ❌ | Excluded from MVM |
| member_identity | address | ❌ | ✅ | MVM only (stub or new) |
| member_identity | assignment_rule | ✅ | ❌ | Excluded from MVM |
| member_identity | authorization_document | ✅ | ❌ | Excluded from MVM |
| member_identity | authorized_representative | ✅ | ❌ | Excluded from MVM |
| member_identity | contact | ❌ | ✅ | MVM only (stub or new) |
| member_identity | dependent | ✅ | ✅ |  |
| member_identity | household | ✅ | ❌ | Excluded from MVM |
| member_identity | identity | ✅ | ✅ |  |
| member_identity | member_address | ✅ | ❌ | Excluded from MVM |
| member_identity | member_contact | ✅ | ❌ | Excluded from MVM |
| member_identity | policy | ✅ | ✅ |  |
| member_identity | subscriber | ✅ | ✅ |  |
| population_segmentation | consent | ✅ | ❌ | Excluded from MVM |
| population_segmentation | member_lifecycle_event | ✅ | ❌ | Excluded from MVM |
| population_segmentation | segment | ✅ | ❌ | Excluded from MVM |

<a id="domain-network"></a>
### network

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| adequacy_compliance | access_standard | ✅ | ❌ | Domain not in MVM |
| adequacy_compliance | access_survey | ✅ | ❌ | Domain not in MVM |
| adequacy_compliance | adequacy_assessment | ✅ | ❌ | Domain not in MVM |
| adequacy_compliance | adequacy_gap | ✅ | ❌ | Domain not in MVM |
| adequacy_compliance | adequacy_standard | ✅ | ❌ | Domain not in MVM |
| adequacy_compliance | exception | ✅ | ❌ | Domain not in MVM |
| adequacy_compliance | filing | ✅ | ❌ | Domain not in MVM |
| directory_verification | network_directory_verification | ✅ | ❌ | Domain not in MVM |
| directory_verification | provider_directory | ✅ | ❌ | Domain not in MVM |
| network_management | change_event | ✅ | ❌ | Domain not in MVM |
| network_management | network_provider | ✅ | ❌ | Domain not in MVM |
| network_management | network_recruitment | ✅ | ❌ | Domain not in MVM |
| network_management | network_service_area | ✅ | ❌ | Domain not in MVM |
| network_management | par_agreement | ✅ | ❌ | Domain not in MVM |
| network_management | plan_association | ✅ | ❌ | Domain not in MVM |
| network_management | provider_network | ✅ | ❌ | Domain not in MVM |
| network_management | termination | ✅ | ❌ | Domain not in MVM |
| network_management | tier | ✅ | ❌ | Domain not in MVM |
| value_based | aco_provider | ✅ | ❌ | Domain not in MVM |
| value_based | vbc_arrangement | ✅ | ❌ | Domain not in MVM |
| value_based | vbc_program | ✅ | ❌ | Domain not in MVM |

<a id="domain-pharmacy"></a>
### pharmacy

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| claim_processing | claim_line | ✅ | ✅ |  |
| claim_processing | part_d_submission | ✅ | ❌ | Excluded from MVM |
| claim_processing | pharmacy_claim | ✅ | ✅ |  |
| clinical_review | dur_alert | ✅ | ❌ | Excluded from MVM |
| clinical_review | mtm_service | ✅ | ❌ | Excluded from MVM |
| clinical_review | prior_authorization | ✅ | ✅ |  |
| clinical_review | specialty_drug_program | ✅ | ❌ | Excluded from MVM |
| drug_management | drug_master | ✅ | ✅ |  |
| drug_management | drug_pricing | ✅ | ✅ |  |
| drug_management | mac_list | ✅ | ❌ | Excluded from MVM |
| formulary_benefits | benefit_accumulator | ✅ | ✅ |  |
| formulary_benefits | formulary | ✅ | ✅ |  |
| formulary_benefits | formulary_drug_tier | ✅ | ✅ |  |
| formulary_benefits | formulary_exception | ✅ | ❌ | Excluded from MVM |
| pharmacy_network | dispensing_pharmacy | ✅ | ✅ |  |
| pharmacy_network | pbm_contract | ✅ | ✅ |  |
| rebate_contracting | drug_rebate | ✅ | ❌ | Excluded from MVM |
| rebate_contracting | pharmacy_contract | ✅ | ❌ | Excluded from MVM |

<a id="domain-plan"></a>
### plan

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| coverage_configuration | provider_contract | ❌ | ✅ | MVM only (stub or new) |
| market_offering | service_area | ❌ | ✅ | MVM only (stub or new) |
| plan_design | benefit | ✅ | ✅ |  |
| plan_design | benefit_package | ✅ | ✅ |  |
| plan_design | cost_share_rule | ✅ | ✅ |  |
| plan_design | health_plan | ✅ | ✅ |  |
| plan_design | hsa_hra_config | ✅ | ❌ | Excluded from MVM |
| plan_design | network_config | ✅ | ✅ |  |
| plan_design | offering | ✅ | ✅ |  |
| plan_design | program_coverage | ✅ | ❌ | Excluded from MVM |
| plan_design | rx_benefit_config | ✅ | ✅ |  |
| plan_design | year | ✅ | ❌ | Excluded from MVM |
| pricing_configuration | crosswalk | ✅ | ❌ | Excluded from MVM |
| pricing_configuration | plan_service_area | ✅ | ❌ | Excluded from MVM |
| pricing_configuration | rate | ✅ | ✅ |  |
| pricing_configuration | status_history | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | plan_amendment | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | plan_provider_contract | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | plan_regulatory_obligation | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | sbc_document | ✅ | ✅ |  |
| regulatory_compliance | submission | ✅ | ❌ | Excluded from MVM |

<a id="domain-provider"></a>
### provider

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_screening | audit_assignment | ✅ | ❌ | Excluded from MVM |
| compliance_screening | exclusion_screening | ✅ | ❌ | Excluded from MVM |
| compliance_screening | sanction | ✅ | ❌ | Excluded from MVM |
| directory_participation | provider | ✅ | ✅ |  |
| directory_verification | directory_entry | ✅ | ✅ |  |
| directory_verification | npi_registry_sync | ✅ | ❌ | Excluded from MVM |
| directory_verification | provider_directory_verification | ✅ | ❌ | Excluded from MVM |
| network_participation | affiliation | ✅ | ❌ | Excluded from MVM |
| network_participation | obligation_compliance | ✅ | ❌ | Excluded from MVM |
| network_participation | participation_status | ✅ | ✅ |  |
| network_participation | provider_network_participation | ✅ | ✅ |  |
| outreach_campaign | outreach_campaign | ✅ | ❌ | Excluded from MVM |
| outreach_campaign | provider_outreach | ✅ | ❌ | Excluded from MVM |
| provider_credentials | privilege | ❌ | ✅ | MVM only (stub or new) |
| provider_identity | dea_registration | ✅ | ❌ | Excluded from MVM |
| provider_identity | facility | ✅ | ✅ |  |
| provider_identity | group_practice | ✅ | ✅ |  |
| provider_identity | license | ✅ | ✅ |  |
| provider_identity | practice_location | ✅ | ✅ |  |
| provider_identity | specialty | ✅ | ✅ |  |

<a id="domain-risk"></a>
### risk

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| actuarial_reserving | actuarial_assumption_set | ✅ | ❌ | Excluded from MVM |
| actuarial_reserving | ibnr_reserve | ✅ | ❌ | Excluded from MVM |
| actuarial_reserving | rate_development | ✅ | ❌ | Excluded from MVM |
| actuarial_reserving | rbc_calculation | ✅ | ❌ | Excluded from MVM |
| actuarial_reserving | risk_underwriting_case | ✅ | ❌ | Excluded from MVM |
| reinsurance_transfer | reinsurance_arrangement | ✅ | ❌ | Excluded from MVM |
| reinsurance_transfer | reinsurance_claim | ✅ | ❌ | Excluded from MVM |
| score_adjustment | adjustment_payment | ✅ | ❌ | Excluded from MVM |
| score_adjustment | hcc_mapping | ✅ | ✅ |  |
| score_adjustment | member_risk_score | ✅ | ✅ |  |
| score_adjustment | pool | ✅ | ❌ | Excluded from MVM |
| score_adjustment | prospective_risk_model | ✅ | ❌ | Excluded from MVM |
| score_adjustment | radv_audit | ✅ | ✅ |  |
| score_adjustment | raps_submission | ✅ | ✅ |  |
| score_adjustment | risk_cms_submission | ✅ | ❌ | Excluded from MVM |
| score_adjustment | score_run | ✅ | ❌ | Excluded from MVM |
| score_management | score_hcc_assignment | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-utilization"></a>
### utilization

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| authorization_management | auth_service_line | ✅ | ✅ |  |
| authorization_management | pa_decision | ✅ | ✅ |  |
| authorization_management | pa_notification | ✅ | ❌ | Excluded from MVM |
| authorization_management | pa_request | ✅ | ✅ |  |
| authorization_management | pa_required_service | ✅ | ❌ | Excluded from MVM |
| authorization_management | peer_to_peer_review | ✅ | ❌ | Excluded from MVM |
| clinical_review | bed_day_review | ✅ | ❌ | Excluded from MVM |
| clinical_review | clinical_criteria | ✅ | ✅ |  |
| clinical_review | concurrent_review | ✅ | ✅ |  |
| clinical_review | medical_policy | ✅ | ✅ |  |
| clinical_review | retrospective_review | ✅ | ❌ | Excluded from MVM |
| clinical_review | tat_compliance_event | ✅ | ❌ | Excluded from MVM |
| episode_tracking | episode_of_care | ✅ | ✅ |  |
| episode_tracking | inpatient_admission | ✅ | ✅ |  |
| program_operations | um_case | ✅ | ✅ |  |
| program_operations | um_delegation | ✅ | ❌ | Excluded from MVM |
| program_operations | um_program | ✅ | ❌ | Excluded from MVM |
| program_operations | um_program_enrollment | ✅ | ❌ | Excluded from MVM |
| program_operations | um_reviewer | ✅ | ❌ | Excluded from MVM |

<a id="domain-vendor"></a>
### vendor

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_management | contract_amendment | ✅ | ❌ | Domain not in MVM |
| contract_management | contract_term | ✅ | ❌ | Domain not in MVM |
| contract_management | rfp | ✅ | ❌ | Domain not in MVM |
| contract_management | rfp_response | ✅ | ❌ | Domain not in MVM |
| contract_management | vendor_contract | ✅ | ❌ | Domain not in MVM |
| contract_management | vendor_document | ✅ | ❌ | Domain not in MVM |
| performance_oversight | incident | ✅ | ❌ | Domain not in MVM |
| performance_oversight | performance | ✅ | ❌ | Domain not in MVM |
| performance_oversight | risk_assessment | ✅ | ❌ | Domain not in MVM |
| performance_oversight | sla_event | ✅ | ❌ | Domain not in MVM |
| performance_oversight | vendor_audit | ✅ | ❌ | Domain not in MVM |
| performance_oversight | vendor_dispute | ✅ | ❌ | Domain not in MVM |
| procurement_spend | goods_receipt | ✅ | ❌ | Domain not in MVM |
| procurement_spend | invoice | ✅ | ❌ | Domain not in MVM |
| procurement_spend | po_line | ✅ | ❌ | Domain not in MVM |
| procurement_spend | purchase_order | ✅ | ❌ | Domain not in MVM |
| procurement_spend | spend | ✅ | ❌ | Domain not in MVM |
| procurement_spend | spend_category | ✅ | ❌ | Domain not in MVM |
| vendor_master | baa_agreement | ✅ | ❌ | Domain not in MVM |
| vendor_master | insurance | ✅ | ❌ | Domain not in MVM |
| vendor_master | onboarding | ✅ | ❌ | Domain not in MVM |
| vendor_master | relationship | ✅ | ❌ | Domain not in MVM |
| vendor_master | vendor | ✅ | ❌ | Domain not in MVM |
| vendor_master | vendor_address | ✅ | ❌ | Domain not in MVM |
| vendor_master | vendor_certification | ✅ | ❌ | Domain not in MVM |
| vendor_master | vendor_contact | ✅ | ❌ | Domain not in MVM |
| vendor_master | vendor_lifecycle_event | ✅ | ❌ | Domain not in MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| access_security | rbac_assignment | ✅ | ❌ | Domain not in MVM |
| access_security | rbac_role | ✅ | ❌ | Domain not in MVM |
| access_security | time_and_attendance | ✅ | ❌ | Domain not in MVM |
| benefits_compliance | background_check | ✅ | ❌ | Domain not in MVM |
| benefits_compliance | compliance_event | ✅ | ❌ | Domain not in MVM |
| benefits_compliance | disciplinary_action | ✅ | ❌ | Domain not in MVM |
| benefits_compliance | employee_benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| benefits_compliance | leave_request | ✅ | ❌ | Domain not in MVM |
| employee_management | employee | ✅ | ❌ | Domain not in MVM |
| employee_management | employment_record | ✅ | ❌ | Domain not in MVM |
| employee_management | job_role | ✅ | ❌ | Domain not in MVM |
| employee_management | org_unit | ✅ | ❌ | Domain not in MVM |
| employee_management | position | ✅ | ❌ | Domain not in MVM |
| payroll_compensation | compensation | ✅ | ❌ | Domain not in MVM |
| payroll_compensation | compensation_plan | ✅ | ❌ | Domain not in MVM |
| payroll_compensation | payroll_cost_allocation | ✅ | ❌ | Domain not in MVM |
| payroll_compensation | payroll_disbursement | ✅ | ❌ | Domain not in MVM |
| payroll_compensation | payroll_run | ✅ | ❌ | Domain not in MVM |
| talent_development | headcount_plan | ✅ | ❌ | Domain not in MVM |
| talent_development | performance_review | ✅ | ❌ | Domain not in MVM |
| talent_development | training_course | ✅ | ❌ | Domain not in MVM |
| talent_development | training_record | ✅ | ❌ | Domain not in MVM |
| talent_development | workforce_certification | ✅ | ❌ | Domain not in MVM |
| talent_development | workforce_recruitment | ✅ | ❌ | Domain not in MVM |
