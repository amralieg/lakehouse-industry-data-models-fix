# Health Insurance Lakehouse Data Models

**Version 1** | Generated on May 03, 2026 at 09:25 PM

**Industry:** health-insurance

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
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

Health Insurance is a critical sector providing medical, dental, and vision coverage to individuals, employers, and government beneficiaries, managing care networks and wellness programs to ensure accessible and affordable healthcare.

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
| Domains | 15 | 19 |
| Subdomains | 44 | 71 |
| Products (Tables) | 189 | 409 |
| Attributes (Columns) | 6803 | 13134 |
| Foreign Keys | 1371 | 1507 |
| Avg Attributes/Product | 36.0 | 32.1 |

## Domain & Product Comparison

<a id="domain-appeal"></a>
### appeal

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| case_management | adverse_determination | ✅ | ✅ |  |
| case_management | appeal_grievance | ✅ | ❌ | Excluded from MVM |
| case_management | case | ✅ | ✅ |  |
| case_management | coverage_dispute | ✅ | ✅ |  |
| case_management | grievance | ❌ | ✅ | MVM only (stub or new) |
| compliance_oversight | appeal_regulatory_filing | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | iro_organization | ✅ | ✅ |  |
| compliance_oversight | penalty | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | timeline | ✅ | ✅ |  |
| correspondence_records | appeal_communication | ✅ | ❌ | Excluded from MVM |
| correspondence_records | appeal_document | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | communication | ❌ | ✅ | MVM only (stub or new) |
| regulatory_compliance | document | ❌ | ✅ | MVM only (stub or new) |
| review_processing | evidence | ✅ | ❌ | Excluded from MVM |
| review_processing | expedited_review | ✅ | ✅ |  |
| review_processing | external_review | ✅ | ✅ |  |
| review_processing | outcome | ✅ | ✅ |  |
| review_processing | review | ✅ | ✅ |  |

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| invoice_management | billing_calendar | ✅ | ❌ | Excluded from MVM |
| invoice_management | billing_dispute | ✅ | ❌ | Excluded from MVM |
| invoice_management | cobra_billing | ✅ | ❌ | Excluded from MVM |
| invoice_management | cycle | ✅ | ✅ |  |
| invoice_management | invoice_line | ✅ | ✅ |  |
| invoice_management | premium_invoice | ✅ | ✅ |  |
| invoice_management | premium_statement | ✅ | ❌ | Excluded from MVM |
| payment_processing | edi_820 | ✅ | ❌ | Excluded from MVM |
| payment_processing | payment_allocation | ✅ | ✅ |  |
| payment_processing | payment_method | ✅ | ✅ |  |
| payment_processing | premium_payment | ✅ | ✅ |  |
| payment_processing | premium_refund | ✅ | ❌ | Excluded from MVM |
| payment_processing | suspense_account | ✅ | ❌ | Excluded from MVM |
| rate_subsidies | aptc_subsidy | ✅ | ✅ |  |
| rate_subsidies | mlr_rebate | ✅ | ❌ | Excluded from MVM |
| rate_subsidies | premium_rate | ✅ | ✅ |  |
| rate_subsidies | rate_schedule | ✅ | ✅ |  |
| reconciliation_collections | account | ✅ | ✅ |  |
| reconciliation_collections | cms_remittance | ✅ | ❌ | Excluded from MVM |
| reconciliation_collections | collection_case | ✅ | ❌ | Excluded from MVM |
| reconciliation_collections | grace_period | ✅ | ✅ |  |
| reconciliation_collections | payer | ✅ | ❌ | Excluded from MVM |
| reconciliation_collections | premium_reconciliation | ✅ | ❌ | Excluded from MVM |
| reconciliation_collections | retro_adjustment | ✅ | ✅ |  |

