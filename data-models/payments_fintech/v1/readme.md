# Payments Fintech Lakehouse Data Models

**Version 1** | Generated on May 04, 2026 at 12:01 AM

**Industry:** payments-fintech

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Cardholder](#domain-cardholder)
  - [Compliance](#domain-compliance)
  - [Dispute](#domain-dispute)
  - [Fraud](#domain-fraud)
  - [Fx](#domain-fx)
  - [Gateway](#domain-gateway)
  - [Interchange](#domain-interchange)
  - [Ledger](#domain-ledger)
  - [Merchant](#domain-merchant)
  - [Network](#domain-network)
  - [Partner](#domain-partner)
  - [Product](#domain-product)
  - [Reference](#domain-reference)
  - [Risk](#domain-risk)
  - [Settlement](#domain-settlement)
  - [Terminal](#domain-terminal)
  - [Transaction](#domain-transaction)
  - [Workforce](#domain-workforce)


## Business Description

Payments and Fintech is a transformative industry connecting consumers, merchants, and financial institutions through fast, secure electronic payment networks, digital wallets, and innovative financial technology solutions spanning over 200 countries.

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
| Domains | 15 | 18 |
| Subdomains | 39 | 61 |
| Products (Tables) | 223 | 546 |
| Attributes (Columns) | 7890 | 16916 |
| Foreign Keys | 1624 | 2188 |
| Avg Attributes/Product | 35.4 | 31.0 |

## Domain & Product Comparison

<a id="domain-cardholder"></a>
### cardholder

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | account_status_history | ✅ | ✅ |  |
| account_management | cardholder_account | ✅ | ✅ |  |
| account_management | cardholder_velocity_control | ✅ | ✅ |  |
| account_management | consent | ✅ | ✅ |  |
| account_management | linked_account | ✅ | ✅ |  |
| account_management | payment_credential | ✅ | ✅ |  |
| account_management | program_enrollment | ✅ | ❌ | Excluded from MVM |
| account_management | relationship | ✅ | ❌ | Excluded from MVM |
| account_management | segment | ✅ | ✅ |  |
| customer_interaction | authentication_event | ✅ | ✅ |  |
| customer_interaction | authentication_session | ✅ | ❌ | Excluded from MVM |
| customer_interaction | cardholder_sca_challenge | ✅ | ✅ |  |
| customer_interaction | contact_event | ✅ | ❌ | Excluded from MVM |
| customer_interaction | device | ✅ | ✅ |  |
| customer_interaction | notification_preference | ✅ | ❌ | Excluded from MVM |
| identity_verification | account_holder | ✅ | ✅ |  |
| identity_verification | address | ✅ | ✅ |  |
| identity_verification | authorized_user | ✅ | ❌ | Excluded from MVM |
| identity_verification | cardholder_aml_screening_result | ✅ | ❌ | Excluded from MVM |
| identity_verification | cardholder_kyc_verification | ✅ | ✅ |  |
| identity_verification | cardholder_profile | ✅ | ✅ |  |
| identity_verification | cardholder_risk_profile | ✅ | ❌ | Excluded from MVM |
| identity_verification | corporate_cardholder | ✅ | ❌ | Excluded from MVM |
| identity_verification | kyc_document | ✅ | ✅ |  |
| identity_verification | pan_record | ✅ | ✅ |  |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| aml_screening | compliance_aml_screening_result | ✅ | ❌ | Excluded from MVM |
| aml_screening | ctf_control | ✅ | ❌ | Excluded from MVM |
| aml_screening | sanctions_check | ✅ | ✅ |  |
| aml_screening | watchlist_entry | ✅ | ✅ |  |
| compliance_operations | case_party_involvement | ❌ | ✅ | MVM only (stub or new) |
| customer_rights | breach_notification | ✅ | ❌ | Excluded from MVM |
| customer_rights | compliance_kyc_verification | ✅ | ✅ |  |
| customer_rights | consent_record | ✅ | ✅ |  |
| customer_rights | gdpr_data_subject_request | ✅ | ❌ | Excluded from MVM |
| customer_rights | jurisdiction_profile | ✅ | ✅ |  |
| customer_rights | training_completion | ✅ | ❌ | Excluded from MVM |
| customer_rights | training_module | ✅ | ❌ | Excluded from MVM |
| policy_controls | attestation | ✅ | ❌ | Excluded from MVM |
| policy_controls | case_transaction_link | ✅ | ❌ | Excluded from MVM |
| policy_controls | compliance_case | ✅ | ✅ |  |
| policy_controls | control | ✅ | ✅ |  |
| policy_controls | control_assessment | ✅ | ✅ |  |
| policy_controls | party | ✅ | ✅ | Also in domain(s): fx, product, risk |
| policy_controls | policy_document | ✅ | ✅ |  |
| policy_controls | regulatory_obligation | ✅ | ✅ |  |
| policy_controls | remediation_action | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | examination_request | ✅ | ✅ |  |
| regulatory_reporting | pci_dss_audit | ✅ | ✅ |  |
| regulatory_reporting | psd2_incident_report | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | regulatory_filing | ✅ | ✅ |  |
| regulatory_reporting | sar_filing | ✅ | ✅ |  |
| regulatory_reporting | sca_exemption | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | str_filing | ✅ | ❌ | Excluded from MVM |
| risk_screening | aml_screening_result | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-dispute"></a>
### dispute

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_governance | dispute_compliance_case | ✅ | ❌ | Excluded from MVM |
| compliance_governance | notification_template | ✅ | ❌ | Excluded from MVM |
| compliance_governance | ratio_monitor | ✅ | ✅ |  |
| compliance_governance | rule_config | ✅ | ✅ |  |
| dispute_processing | arbitration_case | ✅ | ✅ |  |
| dispute_processing | chargeback | ✅ | ✅ |  |
| dispute_processing | claim | ✅ | ✅ |  |
| dispute_processing | dispute_case | ✅ | ✅ |  |
| dispute_processing | dispute_lifecycle_event | ✅ | ❌ | Excluded from MVM |
| dispute_processing | dispute_notification | ✅ | ❌ | Excluded from MVM |
| dispute_processing | evidence_package | ✅ | ✅ |  |
| dispute_processing | lifecycle_event | ❌ | ✅ | MVM only (stub or new) |
| dispute_processing | merchant_response | ✅ | ✅ |  |
| dispute_processing | pre_arbitration | ✅ | ✅ |  |
| dispute_processing | representment | ✅ | ✅ |  |
| dispute_processing | retrieval_request | ✅ | ✅ |  |
| financial_settlement | fee | ✅ | ✅ |  |
| financial_settlement | financial_adjustment | ✅ | ✅ |  |

<a id="domain-fraud"></a>
### fraud

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| case_management | case_payment_link | ✅ | ❌ | Excluded from MVM |
| case_management | case_status_history | ✅ | ❌ | Excluded from MVM |
| case_management | evidence | ✅ | ✅ |  |
| case_management | fraud_case | ✅ | ✅ |  |
| case_management | fraud_notification | ✅ | ❌ | Excluded from MVM |
| case_management | investigation | ✅ | ✅ |  |
| case_management | loss | ✅ | ✅ |  |
| case_management | loss_allocation | ✅ | ❌ | Excluded from MVM |
| case_management | type | ❌ | ✅ | MVM only (stub or new) |
| detection_scoring | auth_3ds_result | ✅ | ✅ |  |
| detection_scoring | compromised_credential | ✅ | ❌ | Excluded from MVM |
| detection_scoring | device_fingerprint | ✅ | ✅ |  |
| detection_scoring | false_positive_review | ✅ | ❌ | Excluded from MVM |
| detection_scoring | fraud_alert | ✅ | ❌ | Excluded from MVM |
| detection_scoring | fraud_sca_challenge | ✅ | ✅ |  |
| detection_scoring | mule_account | ✅ | ❌ | Excluded from MVM |
| detection_scoring | network_fraud_advisory | ✅ | ❌ | Excluded from MVM |
| detection_scoring | score_event | ✅ | ✅ |  |
| detection_scoring | velocity_breach | ✅ | ✅ |  |
| detection_scoring | watchlist | ✅ | ✅ |  |
| fraud_detection | alert | ❌ | ✅ | MVM only (stub or new) |
| reference_data | audit_trail | ✅ | ❌ | Excluded from MVM |
| reference_data | fraud_channel | ✅ | ❌ | Excluded from MVM |
| reference_data | fraud_type | ✅ | ❌ | Excluded from MVM |
| reference_data | message_template | ✅ | ❌ | Excluded from MVM |
| reference_data | test_dataset | ✅ | ❌ | Excluded from MVM |
| rule_configuration | blocklist_audit | ✅ | ❌ | Excluded from MVM |
| rule_configuration | blocklist_entry | ✅ | ✅ |  |
| rule_configuration | fraud_rule | ✅ | ✅ |  |
| rule_configuration | fraud_velocity_control | ✅ | ✅ |  |
| rule_configuration | rule_set | ✅ | ❌ | Excluded from MVM |
| rule_configuration | rule_test | ✅ | ❌ | Excluded from MVM |
| rule_configuration | rule_version | ✅ | ✅ |  |

<a id="domain-fx"></a>
### fx

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| banking_relationships | corridor_bank_assignment | ❌ | ✅ | MVM only (stub or new) |
| fx_pricing | conversion_audit | ✅ | ❌ | Excluded from MVM |
| fx_pricing | currency_pair | ✅ | ✅ |  |
| fx_pricing | dcc_config | ✅ | ✅ |  |
| fx_pricing | exposure | ✅ | ✅ |  |
| fx_pricing | forward_contract | ✅ | ❌ | Excluded from MVM |
| fx_pricing | fx_fee_schedule | ✅ | ✅ |  |
| fx_pricing | rate | ✅ | ✅ |  |
| fx_pricing | rate_feed | ✅ | ✅ |  |
| fx_pricing | rate_margin_config | ✅ | ✅ |  |
| fx_pricing | rate_snapshot | ✅ | ❌ | Excluded from MVM |
| liquidity_management | correspondent_bank | ✅ | ✅ |  |
| liquidity_management | counterparty | ✅ | ❌ | Excluded from MVM |
| liquidity_management | iban_routing | ✅ | ❌ | Excluded from MVM |
| liquidity_management | liquidity_position | ✅ | ❌ | Excluded from MVM |
| liquidity_management | nostro_account | ✅ | ✅ |  |
| liquidity_management | nostro_balance | ✅ | ✅ |  |
| liquidity_management | payment_corridor | ✅ | ✅ |  |
| liquidity_management | treasury_unit | ✅ | ❌ | Excluded from MVM |
| payment_processing | beneficiary | ✅ | ✅ |  |
| payment_processing | cross_border_fee | ✅ | ❌ | Excluded from MVM |
| payment_processing | cross_border_payment | ✅ | ✅ |  |
| payment_processing | currency_pair_enrollment | ✅ | ❌ | Excluded from MVM |
| payment_processing | dcc_transaction | ✅ | ✅ |  |
| payment_processing | multicurrency_settlement | ✅ | ❌ | Excluded from MVM |
| payment_processing | party | ✅ | ❌ | Excluded from MVM |
| payment_processing | swift_gpi_tracker | ✅ | ❌ | Excluded from MVM |
| payment_processing | swift_message | ✅ | ❌ | Excluded from MVM |
| rate_management | feed_coverage | ❌ | ✅ | MVM only (stub or new) |
| regulatory_compliance | fx_reconciliation | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | psd2_fx_disclosure | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | regulatory_reporting_req | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | sanctions_screening_result | ✅ | ❌ | Excluded from MVM |

<a id="domain-gateway"></a>
### gateway

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| integration_management | api_version | ✅ | ❌ | Excluded from MVM |
| integration_management | gateway_api_credential | ✅ | ✅ |  |
| integration_management | merchant_integration | ✅ | ✅ |  |
| integration_management | merchant_sdk_adoption | ✅ | ❌ | Excluded from MVM |
| integration_management | region | ✅ | ❌ | Excluded from MVM |
| integration_management | sdk_adoption | ✅ | ❌ | Excluded from MVM |
| integration_management | sdk_version | ✅ | ❌ | Excluded from MVM |
| integration_management | webhook_delivery | ✅ | ✅ |  |
| integration_management | webhook_subscription | ✅ | ✅ |  |
| performance_monitoring | event_log | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | request | ✅ | ✅ |  |
| performance_monitoring | response | ✅ | ✅ |  |
| performance_monitoring | sla_breach | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | sla_measurement | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | sla_profile | ✅ | ✅ |  |
| routing_operations | acquirer_endpoint | ✅ | ✅ |  |
| routing_operations | endpoint_health | ✅ | ❌ | Excluded from MVM |
| routing_operations | failover_event | ✅ | ✅ |  |
| routing_operations | gateway_protocol_config | ✅ | ❌ | Excluded from MVM |
| routing_operations | gateway_routing_rule | ✅ | ✅ |  |
| routing_operations | routing_decision | ✅ | ✅ |  |
| security_controls | gateway3ds_authentication | ✅ | ❌ | Excluded from MVM |
| security_controls | ip_allowlist | ✅ | ❌ | Excluded from MVM |
| security_controls | rate_limit_breach | ✅ | ❌ | Excluded from MVM |
| security_controls | rate_limit_policy | ✅ | ✅ |  |
| security_controls | threeds_config | ✅ | ✅ |  |
| security_controls | tls_certificate | ✅ | ❌ | Excluded from MVM |
| security_controls | tokenization_request | ✅ | ❌ | Excluded from MVM |

<a id="domain-interchange"></a>
### interchange

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| fee_configuration | acquiring_portfolio_pricing | ✅ | ❌ | Excluded from MVM |
| fee_configuration | cross_border_fee_rule | ✅ | ✅ |  |
| fee_configuration | mdr_config | ✅ | ✅ |  |
| fee_configuration | msf_schedule | ✅ | ✅ |  |
| fee_configuration | payfac_sub_merchant_pricing | ✅ | ❌ | Excluded from MVM |
| fee_configuration | pricing_exception | ✅ | ✅ |  |
| fee_configuration | program_fee_schedule_assignment | ✅ | ❌ | Excluded from MVM |
| fee_configuration | scheme_fee_table | ✅ | ✅ |  |
| fee_configuration | volume_tier_threshold | ✅ | ✅ |  |
| rate_management | bin_interchange_rule | ✅ | ✅ |  |
| rate_management | durbin_compliance_tier | ✅ | ❌ | Excluded from MVM |
| rate_management | irf_rate_category | ✅ | ✅ |  |
| rate_management | irf_table | ✅ | ✅ |  |
| rate_management | mcc_interchange_map | ✅ | ❌ | Excluded from MVM |
| rate_management | pricing_tier | ✅ | ❌ | Excluded from MVM |
| rate_management | program | ✅ | ✅ |  |
| rate_management | rate_history | ✅ | ❌ | Excluded from MVM |
| revenue_accounting | issuer_interchange_income | ✅ | ❌ | Excluded from MVM |
| revenue_accounting | revenue_recognition_entry | ✅ | ❌ | Excluded from MVM |
| transaction_processing | billing | ✅ | ✅ |  |
| transaction_processing | cost_of_acceptance | ✅ | ✅ |  |
| transaction_processing | downgrade | ✅ | ✅ |  |
| transaction_processing | interchange_dispute | ✅ | ❌ | Excluded from MVM |
| transaction_processing | interchange_reconciliation | ✅ | ❌ | Excluded from MVM |
| transaction_processing | qualification | ✅ | ✅ |  |
| transaction_processing | scheme_invoice | ✅ | ✅ |  |
| transaction_processing | scheme_invoice_line | ✅ | ❌ | Excluded from MVM |

<a id="domain-ledger"></a>
### ledger

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_controls | audit_session | ✅ | ❌ | Excluded from MVM |
| compliance_controls | audit_trail | ✅ | ❌ | Excluded from MVM |
| compliance_controls | contract | ✅ | ❌ | Excluded from MVM |
| compliance_controls | performance_obligation | ✅ | ❌ | Excluded from MVM |
| compliance_controls | related_party | ✅ | ❌ | Excluded from MVM |
| compliance_controls | sox_control | ✅ | ❌ | Excluded from MVM |
| compliance_controls | sox_control_test | ✅ | ❌ | Excluded from MVM |
| compliance_controls | vendor | ✅ | ❌ | Excluded from MVM |
| cost_management | accrual_entry | ✅ | ❌ | Excluded from MVM |
| cost_management | allocation_rule | ✅ | ❌ | Excluded from MVM |
| cost_management | cost_center | ✅ | ✅ |  |
| cost_management | depreciation_schedule | ✅ | ❌ | Excluded from MVM |
| cost_management | expense_allocation | ✅ | ❌ | Excluded from MVM |
| cost_management | fixed_asset | ✅ | ❌ | Excluded from MVM |
| financial_reporting | budget | ✅ | ❌ | Excluded from MVM |
| financial_reporting | consolidation_entry | ✅ | ❌ | Excluded from MVM |
| financial_reporting | consolidation_group | ✅ | ❌ | Excluded from MVM |
| financial_reporting | financial_statement | ✅ | ✅ |  |
| financial_reporting | fx_revaluation | ✅ | ❌ | Excluded from MVM |
| financial_reporting | revenue_line | ✅ | ❌ | Excluded from MVM |
| financial_reporting | revenue_recognition_event | ✅ | ✅ |  |
| financial_reporting | revenue_recognition_schedule | ✅ | ✅ |  |
| financial_reporting | tax_provision | ✅ | ❌ | Excluded from MVM |
| general_ledger | account_reconciliation | ✅ | ✅ |  |
| general_ledger | accounting_period | ✅ | ✅ |  |
| general_ledger | config | ❌ | ✅ | MVM only (stub or new) |
| general_ledger | gl_account | ✅ | ✅ |  |
| general_ledger | gl_balance | ✅ | ✅ |  |
| general_ledger | intercompany_transaction | ✅ | ❌ | Excluded from MVM |
| general_ledger | journal_entry | ✅ | ✅ |  |
| general_ledger | journal_line | ✅ | ✅ |  |
| general_ledger | ledger_config | ✅ | ❌ | Excluded from MVM |
| general_ledger | legal_entity | ✅ | ✅ |  |
| general_ledger | payable | ✅ | ✅ |  |
| general_ledger | period_close_task | ✅ | ❌ | Excluded from MVM |
| general_ledger | receivable | ✅ | ✅ |  |
| general_ledger | subledger_entry | ✅ | ✅ |  |

<a id="domain-merchant"></a>
### merchant

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| financial_operations | hierarchy | ❌ | ✅ | MVM only (stub or new) |
| financial_operations | location | ❌ | ✅ | MVM only (stub or new) |
| merchant_onboarding | acquiring_agreement | ✅ | ✅ |  |
| merchant_onboarding | application | ✅ | ✅ |  |
| merchant_onboarding | beneficial_owner | ✅ | ✅ |  |
| merchant_onboarding | boarding_event | ✅ | ❌ | Excluded from MVM |
| merchant_onboarding | document | ✅ | ❌ | Excluded from MVM |
| merchant_onboarding | kyb_verification | ✅ | ✅ |  |
| merchant_onboarding | merchant | ✅ | ✅ |  |
| merchant_onboarding | merchant_contact | ✅ | ✅ |  |
| merchant_onboarding | merchant_location | ✅ | ❌ | Excluded from MVM |
| merchant_onboarding | note | ✅ | ❌ | Excluded from MVM |
| merchant_onboarding | scheme_registration | ✅ | ❌ | Excluded from MVM |
| merchant_onboarding | status_history | ✅ | ❌ | Excluded from MVM |
| pricing_strategy | mcc_assignment | ✅ | ✅ |  |
| pricing_strategy | merchant_fee_schedule | ✅ | ✅ |  |
| pricing_strategy | merchant_pricing_plan | ✅ | ✅ |  |
| risk_compliance | risk_profile | ❌ | ✅ | In ECM under domain(s): risk |
| risk_management | chargeback_threshold | ✅ | ❌ | Excluded from MVM |
| risk_management | merchant_reserve_account | ✅ | ❌ | Excluded from MVM |
| risk_management | merchant_risk_profile | ✅ | ❌ | Excluded from MVM |
| risk_management | pci_compliance | ✅ | ✅ |  |
| risk_management | processing_limit | ✅ | ✅ |  |
| risk_management | risk_rule_override | ✅ | ❌ | Excluded from MVM |
| settlement_operations | merchant_account | ✅ | ✅ |  |
| settlement_operations | merchant_hierarchy | ✅ | ❌ | Excluded from MVM |
| settlement_operations | merchant_settlement_account | ✅ | ✅ |  |
| settlement_operations | payment_facilitator | ✅ | ❌ | Excluded from MVM |
| settlement_operations | portfolio | ✅ | ❌ | Excluded from MVM |
| settlement_operations | sub_merchant | ✅ | ✅ |  |
| settlement_operations | terminal_assignment | ✅ | ❌ | Excluded from MVM |

<a id="domain-network"></a>
### network

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_certification | network_certification_record | ✅ | ❌ | Excluded from MVM |
| compliance_certification | regulatory_coverage | ✅ | ❌ | Excluded from MVM |
| compliance_certification | scheme_certification | ✅ | ❌ | Excluded from MVM |
| compliance_certification | scheme_compliance_record | ✅ | ❌ | Excluded from MVM |
| compliance_certification | scheme_obligation_mapping | ✅ | ❌ | Excluded from MVM |
| network_connectivity | connectivity_event | ✅ | ❌ | Excluded from MVM |
| network_connectivity | cutover | ✅ | ❌ | Excluded from MVM |
| network_connectivity | endpoint | ✅ | ✅ |  |
| network_connectivity | failover_config | ✅ | ❌ | Excluded from MVM |
| network_connectivity | message_log | ✅ | ❌ | Excluded from MVM |
| network_connectivity | sla | ✅ | ✅ |  |
| routing_configuration | multi_network_routing | ✅ | ✅ |  |
| routing_configuration | network_protocol_config | ✅ | ❌ | Excluded from MVM |
| routing_configuration | network_response_code | ✅ | ❌ | Excluded from MVM |
| routing_configuration | network_routing_rule | ✅ | ✅ |  |
| routing_configuration | network_routing_rule2 | ✅ | ❌ | Excluded from MVM |
| routing_configuration | routing_table | ✅ | ✅ |  |
| routing_configuration | volume_limit | ✅ | ❌ | Excluded from MVM |
| scheme_governance | dcc_pricing | ✅ | ❌ | Excluded from MVM |
| scheme_governance | emv_parameter | ✅ | ❌ | Excluded from MVM |
| scheme_governance | scheme | ✅ | ✅ |  |
| scheme_governance | scheme_bulletin | ✅ | ❌ | Excluded from MVM |
| scheme_governance | scheme_event | ✅ | ❌ | Excluded from MVM |
| scheme_governance | scheme_fee_schedule | ✅ | ✅ |  |
| scheme_governance | scheme_membership | ✅ | ✅ |  |
| scheme_governance | scheme_parameter | ✅ | ✅ |  |

<a id="domain-partner"></a>
### partner

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_governance | bin_sponsorship | ✅ | ✅ |  |
| compliance_governance | network_participation | ✅ | ✅ |  |
| compliance_governance | partner_certification_record | ✅ | ❌ | Excluded from MVM |
| compliance_governance | remediation_plan | ✅ | ❌ | Excluded from MVM |
| compliance_governance | sla_breach_event | ✅ | ❌ | Excluded from MVM |
| compliance_governance | sla_commitment | ✅ | ✅ |  |
| integration_services | api_credential_rotation | ✅ | ❌ | Excluded from MVM |
| integration_services | integration_endpoint | ✅ | ✅ |  |
| integration_services | integration_test_case | ✅ | ❌ | Excluded from MVM |
| integration_services | integration_test_result | ✅ | ❌ | Excluded from MVM |
| integration_services | onboarding_application | ✅ | ✅ |  |
| integration_services | onboarding_document | ✅ | ❌ | Excluded from MVM |
| integration_services | partner_api_credential | ✅ | ✅ |  |
| integration_services | rail_onboarding | ✅ | ❌ | Excluded from MVM |
| integration_services | sub_merchant_registration | ✅ | ❌ | Excluded from MVM |
| partner_management | agreement | ✅ | ✅ |  |
| partner_management | ecosystem_partner | ✅ | ✅ |  |
| partner_management | manager_assignment | ✅ | ❌ | Excluded from MVM |
| partner_management | partner_contact | ✅ | ✅ |  |
| partner_management | partner_event | ✅ | ❌ | Excluded from MVM |
| partner_management | partner_hierarchy | ✅ | ❌ | Excluded from MVM |
| partner_management | partner_profile | ✅ | ✅ |  |
| partner_management | partner_type | ✅ | ❌ | Excluded from MVM |
| revenue_operations | invoice | ✅ | ❌ | Excluded from MVM |
| revenue_operations | partner_fee_schedule | ✅ | ❌ | Excluded from MVM |
| revenue_operations | partner_settlement_account | ✅ | ✅ |  |
| revenue_operations | performance_period | ✅ | ❌ | Excluded from MVM |
| revenue_operations | referral_record | ✅ | ❌ | Excluded from MVM |
| revenue_operations | revenue_share_schedule | ✅ | ✅ |  |
| revenue_operations | revenue_share_statement | ✅ | ✅ |  |
| revenue_operations | volume_commitment | ✅ | ❌ | Excluded from MVM |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| channel_distribution | geography | ✅ | ❌ | Excluded from MVM |
| channel_distribution | party | ✅ | ❌ | Excluded from MVM |
| channel_distribution | product_channel | ✅ | ❌ | Excluded from MVM |
| channel_distribution | scheme_product_mapping | ✅ | ❌ | Excluded from MVM |
| channel_distribution | terminal_authorization | ✅ | ❌ | Excluded from MVM |
| offer_promotion | bundle | ✅ | ❌ | Excluded from MVM |
| offer_promotion | bundle_component | ✅ | ❌ | Excluded from MVM |
| offer_promotion | eligibility_rule | ✅ | ✅ |  |
| offer_promotion | promotional_offer | ✅ | ❌ | Excluded from MVM |
| offer_promotion | promotional_offer_redemption | ✅ | ❌ | Excluded from MVM |
| pricing_management | fee_schedule_line | ✅ | ✅ |  |
| pricing_management | interchange_qualification | ✅ | ✅ |  |
| pricing_management | limit | ✅ | ✅ |  |
| pricing_management | pricing_plan_assignment | ✅ | ❌ | Excluded from MVM |
| pricing_management | product_fee_schedule | ✅ | ✅ |  |
| pricing_management | product_lifecycle_event | ✅ | ❌ | Excluded from MVM |
| pricing_management | product_pricing_plan | ✅ | ✅ |  |
| pricing_management | rate_tier | ✅ | ✅ |  |
| product_catalog | a2a_product | ✅ | ✅ |  |
| product_catalog | bnpl_plan | ✅ | ✅ |  |
| product_catalog | card_program | ✅ | ✅ |  |
| product_catalog | feature | ✅ | ✅ |  |
| product_catalog | feature_assignment | ✅ | ✅ |  |
| product_catalog | p2p_product | ✅ | ✅ |  |
| product_catalog | payment_product | ✅ | ✅ |  |
| product_catalog | version | ✅ | ✅ |  |
| product_catalog | virtual_account_product | ✅ | ✅ |  |

<a id="domain-reference"></a>
### reference

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| geographic_metadata | country | ✅ | ❌ | Domain not in MVM |
| geographic_metadata | currency | ✅ | ❌ | Domain not in MVM |
| geographic_metadata | fx_rate | ✅ | ❌ | Domain not in MVM |
| geographic_metadata | holiday_calendar | ✅ | ❌ | Domain not in MVM |
| geographic_metadata | timezone | ✅ | ❌ | Domain not in MVM |
| payment_instruments | bin_range | ✅ | ❌ | Domain not in MVM |
| payment_instruments | card_scheme | ✅ | ❌ | Domain not in MVM |
| payment_instruments | emv_tag | ✅ | ❌ | Domain not in MVM |
| payment_instruments | financial_institution | ✅ | ❌ | Domain not in MVM |
| payment_instruments | iban_structure | ✅ | ❌ | Domain not in MVM |
| payment_instruments | issuer | ✅ | ❌ | Domain not in MVM |
| payment_instruments | issuer_wallet_config | ✅ | ❌ | Domain not in MVM |
| payment_instruments | payment_rail | ✅ | ❌ | Domain not in MVM |
| payment_instruments | qr_code | ✅ | ❌ | Domain not in MVM |
| payment_instruments | swift_bic | ✅ | ❌ | Domain not in MVM |
| payment_instruments | wallet_scheme | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | aml_risk_country | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | kyc_document_type | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | ofac_sanctions_list | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | pci_control | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | regulatory_jurisdiction | ✅ | ❌ | Domain not in MVM |
| transaction_classification | authorization_response_code | ✅ | ❌ | Domain not in MVM |
| transaction_classification | chargeback_reason_code | ✅ | ❌ | Domain not in MVM |
| transaction_classification | decline_code | ✅ | ❌ | Domain not in MVM |
| transaction_classification | iso_message_field | ✅ | ❌ | Domain not in MVM |
| transaction_classification | iso_message_type | ✅ | ❌ | Domain not in MVM |
| transaction_classification | mcc | ✅ | ❌ | Domain not in MVM |
| transaction_classification | nacha_return_code | ✅ | ❌ | Domain not in MVM |
| transaction_classification | network_error_code | ✅ | ❌ | Domain not in MVM |
| transaction_classification | scheme_message | ✅ | ❌ | Domain not in MVM |
| transaction_classification | settlement_cycle | ✅ | ❌ | Domain not in MVM |
| transaction_classification | transaction_type | ✅ | ❌ | Domain not in MVM |

<a id="domain-risk"></a>
### risk

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| limit_governance | concentration_exposure | ✅ | ❌ | Excluded from MVM |
| limit_governance | counterparty_risk_limit | ✅ | ❌ | Excluded from MVM |
| limit_governance | credit_limit | ✅ | ✅ |  |
| limit_governance | exposure_limit | ✅ | ✅ |  |
| limit_governance | threshold | ✅ | ✅ |  |
| policy_management | appetite_framework | ✅ | ❌ | Excluded from MVM |
| policy_management | mitigation_action | ✅ | ✅ |  |
| policy_management | party | ✅ | ❌ | Excluded from MVM |
| policy_management | risk_case | ✅ | ✅ |  |
| policy_management | risk_exception | ✅ | ✅ |  |
| policy_management | risk_policy | ✅ | ❌ | Excluded from MVM |
| policy_management | rule_assignment | ✅ | ❌ | Excluded from MVM |
| policy_management | underwriting_decision | ✅ | ✅ |  |
| policy_management | underwriting_policy | ✅ | ✅ |  |
| risk_monitoring | event | ❌ | ✅ | MVM only (stub or new) |
| risk_scoring | assessment | ✅ | ✅ |  |
| risk_scoring | indicator | ✅ | ✅ |  |
| risk_scoring | model_currency_pair_assignment | ✅ | ❌ | Excluded from MVM |
| risk_scoring | model_validation | ✅ | ❌ | Excluded from MVM |
| risk_scoring | risk_event | ✅ | ❌ | Excluded from MVM |
| risk_scoring | risk_model | ✅ | ❌ | Excluded from MVM |
| risk_scoring | risk_profile | ✅ | ❌ | Excluded from MVM |
| risk_scoring | risk_rule | ✅ | ✅ |  |
| underwriting_policy | model | ❌ | ✅ | MVM only (stub or new) |
| underwriting_policy | policy | ❌ | ✅ | MVM only (stub or new) |
| underwriting_policy | risk_risk_profile | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-settlement"></a>
### settlement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| funding_distribution | funding_confirmation | ✅ | ✅ |  |
| funding_distribution | funding_schedule | ✅ | ✅ |  |
| funding_distribution | merchant_payout | ✅ | ✅ |  |
| funding_distribution | reserve_movement | ✅ | ❌ | Excluded from MVM |
| funding_management | reserve_account | ❌ | ✅ | MVM only (stub or new) |
| participant_management | acquirer | ✅ | ✅ |  |
| participant_management | applied_rate | ✅ | ❌ | Excluded from MVM |
| participant_management | issuing_bank | ✅ | ❌ | Excluded from MVM |
| participant_management | nostro_reconciliation | ✅ | ❌ | Excluded from MVM |
| participant_management | participant | ✅ | ✅ |  |
| settlement_operations | adjustment | ✅ | ✅ |  |
| settlement_operations | clearing_record | ✅ | ✅ |  |
| settlement_operations | cycle | ✅ | ✅ |  |
| settlement_operations | file | ✅ | ❌ | Excluded from MVM |
| settlement_operations | instruction | ✅ | ✅ |  |
| settlement_operations | interchange_settlement | ✅ | ❌ | Excluded from MVM |
| settlement_operations | net_position | ✅ | ✅ |  |
| settlement_operations | reconciliation_record | ✅ | ✅ |  |
| settlement_operations | scheme_fee_settlement | ✅ | ❌ | Excluded from MVM |
| settlement_operations | settlement | ✅ | ✅ |  |
| settlement_operations | settlement_account | ✅ | ✅ |  |
| settlement_operations | settlement_batch | ✅ | ✅ |  |
| settlement_operations | settlement_exception | ✅ | ✅ |  |
| settlement_operations | settlement_reserve_account | ✅ | ❌ | Excluded from MVM |

<a id="domain-terminal"></a>
### terminal

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| digital_wallet | balance_movement | ✅ | ❌ | Domain not in MVM |
| digital_wallet | detokenization_request | ✅ | ❌ | Domain not in MVM |
| digital_wallet | digital_wallet | ✅ | ❌ | Domain not in MVM |
| digital_wallet | hce_credential | ✅ | ❌ | Domain not in MVM |
| digital_wallet | loyalty_account | ✅ | ❌ | Domain not in MVM |
| digital_wallet | loyalty_transaction | ✅ | ❌ | Domain not in MVM |
| digital_wallet | nfc_tap_event | ✅ | ❌ | Domain not in MVM |
| digital_wallet | p2p_transfer | ✅ | ❌ | Domain not in MVM |
| digital_wallet | provisioning_request | ✅ | ❌ | Domain not in MVM |
| digital_wallet | token_pan_mapping | ✅ | ❌ | Domain not in MVM |
| digital_wallet | token_requestor | ✅ | ❌ | Domain not in MVM |
| digital_wallet | upi_registration | ✅ | ❌ | Domain not in MVM |
| digital_wallet | wallet_balance | ✅ | ❌ | Domain not in MVM |
| digital_wallet | wallet_consent | ✅ | ❌ | Domain not in MVM |
| digital_wallet | wallet_device | ✅ | ❌ | Domain not in MVM |
| digital_wallet | wallet_enrollment | ✅ | ❌ | Domain not in MVM |
| digital_wallet | wallet_funding_source | ✅ | ❌ | Domain not in MVM |
| digital_wallet | wallet_limit | ✅ | ❌ | Domain not in MVM |
| digital_wallet | wallet_notification | ✅ | ❌ | Domain not in MVM |
| digital_wallet | wallet_sca_challenge | ✅ | ❌ | Domain not in MVM |
| digital_wallet | wallet_token | ✅ | ❌ | Domain not in MVM |
| digital_wallet | wallet_transaction | ✅ | ❌ | Domain not in MVM |
| instrument_management | ach_account | ✅ | ❌ | Domain not in MVM |
| instrument_management | alt_payment_method | ✅ | ❌ | Domain not in MVM |
| instrument_management | card | ✅ | ❌ | Domain not in MVM |
| instrument_management | card_personalization | ✅ | ❌ | Domain not in MVM |
| instrument_management | card_replacement | ✅ | ❌ | Domain not in MVM |
| instrument_management | instrument_expiry_schedule | ✅ | ❌ | Domain not in MVM |
| instrument_management | instrument_feature | ✅ | ❌ | Domain not in MVM |
| instrument_management | instrument_limit | ✅ | ❌ | Domain not in MVM |
| instrument_management | instrument_status_history | ✅ | ❌ | Domain not in MVM |
| instrument_management | pan_alias | ✅ | ❌ | Domain not in MVM |
| instrument_management | payment_instrument | ✅ | ❌ | Domain not in MVM |
| instrument_management | token | ✅ | ❌ | Domain not in MVM |
| instrument_management | upi | ✅ | ❌ | Domain not in MVM |
| instrument_management | wallet_bin_range | ✅ | ❌ | Domain not in MVM |
| instrument_management | wallet_card_scheme | ✅ | ❌ | Domain not in MVM |
| security_controls | credential_vault | ✅ | ❌ | Domain not in MVM |
| security_controls | emv_config | ✅ | ❌ | Domain not in MVM |
| security_controls | instrument_block | ✅ | ❌ | Domain not in MVM |
| security_controls | instrument_verification | ✅ | ❌ | Domain not in MVM |
| security_controls | key_injection | ✅ | ❌ | Domain not in MVM |
| security_controls | p2pe_scope | ✅ | ❌ | Domain not in MVM |
| security_controls | pin_management | ✅ | ❌ | Domain not in MVM |
| security_controls | secure_element | ✅ | ❌ | Domain not in MVM |
| security_controls | surcharge_config | ✅ | ❌ | Domain not in MVM |
| security_controls | token_lifecycle_event | ✅ | ❌ | Domain not in MVM |
| terminal_operations | acceptance_type | ✅ | ❌ | Domain not in MVM |
| terminal_operations | assignment | ✅ | ❌ | Domain not in MVM |
| terminal_operations | capability | ✅ | ❌ | Domain not in MVM |
| terminal_operations | connectivity | ✅ | ❌ | Domain not in MVM |
| terminal_operations | contactless_profile | ✅ | ❌ | Domain not in MVM |
| terminal_operations | deployment | ✅ | ❌ | Domain not in MVM |
| terminal_operations | downtime | ✅ | ❌ | Domain not in MVM |
| terminal_operations | emv_parameter_set | ✅ | ❌ | Domain not in MVM |
| terminal_operations | inventory | ✅ | ❌ | Domain not in MVM |
| terminal_operations | maintenance | ✅ | ❌ | Domain not in MVM |
| terminal_operations | pos_terminal | ✅ | ❌ | Domain not in MVM |
| terminal_operations | receipt_template | ✅ | ❌ | Domain not in MVM |
| terminal_operations | software | ✅ | ❌ | Domain not in MVM |
| terminal_operations | software_update | ✅ | ❌ | Domain not in MVM |
| terminal_operations | status_event | ✅ | ❌ | Domain not in MVM |
| terminal_operations | tamper_event | ✅ | ❌ | Domain not in MVM |
| terminal_operations | terminal_alert | ✅ | ❌ | Domain not in MVM |
| terminal_operations | terminal_batch | ✅ | ❌ | Domain not in MVM |
| terminal_operations | terminal_certification | ✅ | ❌ | Domain not in MVM |
| terminal_operations | terminal_config | ✅ | ❌ | Domain not in MVM |
| terminal_operations | terminal_fee_schedule | ✅ | ❌ | Domain not in MVM |
| terminal_operations | terminal_group | ✅ | ❌ | Domain not in MVM |
| terminal_operations | terminal_model | ✅ | ❌ | Domain not in MVM |
| terminal_operations | terminal_reconciliation | ✅ | ❌ | Domain not in MVM |
| terminal_operations | tid_provisioning | ✅ | ❌ | Domain not in MVM |

<a id="domain-transaction"></a>
### transaction

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| channel_configuration | pos_entry_mode | ✅ | ❌ | Excluded from MVM |
| channel_configuration | transaction | ✅ | ✅ |  |
| channel_configuration | transaction_response_code | ✅ | ❌ | Excluded from MVM |
| channel_configuration | txn_channel | ✅ | ❌ | Excluded from MVM |
| channel_configuration | txn_type | ✅ | ✅ |  |
| risk_management | txn_limit_rule | ✅ | ✅ |  |
| risk_management | txn_routing_decision | ✅ | ✅ |  |
| settlement_operations | ach_entry | ✅ | ❌ | Excluded from MVM |
| settlement_operations | batch_item | ✅ | ❌ | Excluded from MVM |
| settlement_operations | clearing_submission | ✅ | ✅ |  |
| settlement_operations | iso_message | ✅ | ❌ | Excluded from MVM |
| settlement_operations | reconciliation_exception | ✅ | ❌ | Excluded from MVM |
| settlement_operations | rtp_payment | ✅ | ❌ | Excluded from MVM |
| settlement_operations | swift_payment | ✅ | ❌ | Excluded from MVM |
| settlement_operations | transaction_batch | ✅ | ✅ |  |
| settlement_operations | transaction_reconciliation | ✅ | ❌ | Excluded from MVM |
| settlement_reconciliation | reconciliation | ❌ | ✅ | MVM only (stub or new) |
| transaction_processing | authorization | ✅ | ✅ |  |
| transaction_processing | capture | ✅ | ✅ |  |
| transaction_processing | fx_conversion | ✅ | ✅ |  |
| transaction_processing | instrument_issuance | ✅ | ❌ | Excluded from MVM |
| transaction_processing | payment_txn | ✅ | ✅ |  |
| transaction_processing | refund | ✅ | ✅ |  |
| transaction_processing | reversal | ✅ | ✅ |  |
| transaction_processing | stp_record | ✅ | ❌ | Excluded from MVM |
| transaction_processing | threeds_authentication | ✅ | ❌ | Excluded from MVM |
| transaction_processing | tokenized_txn | ✅ | ❌ | Excluded from MVM |
| transaction_processing | tps_metric | ✅ | ❌ | Excluded from MVM |
| transaction_processing | txn_fee | ✅ | ✅ |  |
| transaction_processing | txn_lifecycle_event | ✅ | ✅ |  |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| benefits_administration | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| benefits_administration | benefit_plan | ✅ | ❌ | Domain not in MVM |
| benefits_administration | disciplinary_action | ✅ | ❌ | Domain not in MVM |
| benefits_administration | hr_case | ✅ | ❌ | Domain not in MVM |
| benefits_administration | leave_balance | ✅ | ❌ | Domain not in MVM |
| benefits_administration | leave_request | ✅ | ❌ | Domain not in MVM |
| compensation_payroll | compensation_plan | ✅ | ❌ | Domain not in MVM |
| compensation_payroll | equity_grant | ✅ | ❌ | Domain not in MVM |
| compensation_payroll | headcount | ✅ | ❌ | Domain not in MVM |
| compensation_payroll | payroll_deduction | ✅ | ❌ | Domain not in MVM |
| compensation_payroll | payroll_period | ✅ | ❌ | Domain not in MVM |
| compensation_payroll | payroll_record | ✅ | ❌ | Domain not in MVM |
| compensation_payroll | payroll_run | ✅ | ❌ | Domain not in MVM |
| compensation_payroll | time_entry | ✅ | ❌ | Domain not in MVM |
| compensation_payroll | timesheet | ✅ | ❌ | Domain not in MVM |
| employee_records | background_check | ✅ | ❌ | Domain not in MVM |
| employee_records | compliance_record | ✅ | ❌ | Domain not in MVM |
| employee_records | employee | ✅ | ❌ | Domain not in MVM |
| employee_records | employment_contract | ✅ | ❌ | Domain not in MVM |
| employee_records | employment_event | ✅ | ❌ | Domain not in MVM |
| employee_records | job_profile | ✅ | ❌ | Domain not in MVM |
| employee_records | org_unit | ✅ | ❌ | Domain not in MVM |
| employee_records | position | ✅ | ❌ | Domain not in MVM |
| employee_records | role_assignment | ✅ | ❌ | Domain not in MVM |
| employee_records | strategy | ✅ | ❌ | Domain not in MVM |
| employee_records | team | ✅ | ❌ | Domain not in MVM |
| employee_records | work_schedule | ✅ | ❌ | Domain not in MVM |
| employee_records | workforce_location | ✅ | ❌ | Domain not in MVM |
| talent_development | goal | ✅ | ❌ | Domain not in MVM |
| talent_development | objective | ✅ | ❌ | Domain not in MVM |
| talent_development | performance_review | ✅ | ❌ | Domain not in MVM |
| talent_development | succession_plan | ✅ | ❌ | Domain not in MVM |
| talent_development | training_enrollment | ✅ | ❌ | Domain not in MVM |
| talent_development | workforce_certification | ✅ | ❌ | Domain not in MVM |
