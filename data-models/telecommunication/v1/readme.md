# Telecommunication Lakehouse Data Models

**Version 1** | Generated on May 08, 2026 at 08:31 AM

**Industry:** telecommunications

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Analytics](#domain-analytics)
  - [Assurance](#domain-assurance)
  - [Billing](#domain-billing)
  - [Compliance](#domain-compliance)
  - [Content](#domain-content)
  - [Customer](#domain-customer)
  - [Enterprise](#domain-enterprise)
  - [Finance](#domain-finance)
  - [Interconnect](#domain-interconnect)
  - [Inventory](#domain-inventory)
  - [Location](#domain-location)
  - [Network](#domain-network)
  - [Order](#domain-order)
  - [Partner](#domain-partner)
  - [People](#domain-people)
  - [Product](#domain-product)
  - [Sales](#domain-sales)
  - [Service](#domain-service)
  - [Usage](#domain-usage)
  - [Workforce](#domain-workforce)


## Business Description

Telecommunications is a global industry providing wireless services, broadband, fiber internet, and digital entertainment to billions of consumer and business customers through extensive network infrastructure.

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
| Domains | 15 | 20 |
| Subdomains | 40 | 68 |
| Products (Tables) | 167 | 451 |
| Attributes (Columns) | 7601 | 17655 |
| Foreign Keys | 1806 | 2935 |
| Avg Attributes/Product | 45.5 | 39.1 |

## Domain & Product Comparison

<a id="domain-analytics"></a>
### analytics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| data_quality | dq_execution_result | ✅ | ❌ | Domain not in MVM |
| data_quality | dq_issue | ✅ | ❌ | Domain not in MVM |
| data_quality | dq_rule | ✅ | ❌ | Domain not in MVM |
| kpi_management | customer_analytics_kpi | ✅ | ❌ | Domain not in MVM |
| kpi_management | kpi_definition | ✅ | ❌ | Domain not in MVM |
| kpi_management | kpi_target | ✅ | ❌ | Domain not in MVM |
| kpi_management | network_analytics_kpi | ✅ | ❌ | Domain not in MVM |
| kpi_management | revenue_analytics_kpi | ✅ | ❌ | Domain not in MVM |
| model_operations | analytical_model_registry | ✅ | ❌ | Domain not in MVM |
| model_operations | feature_store_definition | ✅ | ❌ | Domain not in MVM |
| model_operations | model_run | ✅ | ❌ | Domain not in MVM |
| model_operations | pipeline_run | ✅ | ❌ | Domain not in MVM |
| model_operations | retention_model_output | ✅ | ❌ | Domain not in MVM |
| reporting_analytics | analytical_dataset | ✅ | ❌ | Domain not in MVM |
| reporting_analytics | analytical_subject_area | ✅ | ❌ | Domain not in MVM |
| reporting_analytics | bi_report_definition | ✅ | ❌ | Domain not in MVM |
| reporting_analytics | dimension_hierarchy | ✅ | ❌ | Domain not in MVM |
| reporting_analytics | reporting_dimension | ✅ | ❌ | Domain not in MVM |
| segment_governance | ab_test | ✅ | ❌ | Domain not in MVM |
| segment_governance | ab_test_assignment | ✅ | ❌ | Domain not in MVM |
| segment_governance | analytics_segment_membership | ✅ | ❌ | Domain not in MVM |
| segment_governance | glossary_term | ✅ | ❌ | Domain not in MVM |
| segment_governance | segment_definition | ✅ | ❌ | Domain not in MVM |

<a id="domain-assurance"></a>
### assurance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| change_management | change_record | ✅ | ❌ | Excluded from MVM |
| change_management | outage_record | ✅ | ✅ |  |
| change_management | problem_record | ✅ | ✅ |  |
| fraud_detection | fraud_alert | ✅ | ✅ |  |
| fraud_detection | fraud_case | ✅ | ✅ |  |
| fraud_detection | fraud_pattern | ✅ | ✅ |  |
| network_operations | alarm_event | ✅ | ✅ |  |
| network_operations | noc_incident | ✅ | ✅ |  |
| network_operations | trouble_ticket | ✅ | ✅ |  |
| revenue_assurance | reconciliation_run | ✅ | ❌ | Excluded from MVM |
| revenue_assurance | revenue_leakage_case | ✅ | ❌ | Excluded from MVM |
| revenue_assurance | sla_breach_event | ✅ | ✅ |  |
| service_quality | kpi_threshold | ✅ | ✅ |  |
| service_quality | performance_measurement | ✅ | ✅ |  |
| service_quality | qos_measurement | ✅ | ❌ | Excluded from MVM |
| service_quality | sla_contract | ✅ | ✅ |  |

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | billing_account | ✅ | ✅ |  |
| account_management | billing_cycle | ✅ | ❌ | Excluded from MVM |
| account_management | billing_subscription | ✅ | ❌ | Excluded from MVM |
| account_management | contract_billing_arrangement | ✅ | ❌ | Excluded from MVM |
| account_management | prepaid_balance | ✅ | ✅ |  |
| dunning_collections | billing_dispute | ✅ | ✅ |  |
| dunning_collections | dunning_event | ✅ | ❌ | Excluded from MVM |
| dunning_collections | dunning_profile | ✅ | ❌ | Excluded from MVM |
| dunning_collections | recovery_agency | ✅ | ❌ | Excluded from MVM |
| dunning_collections | write_off | ✅ | ❌ | Excluded from MVM |
| invoice_processing | adjustment | ✅ | ✅ |  |
| invoice_processing | billing_charge | ✅ | ✅ |  |
| invoice_processing | credit_note | ✅ | ✅ |  |
| invoice_processing | cycle | ❌ | ✅ | MVM only (stub or new) |
| invoice_processing | invoice | ✅ | ✅ |  |
| invoice_processing | invoice_line | ✅ | ✅ |  |
| payment_operations | payment | ✅ | ✅ |  |
| payment_operations | payment_allocation | ✅ | ❌ | Excluded from MVM |
| payment_operations | payment_arrangement | ✅ | ✅ |  |
| payment_operations | recharge | ✅ | ✅ |  |
| payment_operations | voucher_batch | ✅ | ❌ | Excluded from MVM |
| rate_planning | corporate_rate_plan_agreement | ✅ | ❌ | Excluded from MVM |
| rate_planning | rate_plan | ✅ | ✅ |  |
| rate_planning | rate_plan_content_package | ✅ | ❌ | Excluded from MVM |
| rate_planning | rated_event | ✅ | ✅ |  |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_assurance | annual_certification | ✅ | ❌ | Excluded from MVM |
| audit_assurance | audit | ✅ | ✅ |  |
| audit_assurance | audit_finding | ✅ | ❌ | Excluded from MVM |
| audit_assurance | audit_rule_test | ✅ | ❌ | Excluded from MVM |
| audit_assurance | control | ✅ | ❌ | Excluded from MVM |
| audit_assurance | e911_compliance | ✅ | ❌ | Excluded from MVM |
| audit_assurance | lawful_intercept_order | ✅ | ✅ |  |
| audit_assurance | mnp_compliance | ✅ | ✅ |  |
| audit_assurance | spectrum_license | ✅ | ✅ |  |
| privacy_governance | cpni_authorization | ✅ | ❌ | Excluded from MVM |
| privacy_governance | data_breach_incident | ✅ | ✅ |  |
| privacy_governance | privacy_consent | ✅ | ✅ |  |
| privacy_governance | privacy_request | ✅ | ✅ |  |
| regulatory_reporting | account_obligation | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | calendar | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | coverage_obligation | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | regulatory_change | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | regulatory_filing | ✅ | ✅ |  |
| regulatory_reporting | regulatory_obligation | ✅ | ✅ |  |
| regulatory_reporting | regulatory_penalty | ✅ | ❌ | Excluded from MVM |

<a id="domain-content"></a>
### content

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| channel_operations | ad_insertion_policy | ✅ | ❌ | Domain not in MVM |
| channel_operations | content_channel_lineup | ✅ | ❌ | Domain not in MVM |
| channel_operations | epg_schedule | ✅ | ❌ | Domain not in MVM |
| channel_operations | iptv_channel | ✅ | ❌ | Domain not in MVM |
| channel_operations | lineup_channel_membership | ✅ | ❌ | Domain not in MVM |
| channel_operations | network_recording | ✅ | ❌ | Domain not in MVM |
| content_catalog | ingestion_job | ✅ | ❌ | Domain not in MVM |
| content_catalog | programme | ✅ | ❌ | Domain not in MVM |
| content_catalog | series | ✅ | ❌ | Domain not in MVM |
| content_catalog | vod_asset | ✅ | ❌ | Domain not in MVM |
| content_catalog | vod_catalog | ✅ | ❌ | Domain not in MVM |
| content_catalog | vod_rental | ✅ | ❌ | Domain not in MVM |
| package_offering | ott_platform | ✅ | ❌ | Domain not in MVM |
| package_offering | ott_subscription | ✅ | ❌ | Domain not in MVM |
| package_offering | package | ✅ | ❌ | Domain not in MVM |
| package_offering | package_lineup_inclusion | ✅ | ❌ | Domain not in MVM |
| package_offering | package_platform_inclusion | ✅ | ❌ | Domain not in MVM |
| package_offering | package_territory_availability | ✅ | ❌ | Domain not in MVM |
| rights_management | drm_policy | ✅ | ❌ | Domain not in MVM |
| rights_management | entitlement | ✅ | ❌ | Domain not in MVM |
| rights_management | geo_restriction | ✅ | ❌ | Domain not in MVM |
| rights_management | license | ✅ | ❌ | Domain not in MVM |
| rights_management | license_territory | ✅ | ❌ | Domain not in MVM |
| rights_management | ott_entitlement | ✅ | ❌ | Domain not in MVM |
| rights_management | rights_window | ✅ | ❌ | Domain not in MVM |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | address | ❌ | ✅ | MVM only (stub or new) |
| account_management | corporate_hierarchy | ✅ | ❌ | Excluded from MVM |
| account_management | customer_account | ✅ | ✅ |  |
| account_management | customer_account_coverage | ✅ | ❌ | Excluded from MVM |
| account_management | customer_address | ✅ | ❌ | Excluded from MVM |
| account_management | customer_contact | ✅ | ✅ |  |
| account_management | device_registration | ✅ | ✅ |  |
| account_management | household | ✅ | ❌ | Excluded from MVM |
| account_management | kyc_verification | ✅ | ❌ | Excluded from MVM |
| account_management | loyalty_account | ✅ | ❌ | Excluded from MVM |
| account_management | subscription | ❌ | ✅ | MVM only (stub or new) |
| marketing_analytics | csat_response | ✅ | ❌ | Excluded from MVM |
| marketing_analytics | customer_segment_membership | ✅ | ❌ | Excluded from MVM |
| marketing_analytics | promo_redemption | ✅ | ❌ | Excluded from MVM |
| marketing_analytics | redemption | ✅ | ❌ | Excluded from MVM |
| marketing_analytics | survey_template | ✅ | ❌ | Excluded from MVM |
| marketing_analytics | survey_wave | ✅ | ❌ | Excluded from MVM |
| service_operations | account_dealer_transaction | ✅ | ❌ | Excluded from MVM |
| service_operations | case | ✅ | ✅ |  |
| service_operations | consent_record | ✅ | ✅ |  |
| service_operations | customer_interaction | ✅ | ❌ | Excluded from MVM |
| service_operations | customer_mnp_request | ✅ | ❌ | Excluded from MVM |
| service_operations | customer_roaming_session | ✅ | ❌ | Excluded from MVM |
| service_operations | customer_subscription | ✅ | ❌ | Excluded from MVM |
| service_operations | subscriber | ✅ | ✅ |  |
| service_support | interaction | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-enterprise"></a>
### enterprise

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | account_hierarchy | ✅ | ✅ |  |
| account_management | corporate_account | ✅ | ✅ |  |
| account_management | enterprise_account_coverage | ✅ | ❌ | Excluded from MVM |
| account_management | segment | ✅ | ✅ |  |
| account_management | site | ❌ | ✅ | MVM only (stub or new) |
| contract_pricing | discount_scheme | ✅ | ✅ |  |
| contract_pricing | enterprise_contract | ✅ | ✅ |  |
| contract_pricing | government_contract | ✅ | ❌ | Excluded from MVM |
| service_delivery | bandwidth_profile | ✅ | ❌ | Excluded from MVM |
| service_delivery | enterprise_site | ✅ | ❌ | Excluded from MVM |
| service_delivery | enterprise_sla_measurement | ✅ | ❌ | Excluded from MVM |
| service_delivery | iot_deployment | ✅ | ✅ |  |
| service_delivery | managed_service | ✅ | ✅ |  |
| service_delivery | sdwan_topology | ✅ | ✅ |  |
| service_delivery | site_access | ✅ | ❌ | Excluded from MVM |
| service_delivery | sla_breach | ✅ | ✅ |  |
| service_delivery | sla_measurement | ❌ | ✅ | MVM only (stub or new) |
| service_delivery | ticket | ✅ | ❌ | Excluded from MVM |
| service_delivery | topology_site_membership | ❌ | ✅ | MVM only (stub or new) |
| service_delivery | uc_subscription | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| cash_operations | bank_account | ✅ | ❌ | Domain not in MVM |
| cash_operations | bank_statement | ✅ | ❌ | Domain not in MVM |
| cash_operations | cash_pool | ✅ | ❌ | Domain not in MVM |
| cash_operations | fixed_asset | ✅ | ❌ | Domain not in MVM |
| cash_operations | house_bank | ✅ | ❌ | Domain not in MVM |
| cash_operations | payment_plan | ✅ | ❌ | Domain not in MVM |
| cash_operations | payment_run | ✅ | ❌ | Domain not in MVM |
| cash_operations | purchase_order | ✅ | ❌ | Domain not in MVM |
| cash_operations | purchase_order_line | ✅ | ❌ | Domain not in MVM |
| cost_management | allocation_cycle | ✅ | ❌ | Domain not in MVM |
| cost_management | allocation_rule | ✅ | ❌ | Domain not in MVM |
| cost_management | budget_allocation | ✅ | ❌ | Domain not in MVM |
| cost_management | budget_approval | ✅ | ❌ | Domain not in MVM |
| cost_management | budget_line | ✅ | ❌ | Domain not in MVM |
| cost_management | budget_plan | ✅ | ❌ | Domain not in MVM |
| cost_management | capital_project | ✅ | ❌ | Domain not in MVM |
| cost_management | commitment_item | ✅ | ❌ | Domain not in MVM |
| cost_management | controlling_area | ✅ | ❌ | Domain not in MVM |
| cost_management | cost_allocation | ✅ | ❌ | Domain not in MVM |
| cost_management | cost_center | ✅ | ❌ | Domain not in MVM |
| cost_management | cost_element | ✅ | ❌ | Domain not in MVM |
| cost_management | finance_project_assignment | ✅ | ❌ | Domain not in MVM |
| cost_management | functional_area | ✅ | ❌ | Domain not in MVM |
| cost_management | lease_contract | ✅ | ❌ | Domain not in MVM |
| cost_management | profit_center | ✅ | ❌ | Domain not in MVM |
| general_ledger | asset_transaction | ✅ | ❌ | Domain not in MVM |
| general_ledger | chart_of_accounts | ✅ | ❌ | Domain not in MVM |
| general_ledger | company_code | ✅ | ❌ | Domain not in MVM |
| general_ledger | financial_consolidation | ✅ | ❌ | Domain not in MVM |
| general_ledger | general_ledger | ✅ | ❌ | Domain not in MVM |
| general_ledger | intercompany_transaction | ✅ | ❌ | Domain not in MVM |
| general_ledger | journal_entry | ✅ | ❌ | Domain not in MVM |
| general_ledger | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| general_ledger | legal_entity | ✅ | ❌ | Domain not in MVM |
| general_ledger | tax_posting | ✅ | ❌ | Domain not in MVM |
| general_ledger | vendor | ✅ | ❌ | Domain not in MVM |
| general_ledger | vendor_invoice | ✅ | ❌ | Domain not in MVM |
| general_ledger | vendor_payment | ✅ | ❌ | Domain not in MVM |
| revenue_accounting | accounts_receivable | ✅ | ❌ | Domain not in MVM |
| revenue_accounting | performance_obligation | ✅ | ❌ | Domain not in MVM |
| revenue_accounting | revenue_recognition | ✅ | ❌ | Domain not in MVM |

<a id="domain-interconnect"></a>
### interconnect

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| carrier_management | carrier | ✅ | ✅ |  |
| carrier_management | carrier_agreement | ✅ | ✅ |  |
| carrier_management | iot_tariff | ✅ | ✅ |  |
| carrier_management | mnp_transaction | ✅ | ✅ |  |
| carrier_management | peering_arrangement | ✅ | ✅ |  |
| carrier_management | poi | ✅ | ✅ |  |
| carrier_management | rate | ✅ | ✅ |  |
| settlement_operations | nrtrde_record | ✅ | ✅ |  |
| settlement_operations | rap_file | ✅ | ❌ | Excluded from MVM |
| settlement_operations | settlement_dispute | ✅ | ✅ |  |
| settlement_operations | settlement_invoice | ✅ | ✅ |  |
| settlement_operations | settlement_invoice_line | ✅ | ✅ |  |
| settlement_operations | tap_file | ✅ | ✅ |  |
| settlement_operations | tap_record | ✅ | ✅ |  |
| settlement_operations | transit_traffic_record | ✅ | ❌ | Excluded from MVM |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_control | asset_lifecycle_event | ✅ | ✅ |  |
| inventory_control | ip_address_pool | ✅ | ✅ |  |
| inventory_control | maintenance_contract | ✅ | ❌ | Excluded from MVM |
| inventory_control | msisdn_range | ✅ | ✅ |  |
| inventory_control | sim_stock | ✅ | ✅ |  |
| inventory_control | spectrum_allocation | ✅ | ❌ | Excluded from MVM |
| network_assets | circuit | ✅ | ❌ | Excluded from MVM |
| network_assets | cpe_asset | ✅ | ✅ |  |
| network_assets | fiber_cable | ✅ | ✅ |  |
| network_assets | fiber_splice | ✅ | ❌ | Excluded from MVM |
| network_assets | fiber_strand_assignment | ✅ | ❌ | Excluded from MVM |
| network_assets | network_equipment | ✅ | ✅ |  |
| network_assets | olt_asset | ✅ | ✅ |  |
| network_assets | ont_asset | ✅ | ✅ |  |
| network_assets | pop_facility | ✅ | ❌ | Excluded from MVM |
| network_assets | rack_slot_port | ✅ | ❌ | Excluded from MVM |
| network_assets | spare_part | ✅ | ❌ | Excluded from MVM |
| network_assets | splice_closure | ✅ | ❌ | Excluded from MVM |
| service_agreements | colocation | ✅ | ❌ | Excluded from MVM |
| service_agreements | fiber_lease | ✅ | ❌ | Excluded from MVM |
| service_agreements | service_equipment_assignment | ✅ | ❌ | Excluded from MVM |

<a id="domain-location"></a>
### location

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | address_alias | ✅ | ❌ | Domain not in MVM |
| asset_management | exchange | ✅ | ❌ | Domain not in MVM |
| asset_management | location_address | ✅ | ❌ | Domain not in MVM |
| asset_management | location_site | ✅ | ❌ | Domain not in MVM |
| asset_management | mdu_building | ✅ | ❌ | Domain not in MVM |
| asset_management | premise | ✅ | ❌ | Domain not in MVM |
| field_operations | address_validation_event | ✅ | ❌ | Domain not in MVM |
| field_operations | change_event | ✅ | ❌ | Domain not in MVM |
| field_operations | drive_test_record | ✅ | ❌ | Domain not in MVM |
| field_operations | field_survey | ✅ | ❌ | Domain not in MVM |
| field_operations | premises_passed | ✅ | ❌ | Domain not in MVM |
| field_operations | test_campaign | ✅ | ❌ | Domain not in MVM |
| field_operations | test_route | ✅ | ❌ | Domain not in MVM |
| geographic_data | address_geocode | ✅ | ❌ | Domain not in MVM |
| geographic_data | administrative_region | ✅ | ❌ | Domain not in MVM |
| geographic_data | geo_boundary | ✅ | ❌ | Domain not in MVM |
| geographic_data | geo_point | ✅ | ❌ | Domain not in MVM |
| geographic_data | hierarchy | ✅ | ❌ | Domain not in MVM |
| geographic_data | reference_code | ✅ | ❌ | Domain not in MVM |
| network_planning | black_spot | ✅ | ❌ | Domain not in MVM |
| network_planning | cell_coverage_footprint | ✅ | ❌ | Domain not in MVM |
| network_planning | coverage_area | ✅ | ❌ | Domain not in MVM |
| network_planning | coverage_area_version | ✅ | ❌ | Domain not in MVM |
| network_planning | coverage_gap | ✅ | ❌ | Domain not in MVM |
| network_planning | coverage_qualification | ✅ | ❌ | Domain not in MVM |
| network_planning | duct_route | ✅ | ❌ | Domain not in MVM |
| network_planning | geographic_zone | ✅ | ❌ | Domain not in MVM |
| network_planning | infrastructure_corridor | ✅ | ❌ | Domain not in MVM |
| network_planning | network_rollout_zone | ✅ | ❌ | Domain not in MVM |
| network_planning | service_territory | ✅ | ❌ | Domain not in MVM |

<a id="domain-network"></a>
### network

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| capacity_management | capacity | ✅ | ✅ |  |
| capacity_management | network_capacity_plan | ✅ | ❌ | Excluded from MVM |
| capacity_management | slice | ✅ | ✅ |  |
| configuration_management | ran_slice_assignment | ❌ | ✅ | MVM only (stub or new) |
| configuration_management | slice_element_assignment | ❌ | ✅ | MVM only (stub or new) |
| infrastructure_assets | qos_profile | ❌ | ✅ | MVM only (stub or new) |
| network_inventory | circuit | ✅ | ❌ | Excluded from MVM |
| network_inventory | config_template | ✅ | ❌ | Excluded from MVM |
| network_inventory | element | ✅ | ✅ |  |
| network_inventory | ims_node | ✅ | ❌ | Excluded from MVM |
| network_inventory | ip_address_plan | ✅ | ❌ | Excluded from MVM |
| network_inventory | maintenance_window | ✅ | ❌ | Excluded from MVM |
| network_inventory | mpls_tunnel | ✅ | ❌ | Excluded from MVM |
| network_inventory | nfv_vnf | ✅ | ❌ | Excluded from MVM |
| network_inventory | peering_agreement | ✅ | ❌ | Excluded from MVM |
| network_inventory | ran_cell | ✅ | ✅ |  |
| network_inventory | topology | ✅ | ✅ |  |
| network_inventory | transmission_link | ✅ | ✅ |  |
| service_operations | alarm | ✅ | ✅ |  |
| service_operations | cell_slice_assignment | ✅ | ❌ | Excluded from MVM |
| service_operations | config_change | ✅ | ✅ |  |
| service_operations | element_config | ✅ | ✅ |  |
| service_operations | element_outage_impact | ✅ | ❌ | Excluded from MVM |
| service_operations | network_qos_profile | ✅ | ❌ | Excluded from MVM |
| service_operations | performance_counter | ✅ | ✅ |  |
| service_operations | planned_outage | ✅ | ✅ |  |
| service_operations | sdwan_policy | ✅ | ❌ | Excluded from MVM |
| service_operations | slice_vnf_assignment | ✅ | ❌ | Excluded from MVM |

<a id="domain-order"></a>
### order

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| customer_communication | notification | ✅ | ✅ |  |
| customer_communication | notification_template | ✅ | ❌ | Excluded from MVM |
| customer_communication | order_interaction | ✅ | ❌ | Excluded from MVM |
| order_management | amendment | ✅ | ✅ |  |
| order_management | bulk_order | ✅ | ❌ | Excluded from MVM |
| order_management | fulfillment_order | ✅ | ✅ |  |
| order_management | line | ✅ | ✅ |  |
| order_management | order_charge | ✅ | ✅ |  |
| order_management | sla | ✅ | ✅ |  |
| order_management | status_history | ✅ | ✅ |  |
| order_management | task | ✅ | ✅ |  |
| regulatory_compliance | order_mnp_request | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | service_qualification | ✅ | ✅ |  |
| regulatory_compliance | validation_result | ✅ | ❌ | Excluded from MVM |
| risk_monitoring | appointment | ✅ | ✅ |  |
| risk_monitoring | fallout | ✅ | ✅ |  |
| risk_monitoring | jeopardy | ✅ | ❌ | Excluded from MVM |
| service_provisioning | decomposition | ✅ | ❌ | Excluded from MVM |
| service_provisioning | decomposition_rule | ✅ | ❌ | Excluded from MVM |
| service_provisioning | inventory_reservation | ✅ | ❌ | Excluded from MVM |
| service_provisioning | provisioning_request | ✅ | ✅ |  |

<a id="domain-partner"></a>
### partner

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agreement_management | agreement | ✅ | ✅ |  |
| agreement_management | mvno_profile | ✅ | ✅ |  |
| agreement_management | revenue_share_plan | ✅ | ✅ |  |
| agreement_management | roaming_agreement | ✅ | ✅ |  |
| agreement_management | sla_definition | ✅ | ✅ |  |
| partner_operations | dealer | ✅ | ✅ |  |
| partner_operations | onboarding_request | ✅ | ✅ |  |
| partner_operations | partner | ✅ | ✅ |  |
| partner_operations | partner_certification | ✅ | ❌ | Excluded from MVM |
| partner_operations | partner_contact | ✅ | ✅ |  |
| partner_operations | scorecard | ✅ | ❌ | Excluded from MVM |
| settlement_processing | partner_dispute | ✅ | ✅ |  |
| settlement_processing | partner_sla_measurement | ✅ | ❌ | Excluded from MVM |
| settlement_processing | settlement_line | ✅ | ✅ |  |
| settlement_processing | settlement_run | ✅ | ✅ |  |

<a id="domain-people"></a>
### people

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_benefits | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | benefit_plan | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | compensation | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | leave_entitlement | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | leave_request | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | payroll_run | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | payslip | ✅ | ❌ | Domain not in MVM |
| learning_development | calibration_session | ✅ | ❌ | Domain not in MVM |
| learning_development | disciplinary_case | ✅ | ❌ | Domain not in MVM |
| learning_development | goal | ✅ | ❌ | Domain not in MVM |
| learning_development | learning_course | ✅ | ❌ | Domain not in MVM |
| learning_development | learning_enrollment | ✅ | ❌ | Domain not in MVM |
| learning_development | performance_cycle | ✅ | ❌ | Domain not in MVM |
| learning_development | performance_review | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | applicant | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | interview_event | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | offer_letter | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | onboarding_program | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | onboarding_task | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | recruitment_requisition | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | separation_event | ✅ | ❌ | Domain not in MVM |
| workforce_planning | assignment | ✅ | ❌ | Domain not in MVM |
| workforce_planning | employee | ✅ | ❌ | Domain not in MVM |
| workforce_planning | headcount_plan | ✅ | ❌ | Domain not in MVM |
| workforce_planning | job_profile | ✅ | ❌ | Domain not in MVM |
| workforce_planning | org_unit | ✅ | ❌ | Domain not in MVM |
| workforce_planning | policy_acknowledgment | ✅ | ❌ | Domain not in MVM |
| workforce_planning | position | ✅ | ❌ | Domain not in MVM |
| workforce_planning | workforce_policy | ✅ | ❌ | Domain not in MVM |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| catalog_management | bundle_component | ❌ | ✅ | MVM only (stub or new) |
| offering_management | addon | ✅ | ✅ |  |
| offering_management | addon_eligibility | ✅ | ❌ | Excluded from MVM |
| offering_management | bundle | ✅ | ✅ |  |
| offering_management | compatibility_rule | ✅ | ❌ | Excluded from MVM |
| offering_management | device_model | ✅ | ✅ |  |
| offering_management | device_offering | ✅ | ❌ | Excluded from MVM |
| offering_management | device_supply_agreement | ✅ | ❌ | Excluded from MVM |
| offering_management | eligibility_rule | ✅ | ✅ |  |
| offering_management | offering | ✅ | ✅ |  |
| offering_management | offering_filing_metric | ✅ | ❌ | Excluded from MVM |
| offering_management | relationship | ✅ | ❌ | Excluded from MVM |
| offering_management | segment_eligibility | ✅ | ❌ | Excluded from MVM |
| pricing_promotion | bundle_promotion | ✅ | ❌ | Excluded from MVM |
| pricing_promotion | price_alteration | ✅ | ❌ | Excluded from MVM |
| pricing_promotion | price_plan | ✅ | ✅ |  |
| pricing_promotion | promo_offer | ✅ | ✅ |  |
| product_catalog | catalog_item | ✅ | ✅ |  |
| product_catalog | category | ✅ | ❌ | Excluded from MVM |
| product_catalog | lifecycle_status | ✅ | ❌ | Excluded from MVM |
| product_catalog | rule_group | ✅ | ❌ | Excluded from MVM |
| product_catalog | spec | ✅ | ✅ |  |
| product_catalog | zero_rating_program | ✅ | ❌ | Excluded from MVM |
| service_delivery | bundle_channel_inclusion | ✅ | ❌ | Excluded from MVM |
| service_delivery | bundle_subscription | ✅ | ❌ | Excluded from MVM |
| service_delivery | catalog_roaming_enablement | ✅ | ❌ | Excluded from MVM |
| service_delivery | offering_platform_bundle | ✅ | ❌ | Excluded from MVM |
| service_delivery | product_channel_lineup | ✅ | ❌ | Excluded from MVM |
| service_delivery | service_addon_subscription | ✅ | ❌ | Excluded from MVM |
| service_delivery | skill_requirement | ✅ | ❌ | Excluded from MVM |
| service_delivery | sla_template | ✅ | ❌ | Excluded from MVM |

<a id="domain-sales"></a>
### sales

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| channel_distribution | channel | ✅ | ✅ |  |
| channel_distribution | channel_offering | ✅ | ❌ | Excluded from MVM |
| channel_distribution | channel_promotion_eligibility | ✅ | ❌ | Excluded from MVM |
| contract_execution | contract_amendment | ✅ | ❌ | Excluded from MVM |
| contract_execution | contract_template | ✅ | ❌ | Excluded from MVM |
| contract_execution | sales_contract | ✅ | ✅ |  |
| customer_retention | campaign_channel_execution | ❌ | ✅ | MVM only (stub or new) |
| incentive_management | account_team_assignment | ✅ | ❌ | Excluded from MVM |
| incentive_management | activity | ✅ | ❌ | Excluded from MVM |
| incentive_management | b2b_account_plan | ✅ | ❌ | Excluded from MVM |
| incentive_management | commission_plan | ✅ | ✅ |  |
| incentive_management | commission_txn | ✅ | ❌ | Excluded from MVM |
| incentive_management | forecast | ✅ | ❌ | Excluded from MVM |
| incentive_management | mvno_agreement | ✅ | ❌ | Excluded from MVM |
| incentive_management | promotion | ✅ | ✅ |  |
| incentive_management | promotion_redemption | ✅ | ❌ | Excluded from MVM |
| incentive_management | retention_interaction | ✅ | ❌ | Excluded from MVM |
| incentive_management | retention_offer | ✅ | ✅ |  |
| incentive_management | wholesale_rate_card | ✅ | ❌ | Excluded from MVM |
| lead_generation | campaign | ✅ | ✅ |  |
| lead_generation | lead | ✅ | ✅ |  |
| lead_generation | target | ✅ | ✅ |  |
| opportunity_development | opportunity | ✅ | ✅ |  |
| opportunity_development | quote | ✅ | ✅ |  |
| opportunity_development | quote_line | ✅ | ✅ |  |

<a id="domain-service"></a>
### service

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| network_infrastructure | esim_profile | ✅ | ❌ | Excluded from MVM |
| network_infrastructure | service_qos_profile | ✅ | ❌ | Excluded from MVM |
| network_infrastructure | sla_profile | ✅ | ✅ |  |
| network_infrastructure | svc_configuration | ✅ | ✅ |  |
| network_infrastructure | svc_location | ✅ | ✅ |  |
| network_infrastructure | volte_ims_state | ✅ | ❌ | Excluded from MVM |
| provisioning_operations | activation_event | ✅ | ✅ |  |
| provisioning_operations | contract_service_line | ✅ | ❌ | Excluded from MVM |
| provisioning_operations | ftth_ont_config | ✅ | ❌ | Excluded from MVM |
| provisioning_operations | ont_service_binding | ✅ | ❌ | Excluded from MVM |
| provisioning_operations | provisioning_fallout | ✅ | ❌ | Excluded from MVM |
| provisioning_operations | provisioning_order | ✅ | ✅ |  |
| provisioning_operations | visit | ✅ | ❌ | Excluded from MVM |
| service_management | dependency | ✅ | ✅ |  |
| service_management | number_assignment | ✅ | ✅ |  |
| service_management | service_mnp_request | ✅ | ❌ | Excluded from MVM |
| service_management | service_roaming_session | ✅ | ❌ | Excluded from MVM |
| service_management | svc_instance | ✅ | ✅ |  |
| service_management | svc_status_history | ✅ | ✅ |  |
| service_management | svc_suspension | ✅ | ✅ |  |

<a id="domain-usage"></a>
### usage

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| balance_oversight | anomaly | ✅ | ✅ |  |
| balance_oversight | balance | ✅ | ✅ |  |
| balance_oversight | roaming_file | ✅ | ✅ |  |
| data_processing | aggregated_usage | ✅ | ✅ |  |
| data_processing | correction | ✅ | ❌ | Excluded from MVM |
| data_processing | detection_rule | ✅ | ❌ | Excluded from MVM |
| data_processing | mediation_event | ✅ | ✅ |  |
| event_capture | cdr | ✅ | ✅ |  |
| event_capture | content_consumption | ✅ | ❌ | Excluded from MVM |
| event_capture | data_session | ✅ | ✅ |  |
| event_capture | ipdr_record | ✅ | ❌ | Excluded from MVM |
| event_capture | sms_record | ✅ | ✅ |  |
| event_capture | volte_session | ✅ | ❌ | Excluded from MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| field_operations | depot | ✅ | ✅ |  |
| field_operations | dispatch_event | ✅ | ✅ |  |
| field_operations | field_vehicle | ✅ | ✅ |  |
| field_operations | route_plan | ✅ | ✅ |  |
| field_operations | safety_incident | ✅ | ❌ | Excluded from MVM |
| field_operations | team | ✅ | ✅ |  |
| field_operations | technician | ✅ | ✅ |  |
| field_operations | technician_schedule | ✅ | ✅ |  |
| field_operations | work_order | ✅ | ✅ |  |
| workforce_management | certification | ✅ | ✅ |  |
| workforce_management | contractor | ✅ | ❌ | Excluded from MVM |
| workforce_management | shift_template | ✅ | ❌ | Excluded from MVM |
| workforce_management | skill | ✅ | ✅ |  |
| workforce_management | technician_kpi_target | ✅ | ❌ | Excluded from MVM |
| workforce_management | technician_skill_proficiency | ✅ | ❌ | Excluded from MVM |
| workforce_management | tool_checkout | ✅ | ❌ | Excluded from MVM |
| workforce_management | workforce_capacity_plan | ✅ | ❌ | Excluded from MVM |
| workforce_management | workforce_certification | ✅ | ❌ | Excluded from MVM |
| workforce_management | workforce_project_assignment | ✅ | ❌ | Excluded from MVM |