<a id="domain-care"></a>
### care

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| member_coordination | barrier | ✅ | ❌ | Excluded from MVM |
| member_coordination | care_coordinator_assignment | ✅ | ❌ | Excluded from MVM |
| member_coordination | care_plan | ✅ | ✅ |  |
| member_coordination | coordinator | ✅ | ✅ |  |
| member_coordination | coordinator_assignment | ✅ | ✅ |  |
| member_coordination | dme_coordination | ✅ | ❌ | Excluded from MVM |
| member_coordination | member_outreach | ✅ | ✅ |  |
| member_coordination | plan_goal | ✅ | ✅ |  |
| member_coordination | snf_stay | ✅ | ❌ | Excluded from MVM |
| member_coordination | team | ✅ | ✅ |  |
| member_coordination | transition | ✅ | ❌ | Excluded from MVM |
| population_stratification | condition_registry | ✅ | ✅ |  |
| population_stratification | hra | ✅ | ✅ |  |
| population_stratification | member_risk_tier | ✅ | ✅ |  |
| population_stratification | population_segment | ✅ | ❌ | Excluded from MVM |
| population_stratification | question_set | ✅ | ❌ | Excluded from MVM |
| population_stratification | questionnaire | ✅ | ❌ | Excluded from MVM |
| population_stratification | sdoh_assessment | ✅ | ✅ |  |
| program_administration | care_enrollment | ✅ | ✅ |  |
| program_administration | program | ✅ | ✅ |  |
| program_administration | program_accreditation | ✅ | ❌ | Excluded from MVM |
| program_administration | program_enrollment | ✅ | ❌ | Excluded from MVM |
| program_administration | program_obligation_mapping | ✅ | ❌ | Excluded from MVM |
| program_management | team_enrollment_assignment | ❌ | ✅ | MVM only (stub or new) |
| quality_measurement | cahps_survey | ✅ | ✅ |  |
| quality_measurement | gap | ✅ | ✅ |  |
| quality_measurement | gap_obligation | ✅ | ❌ | Excluded from MVM |
| quality_measurement | hedis_measure | ✅ | ✅ |  |
| quality_measurement | hedis_result | ✅ | ✅ |  |
| quality_measurement | measure_obligation_mapping | ✅ | ❌ | Excluded from MVM |
| quality_measurement | star_rating_result | ✅ | ❌ | Excluded from MVM |

<a id="domain-claim"></a>
### claim

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| adjudication_resolution | adjudication | ✅ | ✅ |  |
| adjudication_resolution | adjudication_rate | ✅ | ❌ | Excluded from MVM |
| adjudication_resolution | adjustment | ✅ | ✅ |  |
| adjudication_resolution | denial | ✅ | ✅ |  |
| adjudication_resolution | eob | ✅ | ✅ |  |
| clinical_coding | attachment | ✅ | ❌ | Excluded from MVM |
| clinical_coding | diagnosis | ✅ | ✅ |  |
| clinical_coding | drg | ✅ | ❌ | Excluded from MVM |
| clinical_coding | procedure | ✅ | ✅ |  |
| financial_recovery | cob | ✅ | ✅ |  |
| financial_recovery | ibnr | ✅ | ❌ | Excluded from MVM |
| financial_recovery | payment | ✅ | ✅ |  |
| financial_recovery | subrogation | ✅ | ❌ | Excluded from MVM |
| submission_processing | accumulator | ✅ | ✅ |  |
| submission_processing | header | ✅ | ✅ |  |
| submission_processing | line | ✅ | ✅ |  |
| submission_processing | payer | ✅ | ✅ | Also in domain(s): billing |
| submission_processing | status_event | ✅ | ❌ | Excluded from MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_remediation | accreditation_program | ✅ | ✅ |  |
| audit_remediation | accreditation_survey | ✅ | ✅ |  |
| audit_remediation | audit_engagement | ✅ | ✅ |  |
| audit_remediation | audit_finding | ✅ | ✅ |  |
| audit_remediation | cap_milestone | ✅ | ✅ |  |
| audit_remediation | corrective_action_plan | ✅ | ✅ |  |
| fraud_prevention | employee_screening | ✅ | ❌ | Excluded from MVM |
| fraud_prevention | fwa_case | ✅ | ✅ |  |
| fraud_prevention | fwa_referral | ✅ | ✅ |  |
| fraud_prevention | policy_document | ✅ | ✅ |  |
| fraud_prevention | policy_review | ✅ | ❌ | Excluded from MVM |
| fraud_prevention | training_completion | ✅ | ❌ | Excluded from MVM |
| fraud_prevention | training_program | ✅ | ❌ | Excluded from MVM |
| privacy_protection | baa | ✅ | ✅ |  |
| privacy_protection | breach_incident | ✅ | ✅ |  |
| privacy_protection | breach_notification | ✅ | ❌ | Excluded from MVM |
| privacy_protection | breach_report | ✅ | ❌ | Excluded from MVM |
| privacy_protection | hipaa_privacy_request | ✅ | ✅ |  |
| privacy_protection | phi_disclosure_log | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | compliance_attestation | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | compliance_regulatory_obligation | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | erisa_filing | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | mlr_calculation | ✅ | ✅ |  |
| regulatory_oversight | regulatory_change | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | regulatory_obligation | ❌ | ✅ | MVM only (stub or new) |
| regulatory_oversight | regulatory_submission | ✅ | ✅ |  |
| regulatory_oversight | state_fair_hearing | ✅ | ❌ | Excluded from MVM |

