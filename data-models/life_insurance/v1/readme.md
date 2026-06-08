# Life Insurance Lakehouse Data Models

**Version 1** | Generated on May 04, 2026 at 07:01 AM

**Industry:** insurance

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Actuarial](#domain-actuarial)
  - [Agent](#domain-agent)
  - [Annuity](#domain-annuity)
  - [Billing](#domain-billing)
  - [Claims](#domain-claims)
  - [Commission](#domain-commission)
  - [Compliance](#domain-compliance)
  - [Correspondence](#domain-correspondence)
  - [Document](#domain-document)
  - [Finance](#domain-finance)
  - [Investment](#domain-investment)
  - [Policy](#domain-policy)
  - [Policyholder](#domain-policyholder)
  - [Product](#domain-product)
  - [Reinsurance](#domain-reinsurance)
  - [Reporting](#domain-reporting)
  - [Underwriting](#domain-underwriting)
  - [Vendor](#domain-vendor)
  - [Workforce](#domain-workforce)


## Business Description

Life and Annuity Insurance is a financial services industry providing life insurance policies, annuities, retirement planning, and wealth protection products to individuals and families, managing long-term risk and investment portfolios.

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
| Subdomains | 43 | 59 |
| Products (Tables) | 217 | 468 |
| Attributes (Columns) | 9579 | 18387 |
| Foreign Keys | 1926 | 2825 |
| Avg Attributes/Product | 44.1 | 39.3 |

## Domain & Product Comparison

<a id="domain-actuarial"></a>
### actuarial

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| assumption_governance | assumption_application | ✅ | ❌ | Excluded from MVM |
| assumption_governance | assumption_data_source | ✅ | ❌ | Excluded from MVM |
| assumption_governance | assumption_detail | ✅ | ✅ |  |
| assumption_governance | assumption_set | ✅ | ✅ |  |
| assumption_governance | model_governance | ✅ | ❌ | Excluded from MVM |
| assumption_governance | mortality_table | ✅ | ✅ |  |
| assumption_governance | pricing_basis | ✅ | ✅ |  |
| experience_analysis | experience_study | ✅ | ✅ |  |
| experience_analysis | experience_study_result | ✅ | ✅ |  |
| experience_analysis | opinion | ✅ | ❌ | Excluded from MVM |
| investment_strategy | alm_position | ✅ | ❌ | Excluded from MVM |
| investment_strategy | alm_strategy | ✅ | ❌ | Excluded from MVM |
| investment_strategy | orsa_stress_test | ✅ | ❌ | Excluded from MVM |
| reserve_management | cash_flow_projection | ✅ | ✅ |  |
| reserve_management | cohort_definition | ✅ | ✅ |  |
| reserve_management | ifrs17_csm | ✅ | ❌ | Excluded from MVM |
| reserve_management | liability_segment | ✅ | ❌ | Excluded from MVM |
| reserve_management | pbr_model_segment | ✅ | ✅ |  |
| reserve_management | reserve_calculation | ✅ | ✅ |  |
| reserve_management | reserve_snapshot | ✅ | ✅ |  |
| reserve_management | scenario_set | ✅ | ✅ |  |
| reserve_management | stochastic_scenario | ✅ | ✅ |  |
| reserve_management | tax_qualification_test | ✅ | ❌ | Excluded from MVM |
| reserve_management | valuation_run | ✅ | ✅ |  |

<a id="domain-agent"></a>
### agent

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| distribution_network | agency | ✅ | ✅ |  |
| distribution_network | agency_producer_affiliation | ✅ | ✅ |  |
| distribution_network | distribution_channel | ✅ | ❌ | Excluded from MVM |
| distribution_network | hierarchy_node | ✅ | ✅ |  |
| operational_workflow | agent_bulk_comm_recipient | ✅ | ❌ | Excluded from MVM |
| operational_workflow | agent_training_completion | ✅ | ❌ | Excluded from MVM |
| operational_workflow | compliance_event | ✅ | ❌ | Excluded from MVM |
| operational_workflow | onboarding_case | ✅ | ✅ |  |
| operational_workflow | producer_training | ✅ | ✅ |  |
| operational_workflow | termination_event | ✅ | ✅ |  |
| producer_management | appointment | ✅ | ✅ |  |
| producer_management | contracting | ✅ | ✅ |  |
| producer_management | eo_policy | ✅ | ❌ | Excluded from MVM |
| producer_management | finra_registration | ✅ | ❌ | Excluded from MVM |
| producer_management | license | ✅ | ✅ |  |
| producer_management | producer | ✅ | ✅ |  |
| producer_management | producer_product_auth | ✅ | ✅ |  |
| producer_management | producer_product_authorization | ✅ | ❌ | Excluded from MVM |
| sales_incentives | incentive_program | ✅ | ❌ | Excluded from MVM |
| sales_incentives | production_activity | ✅ | ✅ |  |
| sales_incentives | program_participation | ✅ | ❌ | Excluded from MVM |

<a id="domain-annuity"></a>
### annuity

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_administration | account_value | ✅ | ✅ |  |
| contract_administration | annuity_contract | ✅ | ❌ | Excluded from MVM |
| contract_administration | benefit_base | ✅ | ✅ |  |
| contract_administration | contract | ❌ | ✅ | MVM only (stub or new) |
| contract_administration | contract_crediting_allocation | ✅ | ❌ | Excluded from MVM |
| contract_administration | contract_remediation | ✅ | ❌ | Excluded from MVM |
| contract_administration | contract_valuation | ✅ | ✅ |  |
| contract_administration | cost_basis_ledger | ✅ | ✅ |  |
| contract_administration | death_benefit_option | ✅ | ❌ | Excluded from MVM |
| contract_administration | rider_benefit | ✅ | ✅ |  |
| contract_administration | rider_election | ✅ | ❌ | Excluded from MVM |
| contract_administration | rmd_schedule | ✅ | ✅ |  |
| investment_management | hedge_position | ✅ | ❌ | Excluded from MVM |
| investment_management | index_credit_event | ✅ | ✅ |  |
| investment_management | index_crediting_strategy | ✅ | ✅ |  |
| investment_management | sub_account_allocation | ✅ | ✅ |  |
| payment_processing | annuitization_election | ✅ | ✅ |  |
| payment_processing | annuity_premium_payment | ✅ | ✅ |  |
| payment_processing | benefit_payment | ✅ | ✅ |  |
| payment_processing | bonus_credit | ✅ | ❌ | Excluded from MVM |
| payment_processing | charge_detail | ✅ | ❌ | Excluded from MVM |
| payment_processing | mva_calculation | ✅ | ❌ | Excluded from MVM |
| payment_processing | payout_schedule | ✅ | ✅ |  |
| payment_processing | surrender_charge | ✅ | ✅ |  |
| payment_processing | systematic_withdrawal_plan | ✅ | ❌ | Excluded from MVM |
| payment_processing | tax_free_exchange | ✅ | ✅ |  |
| payment_processing | withdrawal_transaction | ✅ | ✅ |  |

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| payment_scheduling | account | ✅ | ✅ |  |
| payment_scheduling | billing_premium_payment | ✅ | ✅ |  |
| payment_scheduling | eft_authorization | ✅ | ✅ |  |
| payment_scheduling | list_bill_group | ✅ | ✅ |  |
| payment_scheduling | premium_adjustment | ✅ | ✅ |  |
| payment_scheduling | premium_allocation | ✅ | ✅ |  |
| payment_scheduling | premium_bill | ✅ | ✅ |  |
| payment_scheduling | premium_schedule | ✅ | ✅ |  |
| policy_lifecycle | apl_transaction | ✅ | ✅ |  |
| policy_lifecycle | billing_dispute | ✅ | ❌ | Excluded from MVM |
| policy_lifecycle | billing_reinstatement | ✅ | ✅ |  |
| policy_lifecycle | grace_period | ✅ | ✅ |  |
| policy_lifecycle | lapse_event | ✅ | ✅ |  |
| policy_lifecycle | nsf_event | ✅ | ✅ |  |
| policy_lifecycle | refund_transaction | ✅ | ❌ | Excluded from MVM |
| policy_lifecycle | suspense_account | ✅ | ✅ |  |
| policy_lifecycle | transaction | ✅ | ❌ | Excluded from MVM |

<a id="domain-claims"></a>
### claims

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| claim_processing | adjudication | ✅ | ✅ |  |
| claim_processing | beneficiary_verification | ✅ | ✅ |  |
| claim_processing | claim | ✅ | ✅ |  |
| claim_processing | claim_document | ✅ | ✅ |  |
| claim_processing | claim_status_history | ✅ | ✅ |  |
| claim_processing | claimant | ✅ | ✅ |  |
| claim_processing | contestability_review | ✅ | ✅ |  |
| claim_processing | db_calculation | ✅ | ✅ |  |
| claim_processing | fnol | ✅ | ✅ |  |
| claim_processing | living_benefit_claim | ✅ | ✅ |  |
| dispute_resolution | appeal | ✅ | ✅ |  |
| dispute_resolution | interpleader | ✅ | ❌ | Excluded from MVM |
| dispute_resolution | interpleader_team_assignment | ✅ | ❌ | Excluded from MVM |
| dispute_resolution | subrogation | ✅ | ❌ | Excluded from MVM |
| financial_settlement | claim_payment | ✅ | ✅ |  |
| financial_settlement | claim_reserve | ✅ | ✅ |  |
| financial_settlement | claims_cession | ✅ | ❌ | Excluded from MVM |
| financial_settlement | unclaimed_property | ✅ | ❌ | Excluded from MVM |
| fraud_management | claim_investigation | ✅ | ✅ |  |
| fraud_management | investigation_assignment | ✅ | ❌ | Excluded from MVM |
| fraud_management | siu_referral | ✅ | ❌ | Excluded from MVM |

<a id="domain-commission"></a>
### commission

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agent_services | commission_dispute | ✅ | ❌ | Excluded from MVM |
| agent_services | payee | ✅ | ✅ |  |
| agent_services | run | ✅ | ✅ |  |
| agent_services | split_commission | ✅ | ❌ | Excluded from MVM |
| agent_services | statement | ✅ | ✅ |  |
| agent_services | tax_report | ✅ | ❌ | Excluded from MVM |
| payment_processing | adjustment | ✅ | ✅ |  |
| payment_processing | advance_commission | ✅ | ❌ | Excluded from MVM |
| payment_processing | bonus_payment | ✅ | ✅ |  |
| payment_processing | bonus_qualification | ✅ | ✅ |  |
| payment_processing | chargeback | ✅ | ✅ |  |
| payment_processing | commission_payment | ✅ | ❌ | Excluded from MVM |
| payment_processing | commission_transaction | ✅ | ❌ | Excluded from MVM |
| payment_processing | hold | ✅ | ❌ | Excluded from MVM |
| payment_processing | override_commission | ✅ | ✅ |  |
| payment_processing | payment | ❌ | ✅ | MVM only (stub or new) |
| payment_processing | persistency_credit | ✅ | ❌ | Excluded from MVM |
| payment_processing | service_fee | ✅ | ❌ | Excluded from MVM |
| payment_processing | transaction | ❌ | ✅ | In ECM under domain(s): billing |
| rate_configuration | bonus_program | ✅ | ✅ |  |
| rate_configuration | chargeback_rule | ✅ | ✅ |  |
| rate_configuration | compensation_contract | ✅ | ✅ |  |
| rate_configuration | hierarchy_override_rule | ✅ | ❌ | Excluded from MVM |
| rate_configuration | qualification_period | ✅ | ❌ | Excluded from MVM |
| rate_configuration | rate | ✅ | ✅ |  |
| rate_configuration | schedule | ✅ | ✅ |  |
| rate_configuration | schedule_product_rate | ✅ | ❌ | Excluded from MVM |
| rate_configuration | schedule_regulatory_compliance | ✅ | ❌ | Excluded from MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| internal_controls | attestation | ✅ | ❌ | Excluded from MVM |
| internal_controls | compliance_policy | ✅ | ❌ | Excluded from MVM |
| internal_controls | contract_regulatory_compliance | ✅ | ❌ | Excluded from MVM |
| internal_controls | exception | ✅ | ❌ | Excluded from MVM |
| internal_controls | issue | ✅ | ❌ | Excluded from MVM |
| internal_controls | policy_control_mapping | ✅ | ❌ | Excluded from MVM |
| internal_controls | policy_obligation_coverage | ✅ | ❌ | Excluded from MVM |
| internal_controls | sox_control | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | entity_license | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | erisa_plan_filing | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | exam_finding | ✅ | ✅ |  |
| regulatory_oversight | jurisdiction_license | ✅ | ✅ |  |
| regulatory_oversight | market_conduct_exam | ✅ | ✅ |  |
| regulatory_oversight | orsa_report | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | policy_form_approval | ✅ | ✅ |  |
| regulatory_oversight | rate_filing | ✅ | ✅ |  |
| regulatory_oversight | regulatory_change | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | regulatory_filing | ✅ | ✅ |  |
| regulatory_oversight | regulatory_obligation | ✅ | ✅ |  |
| regulatory_oversight | remediation_plan | ✅ | ✅ |  |
| regulatory_oversight | state_regulation | ✅ | ✅ |  |
| transaction_monitoring | aml_alert | ✅ | ❌ | Excluded from MVM |
| transaction_monitoring | aml_case | ✅ | ✅ |  |
| transaction_monitoring | privacy_incident | ✅ | ✅ |  |
| transaction_monitoring | sar_filing | ✅ | ✅ |  |
| transaction_monitoring | suitability_review | ✅ | ✅ |  |
| workforce_education | compliance_training_completion | ✅ | ❌ | Excluded from MVM |
| workforce_education | course_approval | ✅ | ❌ | Excluded from MVM |
| workforce_education | course_communication | ✅ | ❌ | Excluded from MVM |
| workforce_education | training_course | ✅ | ❌ | Excluded from MVM |

<a id="domain-correspondence"></a>
### correspondence

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| issue_resolution | complaint | ✅ | ❌ | Domain not in MVM |
| issue_resolution | complaint_activity | ✅ | ❌ | Domain not in MVM |
| issue_resolution | doi_inquiry | ✅ | ❌ | Domain not in MVM |
| issue_resolution | doi_response | ✅ | ❌ | Domain not in MVM |
| issue_resolution | escalation | ✅ | ❌ | Domain not in MVM |
| issue_resolution | notice_compliance_log | ✅ | ❌ | Domain not in MVM |
| issue_resolution | queue | ✅ | ❌ | Domain not in MVM |
| issue_resolution | queue_assignment | ✅ | ❌ | Domain not in MVM |
| issue_resolution | queue_vendor_assignment | ✅ | ❌ | Domain not in MVM |
| issue_resolution | sla | ✅ | ❌ | Domain not in MVM |
| message_management | address_search | ✅ | ❌ | Domain not in MVM |
| message_management | bulk_comm_campaign | ✅ | ❌ | Domain not in MVM |
| message_management | call_record | ✅ | ❌ | Domain not in MVM |
| message_management | comm_audit_trail | ✅ | ❌ | Domain not in MVM |
| message_management | comm_channel | ✅ | ❌ | Domain not in MVM |
| message_management | comm_preference | ✅ | ❌ | Domain not in MVM |
| message_management | comm_session | ✅ | ❌ | Domain not in MVM |
| message_management | comm_template | ✅ | ❌ | Domain not in MVM |
| message_management | comm_template_version | ✅ | ❌ | Domain not in MVM |
| message_management | communication | ✅ | ❌ | Domain not in MVM |
| message_management | correspondence_bulk_comm_recipient | ✅ | ❌ | Domain not in MVM |
| message_management | delivery_tracking | ✅ | ❌ | Domain not in MVM |
| message_management | inbound_correspondence | ✅ | ❌ | Domain not in MVM |
| message_management | message_thread | ✅ | ❌ | Domain not in MVM |
| message_management | outbound_notice | ✅ | ❌ | Domain not in MVM |
| message_management | returned_mail | ✅ | ❌ | Domain not in MVM |
| message_management | secure_message | ✅ | ❌ | Domain not in MVM |
| message_management | suppression_list | ✅ | ❌ | Domain not in MVM |
| message_management | template_translation | ✅ | ❌ | Domain not in MVM |
| message_management | translation_request | ✅ | ❌ | Domain not in MVM |

<a id="domain-document"></a>
### document

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_governance | acord_form | ✅ | ✅ |  |
| compliance_governance | legal_hold | ✅ | ❌ | Excluded from MVM |
| compliance_governance | retention_schedule | ✅ | ✅ |  |
| content_management | document | ✅ | ✅ |  |
| content_management | document_type | ✅ | ❌ | Excluded from MVM |
| content_management | package | ✅ | ✅ |  |
| content_management | template | ✅ | ✅ |  |
| content_management | version | ✅ | ✅ |  |
| distribution_control | access_log | ✅ | ❌ | Excluded from MVM |
| distribution_control | delivery_consent | ✅ | ✅ |  |
| distribution_control | delivery_event | ✅ | ✅ |  |
| distribution_control | signature | ✅ | ✅ |  |
| document_registry | type | ❌ | ✅ | MVM only (stub or new) |
| workflow_processing | correspondence_link | ✅ | ❌ | Excluded from MVM |
| workflow_processing | nigo_record | ✅ | ✅ |  |
| workflow_processing | request | ✅ | ❌ | Excluded from MVM |
| workflow_processing | workflow | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| accounting_operations | chart_of_accounts | ✅ | ✅ |  |
| accounting_operations | cost_center | ✅ | ✅ |  |
| accounting_operations | general_ledger | ✅ | ✅ |  |
| accounting_operations | intercompany_settlement | ✅ | ❌ | Excluded from MVM |
| accounting_operations | journal_entry | ✅ | ✅ |  |
| accounting_operations | journal_entry_line | ✅ | ✅ |  |
| accounting_operations | legal_entity | ✅ | ✅ |  |
| insurance_valuation | dac_amortization | ✅ | ✅ |  |
| insurance_valuation | dac_asset | ✅ | ✅ |  |
| insurance_valuation | embedded_value | ✅ | ❌ | Excluded from MVM |
| insurance_valuation | gaap_reserve | ✅ | ✅ |  |
| insurance_valuation | ifrs17_contract_group | ✅ | ✅ |  |
| insurance_valuation | ifrs17_measurement | ✅ | ✅ |  |
| insurance_valuation | reinsurance_recoverable | ✅ | ✅ |  |
| insurance_valuation | statutory_reserve | ✅ | ✅ |  |
| planning_performance | budget | ✅ | ❌ | Excluded from MVM |
| planning_performance | budget_variance | ✅ | ❌ | Excluded from MVM |
| planning_performance | cost_center_vendor_engagement | ✅ | ❌ | Excluded from MVM |
| planning_performance | entity_vendor_contract | ✅ | ❌ | Excluded from MVM |
| planning_performance | netting_group | ✅ | ❌ | Excluded from MVM |
| planning_performance | rbc_calculation | ✅ | ✅ |  |
| planning_performance | tax_provision | ✅ | ✅ |  |

<a id="domain-investment"></a>
### investment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_monitoring | alm_analysis | ✅ | ✅ |  |
| compliance_monitoring | alm_gap_measurement | ✅ | ❌ | Excluded from MVM |
| compliance_monitoring | compliance_breach | ✅ | ✅ |  |
| compliance_monitoring | compliance_rule | ✅ | ✅ |  |
| compliance_monitoring | credit_default_rate | ✅ | ❌ | Excluded from MVM |
| compliance_monitoring | guideline | ✅ | ❌ | Excluded from MVM |
| compliance_monitoring | risk_charge | ✅ | ❌ | Excluded from MVM |
| portfolio_management | alternative_asset | ✅ | ❌ | Excluded from MVM |
| portfolio_management | asset_allocation | ✅ | ❌ | Excluded from MVM |
| portfolio_management | asset_holding | ✅ | ✅ |  |
| portfolio_management | benchmark | ✅ | ❌ | Excluded from MVM |
| portfolio_management | mortgage_loan | ✅ | ✅ |  |
| portfolio_management | portfolio | ✅ | ✅ |  |
| portfolio_management | portfolio_segment | ✅ | ❌ | Excluded from MVM |
| portfolio_management | security | ✅ | ✅ |  |
| portfolio_management | separate_account | ✅ | ✅ |  |
| portfolio_management | unit_value | ✅ | ✅ |  |
| risk_accounting | derivative_valuation | ✅ | ❌ | Excluded from MVM |
| risk_accounting | gain_loss_event | ✅ | ❌ | Excluded from MVM |
| risk_accounting | impairment | ✅ | ❌ | Excluded from MVM |
| risk_accounting | income_allocation | ✅ | ✅ |  |
| risk_accounting | performance_attribution | ✅ | ❌ | Excluded from MVM |
| risk_accounting | tax_lot | ✅ | ❌ | Excluded from MVM |
| risk_accounting | valuation | ✅ | ✅ |  |
| trading_operations | counterparty | ✅ | ✅ |  |
| trading_operations | derivative_contract | ✅ | ✅ |  |
| trading_operations | investment_transaction | ✅ | ❌ | Excluded from MVM |
| trading_operations | securities_lending | ✅ | ❌ | Excluded from MVM |
| trading_operations | trade | ✅ | ✅ |  |
| trading_operations | trade_execution | ✅ | ✅ |  |

<a id="domain-policy"></a>
### policy

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_administration | assignment | ✅ | ✅ |  |
| contract_administration | conversion | ✅ | ✅ |  |
| contract_administration | free_look | ✅ | ❌ | Excluded from MVM |
| contract_administration | in_force_policy | ✅ | ✅ |  |
| contract_administration | incontestability | ✅ | ❌ | Excluded from MVM |
| contract_administration | note | ✅ | ❌ | Excluded from MVM |
| contract_administration | owner | ✅ | ✅ |  |
| contract_administration | policy_beneficiary | ✅ | ✅ |  |
| contract_administration | policy_reinstatement | ✅ | ✅ |  |
| contract_administration | policy_rider | ✅ | ❌ | Excluded from MVM |
| contract_administration | rider | ✅ | ✅ |  |
| contract_administration | service_request | ✅ | ✅ |  |
| contract_administration | status_history | ✅ | ✅ |  |
| financial_valuation | dividend | ✅ | ✅ |  |
| financial_valuation | fund_allocation | ✅ | ✅ |  |
| financial_valuation | guaranteed_benefit_allocation | ✅ | ❌ | Excluded from MVM |
| financial_valuation | loan | ✅ | ✅ |  |
| financial_valuation | nonforfeiture_option | ✅ | ❌ | Excluded from MVM |
| financial_valuation | surrender | ✅ | ✅ |  |
| financial_valuation | tax_compliance_test | ✅ | ✅ |  |
| financial_valuation | value | ✅ | ✅ |  |

<a id="domain-policyholder"></a>
### policyholder

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_events | beneficiary_designation | ✅ | ✅ |  |
| compliance_events | consent_record | ✅ | ❌ | Excluded from MVM |
| compliance_events | death_verification | ✅ | ✅ |  |
| compliance_events | insured_risk_assessment | ✅ | ❌ | Excluded from MVM |
| compliance_events | kyc_verification | ✅ | ✅ |  |
| compliance_events | ownership_transfer | ✅ | ✅ |  |
| compliance_events | policyholder_training_completion | ✅ | ❌ | Excluded from MVM |
| compliance_events | power_of_attorney | ✅ | ❌ | Excluded from MVM |
| contact_information | communication_preference | ✅ | ❌ | Excluded from MVM |
| contact_information | party_address | ✅ | ✅ |  |
| contact_information | party_contact | ✅ | ✅ |  |
| contact_information | relationship | ✅ | ✅ |  |
| party_roles | annuitant | ✅ | ✅ |  |
| party_roles | contract_owner | ✅ | ✅ |  |
| party_roles | group_member | ✅ | ❌ | Excluded from MVM |
| party_roles | group_sponsor | ✅ | ❌ | Excluded from MVM |
| party_roles | insured | ✅ | ✅ |  |
| party_roles | party | ✅ | ✅ |  |
| party_roles | policyholder_beneficiary | ✅ | ✅ |  |
| party_roles | trust | ✅ | ✅ |  |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| catalog_management | benefit_structure | ✅ | ✅ |  |
| catalog_management | form | ✅ | ✅ |  |
| catalog_management | plan | ✅ | ✅ |  |
| catalog_management | plan_rider_configuration | ✅ | ❌ | Excluded from MVM |
| catalog_management | plan_template_assignment | ✅ | ❌ | Excluded from MVM |
| catalog_management | plan_version | ✅ | ✅ |  |
| catalog_management | product_line | ✅ | ❌ | Excluded from MVM |
| catalog_management | rider_definition | ✅ | ✅ |  |
| catalog_management | separate_account_fund | ✅ | ✅ |  |
| catalog_management | vendor_service | ✅ | ❌ | Excluded from MVM |
| plan_design | plan_rider_eligibility | ❌ | ✅ | MVM only (stub or new) |
| plan_design | plan_underwriting_eligibility | ❌ | ✅ | MVM only (stub or new) |
| pricing_structure | charge_schedule | ✅ | ✅ |  |
| pricing_structure | coi_rate_schedule | ✅ | ✅ |  |
| pricing_structure | crediting_strategy | ✅ | ✅ |  |
| pricing_structure | di_benefit_definition | ✅ | ❌ | Excluded from MVM |
| pricing_structure | expense_charge | ✅ | ❌ | Excluded from MVM |
| pricing_structure | illustration_assumption | ✅ | ❌ | Excluded from MVM |
| pricing_structure | premium_rate_table | ✅ | ✅ |  |
| pricing_structure | profitability_assumption | ✅ | ❌ | Excluded from MVM |
| pricing_structure | underwriting_class | ✅ | ✅ |  |
| regulatory_compliance | filing | ✅ | ✅ |  |
| regulatory_compliance | irc7702_parameter | ✅ | ✅ |  |
| regulatory_compliance | plan_obligation_compliance | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | rate_action | ✅ | ✅ |  |
| regulatory_compliance | retirement | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | state_approval | ✅ | ✅ |  |
| regulatory_compliance | suitability_rule | ✅ | ✅ |  |
| regulatory_compliance | tax_qualification | ✅ | ❌ | Excluded from MVM |

<a id="domain-reinsurance"></a>
### reinsurance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| cession_operations | cession | ❌ | ✅ | MVM only (stub or new) |
| cession_processing | facultative_submission | ✅ | ✅ |  |
| cession_processing | inforce_cession_snapshot | ✅ | ❌ | Excluded from MVM |
| cession_processing | nar_calculation | ✅ | ✅ |  |
| cession_processing | recapture_event | ✅ | ✅ |  |
| cession_processing | reinsurance_cession | ✅ | ❌ | Excluded from MVM |
| cession_processing | retrocession_cession | ✅ | ❌ | Excluded from MVM |
| counterparty_relations | dispute_evidence | ✅ | ❌ | Excluded from MVM |
| counterparty_relations | reinsurance_dispute | ✅ | ❌ | Excluded from MVM |
| counterparty_relations | reinsurer_contact | ✅ | ❌ | Excluded from MVM |
| counterparty_relations | reinsurer_credit_assumption | ✅ | ❌ | Excluded from MVM |
| counterparty_relations | treaty_experience_analysis | ✅ | ❌ | Excluded from MVM |
| financial_settlement | bordereaux | ✅ | ✅ |  |
| financial_settlement | bordereaux_line | ✅ | ✅ |  |
| financial_settlement | claim_recoverable | ✅ | ✅ |  |
| financial_settlement | coinsurance_fund_withheld | ✅ | ❌ | Excluded from MVM |
| financial_settlement | experience_refund | ✅ | ❌ | Excluded from MVM |
| financial_settlement | premium | ✅ | ✅ |  |
| financial_settlement | reinsurer_settlement | ✅ | ✅ |  |
| financial_settlement | reserve | ✅ | ✅ |  |
| treaty_management | automatic_binding_limit | ✅ | ✅ |  |
| treaty_management | reinsurance_treaty | ✅ | ❌ | Excluded from MVM |
| treaty_management | reinsurer | ✅ | ✅ |  |
| treaty_management | retention_limit | ✅ | ✅ |  |
| treaty_management | retrocession_treaty | ✅ | ❌ | Excluded from MVM |
| treaty_management | treaty | ✅ | ✅ |  |
| treaty_management | treaty_schedule | ✅ | ✅ |  |

<a id="domain-reporting"></a>
### reporting

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| framework_configuration | close_calendar | ✅ | ❌ | Domain not in MVM |
| framework_configuration | close_task | ✅ | ❌ | Domain not in MVM |
| framework_configuration | gaap_report_config | ✅ | ❌ | Domain not in MVM |
| framework_configuration | ifrs17_report_config | ✅ | ❌ | Domain not in MVM |
| framework_configuration | management_report_config | ✅ | ❌ | Domain not in MVM |
| framework_configuration | segment_definition | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | filing_content | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | filing_template | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | rbc_filing | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | statutory_exhibit | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | statutory_filing | ✅ | ❌ | Domain not in MVM |
| report_production | package_content | ✅ | ❌ | Domain not in MVM |
| report_production | report_access_policy | ✅ | ❌ | Domain not in MVM |
| report_production | report_approval | ✅ | ❌ | Domain not in MVM |
| report_production | report_control | ✅ | ❌ | Domain not in MVM |
| report_production | report_definition | ✅ | ❌ | Domain not in MVM |
| report_production | report_distribution | ✅ | ❌ | Domain not in MVM |
| report_production | report_exception | ✅ | ❌ | Domain not in MVM |
| report_production | report_line_definition | ✅ | ❌ | Domain not in MVM |
| report_production | report_package | ✅ | ❌ | Domain not in MVM |
| report_production | report_period | ✅ | ❌ | Domain not in MVM |
| report_production | report_recipient | ✅ | ❌ | Domain not in MVM |
| report_production | report_reconciliation | ✅ | ❌ | Domain not in MVM |
| report_production | report_run | ✅ | ❌ | Domain not in MVM |
| report_production | report_schedule | ✅ | ❌ | Domain not in MVM |
| report_production | report_version | ✅ | ❌ | Domain not in MVM |

<a id="domain-underwriting"></a>
### underwriting

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| application_processing | rule_execution_result | ❌ | ✅ | MVM only (stub or new) |
| case_management | application | ✅ | ✅ |  |
| case_management | application_party_role | ✅ | ❌ | Excluded from MVM |
| case_management | case_activity | ✅ | ❌ | Excluded from MVM |
| case_management | counter_offer | ✅ | ❌ | Excluded from MVM |
| case_management | decision | ✅ | ✅ |  |
| case_management | exclusion_rider | ✅ | ✅ |  |
| case_management | policy_change_uw | ✅ | ❌ | Excluded from MVM |
| case_management | program | ✅ | ❌ | Excluded from MVM |
| case_management | uw_authority | ✅ | ❌ | Excluded from MVM |
| evidence_collection | application_document | ✅ | ❌ | Excluded from MVM |
| evidence_collection | aps_record | ✅ | ✅ |  |
| evidence_collection | evidence_requirement | ✅ | ✅ |  |
| evidence_collection | evidence_review | ✅ | ✅ |  |
| evidence_collection | mib_inquiry | ✅ | ✅ |  |
| evidence_collection | paramedical_exam | ✅ | ✅ |  |
| reinsurance_operations | reinsurance_placement | ✅ | ✅ |  |
| reinsurance_operations | treaty_risk_pricing | ✅ | ❌ | Excluded from MVM |
| risk_decisioning | risk_assessment | ❌ | ✅ | MVM only (stub or new) |
| risk_evaluation | financial_uw_review | ✅ | ✅ |  |
| risk_evaluation | impairment_guide | ✅ | ❌ | Excluded from MVM |
| risk_evaluation | program_rule_configuration | ✅ | ❌ | Excluded from MVM |
| risk_evaluation | risk_class | ✅ | ✅ |  |
| risk_evaluation | rule | ✅ | ✅ |  |
| risk_evaluation | rules_engine_output | ✅ | ✅ |  |
| risk_evaluation | stoli_review | ✅ | ❌ | Excluded from MVM |
| risk_evaluation | underwriting_risk_assessment | ✅ | ❌ | Excluded from MVM |

<a id="domain-vendor"></a>
### vendor

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_governance | baa | ✅ | ❌ | Domain not in MVM |
| compliance_governance | contract_amendment | ✅ | ❌ | Domain not in MVM |
| compliance_governance | contract_credential_requirement | ✅ | ❌ | Domain not in MVM |
| compliance_governance | credential | ✅ | ❌ | Domain not in MVM |
| compliance_governance | insurance_cert | ✅ | ❌ | Domain not in MVM |
| compliance_governance | policy_compliance | ✅ | ❌ | Domain not in MVM |
| compliance_governance | risk_finding | ✅ | ❌ | Domain not in MVM |
| compliance_governance | tpa_agreement | ✅ | ❌ | Domain not in MVM |
| compliance_governance | vendor_risk_assessment | ✅ | ❌ | Domain not in MVM |
| performance_oversight | incident | ✅ | ❌ | Domain not in MVM |
| performance_oversight | sla_agreement | ✅ | ❌ | Domain not in MVM |
| performance_oversight | sla_measurement | ✅ | ❌ | Domain not in MVM |
| performance_oversight | vendor_performance_review | ✅ | ❌ | Domain not in MVM |
| relationship_management | contact | ✅ | ❌ | Domain not in MVM |
| relationship_management | onboarding | ✅ | ❌ | Domain not in MVM |
| relationship_management | preferred_vendor | ✅ | ❌ | Domain not in MVM |
| relationship_management | vendor | ✅ | ❌ | Domain not in MVM |
| relationship_management | vendor_bank_account | ✅ | ❌ | Domain not in MVM |
| relationship_management | vendor_contract | ✅ | ❌ | Domain not in MVM |
| transaction_processing | custodian_account | ✅ | ❌ | Domain not in MVM |
| transaction_processing | exam_vendor_order | ✅ | ❌ | Domain not in MVM |
| transaction_processing | invoice | ✅ | ❌ | Domain not in MVM |
| transaction_processing | invoice_line | ✅ | ❌ | Domain not in MVM |
| transaction_processing | service_order | ✅ | ❌ | Domain not in MVM |
| transaction_processing | spend | ✅ | ❌ | Domain not in MVM |
| transaction_processing | vendor_payment | ✅ | ❌ | Domain not in MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| employee_administration | employee | ✅ | ❌ | Domain not in MVM |
| employee_administration | employee_skill | ✅ | ❌ | Domain not in MVM |
| employee_administration | employment_record | ✅ | ❌ | Domain not in MVM |
| employee_administration | job_role | ✅ | ❌ | Domain not in MVM |
| employee_administration | org_unit | ✅ | ❌ | Domain not in MVM |
| employee_administration | position | ✅ | ❌ | Domain not in MVM |
| employee_administration | region | ✅ | ❌ | Domain not in MVM |
| employee_administration | team | ✅ | ❌ | Domain not in MVM |
| employee_administration | work_location | ✅ | ❌ | Domain not in MVM |
| employee_administration | work_schedule | ✅ | ❌ | Domain not in MVM |
| learning_compliance | background_check | ✅ | ❌ | Domain not in MVM |
| learning_compliance | ce_credit | ✅ | ❌ | Domain not in MVM |
| learning_compliance | staff_license | ✅ | ❌ | Domain not in MVM |
| learning_compliance | staff_training | ✅ | ❌ | Domain not in MVM |
| learning_compliance | training_enrollment | ✅ | ❌ | Domain not in MVM |
| learning_compliance | training_session | ✅ | ❌ | Domain not in MVM |
| learning_compliance | uw_authority_assignment | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | compensation | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | leave_request | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_calendar | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_period | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_record | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | time_record | ✅ | ❌ | Domain not in MVM |
| talent_management | candidate | ✅ | ❌ | Domain not in MVM |
| talent_management | disciplinary_action | ✅ | ❌ | Domain not in MVM |
| talent_management | headcount_plan | ✅ | ❌ | Domain not in MVM |
| talent_management | interview_event | ✅ | ❌ | Domain not in MVM |
| talent_management | interview_scorecard | ✅ | ❌ | Domain not in MVM |
| talent_management | offer | ✅ | ❌ | Domain not in MVM |
| talent_management | performance_goal | ✅ | ❌ | Domain not in MVM |
| talent_management | requisition | ✅ | ❌ | Domain not in MVM |
| talent_management | succession_plan | ✅ | ❌ | Domain not in MVM |
| talent_management | workforce_performance_review | ✅ | ❌ | Domain not in MVM |
