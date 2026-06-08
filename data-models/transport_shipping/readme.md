# Transport Shipping Lakehouse Data Models

**Version 1** | Generated on May 08, 2026 at 10:34 PM

**Industry:** logistics

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
  - [Contract](#domain-contract)
  - [Customer](#domain-customer)
  - [Customs](#domain-customs)
  - [Document](#domain-document)
  - [Finance](#domain-finance)
  - [Fleet](#domain-fleet)
  - [Freight](#domain-freight)
  - [Fulfillment](#domain-fulfillment)
  - [Network](#domain-network)
  - [Pricing](#domain-pricing)
  - [Procurement](#domain-procurement)
  - [Route](#domain-route)
  - [Safety](#domain-safety)
  - [Shipment](#domain-shipment)
  - [Sustainability](#domain-sustainability)
  - [Warehouse](#domain-warehouse)
  - [Workforce](#domain-workforce)


## Business Description

Transport and Shipping is a global logistics industry providing express delivery, freight forwarding, supply chain management, and e-commerce fulfillment services that connect businesses and consumers across continents.

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
| Domains | 14 | 19 |
| Subdomains | 44 | 79 |
| Products (Tables) | 210 | 514 |
| Attributes (Columns) | 9524 | 20747 |
| Foreign Keys | 1918 | 3292 |
| Avg Attributes/Product | 45.4 | 40.4 |

## Domain & Product Comparison

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_configuration | billing_account | ✅ | ✅ |  |
| account_configuration | cycle | ✅ | ✅ |  |
| account_configuration | payment_term | ✅ | ✅ |  |
| account_configuration | tax_schedule | ✅ | ✅ |  |
| carrier_settlements | carrier_payable | ✅ | ✅ |  |
| carrier_settlements | freight_audit | ✅ | ✅ |  |
| carrier_settlements | service_line | ✅ | ❌ | Excluded from MVM |
| cash_collections | advance_payment | ✅ | ❌ | Excluded from MVM |
| cash_collections | cod_collection | ✅ | ❌ | Excluded from MVM |
| cash_collections | dunning_invoice_coverage | ✅ | ❌ | Excluded from MVM |
| cash_collections | dunning_record | ✅ | ❌ | Excluded from MVM |
| cash_collections | payment | ✅ | ✅ |  |
| cash_collections | payment_allocation | ✅ | ✅ |  |
| cash_collections | write_off | ✅ | ❌ | Excluded from MVM |
| customer_invoicing | dispute | ❌ | ✅ | MVM only (stub or new) |
| invoice_management | billing_dispute | ✅ | ❌ | Excluded from MVM |
| invoice_management | billing_invoice_line | ✅ | ✅ |  |
| invoice_management | charge_event | ✅ | ❌ | Excluded from MVM |
| invoice_management | consolidated_invoice | ✅ | ❌ | Excluded from MVM |
| invoice_management | credit_note | ✅ | ✅ |  |
| invoice_management | debit_note | ✅ | ❌ | Excluded from MVM |
| invoice_management | intercompany_billing | ✅ | ❌ | Excluded from MVM |
| invoice_management | invoice | ✅ | ✅ |  |
| revenue_accounting | performance_obligation | ✅ | ✅ |  |
| revenue_accounting | receivable | ✅ | ✅ |  |
| revenue_accounting | revenue_recognition | ✅ | ❌ | Excluded from MVM |

<a id="domain-claim"></a>
### claim

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| claim_registration | cargo_claim | ✅ | ✅ |  |
| claim_registration | claim_document | ✅ | ✅ |  |
| claim_registration | claim_event | ✅ | ✅ |  |
| claim_registration | claim_party | ✅ | ✅ |  |
| claim_registration | claimant | ✅ | ✅ |  |
| claim_registration | line | ✅ | ✅ |  |
| claim_registration | status_history | ✅ | ✅ |  |
| financial_resolution | policy | ✅ | ✅ |  |
| financial_resolution | recovery_action | ✅ | ❌ | Excluded from MVM |
| financial_resolution | reserve | ✅ | ✅ |  |
| financial_resolution | settlement | ✅ | ✅ |  |
| financial_resolution | subrogation_case | ✅ | ❌ | Excluded from MVM |
| loss_assessment | appeal | ✅ | ❌ | Excluded from MVM |
| loss_assessment | cargo_survey | ✅ | ✅ |  |
| loss_assessment | liability_determination | ✅ | ✅ |  |
| loss_assessment | surveyor | ✅ | ❌ | Excluded from MVM |

<a id="domain-contract"></a>
### contract

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| commercial_agreements | agreement | ✅ | ✅ |  |
| commercial_agreements | agreement_supplier_service | ✅ | ❌ | Excluded from MVM |
| commercial_agreements | agreement_version | ✅ | ✅ |  |
| commercial_agreements | carrier_agreement | ✅ | ✅ |  |
| commercial_agreements | contract_approval_workflow | ✅ | ❌ | Excluded from MVM |
| commercial_agreements | contract_party | ✅ | ✅ |  |
| commercial_agreements | lane_commitment | ✅ | ✅ |  |
| commercial_agreements | partnership_agreement | ✅ | ❌ | Excluded from MVM |
| commercial_agreements | service_scope | ✅ | ✅ |  |
| lifecycle_renewal | renewal_event | ✅ | ❌ | Excluded from MVM |
| lifecycle_renewal | renewal_schedule | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | contract_dispute | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | contract_sla_commitment | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | sla_commitment | ❌ | ✅ | MVM only (stub or new) |
| performance_monitoring | sla_performance | ✅ | ✅ |  |
| performance_monitoring | volume_commitment | ❌ | ✅ | MVM only (stub or new) |
| rate_obligations | contract_surcharge_schedule | ✅ | ✅ |  |
| rate_obligations | contract_volume_commitment | ✅ | ❌ | Excluded from MVM |
| rate_obligations | incentive_clause | ✅ | ❌ | Excluded from MVM |
| rate_obligations | penalty_clause | ✅ | ✅ |  |
| rate_obligations | penalty_event | ✅ | ✅ |  |
| rate_obligations | rate_schedule | ✅ | ✅ |  |
| rate_obligations | volume_actuals | ✅ | ✅ |  |
| regulatory_compliance | agreement_compliance_qualification | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | carrier_document_specification | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | compliance_documentation_requirement | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | compliance_obligation | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | compliance_review | ✅ | ❌ | Excluded from MVM |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | account_hierarchy | ✅ | ✅ |  |
| account_management | account_team_assignment | ✅ | ❌ | Excluded from MVM |
| account_management | address_book | ✅ | ✅ |  |
| account_management | contact | ✅ | ✅ |  |
| account_management | customer_account | ✅ | ✅ |  |
| account_management | lessee | ✅ | ❌ | Excluded from MVM |
| account_management | segment | ✅ | ✅ |  |
| compliance_finance | carbon_enrollment | ✅ | ❌ | Excluded from MVM |
| compliance_finance | credit_profile | ✅ | ✅ |  |
| compliance_finance | customer_program_enrollment | ✅ | ❌ | Excluded from MVM |
| compliance_finance | kyc_verification | ✅ | ❌ | Excluded from MVM |
| compliance_finance | partner_relationship | ✅ | ✅ |  |
| compliance_finance | sustainability_participation | ✅ | ❌ | Excluded from MVM |
| operational_profiles | consignee_profile | ✅ | ✅ |  |
| operational_profiles | customer_allocation | ✅ | ❌ | Excluded from MVM |
| operational_profiles | customer_volume_commitment | ✅ | ❌ | Excluded from MVM |
| operational_profiles | ecommerce_seller | ✅ | ❌ | Excluded from MVM |
| operational_profiles | service_preference | ✅ | ✅ |  |
| operational_profiles | shipper_profile | ✅ | ✅ |  |
| operational_profiles | sla_entitlement | ✅ | ✅ |  |
| operational_profiles | zone_rate | ✅ | ❌ | Excluded from MVM |
| operational_profiles | zone_service_agreement | ✅ | ❌ | Excluded from MVM |
| sales_engagement | lead | ✅ | ❌ | Excluded from MVM |
| sales_engagement | onboarding | ✅ | ✅ |  |
| sales_engagement | opportunity | ✅ | ❌ | Excluded from MVM |
| sales_engagement | opportunity_team_member | ✅ | ❌ | Excluded from MVM |
| sales_engagement | service_case | ✅ | ✅ |  |

<a id="domain-customs"></a>
### customs

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| declaration_filing | ams_filing | ✅ | ✅ |  |
| declaration_filing | broker_assignment | ✅ | ✅ |  |
| declaration_filing | customs_event | ✅ | ❌ | Excluded from MVM |
| declaration_filing | declaration | ✅ | ✅ |  |
| declaration_filing | declaration_line | ✅ | ✅ |  |
| declaration_filing | dg_declaration | ✅ | ❌ | Excluded from MVM |
| declaration_filing | hold | ✅ | ✅ |  |
| declaration_filing | isf_filing | ✅ | ✅ |  |
| declaration_processing | declaration_compliance_benefit | ❌ | ✅ | MVM only (stub or new) |
| party_management | trade_party | ✅ | ✅ |  |
| party_management | trade_transaction | ✅ | ❌ | Excluded from MVM |
| tariff_valuation | drawback_claim | ✅ | ❌ | Excluded from MVM |
| tariff_valuation | duty_assessment | ✅ | ✅ |  |
| tariff_valuation | hs_classification | ✅ | ✅ |  |
| tariff_valuation | incoterms_assignment | ✅ | ✅ |  |
| tariff_valuation | tariff_rate | ✅ | ✅ |  |
| tariff_valuation | valuation | ✅ | ❌ | Excluded from MVM |
| trade_compliance | certificate_of_origin | ✅ | ✅ |  |
| trade_compliance | compliance_audit | ✅ | ❌ | Excluded from MVM |
| trade_compliance | compliance_program | ✅ | ✅ |  |
| trade_compliance | denied_party_screening | ✅ | ✅ |  |
| trade_compliance | license_permit | ✅ | ✅ |  |
| trade_compliance | origin_determination | ✅ | ✅ |  |
| trade_compliance | program_participation | ✅ | ❌ | Excluded from MVM |
| trade_compliance | ruling_request | ✅ | ❌ | Excluded from MVM |
| trade_compliance | trade_agreement | ✅ | ✅ |  |
| trade_compliance | trade_agreement_utilization | ✅ | ❌ | Excluded from MVM |
| zone_operations | ftz_admission | ✅ | ❌ | Excluded from MVM |
| zone_operations | ftz_inventory | ✅ | ❌ | Excluded from MVM |

<a id="domain-document"></a>
### document

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| access_control | access_log | ✅ | ❌ | Domain not in MVM |
| access_control | storage | ✅ | ❌ | Domain not in MVM |
| access_control | workflow | ✅ | ❌ | Domain not in MVM |
| access_control | workflow_task | ✅ | ❌ | Domain not in MVM |
| compliance_governance | compliance_check | ✅ | ❌ | Domain not in MVM |
| compliance_governance | destruction_record | ✅ | ❌ | Domain not in MVM |
| compliance_governance | digital_signature | ✅ | ❌ | Domain not in MVM |
| compliance_governance | legal_hold | ✅ | ❌ | Domain not in MVM |
| compliance_governance | notarization_record | ✅ | ❌ | Domain not in MVM |
| compliance_governance | retention_policy | ✅ | ❌ | Domain not in MVM |
| lifecycle_processing | amendment | ✅ | ❌ | Domain not in MVM |
| lifecycle_processing | distribution | ✅ | ❌ | Domain not in MVM |
| lifecycle_processing | document_exception | ✅ | ❌ | Domain not in MVM |
| lifecycle_processing | issuance | ✅ | ❌ | Domain not in MVM |
| lifecycle_processing | request | ✅ | ❌ | Domain not in MVM |
| lifecycle_processing | version | ✅ | ❌ | Domain not in MVM |
| record_management | certificate | ✅ | ❌ | Domain not in MVM |
| record_management | document_package | ✅ | ❌ | Domain not in MVM |
| record_management | template | ✅ | ❌ | Domain not in MVM |
| record_management | trade_document | ✅ | ❌ | Domain not in MVM |
| record_management | transport_document | ✅ | ❌ | Domain not in MVM |
| record_management | type | ✅ | ❌ | Domain not in MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_compliance | asset_depreciation | ✅ | ❌ | Domain not in MVM |
| asset_compliance | capex_project | ✅ | ❌ | Domain not in MVM |
| asset_compliance | commitment_item | ✅ | ❌ | Domain not in MVM |
| asset_compliance | fixed_asset | ✅ | ❌ | Domain not in MVM |
| asset_compliance | fund | ✅ | ❌ | Domain not in MVM |
| asset_compliance | lease_contract | ✅ | ❌ | Domain not in MVM |
| asset_compliance | project | ✅ | ❌ | Domain not in MVM |
| asset_compliance | tax_account | ✅ | ❌ | Domain not in MVM |
| asset_compliance | tax_filing | ✅ | ❌ | Domain not in MVM |
| asset_compliance | wbs_element | ✅ | ❌ | Domain not in MVM |
| corporate_structure | business_unit | ✅ | ❌ | Domain not in MVM |
| corporate_structure | company_code | ✅ | ❌ | Domain not in MVM |
| corporate_structure | controlling_area | ✅ | ❌ | Domain not in MVM |
| corporate_structure | credit_control_area | ✅ | ❌ | Domain not in MVM |
| corporate_structure | legal_entity | ✅ | ❌ | Domain not in MVM |
| corporate_structure | party | ✅ | ❌ | Domain not in MVM |
| cost_management | budget | ✅ | ❌ | Domain not in MVM |
| cost_management | budget_line | ✅ | ❌ | Domain not in MVM |
| cost_management | cost_allocation | ✅ | ❌ | Domain not in MVM |
| cost_management | cost_center | ✅ | ❌ | Domain not in MVM |
| cost_management | cost_element | ✅ | ❌ | Domain not in MVM |
| cost_management | internal_order | ✅ | ❌ | Domain not in MVM |
| cost_management | profit_center | ✅ | ❌ | Domain not in MVM |
| cost_management | target_allocation | ✅ | ❌ | Domain not in MVM |
| general_accounting | accrual | ✅ | ❌ | Domain not in MVM |
| general_accounting | chart_of_accounts | ✅ | ❌ | Domain not in MVM |
| general_accounting | currency_rate | ✅ | ❌ | Domain not in MVM |
| general_accounting | finance_audit_finding | ✅ | ❌ | Domain not in MVM |
| general_accounting | financial_control | ✅ | ❌ | Domain not in MVM |
| general_accounting | financial_period_close | ✅ | ❌ | Domain not in MVM |
| general_accounting | financial_statement | ✅ | ❌ | Domain not in MVM |
| general_accounting | fiscal_period | ✅ | ❌ | Domain not in MVM |
| general_accounting | journal_entry | ✅ | ❌ | Domain not in MVM |
| general_accounting | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| general_accounting | ledger | ✅ | ❌ | Domain not in MVM |
| treasury_operations | accounts_payable | ✅ | ❌ | Domain not in MVM |
| treasury_operations | accounts_receivable | ✅ | ❌ | Domain not in MVM |
| treasury_operations | bank_account | ✅ | ❌ | Domain not in MVM |
| treasury_operations | bank_statement | ✅ | ❌ | Domain not in MVM |
| treasury_operations | bank_statement_line | ✅ | ❌ | Domain not in MVM |
| treasury_operations | house_bank | ✅ | ❌ | Domain not in MVM |
| treasury_operations | intercompany_settlement | ✅ | ❌ | Domain not in MVM |
| treasury_operations | payment_proposal | ✅ | ❌ | Domain not in MVM |
| treasury_operations | payment_run | ✅ | ❌ | Domain not in MVM |

<a id="domain-fleet"></a>
### fleet

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_lifecycle | asset_acquisition | ✅ | ❌ | Excluded from MVM |
| asset_lifecycle | asset_disposal | ✅ | ❌ | Excluded from MVM |
| asset_lifecycle | asset_insurance | ✅ | ❌ | Excluded from MVM |
| asset_lifecycle | asset_licence | ✅ | ✅ |  |
| asset_lifecycle | asset_type | ✅ | ✅ |  |
| asset_lifecycle | container_unit | ✅ | ✅ |  |
| asset_lifecycle | transport_asset | ✅ | ✅ |  |
| asset_lifecycle | tyre_record | ✅ | ❌ | Excluded from MVM |
| cost_routing | asset_assignment | ✅ | ✅ |  |
| cost_routing | asset_cost_record | ✅ | ❌ | Excluded from MVM |
| cost_routing | fuel_transaction | ✅ | ✅ |  |
| cost_routing | toll_record | ✅ | ❌ | Excluded from MVM |
| cost_routing | trip | ✅ | ✅ |  |
| driver_operations | driver_certification | ✅ | ❌ | Excluded from MVM |
| driver_operations | driver_engagement | ✅ | ❌ | Excluded from MVM |
| driver_operations | driver_licence_type | ✅ | ❌ | Excluded from MVM |
| driver_operations | driver_performance | ✅ | ❌ | Excluded from MVM |
| driver_operations | driver_profile | ✅ | ✅ |  |
| driver_operations | fleet_driver_assignment | ✅ | ❌ | Excluded from MVM |
| driver_operations | fleet_training_completion | ✅ | ❌ | Excluded from MVM |
| driver_operations | hos_log | ✅ | ❌ | Excluded from MVM |
| maintenance_compliance | asset_inspection | ✅ | ✅ |  |
| maintenance_compliance | depot | ✅ | ✅ |  |
| maintenance_compliance | depot_certification | ✅ | ❌ | Excluded from MVM |
| maintenance_compliance | depot_initiative_implementation | ✅ | ❌ | Excluded from MVM |
| maintenance_compliance | incident | ✅ | ✅ |  |
| maintenance_compliance | maintenance_order | ✅ | ✅ |  |
| maintenance_compliance | maintenance_schedule | ✅ | ✅ |  |
| tracking_monitoring | asset_position | ✅ | ❌ | Excluded from MVM |
| tracking_monitoring | asset_utilisation | ✅ | ✅ |  |
| tracking_monitoring | geofence_zone | ✅ | ❌ | Excluded from MVM |
| tracking_monitoring | reefer_monitoring | ✅ | ❌ | Excluded from MVM |
| tracking_monitoring | rfid_scan | ✅ | ❌ | Excluded from MVM |
| tracking_monitoring | telematics_event | ✅ | ✅ |  |
| workforce_coordination | driver_assignment | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-freight"></a>
### freight

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| cargo_operations | cfs_operation | ✅ | ❌ | Excluded from MVM |
| cargo_operations | consolidation | ✅ | ✅ |  |
| cargo_operations | freight_leg | ✅ | ✅ |  |
| cargo_operations | intermodal_transfer | ✅ | ✅ |  |
| cargo_operations | load_plan | ✅ | ✅ |  |
| carrier_services | carbon_allocation | ✅ | ❌ | Excluded from MVM |
| carrier_services | freight_carrier_assignment | ✅ | ✅ |  |
| carrier_services | shipment_agent_service | ✅ | ❌ | Excluded from MVM |
| order_management | booking | ✅ | ✅ |  |
| order_management | freight_charge | ✅ | ✅ |  |
| order_management | freight_exception | ✅ | ❌ | Excluded from MVM |
| order_management | freight_order | ✅ | ✅ |  |
| order_management | milestone | ✅ | ✅ |  |
| order_management | quote | ✅ | ✅ |  |
| transport_documentation | air_waybill | ✅ | ✅ |  |
| transport_documentation | bill_of_lading | ✅ | ✅ |  |
| transport_documentation | cargo | ✅ | ✅ |  |
| transport_documentation | document_attachment | ✅ | ❌ | Excluded from MVM |
| transport_execution | exception | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-fulfillment"></a>
### fulfillment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| carrier_services | fulfillment_carrier_assignment | ✅ | ✅ |  |
| carrier_services | parcel_manifest | ✅ | ✅ |  |
| carrier_services | rma | ✅ | ✅ |  |
| carrier_services | service | ✅ | ❌ | Excluded from MVM |
| delivery_execution | consignee | ✅ | ✅ |  |
| delivery_execution | delivery_attempt | ✅ | ✅ |  |
| delivery_execution | delivery_confirmation | ✅ | ❌ | Excluded from MVM |
| delivery_execution | dispatch_run | ✅ | ✅ |  |
| delivery_execution | fulfillment_delivery_zone | ✅ | ✅ |  |
| delivery_execution | last_mile_dispatch | ✅ | ✅ |  |
| merchant_integration | allocation | ❌ | ✅ | MVM only (stub or new) |
| merchant_partners | merchant | ✅ | ✅ |  |
| merchant_partners | merchant_carrier_agreement | ✅ | ❌ | Excluded from MVM |
| merchant_partners | merchant_compliance_enrollment | ✅ | ❌ | Excluded from MVM |
| merchant_partners | merchant_integration | ✅ | ✅ |  |
| merchant_partners | merchant_safety_certification | ✅ | ❌ | Excluded from MVM |
| order_management | fulfillment_exception | ✅ | ❌ | Excluded from MVM |
| order_management | fulfillment_order | ✅ | ✅ |  |
| order_management | order_line | ✅ | ✅ |  |
| order_management | sla_breach | ✅ | ❌ | Excluded from MVM |
| order_management | wave | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | center | ✅ | ✅ |  |
| warehouse_operations | fulfillment_allocation | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | fulfillment_program_enrollment | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | pack_task | ✅ | ✅ |  |
| warehouse_operations | parcel | ✅ | ✅ |  |

<a id="domain-network"></a>
### network

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agent_management | agent | ✅ | ✅ |  |
| agent_management | agent_appointment | ✅ | ✅ |  |
| agent_management | correspondent_office | ✅ | ❌ | Excluded from MVM |
| agent_management | gsa_agreement | ✅ | ❌ | Excluded from MVM |
| capacity_agreements | blocked_space_agreement | ✅ | ✅ |  |
| capacity_agreements | capacity_allocation | ✅ | ✅ |  |
| capacity_agreements | interline_agreement | ✅ | ✅ |  |
| capacity_agreements | interline_prorate | ✅ | ❌ | Excluded from MVM |
| capacity_agreements | partner_settlement | ✅ | ✅ |  |
| capacity_agreements | partner_tariff | ✅ | ❌ | Excluded from MVM |
| carrier_operations | carrier | ✅ | ✅ |  |
| carrier_operations | carrier_contact | ✅ | ✅ |  |
| carrier_operations | carrier_offset_participation | ✅ | ❌ | Excluded from MVM |
| carrier_operations | carrier_profile | ✅ | ✅ |  |
| carrier_operations | carrier_service | ✅ | ✅ |  |
| carrier_operations | carrier_service_agreement | ✅ | ❌ | Excluded from MVM |
| coverage_infrastructure | coverage | ✅ | ❌ | Excluded from MVM |
| coverage_infrastructure | edi_connection | ✅ | ✅ |  |
| coverage_infrastructure | hub_gateway | ✅ | ❌ | Excluded from MVM |
| coverage_infrastructure | network_event | ✅ | ✅ |  |
| partner_governance | contractor | ✅ | ❌ | Excluded from MVM |
| partner_governance | partner | ✅ | ✅ |  |
| partner_governance | partner_audit | ✅ | ❌ | Excluded from MVM |
| partner_governance | partner_certification | ✅ | ✅ |  |
| partner_governance | partner_incident | ✅ | ❌ | Excluded from MVM |
| partner_governance | partner_onboarding | ✅ | ✅ |  |
| partner_governance | partner_performance | ✅ | ✅ |  |
| partner_governance | partner_sla | ✅ | ✅ |  |
| partner_governance | partner_tier | ✅ | ❌ | Excluded from MVM |
| partner_governance | tpl_capability | ✅ | ❌ | Excluded from MVM |
| partner_governance | tpl_provider | ✅ | ✅ |  |
| partner_governance | training_provider | ✅ | ❌ | Excluded from MVM |

<a id="domain-pricing"></a>
### pricing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| charge_supplements | accessorial_charge | ✅ | ✅ |  |
| charge_supplements | charge_code | ✅ | ✅ |  |
| charge_supplements | fuel_index | ✅ | ✅ |  |
| charge_supplements | incoterms_charge_allocation | ✅ | ❌ | Excluded from MVM |
| charge_supplements | pricing_surcharge_schedule | ✅ | ✅ |  |
| charge_supplements | surcharge | ✅ | ✅ |  |
| quote_negotiation | carrier_buy_rate | ✅ | ✅ |  |
| quote_negotiation | commodity_rate_class | ✅ | ❌ | Excluded from MVM |
| quote_negotiation | dim_weight_rule | ✅ | ✅ |  |
| quote_negotiation | pricing_volume_commitment | ✅ | ❌ | Excluded from MVM |
| quote_negotiation | service_level_rate | ✅ | ❌ | Excluded from MVM |
| quote_negotiation | spot_quote | ✅ | ✅ |  |
| quote_negotiation | spot_quote_line | ✅ | ✅ |  |
| rate_management | contract_rate | ✅ | ✅ |  |
| rate_management | gri_announcement | ✅ | ❌ | Excluded from MVM |
| rate_management | lane_rate_zone | ✅ | ✅ |  |
| rate_management | rate_audit | ✅ | ❌ | Excluded from MVM |
| rate_management | rate_card | ✅ | ✅ |  |
| rate_management | rate_card_assignment | ✅ | ❌ | Excluded from MVM |
| rate_management | rate_line | ✅ | ✅ |  |
| rate_management | rate_request | ✅ | ❌ | Excluded from MVM |
| rate_management | rate_rule | ✅ | ✅ |  |
| rate_management | rate_sustainability_contribution | ✅ | ❌ | Excluded from MVM |
| rate_management | tariff | ✅ | ✅ |  |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| order_fulfillment | approval_rule | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | approval_session | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | goods_receipt | ✅ | ✅ |  |
| order_fulfillment | item | ✅ | ✅ |  |
| order_fulfillment | po_line | ✅ | ✅ |  |
| order_fulfillment | procurement_approval_workflow | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | procurement_invoice_line | ✅ | ✅ |  |
| order_fulfillment | purchase_order | ✅ | ✅ |  |
| order_fulfillment | purchase_requisition | ✅ | ✅ |  |
| order_fulfillment | supplier_invoice | ✅ | ✅ |  |
| sourcing_agreements | blanket_order | ✅ | ❌ | Excluded from MVM |
| sourcing_agreements | carbon_offset_procurement_agreement | ✅ | ❌ | Excluded from MVM |
| sourcing_agreements | contract_sustainability_contribution | ✅ | ❌ | Excluded from MVM |
| sourcing_agreements | contracted_service | ✅ | ❌ | Excluded from MVM |
| sourcing_agreements | procurement_contract | ✅ | ❌ | Excluded from MVM |
| sourcing_agreements | rate_agreement | ✅ | ❌ | Excluded from MVM |
| sourcing_agreements | rfq | ✅ | ✅ |  |
| sourcing_agreements | supplier_quote | ✅ | ✅ |  |
| vendor_management | supplier | ✅ | ✅ |  |
| vendor_management | supplier_performance | ✅ | ❌ | Excluded from MVM |
| vendor_management | supplier_qualification | ✅ | ✅ |  |
| vendor_management | supplier_site | ✅ | ✅ |  |
| vendor_management | supply_agreement | ❌ | ✅ | In ECM under domain(s): warehouse |

<a id="domain-route"></a>
### route

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| carrier_operations | carrier_lane_allocation | ✅ | ✅ |  |
| carrier_operations | carrier_schedule | ✅ | ✅ |  |
| carrier_operations | transit_time_standard | ✅ | ✅ |  |
| execution_planning | eta_event | ✅ | ✅ |  |
| execution_planning | lane_performance | ✅ | ✅ |  |
| execution_planning | network_optimization_run | ✅ | ❌ | Excluded from MVM |
| execution_planning | optimization_recommendation | ✅ | ❌ | Excluded from MVM |
| execution_planning | plan | ✅ | ✅ |  |
| execution_planning | plan_leg | ✅ | ✅ |  |
| execution_planning | route_exception | ✅ | ❌ | Excluded from MVM |
| lane_governance | lane_assignment | ✅ | ❌ | Excluded from MVM |
| lane_governance | lane_budget_allocation | ✅ | ❌ | Excluded from MVM |
| lane_governance | lane_compliance_certification | ✅ | ❌ | Excluded from MVM |
| lane_governance | lane_facility_service | ✅ | ❌ | Excluded from MVM |
| lane_governance | lane_fulfillment_allocation | ✅ | ❌ | Excluded from MVM |
| lane_governance | lane_qualification | ✅ | ❌ | Excluded from MVM |
| lane_governance | lane_safety_program_requirement | ✅ | ❌ | Excluded from MVM |
| lane_governance | lane_surcharge_application | ✅ | ❌ | Excluded from MVM |
| lane_governance | schedule_dg_requirement | ✅ | ❌ | Excluded from MVM |
| network_topology | corridor_leg | ✅ | ✅ |  |
| network_topology | hub_spoke_config | ✅ | ✅ |  |
| network_topology | lane | ✅ | ✅ |  |
| network_topology | network_node | ✅ | ✅ |  |
| network_topology | route_delivery_zone | ✅ | ✅ |  |
| network_topology | service_corridor | ✅ | ✅ |  |

<a id="domain-safety"></a>
### safety

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_assurance | audit | ✅ | ❌ | Domain not in MVM |
| compliance_assurance | contractor_safety_prequal | ✅ | ❌ | Domain not in MVM |
| compliance_assurance | dg_certification | ✅ | ❌ | Domain not in MVM |
| compliance_assurance | facility_inspection | ✅ | ❌ | Domain not in MVM |
| compliance_assurance | hse_legal_register | ✅ | ❌ | Domain not in MVM |
| compliance_assurance | permit | ✅ | ❌ | Domain not in MVM |
| compliance_assurance | safety_audit_finding | ✅ | ❌ | Domain not in MVM |
| incident_management | corrective_action | ✅ | ❌ | Domain not in MVM |
| incident_management | dg_incident | ✅ | ❌ | Domain not in MVM |
| incident_management | environmental_incident | ✅ | ❌ | Domain not in MVM |
| incident_management | hse_incident | ✅ | ❌ | Domain not in MVM |
| incident_management | incident_investigation | ✅ | ❌ | Domain not in MVM |
| incident_management | observation | ✅ | ❌ | Domain not in MVM |
| incident_management | osha_recordable | ✅ | ❌ | Domain not in MVM |
| incident_management | regulatory_notification | ✅ | ❌ | Domain not in MVM |
| risk_prevention | alert | ✅ | ❌ | Domain not in MVM |
| risk_prevention | emergency_drill | ✅ | ❌ | Domain not in MVM |
| risk_prevention | emergency_response_plan | ✅ | ❌ | Domain not in MVM |
| risk_prevention | hazard_register | ✅ | ❌ | Domain not in MVM |
| risk_prevention | hub_emergency_plan | ✅ | ❌ | Domain not in MVM |
| risk_prevention | risk_assessment | ✅ | ❌ | Domain not in MVM |
| workforce_readiness | coaching_session | ✅ | ❌ | Domain not in MVM |
| workforce_readiness | driver_safety_event | ✅ | ❌ | Domain not in MVM |
| workforce_readiness | driver_safety_program | ✅ | ❌ | Domain not in MVM |
| workforce_readiness | fatigue_risk_assessment | ✅ | ❌ | Domain not in MVM |
| workforce_readiness | occupational_health_case | ✅ | ❌ | Domain not in MVM |
| workforce_readiness | ppe_issuance | ✅ | ❌ | Domain not in MVM |
| workforce_readiness | program | ✅ | ❌ | Domain not in MVM |
| workforce_readiness | program_training_requirement | ✅ | ❌ | Domain not in MVM |
| workforce_readiness | safety_training_completion | ✅ | ❌ | Domain not in MVM |
| workforce_readiness | training | ✅ | ❌ | Domain not in MVM |

<a id="domain-shipment"></a>
### shipment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| booking_management | consignment | ✅ | ✅ |  |
| booking_management | delivery_instruction | ✅ | ✅ |  |
| booking_management | package | ❌ | ✅ | MVM only (stub or new) |
| booking_management | shipment_carrier_assignment | ✅ | ✅ |  |
| booking_management | shipment_driver_assignment | ✅ | ❌ | Excluded from MVM |
| booking_management | shipment_leg | ✅ | ✅ |  |
| booking_management | shipment_package | ✅ | ❌ | Excluded from MVM |
| booking_management | shipment_sla_commitment | ✅ | ❌ | Excluded from MVM |
| cargo_consolidation | consignment_accessorial_application | ✅ | ❌ | Excluded from MVM |
| cargo_consolidation | consignment_consolidation_entry | ✅ | ❌ | Excluded from MVM |
| cargo_consolidation | freight_manifest | ✅ | ✅ |  |
| cargo_consolidation | manifest_line_item | ✅ | ❌ | Excluded from MVM |
| cargo_consolidation | manifest_supplier_pickup | ✅ | ❌ | Excluded from MVM |
| cargo_consolidation | shipment_charge | ✅ | ✅ |  |
| cargo_consolidation | shipment_document | ✅ | ✅ |  |
| delivery_fulfillment | consignment_offset_allocation | ✅ | ❌ | Excluded from MVM |
| delivery_fulfillment | pod | ✅ | ✅ |  |
| delivery_fulfillment | return_shipment | ✅ | ❌ | Excluded from MVM |
| delivery_fulfillment | shipment_asn | ✅ | ❌ | Excluded from MVM |
| transit_operations | consignment_status | ✅ | ✅ |  |
| transit_operations | eta_milestone | ✅ | ✅ |  |
| transit_operations | exception_event | ✅ | ✅ |  |
| transit_operations | temperature_log | ✅ | ❌ | Excluded from MVM |
| transit_operations | tracking_event | ✅ | ✅ |  |
| transit_operations | transit_hub_event | ✅ | ❌ | Excluded from MVM |
| transport_execution | manifest_line | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-sustainability"></a>
### sustainability

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| carbon_accounting | emissions_factor | ✅ | ❌ | Domain not in MVM |
| carbon_accounting | fuel_consumption_record | ✅ | ❌ | Domain not in MVM |
| carbon_accounting | ghg_inventory | ✅ | ❌ | Domain not in MVM |
| carbon_accounting | shipment_carbon_footprint | ✅ | ❌ | Domain not in MVM |
| carbon_accounting | supplier_emissions_disclosure | ✅ | ❌ | Domain not in MVM |
| offset_compliance | carbon_offset_program | ✅ | ❌ | Domain not in MVM |
| offset_compliance | carbon_offset_transaction | ✅ | ❌ | Domain not in MVM |
| offset_compliance | compliance_period | ✅ | ❌ | Domain not in MVM |
| offset_compliance | corsia_compliance_record | ✅ | ❌ | Domain not in MVM |
| offset_compliance | eu_ets_allowance | ✅ | ❌ | Domain not in MVM |
| offset_compliance | saf_procurement | ✅ | ❌ | Domain not in MVM |
| reporting_governance | customer_carbon_report | ✅ | ❌ | Domain not in MVM |
| reporting_governance | esg_disclosure | ✅ | ❌ | Domain not in MVM |
| reporting_governance | esg_rating_record | ✅ | ❌ | Domain not in MVM |
| reporting_governance | green_shipment_certificate | ✅ | ❌ | Domain not in MVM |
| reporting_governance | initiative | ✅ | ❌ | Domain not in MVM |
| reporting_governance | target | ✅ | ❌ | Domain not in MVM |
| resource_operations | energy_consumption_record | ✅ | ❌ | Domain not in MVM |
| resource_operations | packaging_sustainability | ✅ | ❌ | Domain not in MVM |
| resource_operations | renewable_energy_certificate | ✅ | ❌ | Domain not in MVM |
| resource_operations | waste_record | ✅ | ❌ | Domain not in MVM |
| resource_operations | water_consumption_record | ✅ | ❌ | Domain not in MVM |

<a id="domain-warehouse"></a>
### warehouse

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| facility_infrastructure | dock_appointment | ✅ | ✅ |  |
| facility_infrastructure | equipment | ✅ | ❌ | Excluded from MVM |
| facility_infrastructure | facility | ✅ | ✅ |  |
| facility_infrastructure | hazmat_storage_compliance | ✅ | ❌ | Excluded from MVM |
| facility_infrastructure | packing_station | ✅ | ❌ | Excluded from MVM |
| facility_infrastructure | storage_location | ✅ | ✅ |  |
| facility_infrastructure | zone | ✅ | ✅ |  |
| inbound_operations | asn | ❌ | ✅ | MVM only (stub or new) |
| inbound_receiving | asn_line | ✅ | ✅ |  |
| inbound_receiving | inbound_receipt | ✅ | ✅ |  |
| inbound_receiving | inbound_receipt_line | ✅ | ✅ |  |
| inbound_receiving | putaway_task | ✅ | ✅ |  |
| inbound_receiving | returns_receipt | ✅ | ❌ | Excluded from MVM |
| inbound_receiving | returns_receipt_line | ✅ | ❌ | Excluded from MVM |
| inbound_receiving | warehouse_asn | ✅ | ❌ | Excluded from MVM |
| inventory_control | carton | ✅ | ❌ | Excluded from MVM |
| inventory_control | cycle_count | ✅ | ✅ |  |
| inventory_control | cycle_count_line | ✅ | ✅ |  |
| inventory_control | handling_unit | ✅ | ✅ |  |
| inventory_control | inventory_movement | ✅ | ✅ |  |
| inventory_control | inventory_position | ✅ | ✅ |  |
| inventory_control | material | ✅ | ❌ | Excluded from MVM |
| inventory_control | pallet | ✅ | ❌ | Excluded from MVM |
| inventory_control | replenishment_order | ✅ | ❌ | Excluded from MVM |
| inventory_control | sku | ✅ | ✅ |  |
| outbound_fulfillment | outbound_order_line | ✅ | ✅ |  |
| outbound_fulfillment | outbound_shipment_order | ✅ | ✅ |  |
| outbound_fulfillment | pack_order | ✅ | ✅ |  |
| outbound_fulfillment | pick_task | ✅ | ✅ |  |
| outbound_fulfillment | pick_wave | ✅ | ✅ |  |
| outbound_fulfillment | wip_record | ✅ | ❌ | Excluded from MVM |
| partner_agreements | counter_team | ✅ | ❌ | Excluded from MVM |
| partner_agreements | facility_agreement | ✅ | ❌ | Excluded from MVM |
| partner_agreements | facility_carrier_service | ✅ | ❌ | Excluded from MVM |
| partner_agreements | facility_partner_agreement | ✅ | ❌ | Excluded from MVM |
| partner_agreements | labor_activity | ✅ | ❌ | Excluded from MVM |
| partner_agreements | service_agreement | ✅ | ❌ | Excluded from MVM |
| partner_agreements | supply_agreement | ✅ | ❌ | Excluded from MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_benefits | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | compensation_plan | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | labor_contract | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | labor_cost_allocation | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | pay_group | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | payroll_record | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | payroll_run | ✅ | ❌ | Domain not in MVM |
| organization_structure | employee | ✅ | ❌ | Domain not in MVM |
| organization_structure | fte_plan | ✅ | ❌ | Domain not in MVM |
| organization_structure | job_profile | ✅ | ❌ | Domain not in MVM |
| organization_structure | location | ✅ | ❌ | Domain not in MVM |
| organization_structure | org_unit | ✅ | ❌ | Domain not in MVM |
| organization_structure | position | ✅ | ❌ | Domain not in MVM |
| organization_structure | recruitment_requisition | ✅ | ❌ | Domain not in MVM |
| organization_structure | worker_assignment | ✅ | ❌ | Domain not in MVM |
| safety_compliance | crew_certification | ✅ | ❌ | Domain not in MVM |
| safety_compliance | driver_qualification | ✅ | ❌ | Domain not in MVM |
| safety_compliance | drug_alcohol_test | ✅ | ❌ | Domain not in MVM |
| safety_compliance | fmla_case | ✅ | ❌ | Domain not in MVM |
| safety_compliance | hours_of_service_log | ✅ | ❌ | Domain not in MVM |
| safety_compliance | random_pool | ✅ | ❌ | Domain not in MVM |
| scheduling_operations | absence_record | ✅ | ❌ | Domain not in MVM |
| scheduling_operations | initiative_participation | ✅ | ❌ | Domain not in MVM |
| scheduling_operations | shift_assignment | ✅ | ❌ | Domain not in MVM |
| scheduling_operations | shift_schedule | ✅ | ❌ | Domain not in MVM |
| scheduling_operations | target_accountability | ✅ | ❌ | Domain not in MVM |
| talent_development | competency_record | ✅ | ❌ | Domain not in MVM |
| talent_development | performance_review | ✅ | ❌ | Domain not in MVM |
| talent_development | training_course | ✅ | ❌ | Domain not in MVM |
| talent_development | training_record | ✅ | ❌ | Domain not in MVM |
| talent_development | training_session | ✅ | ❌ | Domain not in MVM |
| talent_development | workforce_training_completion | ✅ | ❌ | Domain not in MVM |