<a id="domain-contract"></a>
### contract

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agreement_lifecycle | amendment | ✅ | ✅ |  |
| agreement_lifecycle | contract_dispute | ✅ | ❌ | Excluded from MVM |
| agreement_lifecycle | contract_lifecycle_event | ✅ | ❌ | Excluded from MVM |
| agreement_lifecycle | contract_provider_contract | ✅ | ❌ | Excluded from MVM |
| agreement_lifecycle | party | ✅ | ✅ |  |
| agreement_lifecycle | service_scope | ✅ | ✅ |  |
| agreement_lifecycle | term | ✅ | ✅ |  |
| compliance_oversight | contract_audit | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | delegation_agreement | ✅ | ✅ |  |
| compliance_oversight | network_participation | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | obligation | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | party_regulatory_obligation_compliance | ✅ | ❌ | Excluded from MVM |
| contract_administration | contract_network_participation | ❌ | ✅ | MVM only (stub or new) |
| contract_administration | provider_contract | ❌ | ✅ | MVM only (stub or new) |
| performance_incentives | bundled_payment_episode | ✅ | ❌ | Excluded from MVM |
| performance_incentives | incentive_arrangement | ✅ | ✅ |  |
| performance_incentives | vbc_contract | ✅ | ✅ |  |
| performance_incentives | vbc_performance_period | ✅ | ✅ |  |
| reimbursement_pricing | capitation_arrangement | ✅ | ✅ |  |
| reimbursement_pricing | capitation_payment | ✅ | ✅ |  |
| reimbursement_pricing | fee_schedule | ✅ | ✅ |  |
| reimbursement_pricing | fee_schedule_rate | ✅ | ✅ |  |
| reimbursement_pricing | financial_summary | ✅ | ❌ | Excluded from MVM |
| reimbursement_pricing | reimbursement_policy | ✅ | ✅ |  |

<a id="domain-credential"></a>
### credential

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| application_processing | application | ✅ | ❌ | Domain not in MVM |
| application_processing | credential_appeal | ✅ | ❌ | Domain not in MVM |
| application_processing | credential_attestation | ✅ | ❌ | Domain not in MVM |
| application_processing | credential_lifecycle_event | ✅ | ❌ | Domain not in MVM |
| application_processing | credential_outreach | ✅ | ❌ | Domain not in MVM |
| application_processing | expedited_credential | ✅ | ❌ | Domain not in MVM |
| application_processing | record | ✅ | ❌ | Domain not in MVM |
| application_processing | recredential_cycle | ✅ | ❌ | Domain not in MVM |
| committee_governance | committee | ✅ | ❌ | Domain not in MVM |
| committee_governance | committee_review | ✅ | ❌ | Domain not in MVM |
| committee_governance | committee_type | ✅ | ❌ | Domain not in MVM |
| committee_governance | contract_link | ✅ | ❌ | Domain not in MVM |
| committee_governance | credential_document | ✅ | ❌ | Domain not in MVM |
| committee_governance | decision_document | ✅ | ❌ | Domain not in MVM |
| compliance_screening | finding | ✅ | ❌ | Domain not in MVM |
| compliance_screening | npdb_query | ✅ | ❌ | Domain not in MVM |
| compliance_screening | obligation_mapping | ✅ | ❌ | Domain not in MVM |
| compliance_screening | psv_verification | ✅ | ❌ | Domain not in MVM |
| compliance_screening | sanction_screening | ✅ | ❌ | Domain not in MVM |
| delegation_oversight | cvo_relationship | ✅ | ❌ | Domain not in MVM |
| delegation_oversight | delegated_entity | ✅ | ❌ | Domain not in MVM |
| delegation_oversight | delegation_audit | ✅ | ❌ | Domain not in MVM |

