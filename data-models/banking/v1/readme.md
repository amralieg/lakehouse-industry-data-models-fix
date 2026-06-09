# Banking Lakehouse Data Models

**Version 1** | Generated on May 03, 2026 at 02:24 AM

**Industry:** banking

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Account](#domain-account)
  - [Asset](#domain-asset)
  - [Audit](#domain-audit)
  - [Channel](#domain-channel)
  - [Collateral](#domain-collateral)
  - [Compliance](#domain-compliance)
  - [Customer](#domain-customer)
  - [Fraud](#domain-fraud)
  - [Hr](#domain-hr)
  - [Investment](#domain-investment)
  - [Ledger](#domain-ledger)
  - [Loan](#domain-loan)
  - [Payment](#domain-payment)
  - [Reference](#domain-reference)
  - [Risk](#domain-risk)
  - [Security](#domain-security)
  - [Trade](#domain-trade)
  - [Treasury](#domain-treasury)
  - [Wealth](#domain-wealth)


## Business Description

Retail and Investment Banking is a cornerstone of the global financial system, providing commercial lending, investment banking, securities trading, asset management, and wealth advisory services to corporations, governments, and individuals.

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
| Domains | 17 | 19 |
| Subdomains | 46 | 68 |
| Products (Tables) | 227 | 501 |
| Attributes (Columns) | 9883 | 19794 |
| Foreign Keys | 2478 | 3301 |
| Avg Attributes/Product | 43.5 | 39.5 |

## Domain & Product Comparison

<a id="domain-account"></a>
### account

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_master | account_position | ✅ | ❌ | Excluded from MVM |
| account_master | certificate_of_deposit | ✅ | ❌ | Excluded from MVM |
| account_master | custodial_account | ✅ | ❌ | Excluded from MVM |
| account_master | deposit_account | ✅ | ✅ |  |
| account_master | document | ✅ | ❌ | Excluded from MVM |
| account_master | holder | ✅ | ✅ |  |
| account_master | type | ✅ | ❌ | Excluded from MVM |
| product_pricing | account_limit | ✅ | ✅ |  |
| product_pricing | account_product | ✅ | ❌ | Excluded from MVM |
| product_pricing | interest_rate | ✅ | ✅ |  |
| product_pricing | overdraft_facility | ✅ | ✅ |  |
| product_pricing | rate_tier | ✅ | ❌ | Excluded from MVM |
| relationship_management | account_collateral_pledge | ✅ | ❌ | Excluded from MVM |
| relationship_management | account_pledge | ✅ | ❌ | Excluded from MVM |
| relationship_management | account_portfolio_holding | ✅ | ❌ | Excluded from MVM |
| relationship_management | beneficiary_designation | ✅ | ❌ | Excluded from MVM |
| relationship_management | channel_enrollment | ✅ | ❌ | Excluded from MVM |
| relationship_management | custody_mandate | ✅ | ❌ | Excluded from MVM |
| relationship_management | rm_account_assignment | ✅ | ❌ | Excluded from MVM |
| transaction_processing | account_fee | ✅ | ✅ |  |
| transaction_processing | account_transaction | ✅ | ✅ |  |
| transaction_processing | balance | ✅ | ✅ |  |
| transaction_processing | direct_debit_mandate | ✅ | ✅ |  |
| transaction_processing | dormancy_review | ✅ | ❌ | Excluded from MVM |
| transaction_processing | hold | ✅ | ✅ |  |
| transaction_processing | interest_accrual | ✅ | ✅ |  |
| transaction_processing | standing_order | ✅ | ✅ |  |
| transaction_processing | statement | ✅ | ✅ |  |
| transaction_processing | status_history | ✅ | ✅ |  |
| transaction_processing | sweep | ✅ | ❌ | Excluded from MVM |

<a id="domain-asset"></a>
### asset

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_risk | fund_audit | ✅ | ❌ | Excluded from MVM |
| compliance_risk | fund_regulatory_report | ✅ | ❌ | Excluded from MVM |
| compliance_risk | fund_risk_exposure | ✅ | ❌ | Excluded from MVM |
| compliance_risk | investment_restriction | ✅ | ✅ |  |
| compliance_risk | restriction_breach | ✅ | ❌ | Excluded from MVM |
| distribution_operations | distribution_event | ✅ | ✅ |  |
| distribution_operations | fund_distribution_channel | ✅ | ❌ | Excluded from MVM |
| distribution_operations | transfer_agency_event | ✅ | ❌ | Excluded from MVM |
| fund_management | fund | ✅ | ✅ |  |
| fund_management | fund_administrator | ✅ | ❌ | Excluded from MVM |
| fund_management | fund_benchmark | ✅ | ❌ | Excluded from MVM |
| fund_management | fund_class | ✅ | ✅ |  |
| fund_management | fund_expense | ✅ | ❌ | Excluded from MVM |
| fund_management | fund_fee_schedule | ✅ | ❌ | Excluded from MVM |
| fund_management | fund_holding | ✅ | ✅ |  |
| fund_management | fund_lifecycle_event | ✅ | ❌ | Excluded from MVM |
| fund_management | fund_management_assignment | ✅ | ❌ | Excluded from MVM |
| fund_management | fund_mandate | ✅ | ✅ |  |
| fund_management | fund_performance | ✅ | ✅ |  |
| fund_management | fund_transaction | ✅ | ✅ |  |
| fund_management | fund_valuation_adjustment | ✅ | ❌ | Excluded from MVM |
| fund_management | nav_record | ✅ | ✅ |  |
| investor_account | unit_register | ❌ | ✅ | MVM only (stub or new) |
| investor_services | asset_unit_register | ✅ | ❌ | Excluded from MVM |
| investor_services | fund_switch | ✅ | ❌ | Excluded from MVM |
| investor_services | investor_account | ✅ | ✅ |  |
| investor_services | investor_statement | ✅ | ❌ | Excluded from MVM |
| investor_services | redemption | ✅ | ✅ |  |
| investor_services | subscription | ✅ | ✅ |  |

<a id="domain-audit"></a>
### audit

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| execution_management | audit_report | ✅ | ❌ | Domain not in MVM |
| execution_management | continuous_monitoring | ✅ | ❌ | Domain not in MVM |
| execution_management | engagement | ✅ | ❌ | Domain not in MVM |
| execution_management | engagement_assignment | ✅ | ❌ | Domain not in MVM |
| execution_management | engagement_scope | ✅ | ❌ | Domain not in MVM |
| execution_management | finding | ✅ | ❌ | Domain not in MVM |
| execution_management | issue_validation | ✅ | ❌ | Domain not in MVM |
| execution_management | management_action | ✅ | ❌ | Domain not in MVM |
| execution_management | monitoring_exception | ✅ | ❌ | Domain not in MVM |
| execution_management | program | ✅ | ❌ | Domain not in MVM |
| execution_management | recommendation | ✅ | ❌ | Domain not in MVM |
| execution_management | workpaper | ✅ | ❌ | Domain not in MVM |
| planning_operations | audit_budget | ✅ | ❌ | Domain not in MVM |
| planning_operations | business_process | ✅ | ❌ | Domain not in MVM |
| planning_operations | plan | ✅ | ❌ | Domain not in MVM |
| planning_operations | program_step | ✅ | ❌ | Domain not in MVM |
| planning_operations | risk_assessment | ✅ | ❌ | Domain not in MVM |
| planning_operations | three_lines_assignment | ✅ | ❌ | Domain not in MVM |
| planning_operations | universe | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | cae_charter | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | committee_report | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | cosourcing_arrangement | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | issue_tracker | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | quality_assurance_review | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | regulatory_audit | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | regulatory_finding | ✅ | ❌ | Domain not in MVM |
| resource_allocation | notification | ✅ | ❌ | Domain not in MVM |
| resource_allocation | resource | ✅ | ❌ | Domain not in MVM |

<a id="domain-channel"></a>
### channel

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| channel_operations | atm | ✅ | ✅ |  |
| channel_operations | atm_transaction | ✅ | ✅ |  |
| channel_operations | branch | ✅ | ✅ |  |
| channel_operations | branch_teller_transaction | ✅ | ❌ | Excluded from MVM |
| channel_operations | channel | ✅ | ✅ |  |
| channel_operations | channel_product | ✅ | ❌ | Excluded from MVM |
| channel_operations | contact_center | ✅ | ❌ | Excluded from MVM |
| channel_operations | digital_channel | ✅ | ✅ |  |
| channel_operations | queue | ✅ | ❌ | Excluded from MVM |
| customer_interaction | branch_appointment | ✅ | ❌ | Excluded from MVM |
| customer_interaction | channel_alert | ✅ | ❌ | Excluded from MVM |
| customer_interaction | channel_relationship_manager | ✅ | ❌ | Excluded from MVM |
| customer_interaction | interaction | ✅ | ✅ |  |
| customer_interaction | journey | ✅ | ❌ | Excluded from MVM |
| customer_interaction | journey_instance | ✅ | ❌ | Excluded from MVM |
| customer_interaction | journey_template | ✅ | ❌ | Excluded from MVM |
| customer_interaction | preference | ✅ | ❌ | Excluded from MVM |
| customer_interaction | rm_client_assignment | ✅ | ❌ | Excluded from MVM |
| customer_interaction | session | ✅ | ✅ |  |
| digital_experience | alert_template | ✅ | ❌ | Excluded from MVM |
| digital_experience | api_application | ✅ | ❌ | Excluded from MVM |
| digital_experience | campaign | ✅ | ❌ | Excluded from MVM |
| digital_experience | third_party_provider | ✅ | ❌ | Excluded from MVM |
| risk_compliance | audit_scope | ✅ | ❌ | Excluded from MVM |
| risk_compliance | branch_audit_scope | ✅ | ❌ | Excluded from MVM |
| risk_compliance | channel_incident | ✅ | ❌ | Excluded from MVM |
| risk_compliance | cost_allocation | ✅ | ❌ | Excluded from MVM |
| risk_compliance | open_banking_consent | ✅ | ❌ | Excluded from MVM |
| risk_compliance | override_approval | ✅ | ❌ | Excluded from MVM |
| risk_compliance | override_request | ✅ | ❌ | Excluded from MVM |
| risk_compliance | rule_configuration | ✅ | ❌ | Excluded from MVM |
| risk_compliance | sla | ✅ | ❌ | Excluded from MVM |
| risk_compliance | sla_breach | ✅ | ❌ | Excluded from MVM |

<a id="domain-collateral"></a>
### collateral

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_registry | collateral_asset | ✅ | ✅ |  |
| asset_registry | collateral_basket | ✅ | ❌ | Excluded from MVM |
| asset_registry | concentration_limit | ✅ | ❌ | Excluded from MVM |
| asset_registry | csa_agreement | ✅ | ❌ | Excluded from MVM |
| asset_registry | eligibility_rule | ✅ | ✅ |  |
| asset_registry | haircut_schedule | ✅ | ✅ |  |
| asset_registry | insurance_policy | ✅ | ❌ | Excluded from MVM |
| asset_registry | isda_master_agreement | ✅ | ❌ | Excluded from MVM |
| legal_agreements | collateral_lifecycle_event | ✅ | ❌ | Excluded from MVM |
| legal_agreements | collateral_pledge | ✅ | ❌ | Excluded from MVM |
| legal_agreements | collateral_position | ✅ | ✅ |  |
| legal_agreements | lien_filing | ✅ | ❌ | Excluded from MVM |
| legal_agreements | netting_set | ✅ | ✅ |  |
| legal_agreements | pledge_agreement | ✅ | ✅ |  |
| margin_management | collateral_margin_call | ✅ | ❌ | Excluded from MVM |
| margin_management | collateral_valuation | ✅ | ✅ |  |
| margin_management | initial_margin | ✅ | ❌ | Excluded from MVM |
| margin_management | margin_agreement | ✅ | ✅ |  |
| margin_management | margin_call | ❌ | ✅ | MVM only (stub or new) |
| margin_management | margin_exposure | ✅ | ✅ |  |
| margin_management | optimization | ✅ | ❌ | Excluded from MVM |
| margin_management | review | ✅ | ❌ | Excluded from MVM |
| margin_management | stress_valuation | ✅ | ❌ | Excluded from MVM |
| margin_management | variation_margin | ✅ | ❌ | Excluded from MVM |
| pledge_operations | pledge | ❌ | ✅ | MVM only (stub or new) |
| repo_operations | repo_agreement | ✅ | ❌ | Excluded from MVM |
| repo_operations | repo_leg | ✅ | ❌ | Excluded from MVM |
| repo_operations | substitution | ✅ | ❌ | Excluded from MVM |
| repo_operations | transfer | ✅ | ❌ | Excluded from MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| aml_monitoring | aml_alert | ✅ | ✅ |  |
| aml_monitoring | aml_case | ✅ | ✅ |  |
| aml_monitoring | kyc_review | ✅ | ✅ |  |
| aml_monitoring | monitoring_rule | ✅ | ✅ |  |
| aml_monitoring | rule_validation | ✅ | ❌ | Excluded from MVM |
| compliance_operations | breach | ✅ | ❌ | Excluded from MVM |
| compliance_operations | compliance_sox_control | ✅ | ❌ | Excluded from MVM |
| compliance_operations | consent_order | ✅ | ❌ | Excluded from MVM |
| compliance_operations | coverage | ✅ | ❌ | Excluded from MVM |
| compliance_operations | data_subject_request | ✅ | ❌ | Excluded from MVM |
| compliance_operations | disclosure_template | ✅ | ❌ | Excluded from MVM |
| compliance_operations | obligation | ✅ | ✅ |  |
| compliance_operations | policy | ✅ | ✅ |  |
| compliance_operations | training_record | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | compliance_regulatory_filing | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | ctr_filing | ✅ | ✅ |  |
| regulatory_reporting | exam_finding | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | regulatory_calendar | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | regulatory_change | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | regulatory_exam | ✅ | ✅ |  |
| regulatory_reporting | regulatory_filing | ❌ | ✅ | MVM only (stub or new) |
| sanctions_screening | sanctions_list_entry | ✅ | ✅ |  |
| sanctions_screening | sanctions_screening_event | ✅ | ✅ |  |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| identity_management | corporate_profile | ✅ | ✅ |  |
| identity_management | individual_profile | ✅ | ✅ |  |
| identity_management | party | ✅ | ✅ |  |
| identity_management | party_address | ✅ | ✅ |  |
| identity_management | party_contact | ✅ | ✅ |  |
| identity_management | party_document | ✅ | ✅ |  |
| identity_management | party_identifier | ✅ | ✅ |  |
| identity_management | relationship_hierarchy | ✅ | ✅ |  |
| marketing_operations | marketing_campaign | ✅ | ❌ | Excluded from MVM |
| marketing_operations | party_segment_assignment | ✅ | ✅ |  |
| marketing_operations | prospect | ✅ | ❌ | Excluded from MVM |
| marketing_operations | segment | ✅ | ✅ |  |
| regulatory_compliance | beneficial_owner | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | complaint | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | consent_record | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | customer_beneficial_owner | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | fatca_crs_classification | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | kyc_record | ✅ | ✅ |  |
| regulatory_compliance | kyc_review_event | ✅ | ✅ |  |
| regulatory_compliance | party_lifecycle_event | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | party_risk_rating | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | risk_rating | ✅ | ✅ |  |
| regulatory_compliance | tax_profile | ✅ | ❌ | Excluded from MVM |
| relationship_services | account_holder | ✅ | ✅ |  |
| relationship_services | customer_investor_order | ✅ | ❌ | Excluded from MVM |
| relationship_services | customer_relationship_manager | ✅ | ❌ | Excluded from MVM |
| relationship_services | customer_unit_register | ✅ | ❌ | Excluded from MVM |
| relationship_services | limit_allocation | ✅ | ❌ | Excluded from MVM |
| relationship_services | onboarding_case | ✅ | ✅ |  |
| relationship_services | party_relationship | ✅ | ✅ |  |

<a id="domain-fraud"></a>
### fraud

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| case_management | case | ✅ | ✅ |  |
| case_management | claim | ✅ | ✅ |  |
| case_management | evidence | ✅ | ✅ |  |
| case_management | fraud_incident | ✅ | ❌ | Excluded from MVM |
| case_management | investigation | ✅ | ✅ |  |
| case_management | law_enforcement_referral | ✅ | ❌ | Excluded from MVM |
| case_management | loss_recovery | ✅ | ✅ |  |
| case_management | sar_filing | ✅ | ✅ |  |
| detection_rules | detection_rule | ✅ | ✅ |  |
| detection_rules | device_fingerprint | ✅ | ❌ | Excluded from MVM |
| detection_rules | fraud_alert | ✅ | ❌ | Excluded from MVM |
| detection_rules | fraud_watchlist | ✅ | ❌ | Excluded from MVM |
| detection_rules | rule_performance | ✅ | ❌ | Excluded from MVM |
| detection_rules | typology | ✅ | ❌ | Excluded from MVM |
| entity_registry | chargeback | ✅ | ✅ |  |
| entity_registry | fraud_ring | ✅ | ❌ | Excluded from MVM |
| entity_registry | loss | ✅ | ❌ | Excluded from MVM |
| entity_registry | merchant | ✅ | ❌ | Excluded from MVM |
| entity_registry | network_link | ✅ | ✅ |  |
| entity_registry | subject | ✅ | ✅ |  |
| entity_registry | subject_account_link | ✅ | ❌ | Excluded from MVM |
| fraud_detection | alert | ❌ | ✅ | MVM only (stub or new) |
| fraud_detection | incident | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-hr"></a>
### hr

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_benefits | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | benefit_plan | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | compensation_event | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | competency_framework | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | rating_scale | ✅ | ❌ | Domain not in MVM |
| employee_relations | employee_relation_case | ✅ | ❌ | Domain not in MVM |
| employee_relations | license_certification | ✅ | ❌ | Domain not in MVM |
| employee_relations | performance_review | ✅ | ❌ | Domain not in MVM |
| employee_relations | regulatory_disclosure | ✅ | ❌ | Domain not in MVM |
| employee_relations | review_cycle | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | candidate | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | job_profile | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | job_requisition | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | succession_plan | ✅ | ❌ | Domain not in MVM |
| workforce_operations | employee | ✅ | ❌ | Domain not in MVM |
| workforce_operations | hr_position | ✅ | ❌ | Domain not in MVM |
| workforce_operations | learning_course | ✅ | ❌ | Domain not in MVM |
| workforce_operations | learning_enrollment | ✅ | ❌ | Domain not in MVM |
| workforce_operations | onboarding_event | ✅ | ❌ | Domain not in MVM |
| workforce_operations | org_unit | ✅ | ❌ | Domain not in MVM |
| workforce_operations | payroll_record | ✅ | ❌ | Domain not in MVM |
| workforce_operations | payroll_run | ✅ | ❌ | Domain not in MVM |
| workforce_operations | time_attendance | ✅ | ❌ | Domain not in MVM |
| workforce_operations | work_location | ✅ | ❌ | Domain not in MVM |
| workforce_operations | workforce_plan | ✅ | ❌ | Domain not in MVM |

<a id="domain-investment"></a>
### investment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| capital_markets | investor_order | ❌ | ✅ | MVM only (stub or new) |
| capital_markets | syndication | ❌ | ✅ | MVM only (stub or new) |
| deal_origination | approval_committee | ✅ | ❌ | Excluded from MVM |
| deal_origination | coverage_assignment | ✅ | ✅ |  |
| deal_origination | deal | ✅ | ✅ |  |
| deal_origination | deal_team_member | ✅ | ❌ | Excluded from MVM |
| deal_origination | pipeline_stage | ✅ | ❌ | Excluded from MVM |
| deal_origination | pitch_book | ✅ | ❌ | Excluded from MVM |
| market_reporting | league_table | ✅ | ❌ | Excluded from MVM |
| market_reporting | tombstone | ✅ | ❌ | Excluded from MVM |
| transaction_execution | deal_broker_participation | ✅ | ❌ | Excluded from MVM |
| transaction_execution | deal_document | ✅ | ❌ | Excluded from MVM |
| transaction_execution | deal_participant | ✅ | ✅ |  |
| transaction_execution | deal_participation | ✅ | ❌ | Excluded from MVM |
| transaction_execution | fee_arrangement | ✅ | ✅ |  |
| transaction_execution | investment_investor_order | ✅ | ❌ | Excluded from MVM |
| transaction_execution | investment_mandate | ✅ | ✅ |  |
| transaction_execution | investment_regulatory_filing | ✅ | ❌ | Excluded from MVM |
| transaction_execution | investment_syndication | ✅ | ❌ | Excluded from MVM |
| transaction_execution | investment_valuation | ✅ | ✅ |  |
| transaction_execution | offering | ✅ | ✅ |  |
| transaction_execution | syndication_allocation | ✅ | ❌ | Excluded from MVM |
| transaction_execution | tranche | ✅ | ✅ |  |
| transaction_execution | transaction_structure | ✅ | ✅ |  |
| transaction_execution | underwriting | ✅ | ✅ |  |

<a id="domain-ledger"></a>
### ledger

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| consolidation_operations | consolidation_group | ✅ | ❌ | Excluded from MVM |
| consolidation_operations | consolidation_run | ✅ | ❌ | Excluded from MVM |
| consolidation_operations | financial_close_task | ✅ | ❌ | Excluded from MVM |
| consolidation_operations | intercompany_elimination | ✅ | ❌ | Excluded from MVM |
| consolidation_operations | intercompany_transaction | ✅ | ✅ |  |
| cost_management | account_testing_scope | ✅ | ❌ | Excluded from MVM |
| cost_management | cost_center | ✅ | ✅ |  |
| cost_management | ledger_budget | ✅ | ❌ | Excluded from MVM |
| cost_management | profit_center | ✅ | ✅ |  |
| cost_management | tax_provision | ✅ | ❌ | Excluded from MVM |
| general_ledger | accounting_calendar | ✅ | ❌ | Excluded from MVM |
| general_ledger | accounting_period | ✅ | ✅ |  |
| general_ledger | chart_of_accounts | ✅ | ✅ |  |
| general_ledger | gl_account | ✅ | ✅ |  |
| general_ledger | journal_entry | ✅ | ✅ |  |
| general_ledger | journal_entry_line | ✅ | ✅ |  |
| general_ledger | legal_entity | ✅ | ✅ |  |
| general_ledger | set | ✅ | ❌ | Excluded from MVM |
| general_ledger | subledger | ✅ | ✅ |  |
| general_ledger | subledger_reconciliation | ✅ | ❌ | Excluded from MVM |
| general_ledger | trial_balance | ✅ | ✅ |  |
| regulatory_controls | ledger_sox_control | ✅ | ❌ | Excluded from MVM |
| regulatory_controls | recurring_template | ✅ | ❌ | Excluded from MVM |
| regulatory_controls | task_template | ✅ | ❌ | Excluded from MVM |

<a id="domain-loan"></a>
### loan

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| credit_servicing | amortization_schedule | ✅ | ✅ |  |
| credit_servicing | disbursement | ✅ | ✅ |  |
| credit_servicing | drawdown | ✅ | ✅ |  |
| credit_servicing | lender_participation | ✅ | ❌ | Excluded from MVM |
| credit_servicing | loan_account | ✅ | ✅ |  |
| credit_servicing | loan_fee_schedule | ✅ | ❌ | Excluded from MVM |
| credit_servicing | loan_syndication | ✅ | ❌ | Excluded from MVM |
| credit_servicing | modification | ✅ | ✅ |  |
| credit_servicing | repayment | ✅ | ✅ |  |
| loan_origination | credit_application | ✅ | ✅ |  |
| loan_origination | facility | ✅ | ✅ |  |
| loan_origination | pricing | ✅ | ✅ |  |
| risk_management | collateral_link | ✅ | ✅ |  |
| risk_management | compliance_check | ✅ | ❌ | Excluded from MVM |
| risk_management | covenant | ✅ | ✅ |  |
| risk_management | covenant_package | ✅ | ❌ | Excluded from MVM |
| risk_management | credit_review | ✅ | ✅ |  |
| risk_management | facility_cfp_assumption | ✅ | ❌ | Excluded from MVM |
| risk_management | guarantee | ✅ | ✅ |  |
| risk_management | insurance | ✅ | ❌ | Excluded from MVM |
| risk_management | loan_collateral_pledge | ✅ | ❌ | Excluded from MVM |
| risk_management | loan_ecl_provision | ✅ | ✅ |  |
| risk_management | sanctions_screening | ✅ | ❌ | Excluded from MVM |
| risk_management | stress_projection | ✅ | ❌ | Excluded from MVM |
| risk_management | stress_test_result | ✅ | ❌ | Excluded from MVM |
| risk_management | write_off | ✅ | ✅ |  |
| trade_finance | bank_guarantee | ✅ | ✅ |  |
| trade_finance | bill_of_lading | ✅ | ❌ | Excluded from MVM |
| trade_finance | document_presentation | ✅ | ❌ | Excluded from MVM |
| trade_finance | documentary_collection | ✅ | ✅ |  |
| trade_finance | forfaiting | ✅ | ❌ | Excluded from MVM |
| trade_finance | lc | ✅ | ✅ |  |
| trade_finance | lc_drawing | ✅ | ✅ |  |
| trade_finance | supply_chain_program | ✅ | ❌ | Excluded from MVM |
| trade_finance | trade_document | ✅ | ✅ |  |
| trade_finance | trade_event | ✅ | ❌ | Excluded from MVM |
| trade_finance | trade_facility | ✅ | ❌ | Excluded from MVM |
| trade_finance | trade_finance_transaction | ✅ | ❌ | Excluded from MVM |
| trade_finance | trade_settlement | ✅ | ❌ | Excluded from MVM |
| trade_finance | trade_utilization | ✅ | ❌ | Excluded from MVM |

<a id="domain-payment"></a>
### payment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| partner_services | beneficiary | ✅ | ✅ |  |
| partner_services | card | ✅ | ✅ |  |
| partner_services | correspondent_bank | ✅ | ✅ |  |
| partner_services | correspondent_currency_service | ✅ | ❌ | Excluded from MVM |
| partner_services | merchant | ✅ | ✅ | Also in domain(s): fraud |
| partner_services | merchant_agreement | ✅ | ❌ | Excluded from MVM |
| partner_services | payment_processor | ✅ | ❌ | Excluded from MVM |
| payment_operations | batch | ✅ | ❌ | Excluded from MVM |
| payment_operations | card_transaction | ✅ | ✅ |  |
| payment_operations | clearing_record | ✅ | ✅ |  |
| payment_operations | exception | ✅ | ❌ | Excluded from MVM |
| payment_operations | fx_transaction | ✅ | ✅ |  |
| payment_operations | instruction | ✅ | ✅ |  |
| payment_operations | payment_channel | ✅ | ✅ |  |
| payment_operations | payment_mandate | ✅ | ✅ |  |
| payment_operations | payment_transaction | ✅ | ✅ |  |
| payment_operations | reconciliation | ✅ | ✅ |  |
| payment_operations | return | ✅ | ✅ |  |
| payment_operations | routing | ✅ | ✅ |  |
| payment_operations | status_event | ✅ | ✅ |  |
| payment_operations | swift_message | ✅ | ❌ | Excluded from MVM |
| reconciliation_operations | reconciliation_item | ❌ | ✅ | MVM only (stub or new) |
| risk_compliance | payment_fee | ✅ | ❌ | Excluded from MVM |
| risk_compliance | sanction_screening | ✅ | ✅ |  |

<a id="domain-reference"></a>
### reference

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| currency_management | benchmark_rate_fixing | ✅ | ✅ |  |
| currency_management | currency | ✅ | ✅ |  |
| currency_management | exchange_rate | ✅ | ✅ |  |
| currency_management | holiday_calendar | ✅ | ✅ |  |
| currency_management | holiday_date | ✅ | ✅ |  |
| currency_management | rate_benchmark | ✅ | ✅ |  |
| instrument_registry | bic_directory | ✅ | ✅ |  |
| instrument_registry | code_list | ✅ | ❌ | Excluded from MVM |
| instrument_registry | instrument_classification | ✅ | ❌ | Excluded from MVM |
| instrument_registry | instrument_identifier | ✅ | ❌ | Excluded from MVM |
| instrument_registry | lei_registry | ✅ | ✅ |  |
| instrument_registry | market_center | ✅ | ❌ | Excluded from MVM |
| instrument_registry | market_data_source | ✅ | ❌ | Excluded from MVM |
| instrument_registry | product_type | ✅ | ✅ |  |
| regulatory_taxonomy | country | ✅ | ✅ |  |
| regulatory_taxonomy | geographic_region | ✅ | ❌ | Excluded from MVM |
| regulatory_taxonomy | industry_code | ✅ | ✅ |  |
| regulatory_taxonomy | jurisdiction | ✅ | ✅ |  |
| regulatory_taxonomy | regulatory_taxonomy | ✅ | ❌ | Excluded from MVM |
| regulatory_taxonomy | reporting_code | ✅ | ❌ | Excluded from MVM |

<a id="domain-risk"></a>
### risk

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| credit_management | assessment | ✅ | ✅ |  |
| credit_management | concentration_risk | ✅ | ❌ | Excluded from MVM |
| credit_management | counterparty_rating | ✅ | ✅ |  |
| credit_management | credit_exposure | ✅ | ✅ |  |
| credit_management | irb_model | ✅ | ❌ | Excluded from MVM |
| credit_management | model_deployment | ✅ | ❌ | Excluded from MVM |
| credit_management | model_validation | ✅ | ❌ | Excluded from MVM |
| credit_management | risk_ecl_provision | ✅ | ✅ |  |
| liquidity_governance | kri_measurement | ✅ | ✅ |  |
| liquidity_governance | liquidity_metric | ✅ | ✅ |  |
| market_analysis | factor | ✅ | ✅ |  |
| market_analysis | market_risk_position | ✅ | ✅ |  |
| market_analysis | scenario_result | ✅ | ❌ | Excluded from MVM |
| market_analysis | stress_scenario | ✅ | ✅ |  |
| market_analysis | stress_test_factor_result | ✅ | ❌ | Excluded from MVM |
| market_analysis | stress_test_run | ✅ | ✅ |  |
| market_analysis | valuation_model | ✅ | ❌ | Excluded from MVM |
| operational_oversight | appetite | ✅ | ✅ |  |
| operational_oversight | operational_risk_event | ✅ | ✅ |  |
| operational_oversight | risk_limit | ✅ | ✅ |  |
| operational_oversight | risk_report | ✅ | ❌ | Excluded from MVM |
| operational_oversight | scenario_appetite_result | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-security"></a>
### security

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| credit_risk | credit_rating | ✅ | ✅ |  |
| credit_risk | instrument_lifecycle | ✅ | ❌ | Excluded from MVM |
| credit_risk | instrument_relationship | ✅ | ❌ | Excluded from MVM |
| market_operations | constituent | ✅ | ❌ | Excluded from MVM |
| market_operations | corporate_action | ✅ | ✅ |  |
| market_operations | index_constituent | ✅ | ❌ | Excluded from MVM |
| market_operations | instrument_channel_availability | ✅ | ❌ | Excluded from MVM |
| market_operations | instrument_eligibility | ✅ | ❌ | Excluded from MVM |
| market_operations | instrument_haircut_applicability | ✅ | ❌ | Excluded from MVM |
| market_operations | liquidity_holding | ✅ | ❌ | Excluded from MVM |
| market_operations | security_holding | ✅ | ❌ | Excluded from MVM |
| market_operations | security_watchlist | ✅ | ❌ | Excluded from MVM |
| market_operations | trading_restriction | ✅ | ❌ | Excluded from MVM |
| pricing_valuation | coupon_schedule | ✅ | ❌ | Excluded from MVM |
| pricing_valuation | price | ✅ | ✅ |  |
| pricing_valuation | yield_curve | ✅ | ✅ |  |
| pricing_valuation | yield_curve_node | ✅ | ❌ | Excluded from MVM |
| product_catalog | benchmark | ✅ | ✅ |  |
| product_catalog | classification | ✅ | ✅ |  |
| product_catalog | derivative | ✅ | ✅ |  |
| product_catalog | equity | ✅ | ✅ |  |
| product_catalog | fixed_income | ✅ | ✅ |  |
| product_catalog | identifier | ✅ | ✅ |  |
| product_catalog | instrument | ✅ | ✅ |  |
| product_catalog | issuer | ✅ | ✅ |  |
| product_catalog | listing | ✅ | ✅ |  |
| product_catalog | prospectus | ✅ | ❌ | Excluded from MVM |
| product_catalog | structured_product | ✅ | ❌ | Excluded from MVM |

<a id="domain-trade"></a>
### trade

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| execution_processing | best_execution | ✅ | ❌ | Excluded from MVM |
| execution_processing | capture | ✅ | ✅ |  |
| execution_processing | clearing_instruction | ✅ | ❌ | Excluded from MVM |
| execution_processing | confirmation | ✅ | ✅ |  |
| execution_processing | execution | ✅ | ✅ |  |
| execution_processing | mtm_valuation | ✅ | ✅ |  |
| execution_processing | pnl_attribution | ✅ | ❌ | Excluded from MVM |
| execution_processing | regulatory_report | ✅ | ❌ | Excluded from MVM |
| execution_processing | settlement_instruction | ✅ | ✅ |  |
| execution_processing | trade_fee | ✅ | ✅ |  |
| execution_processing | trade_lifecycle_event | ✅ | ❌ | Excluded from MVM |
| execution_processing | trade_margin_call | ✅ | ❌ | Excluded from MVM |
| execution_processing | trade_position | ✅ | ✅ |  |
| order_management | allocation | ✅ | ✅ |  |
| order_management | amendment | ✅ | ❌ | Excluded from MVM |
| order_management | order | ✅ | ✅ |  |
| reference_data | broker | ✅ | ✅ |  |
| reference_data | clearing_house | ✅ | ✅ |  |
| reference_data | commission_schedule | ✅ | ❌ | Excluded from MVM |
| reference_data | compression_cycle | ✅ | ❌ | Excluded from MVM |
| reference_data | counterparty_agreement | ✅ | ✅ |  |
| reference_data | isda_master_agreement | ✅ | ❌ | Excluded from MVM |
| reference_data | trade_repository | ✅ | ❌ | Excluded from MVM |
| reference_data | trading_book | ✅ | ✅ |  |

<a id="domain-treasury"></a>
### treasury

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_liability | alco_meeting | ✅ | ❌ | Excluded from MVM |
| asset_liability | alco_resolution | ✅ | ❌ | Excluded from MVM |
| asset_liability | alm_hedge | ✅ | ❌ | Excluded from MVM |
| asset_liability | balance_sheet_position | ✅ | ❌ | Excluded from MVM |
| asset_liability | interest_rate_risk_position | ✅ | ✅ |  |
| asset_liability | investment_portfolio | ✅ | ❌ | Excluded from MVM |
| asset_liability | nostro_account | ✅ | ✅ |  |
| asset_liability | nostro_reconciliation | ✅ | ❌ | Excluded from MVM |
| capital_planning | capital_plan | ✅ | ✅ |  |
| capital_planning | capital_ratio | ✅ | ✅ |  |
| capital_planning | debt_issuance | ✅ | ✅ |  |
| capital_planning | ftp_allocation | ✅ | ✅ |  |
| capital_planning | ftp_rate | ✅ | ✅ |  |
| capital_planning | funding_plan | ✅ | ✅ |  |
| capital_planning | transfer_pricing_curve | ✅ | ❌ | Excluded from MVM |
| liquidity_management | cash_flow_forecast | ✅ | ✅ |  |
| liquidity_management | contingency_funding_plan | ✅ | ❌ | Excluded from MVM |
| liquidity_management | hqla_inventory | ✅ | ✅ |  |
| liquidity_management | interbank_placement | ✅ | ✅ |  |
| liquidity_management | liquidity_position | ✅ | ✅ |  |
| liquidity_management | liquidity_ratio | ✅ | ✅ |  |
| liquidity_management | repo_position | ✅ | ✅ |  |
| liquidity_management | repo_transaction | ✅ | ✅ |  |
| liquidity_management | stress_scenario_cfp | ✅ | ❌ | Excluded from MVM |

<a id="domain-wealth"></a>
### wealth

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| client_advisory | client_mandate | ✅ | ✅ |  |
| client_advisory | estate_plan | ✅ | ❌ | Excluded from MVM |
| client_advisory | fee_billing | ✅ | ✅ |  |
| client_advisory | fee_schedule | ❌ | ✅ | MVM only (stub or new) |
| client_advisory | suitability_assessment | ✅ | ✅ |  |
| client_advisory | trust_account | ✅ | ✅ |  |
| client_advisory | wealth_fee_schedule | ✅ | ❌ | Excluded from MVM |
| governance_compliance | investment_committee | ✅ | ❌ | Excluded from MVM |
| governance_compliance | prime_broker_agreement | ✅ | ❌ | Excluded from MVM |
| investment_operations | custodian_account | ✅ | ✅ |  |
| investment_operations | investment_proposal | ✅ | ❌ | Excluded from MVM |
| investment_operations | nav_calculation | ✅ | ✅ |  |
| investment_operations | performance_return | ✅ | ✅ |  |
| investment_operations | portfolio_corporate_action | ✅ | ❌ | Excluded from MVM |
| investment_operations | portfolio_transaction | ✅ | ✅ |  |
| investment_operations | rebalancing_order | ✅ | ✅ |  |
| investment_operations | tax_lot | ✅ | ✅ |  |
| portfolio_management | alternative_investment | ✅ | ❌ | Excluded from MVM |
| portfolio_management | asset_allocation | ✅ | ✅ |  |
| portfolio_management | composite | ✅ | ❌ | Excluded from MVM |
| portfolio_management | holding_pledge | ✅ | ❌ | Excluded from MVM |
| portfolio_management | investment_policy_statement | ✅ | ✅ |  |
| portfolio_management | managed_portfolio | ✅ | ✅ |  |
| portfolio_management | model_portfolio | ✅ | ✅ |  |
| portfolio_management | portfolio_assignment | ✅ | ❌ | Excluded from MVM |
| portfolio_management | portfolio_broker_relationship | ✅ | ❌ | Excluded from MVM |
| portfolio_management | portfolio_holding | ❌ | ✅ | MVM only (stub or new) |
| portfolio_management | portfolio_pledge | ✅ | ❌ | Excluded from MVM |
| portfolio_management | portfolio_servicing | ✅ | ❌ | Excluded from MVM |
| portfolio_management | portfolio_stress_application | ✅ | ❌ | Excluded from MVM |
| portfolio_management | wealth_holding | ✅ | ❌ | Excluded from MVM |
| portfolio_management | wealth_portfolio_holding | ✅ | ❌ | Excluded from MVM |