<a id="domain-employer"></a>
### employer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | employer_contract | ✅ | ❌ | Excluded from MVM |
| account_management | group | ✅ | ✅ |  |
| account_management | group_amendment | ✅ | ❌ | Excluded from MVM |
| account_management | group_contact | ✅ | ✅ |  |
| account_management | group_division | ✅ | ✅ |  |
| account_management | group_document | ✅ | ❌ | Excluded from MVM |
| account_management | group_location | ✅ | ✅ |  |
| account_management | regulatory_compliance_record | ✅ | ❌ | Excluded from MVM |
| benefits_enrollment | cobra_administration | ✅ | ❌ | Excluded from MVM |
| benefits_enrollment | contribution_strategy | ✅ | ✅ |  |
| benefits_enrollment | erisa_plan_document | ✅ | ❌ | Excluded from MVM |
| benefits_enrollment | group_plan_offering | ✅ | ✅ |  |
| benefits_enrollment | open_enrollment_window | ✅ | ✅ |  |
| benefits_enrollment | participation_requirement | ✅ | ✅ |  |
| benefits_enrollment | wellness_program | ✅ | ❌ | Excluded from MVM |
| channel_partners | broker | ✅ | ✅ |  |
| channel_partners | broker_agreement | ✅ | ❌ | Excluded from MVM |
| channel_partners | broker_assignment | ✅ | ✅ |  |
| channel_partners | tpa | ✅ | ❌ | Excluded from MVM |
| underwriting_pricing | aso_fee_schedule | ✅ | ❌ | Excluded from MVM |
| underwriting_pricing | employer_underwriting_case | ✅ | ✅ |  |
| underwriting_pricing | group_rating_factor | ✅ | ❌ | Excluded from MVM |
| underwriting_pricing | group_renewal | ✅ | ✅ |  |
| underwriting_pricing | rate_quote | ✅ | ✅ |  |
| underwriting_pricing | stop_loss_policy | ✅ | ❌ | Excluded from MVM |
| underwriting_pricing | tpa_arrangement | ✅ | ✅ |  |

<a id="domain-enrollment"></a>
### enrollment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| coverage_eligibility | cobra_election | ✅ | ✅ |  |
| coverage_eligibility | eligibility_verification | ✅ | ✅ |  |
| coverage_eligibility | enrollment_eligibility_span | ✅ | ✅ |  |
| coverage_eligibility | medicaid_eligibility | ✅ | ✅ |  |
| coverage_eligibility | medicare_entitlement | ✅ | ✅ |  |
| plan_selection | exchange_enrollment | ✅ | ✅ |  |
| plan_selection | open_enrollment_period | ✅ | ✅ |  |
| plan_selection | plan_election | ✅ | ✅ |  |
| plan_selection | qualifying_life_event | ✅ | ✅ |  |
| transaction_processing | edi_transaction | ✅ | ❌ | Excluded from MVM |
| transaction_processing | enrollment_batch | ✅ | ❌ | Excluded from MVM |
| transaction_processing | enrollment_cms_submission | ✅ | ❌ | Excluded from MVM |
| transaction_processing | event | ✅ | ✅ |  |
| transaction_processing | pend_queue | ✅ | ❌ | Excluded from MVM |
| transaction_processing | reconciliation | ✅ | ❌ | Excluded from MVM |
| transaction_processing | submission_batch | ✅ | ❌ | Excluded from MVM |
| transaction_processing | transaction | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_depreciation | depreciation_transaction | ✅ | ❌ | Domain not in MVM |
| asset_depreciation | fixed_asset | ✅ | ❌ | Domain not in MVM |
| budget_planning | actuarial_reserve | ✅ | ❌ | Domain not in MVM |
| budget_planning | budget | ✅ | ❌ | Domain not in MVM |
| budget_planning | budget_line | ✅ | ❌ | Domain not in MVM |
| budget_planning | finance_regulatory_filing | ✅ | ❌ | Domain not in MVM |
| budget_planning | mlr_financial_entry | ✅ | ❌ | Domain not in MVM |
| budget_planning | premium_revenue | ✅ | ❌ | Domain not in MVM |
| budget_planning | tax_filing | ✅ | ❌ | Domain not in MVM |
| general_accounting | cost_center | ✅ | ❌ | Domain not in MVM |
| general_accounting | intercompany_transaction | ✅ | ❌ | Domain not in MVM |
| general_accounting | journal_entry | ✅ | ❌ | Domain not in MVM |
| general_accounting | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| general_accounting | ledger | ✅ | ❌ | Domain not in MVM |
| general_accounting | legal_entity | ✅ | ❌ | Domain not in MVM |
| payable_receivable | ap_invoice | ✅ | ❌ | Domain not in MVM |
| payable_receivable | ap_payment | ✅ | ❌ | Domain not in MVM |
| payable_receivable | ar_invoice | ✅ | ❌ | Domain not in MVM |
| payable_receivable | ar_receipt | ✅ | ❌ | Domain not in MVM |
| payable_receivable | bank_account | ✅ | ❌ | Domain not in MVM |
| payable_receivable | bank_reconciliation | ✅ | ❌ | Domain not in MVM |
| payable_receivable | reinsurance_transaction | ✅ | ❌ | Domain not in MVM |
| payable_receivable | vbc_settlement | ✅ | ❌ | Domain not in MVM |

<a id="domain-member"></a>
### member

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| engagement_compliance | authorization_document | ✅ | ❌ | Excluded from MVM |
| engagement_compliance | authorized_representative | ✅ | ❌ | Excluded from MVM |
| engagement_compliance | consent | ✅ | ✅ |  |
| engagement_compliance | id_card | ✅ | ❌ | Excluded from MVM |
| engagement_compliance | member_communication | ✅ | ❌ | Excluded from MVM |
| engagement_compliance | member_grievance | ✅ | ❌ | Excluded from MVM |
| enrollment_coverage | cobra_continuant | ✅ | ✅ |  |
| enrollment_coverage | disenrollment | ✅ | ✅ |  |
| enrollment_coverage | member_eligibility_span | ✅ | ✅ |  |
| enrollment_coverage | member_enrollment | ✅ | ✅ |  |
| enrollment_coverage | member_lifecycle_event | ✅ | ❌ | Excluded from MVM |
| enrollment_coverage | policy | ✅ | ✅ |  |
| identity_profile | dependent | ✅ | ✅ |  |
| identity_profile | household | ✅ | ❌ | Excluded from MVM |
| identity_profile | identity | ✅ | ✅ |  |
| identity_profile | member_address | ✅ | ❌ | Excluded from MVM |
| identity_profile | member_contact | ✅ | ❌ | Excluded from MVM |
| identity_profile | subscriber | ✅ | ✅ |  |
| member_identity | address | ❌ | ✅ | MVM only (stub or new) |
| member_identity | contact | ❌ | ✅ | MVM only (stub or new) |
| plan_assignment | assignment_rule | ✅ | ❌ | Excluded from MVM |
| plan_assignment | cob_record | ✅ | ✅ |  |
| plan_assignment | lob_assignment | ✅ | ❌ | Excluded from MVM |
| plan_assignment | pcp_assignment | ✅ | ✅ |  |
| plan_assignment | segment | ✅ | ❌ | Excluded from MVM |

<a id="domain-network"></a>
### network

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_adequacy | access_standard | ✅ | ✅ |  |
| compliance_adequacy | access_survey | ✅ | ❌ | Excluded from MVM |
| compliance_adequacy | adequacy_assessment | ✅ | ✅ |  |
| compliance_adequacy | adequacy_gap | ✅ | ✅ |  |
| compliance_adequacy | adequacy_standard | ✅ | ✅ |  |
| compliance_adequacy | exception | ✅ | ✅ |  |
| compliance_adequacy | filing | ✅ | ❌ | Excluded from MVM |
| directory_operations | network_directory_verification | ✅ | ❌ | Excluded from MVM |
| directory_operations | provider_directory | ✅ | ✅ |  |
| network_structure | change_event | ✅ | ❌ | Excluded from MVM |
| network_structure | network_provider | ✅ | ✅ |  |
| network_structure | network_recruitment | ✅ | ❌ | Excluded from MVM |
| network_structure | network_service_area | ✅ | ✅ |  |
| network_structure | par_agreement | ✅ | ✅ |  |
| network_structure | plan_association | ✅ | ✅ |  |
| network_structure | provider_network | ✅ | ✅ |  |
| network_structure | termination | ✅ | ❌ | Excluded from MVM |
| network_structure | tier | ✅ | ✅ |  |
| value_care | aco_provider | ✅ | ❌ | Excluded from MVM |
| value_care | vbc_arrangement | ✅ | ✅ |  |
| value_care | vbc_program | ✅ | ✅ |  |

<a id="domain-pharmacy"></a>
### pharmacy

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| claims_processing | benefit_accumulator | ✅ | ❌ | Excluded from MVM |
| claims_processing | claim_line | ✅ | ✅ |  |
| claims_processing | dur_alert | ✅ | ✅ |  |
| claims_processing | part_d_submission | ✅ | ❌ | Excluded from MVM |
| claims_processing | pharmacy_claim | ✅ | ✅ |  |
| claims_processing | prior_authorization | ✅ | ✅ |  |
| drug_catalog | drug_master | ✅ | ✅ |  |
| drug_catalog | drug_pricing | ✅ | ✅ |  |
| drug_catalog | drug_rebate | ✅ | ❌ | Excluded from MVM |
| drug_catalog | mac_list | ✅ | ❌ | Excluded from MVM |
| formulary_management | formulary | ✅ | ✅ |  |
| formulary_management | formulary_drug_tier | ✅ | ✅ |  |
| formulary_management | formulary_exception | ✅ | ❌ | Excluded from MVM |
| formulary_management | mtm_service | ✅ | ❌ | Excluded from MVM |
| formulary_management | specialty_drug_program | ✅ | ❌ | Excluded from MVM |
| network_contracting | dispensing_pharmacy | ✅ | ✅ |  |
| network_contracting | pbm_contract | ✅ | ✅ |  |
| network_contracting | pharmacy_contract | ✅ | ❌ | Excluded from MVM |

<a id="domain-plan"></a>
### plan

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| lifecycle_operations | crosswalk | ✅ | ❌ | Excluded from MVM |
| lifecycle_operations | offering | ✅ | ✅ |  |
| lifecycle_operations | plan_provider_contract | ✅ | ❌ | Excluded from MVM |
| lifecycle_operations | program_coverage | ✅ | ❌ | Excluded from MVM |
| lifecycle_operations | status_history | ✅ | ❌ | Excluded from MVM |
| product_design | benefit | ✅ | ✅ |  |
| product_design | benefit_package | ✅ | ✅ |  |
| product_design | cost_share_rule | ✅ | ✅ |  |
| product_design | health_plan | ✅ | ✅ |  |
| product_design | hsa_hra_config | ✅ | ✅ |  |
| product_design | network_config | ✅ | ✅ |  |
| product_design | plan_service_area | ✅ | ✅ |  |
| product_design | rate | ✅ | ✅ |  |
| product_design | rx_benefit_config | ✅ | ✅ |  |
| product_design | sbc_document | ✅ | ❌ | Excluded from MVM |
| product_design | year | ✅ | ✅ |  |
| regulatory_compliance | plan_amendment | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | plan_regulatory_obligation | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | submission | ✅ | ❌ | Excluded from MVM |

<a id="domain-provider"></a>
### provider

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| entity_management | affiliation | ✅ | ✅ |  |
| entity_management | dea_registration | ✅ | ✅ |  |
| entity_management | facility | ✅ | ✅ |  |
| entity_management | group_practice | ✅ | ✅ |  |
| entity_management | license | ✅ | ✅ |  |
| entity_management | practice_location | ✅ | ✅ |  |
| entity_management | provider_provider | ✅ | ✅ |  |
| entity_management | specialty | ✅ | ✅ |  |
| network_participation | directory_entry | ✅ | ✅ |  |
| network_participation | participation_status | ✅ | ❌ | Excluded from MVM |
| network_participation | provider_affiliation | ❌ | ✅ | MVM only (stub or new) |
| network_participation | provider_network_participation | ✅ | ✅ |  |
| outreach_operations | outreach_campaign | ✅ | ❌ | Excluded from MVM |
| outreach_operations | provider_outreach | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | audit_assignment | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | exclusion_screening | ✅ | ✅ |  |
| regulatory_compliance | npi_registry_sync | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | obligation_compliance | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | provider_directory_verification | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | sanction | ✅ | ❌ | Excluded from MVM |

<a id="domain-risk"></a>
### risk

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| actuarial_pricing | actuarial_assumption_set | ✅ | ❌ | Excluded from MVM |
| actuarial_pricing | ibnr_reserve | ✅ | ❌ | Excluded from MVM |
| actuarial_pricing | pool | ✅ | ❌ | Excluded from MVM |
| actuarial_pricing | rate_development | ✅ | ❌ | Excluded from MVM |
| actuarial_pricing | rbc_calculation | ✅ | ❌ | Excluded from MVM |
| regulatory_submission | adjustment_payment | ✅ | ❌ | Excluded from MVM |
| regulatory_submission | radv_audit | ✅ | ❌ | Excluded from MVM |
| regulatory_submission | raps_submission | ✅ | ✅ |  |
| regulatory_submission | risk_cms_submission | ✅ | ❌ | Excluded from MVM |
| risk_adjustment | cms_submission | ❌ | ✅ | MVM only (stub or new) |
| risk_adjustment | score_hcc_contribution | ❌ | ✅ | MVM only (stub or new) |
| score_modeling | hcc_mapping | ✅ | ✅ |  |
| score_modeling | member_risk_score | ✅ | ✅ |  |
| score_modeling | prospective_risk_model | ✅ | ❌ | Excluded from MVM |
| score_modeling | score_run | ✅ | ❌ | Excluded from MVM |
| underwriting_protection | reinsurance_arrangement | ✅ | ✅ |  |
| underwriting_protection | reinsurance_claim | ✅ | ✅ |  |
| underwriting_protection | risk_underwriting_case | ✅ | ✅ |  |

<a id="domain-utilization"></a>
### utilization

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| authorization_processing | auth_service_line | ✅ | ✅ |  |
| authorization_processing | pa_decision | ✅ | ✅ |  |
| authorization_processing | pa_notification | ✅ | ❌ | Excluded from MVM |
| authorization_processing | pa_request | ✅ | ✅ |  |
| authorization_processing | pa_required_service | ✅ | ✅ |  |
| clinical_review | bed_day_review | ✅ | ❌ | Excluded from MVM |
| clinical_review | concurrent_review | ✅ | ✅ |  |
| clinical_review | episode_of_care | ✅ | ❌ | Excluded from MVM |
| clinical_review | inpatient_admission | ✅ | ✅ |  |
| clinical_review | peer_to_peer_review | ✅ | ❌ | Excluded from MVM |
| clinical_review | retrospective_review | ✅ | ✅ |  |
| program_operations | reviewer_program_assignment | ❌ | ✅ | MVM only (stub or new) |
| program_oversight | clinical_criteria | ✅ | ✅ |  |
| program_oversight | medical_policy | ✅ | ✅ |  |
| program_oversight | tat_compliance_event | ✅ | ❌ | Excluded from MVM |
| program_oversight | um_case | ✅ | ✅ |  |
| program_oversight | um_delegation | ✅ | ❌ | Excluded from MVM |
| program_oversight | um_program | ✅ | ✅ |  |
| program_oversight | um_program_enrollment | ✅ | ❌ | Excluded from MVM |
| program_oversight | um_reviewer | ✅ | ✅ |  |

<a id="domain-vendor"></a>
### vendor

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_operations | baa_agreement | ✅ | ❌ | Domain not in MVM |
| contract_operations | contract_amendment | ✅ | ❌ | Domain not in MVM |
| contract_operations | contract_term | ✅ | ❌ | Domain not in MVM |
| contract_operations | rfp | ✅ | ❌ | Domain not in MVM |
| contract_operations | rfp_response | ✅ | ❌ | Domain not in MVM |
| contract_operations | vendor_contract | ✅ | ❌ | Domain not in MVM |
| procurement_spend | goods_receipt | ✅ | ❌ | Domain not in MVM |
| procurement_spend | invoice | ✅ | ❌ | Domain not in MVM |
| procurement_spend | po_line | ✅ | ❌ | Domain not in MVM |
| procurement_spend | purchase_order | ✅ | ❌ | Domain not in MVM |
| procurement_spend | spend | ✅ | ❌ | Domain not in MVM |
| procurement_spend | spend_category | ✅ | ❌ | Domain not in MVM |
| procurement_spend | vendor_dispute | ✅ | ❌ | Domain not in MVM |
| risk_compliance | incident | ✅ | ❌ | Domain not in MVM |
| risk_compliance | insurance | ✅ | ❌ | Domain not in MVM |
| risk_compliance | performance | ✅ | ❌ | Domain not in MVM |
| risk_compliance | risk_assessment | ✅ | ❌ | Domain not in MVM |
| risk_compliance | sla_event | ✅ | ❌ | Domain not in MVM |
| risk_compliance | vendor_audit | ✅ | ❌ | Domain not in MVM |
| risk_compliance | vendor_certification | ✅ | ❌ | Domain not in MVM |
| supplier_management | onboarding | ✅ | ❌ | Domain not in MVM |
| supplier_management | relationship | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_address | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_contact | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_document | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_lifecycle_event | ✅ | ❌ | Domain not in MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_governance | background_check | ✅ | ❌ | Domain not in MVM |
| compliance_governance | compliance_event | ✅ | ❌ | Domain not in MVM |
| compliance_governance | disciplinary_action | ✅ | ❌ | Domain not in MVM |
| compliance_governance | rbac_assignment | ✅ | ❌ | Domain not in MVM |
| compliance_governance | rbac_role | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | compensation | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | compensation_plan | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | employee_benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | leave_request | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_cost_allocation | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_disbursement | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_run | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | time_and_attendance | ✅ | ❌ | Domain not in MVM |
| people_administration | employee | ✅ | ❌ | Domain not in MVM |
| people_administration | employment_record | ✅ | ❌ | Domain not in MVM |
| people_administration | headcount_plan | ✅ | ❌ | Domain not in MVM |
| people_administration | job_role | ✅ | ❌ | Domain not in MVM |
| people_administration | org_unit | ✅ | ❌ | Domain not in MVM |
| people_administration | position | ✅ | ❌ | Domain not in MVM |
| people_administration | workforce_recruitment | ✅ | ❌ | Domain not in MVM |
| talent_development | performance_review | ✅ | ❌ | Domain not in MVM |
| talent_development | training_course | ✅ | ❌ | Domain not in MVM |
| talent_development | training_record | ✅ | ❌ | Domain not in MVM |
| talent_development | workforce_certification | ✅ | ❌ | Domain not in MVM |
