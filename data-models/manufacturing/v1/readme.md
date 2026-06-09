# Manufacturing Lakehouse Data Models

**Version 1** | Generated on May 06, 2026 at 09:42 AM

**Industry:** industrial-manufacturing

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Asset](#domain-asset)
  - [Automation](#domain-automation)
  - [Billing](#domain-billing)
  - [Compliance](#domain-compliance)
  - [Customer](#domain-customer)
  - [Engineering](#domain-engineering)
  - [Finance](#domain-finance)
  - [Inventory](#domain-inventory)
  - [Logistics](#domain-logistics)
  - [Order](#domain-order)
  - [Procurement](#domain-procurement)
  - [Product](#domain-product)
  - [Production](#domain-production)
  - [Project](#domain-project)
  - [Quality](#domain-quality)
  - [Sales](#domain-sales)
  - [Service](#domain-service)
  - [Supplier](#domain-supplier)
  - [Supply](#domain-supply)
  - [Workforce](#domain-workforce)


## Business Description

Industrial Manufacturing encompasses the design, production, and delivery of automation systems, electrification solutions, and smart infrastructure components for factories, buildings, transportation, and urban environments.

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
| Domains | 12 | 20 |
| Subdomains | 28 | 71 |
| Products (Tables) | 129 | 413 |
| Attributes (Columns) | 5637 | 15623 |
| Foreign Keys | 1193 | 2290 |
| Avg Attributes/Product | 43.7 | 37.8 |

## Domain & Product Comparison

<a id="domain-asset"></a>
### asset

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_register | asset_certification | ✅ | ❌ | Excluded from MVM |
| asset_register | asset_warranty | ✅ | ❌ | Excluded from MVM |
| asset_register | capex_asset_record | ✅ | ❌ | Excluded from MVM |
| asset_register | equipment_register | ✅ | ✅ |  |
| asset_register | location | ✅ | ✅ |  |
| asset_register | plant | ✅ | ❌ | Excluded from MVM |
| compliance_assurance | calibration_record | ✅ | ✅ |  |
| compliance_assurance | calibration_standard | ✅ | ❌ | Excluded from MVM |
| compliance_assurance | compliance_assessment | ✅ | ❌ | Excluded from MVM |
| compliance_assurance | inspection_checklist | ✅ | ❌ | Excluded from MVM |
| compliance_assurance | inspection_event | ✅ | ✅ |  |
| compliance_assurance | regulatory_applicability | ✅ | ❌ | Excluded from MVM |
| maintenance_planning | asset_pm_schedule | ✅ | ❌ | Excluded from MVM |
| maintenance_planning | asset_work_order | ✅ | ✅ |  |
| maintenance_planning | craft_skill | ✅ | ❌ | Excluded from MVM |
| maintenance_planning | job_plan | ✅ | ✅ |  |
| maintenance_planning | job_plan_material_requirement | ❌ | ✅ | MVM only (stub or new) |
| maintenance_planning | maintenance_strategy | ✅ | ❌ | Excluded from MVM |
| maintenance_planning | pm_schedule | ❌ | ✅ | MVM only (stub or new) |
| maintenance_planning | work_order_type | ✅ | ❌ | Excluded from MVM |
| reliability_management | asset_downtime_event | ✅ | ✅ |  |
| reliability_management | condition_reading | ✅ | ✅ |  |
| reliability_management | failure_record | ✅ | ✅ |  |
| reliability_management | lubrication_route | ✅ | ❌ | Excluded from MVM |
| reliability_management | reliability_record | ✅ | ❌ | Excluded from MVM |
| spare_parts | equipment_allocation | ✅ | ❌ | Excluded from MVM |
| spare_parts | equipment_shipment | ✅ | ❌ | Excluded from MVM |
| spare_parts | spare_part | ✅ | ✅ |  |

<a id="domain-automation"></a>
### automation

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| device_management | device_config_snapshot | ✅ | ❌ | Domain not in MVM |
| device_management | device_connectivity_event | ✅ | ❌ | Domain not in MVM |
| device_management | device_registry | ✅ | ❌ | Domain not in MVM |
| device_management | edge_gateway | ✅ | ❌ | Domain not in MVM |
| device_management | firmware_update | ✅ | ❌ | Domain not in MVM |
| device_management | io_mapping | ✅ | ❌ | Domain not in MVM |
| device_management | network_segment | ✅ | ❌ | Domain not in MVM |
| device_management | opc_server | ✅ | ❌ | Domain not in MVM |
| operations_assurance | automation_change_request | ✅ | ❌ | Domain not in MVM |
| operations_assurance | automation_project | ✅ | ❌ | Domain not in MVM |
| operations_assurance | automation_script | ✅ | ❌ | Domain not in MVM |
| operations_assurance | batch_schedule | ✅ | ❌ | Domain not in MVM |
| operations_assurance | fat_sat_record | ✅ | ❌ | Domain not in MVM |
| operations_assurance | proof_test_record | ✅ | ❌ | Domain not in MVM |
| operations_assurance | scada_session | ✅ | ❌ | Domain not in MVM |
| operations_assurance | test_case | ✅ | ❌ | Domain not in MVM |
| operations_assurance | test_procedure | ✅ | ❌ | Domain not in MVM |
| process_control | alarm_definition | ✅ | ❌ | Domain not in MVM |
| process_control | alarm_event | ✅ | ❌ | Domain not in MVM |
| process_control | batch_execution | ✅ | ❌ | Domain not in MVM |
| process_control | control_mode_event | ✅ | ❌ | Domain not in MVM |
| process_control | control_system | ✅ | ❌ | Domain not in MVM |
| process_control | equipment_phase | ✅ | ❌ | Domain not in MVM |
| process_control | historian_config | ✅ | ❌ | Domain not in MVM |
| process_control | plc_program | ✅ | ❌ | Domain not in MVM |
| process_control | process_parameter | ✅ | ❌ | Domain not in MVM |
| process_control | recipe | ✅ | ❌ | Domain not in MVM |
| process_control | safety_function | ✅ | ❌ | Domain not in MVM |
| process_control | setpoint_change | ✅ | ❌ | Domain not in MVM |
| process_control | tag_definition | ✅ | ❌ | Domain not in MVM |

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| credit_collections | collections | ✅ | ❌ | Domain not in MVM |
| credit_collections | credit_limit | ✅ | ❌ | Domain not in MVM |
| credit_collections | dispute | ✅ | ❌ | Domain not in MVM |
| credit_collections | write_off | ✅ | ❌ | Domain not in MVM |
| invoice_management | billing_account | ✅ | ❌ | Domain not in MVM |
| invoice_management | billing_cycle | ✅ | ❌ | Domain not in MVM |
| invoice_management | billing_schedule | ✅ | ❌ | Domain not in MVM |
| invoice_management | intercompany_invoice | ✅ | ❌ | Domain not in MVM |
| invoice_management | invoice | ✅ | ❌ | Domain not in MVM |
| invoice_management | invoice_line | ✅ | ❌ | Domain not in MVM |
| invoice_management | tax_determination | ✅ | ❌ | Domain not in MVM |
| payment_processing | advance_payment | ✅ | ❌ | Domain not in MVM |
| payment_processing | payment | ✅ | ❌ | Domain not in MVM |
| payment_processing | payment_term | ✅ | ❌ | Domain not in MVM |
| payment_processing | revenue_recognition_event | ✅ | ❌ | Domain not in MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| cybersecurity_controls | cybersecurity_assessment | ✅ | ❌ | Domain not in MVM |
| cybersecurity_controls | cybersecurity_control | ✅ | ❌ | Domain not in MVM |
| environmental_compliance | emission_source | ✅ | ❌ | Domain not in MVM |
| environmental_compliance | emissions_record | ✅ | ❌ | Domain not in MVM |
| environmental_compliance | environmental_aspect | ✅ | ❌ | Domain not in MVM |
| environmental_compliance | facility | ✅ | ❌ | Domain not in MVM |
| environmental_compliance | permit | ✅ | ❌ | Domain not in MVM |
| environmental_compliance | waste_record | ✅ | ❌ | Domain not in MVM |
| regulatory_management | audit_event | ✅ | ❌ | Domain not in MVM |
| regulatory_management | audit_plan | ✅ | ❌ | Domain not in MVM |
| regulatory_management | compliance_audit_finding | ✅ | ❌ | Domain not in MVM |
| regulatory_management | compliance_capa_record | ✅ | ❌ | Domain not in MVM |
| regulatory_management | compliance_product_certification | ✅ | ❌ | Domain not in MVM |
| regulatory_management | controlled_document | ✅ | ❌ | Domain not in MVM |
| regulatory_management | obligation | ✅ | ❌ | Domain not in MVM |
| regulatory_management | periodic_evaluation | ✅ | ❌ | Domain not in MVM |
| regulatory_management | regulatory_filing | ✅ | ❌ | Domain not in MVM |
| regulatory_management | regulatory_requirement | ✅ | ❌ | Domain not in MVM |
| safety_operations | hazardous_substance | ✅ | ❌ | Domain not in MVM |
| safety_operations | process_hazard | ✅ | ❌ | Domain not in MVM |
| safety_operations | safety_checklist | ✅ | ❌ | Domain not in MVM |
| safety_operations | safety_incident | ✅ | ❌ | Domain not in MVM |
| safety_operations | safety_inspection | ✅ | ❌ | Domain not in MVM |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_identity | account | ❌ | ✅ | MVM only (stub or new) |
| account_management | account_hierarchy | ✅ | ❌ | Excluded from MVM |
| account_management | account_relationship | ✅ | ❌ | Excluded from MVM |
| account_management | account_team | ✅ | ❌ | Excluded from MVM |
| account_management | customer_account | ✅ | ❌ | Excluded from MVM |
| agreement_terms | account_site | ✅ | ✅ |  |
| agreement_terms | customer_certification | ✅ | ❌ | Excluded from MVM |
| agreement_terms | segment | ✅ | ✅ |  |
| agreement_terms | sla_agreement | ✅ | ✅ |  |
| contact_details | address | ✅ | ✅ |  |
| contact_details | customer_contact | ✅ | ✅ |  |
| credit_services | credit_profile | ✅ | ✅ |  |
| credit_services | customer_entitlement | ✅ | ❌ | Excluded from MVM |
| sales_operations | customer_document | ✅ | ❌ | Excluded from MVM |
| sales_operations | customer_lead | ✅ | ❌ | Excluded from MVM |
| sales_operations | customer_onboarding | ✅ | ❌ | Excluded from MVM |
| sales_operations | interaction | ✅ | ❌ | Excluded from MVM |

<a id="domain-engineering"></a>
### engineering

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| change_control | affected_item | ❌ | ✅ | MVM only (stub or new) |
| change_control | design_review | ✅ | ❌ | Excluded from MVM |
| change_control | ecn | ✅ | ✅ |  |
| change_control | eco | ✅ | ✅ |  |
| change_control | project | ❌ | ✅ | MVM only (stub or new) |
| product_design | cad_model | ✅ | ❌ | Excluded from MVM |
| product_design | certification_requirement | ✅ | ❌ | Excluded from MVM |
| product_design | component | ✅ | ✅ |  |
| product_design | dfm_analysis | ✅ | ❌ | Excluded from MVM |
| product_design | dfmea | ✅ | ❌ | Excluded from MVM |
| product_design | drawing | ✅ | ✅ |  |
| product_design | engineering_revision | ✅ | ✅ |  |
| product_design | engineering_specification | ✅ | ✅ |  |
| project_execution | bom | ✅ | ✅ |  |
| project_execution | component_installation | ✅ | ❌ | Excluded from MVM |
| project_execution | configuration_baseline | ✅ | ❌ | Excluded from MVM |
| project_execution | engineering_bom_line | ✅ | ✅ |  |
| project_execution | engineering_project | ✅ | ❌ | Excluded from MVM |
| project_execution | project_material_allocation | ✅ | ❌ | Excluded from MVM |
| project_execution | test_result | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_accounting | bank_account | ✅ | ✅ |  |
| asset_accounting | business_partner | ✅ | ✅ |  |
| asset_accounting | capex_request | ✅ | ❌ | Excluded from MVM |
| asset_accounting | chart_of_accounts | ✅ | ❌ | Excluded from MVM |
| asset_accounting | company_code | ✅ | ✅ |  |
| asset_accounting | financial_plan | ✅ | ❌ | Excluded from MVM |
| asset_accounting | fixed_asset | ✅ | ✅ |  |
| asset_accounting | gl_account | ✅ | ✅ |  |
| asset_accounting | ledger | ✅ | ❌ | Excluded from MVM |
| cost_management | allocation_cycle | ✅ | ❌ | Excluded from MVM |
| cost_management | allocation_rule | ✅ | ❌ | Excluded from MVM |
| cost_management | cost_allocation | ✅ | ❌ | Excluded from MVM |
| cost_management | cost_center | ✅ | ✅ |  |
| cost_management | cost_element | ✅ | ❌ | Excluded from MVM |
| cost_management | cost_estimate | ✅ | ❌ | Excluded from MVM |
| cost_management | cost_object | ✅ | ❌ | Excluded from MVM |
| cost_management | finance_budget | ✅ | ❌ | Excluded from MVM |
| cost_management | internal_order | ✅ | ❌ | Excluded from MVM |
| cost_management | profit_center | ✅ | ✅ |  |
| cost_management | statistical_key_figure | ✅ | ❌ | Excluded from MVM |
| ledger_controlling | budget | ❌ | ✅ | MVM only (stub or new) |
| procurement_payables | commodity_category | ❌ | ✅ | In ECM under domain(s): procurement |
| procurement_payables | procurement_contract | ❌ | ✅ | In ECM under domain(s): procurement |
| procurement_payables | supplier_invoice | ❌ | ✅ | In ECM under domain(s): procurement |
| transaction_processing | ap_invoice | ✅ | ✅ |  |
| transaction_processing | ar_item | ✅ | ✅ |  |
| transaction_processing | intercompany_transaction | ✅ | ❌ | Excluded from MVM |
| transaction_processing | journal_entry | ✅ | ✅ |  |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_management | control_cycle | ✅ | ❌ | Excluded from MVM |
| inventory_management | cycle_count | ✅ | ✅ |  |
| inventory_management | cycle_count_line | ✅ | ✅ |  |
| inventory_management | inventory_safety_stock_policy | ✅ | ❌ | Excluded from MVM |
| inventory_management | kanban_card | ✅ | ❌ | Excluded from MVM |
| inventory_management | quarantine_stock | ✅ | ❌ | Excluded from MVM |
| inventory_management | replenishment_order | ✅ | ✅ |  |
| inventory_management | stock_balance | ✅ | ✅ |  |
| inventory_management | stock_movement | ✅ | ✅ |  |
| inventory_management | stock_valuation | ✅ | ❌ | Excluded from MVM |
| inventory_management | wip_stock | ✅ | ❌ | Excluded from MVM |
| product_catalog | lot_batch | ✅ | ✅ |  |
| product_catalog | material_master | ✅ | ✅ |  |
| product_catalog | serialized_unit | ✅ | ✅ |  |
| warehouse_operations | plant | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | stock_location | ✅ | ✅ |  |
| warehouse_operations | supply_area | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | warehouse | ✅ | ✅ |  |

<a id="domain-logistics"></a>
### logistics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| carrier_management | carrier | ✅ | ❌ | Domain not in MVM |
| carrier_management | carrier_certification | ✅ | ❌ | Domain not in MVM |
| carrier_management | carrier_contract | ✅ | ❌ | Domain not in MVM |
| freight_finance | freight_claim | ✅ | ❌ | Domain not in MVM |
| freight_finance | freight_invoice | ✅ | ❌ | Domain not in MVM |
| freight_finance | freight_order | ✅ | ❌ | Domain not in MVM |
| freight_finance | freight_rate | ✅ | ❌ | Domain not in MVM |
| shipment_operations | bill_of_lading | ✅ | ❌ | Domain not in MVM |
| shipment_operations | delivery_appointment | ✅ | ❌ | Domain not in MVM |
| shipment_operations | delivery_note | ✅ | ❌ | Domain not in MVM |
| shipment_operations | inbound_delivery | ✅ | ❌ | Domain not in MVM |
| shipment_operations | load_plan | ✅ | ❌ | Domain not in MVM |
| shipment_operations | shipment | ✅ | ❌ | Domain not in MVM |
| shipment_operations | shipment_leg | ✅ | ❌ | Domain not in MVM |
| shipment_operations | shipment_tracking_event | ✅ | ❌ | Domain not in MVM |
| trade_compliance | customs_broker | ✅ | ❌ | Domain not in MVM |
| trade_compliance | customs_declaration | ✅ | ❌ | Domain not in MVM |
| trade_compliance | dangerous_goods_declaration | ✅ | ❌ | Domain not in MVM |
| trade_compliance | trade_compliance_record | ✅ | ❌ | Domain not in MVM |
| transport_planning | lane | ✅ | ❌ | Domain not in MVM |
| transport_planning | node | ✅ | ❌ | Domain not in MVM |
| transport_planning | transport_route | ✅ | ❌ | Domain not in MVM |

<a id="domain-order"></a>
### order

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_scheduling | blanket_order | ✅ | ✅ |  |
| contract_scheduling | blanket_order_release | ✅ | ✅ |  |
| delivery_fulfillment | delivery | ✅ | ✅ |  |
| delivery_fulfillment | delivery_item | ✅ | ✅ |  |
| delivery_fulfillment | fulfillment_sla | ✅ | ❌ | Excluded from MVM |
| delivery_fulfillment | goods_issue | ✅ | ✅ |  |
| delivery_fulfillment | proof_of_delivery | ✅ | ❌ | Excluded from MVM |
| delivery_fulfillment | schedule_line | ✅ | ✅ |  |
| fulfillment_returns | rma | ❌ | ✅ | MVM only (stub or new) |
| order_management | amendment | ✅ | ❌ | Excluded from MVM |
| order_management | header | ❌ | ✅ | MVM only (stub or new) |
| order_management | hold | ✅ | ❌ | Excluded from MVM |
| order_management | line | ✅ | ❌ | Excluded from MVM |
| order_management | order_header | ✅ | ❌ | Excluded from MVM |
| order_management | order_line | ❌ | ✅ | In ECM under domain(s): product |
| order_management | order_status_event | ✅ | ❌ | Excluded from MVM |
| pricing_conditions | condition_type | ✅ | ❌ | Excluded from MVM |
| pricing_conditions | pricing_condition | ✅ | ❌ | Excluded from MVM |
| return_processing | order_rma | ✅ | ❌ | Excluded from MVM |
| return_processing | rma_line | ✅ | ✅ |  |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| order_management | contract_release_order | ✅ | ❌ | Domain not in MVM |
| order_management | po_line_item | ✅ | ❌ | Domain not in MVM |
| order_management | purchase_order | ✅ | ❌ | Domain not in MVM |
| receiving_invoicing | invoice_line_item | ✅ | ❌ | Domain not in MVM |
| receiving_invoicing | procurement_goods_receipt | ✅ | ❌ | Domain not in MVM |
| receiving_invoicing | service_entry_sheet | ✅ | ❌ | Domain not in MVM |
| receiving_invoicing | spend_record | ✅ | ❌ | Domain not in MVM |
| receiving_invoicing | supplier_invoice | ✅ | ❌ | Domain not in MVM |
| requisition_approval | approval_workflow | ✅ | ❌ | Domain not in MVM |
| requisition_approval | purchase_requisition | ✅ | ❌ | Domain not in MVM |
| supplier_sourcing | commodity_category | ✅ | ❌ | Domain not in MVM |
| supplier_sourcing | procurement_contract | ✅ | ❌ | Domain not in MVM |
| supplier_sourcing | purchase_info_record | ✅ | ❌ | Domain not in MVM |
| supplier_sourcing | rfq | ✅ | ❌ | Domain not in MVM |
| supplier_sourcing | source_list | ✅ | ❌ | Domain not in MVM |
| supplier_sourcing | sourcing_event | ✅ | ❌ | Domain not in MVM |
| supplier_sourcing | sourcing_strategy | ✅ | ❌ | Domain not in MVM |
| supplier_sourcing | supplier_quotation | ✅ | ❌ | Domain not in MVM |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| item_catalog | catalog_entry | ✅ | ❌ | Excluded from MVM |
| item_catalog | classification | ✅ | ❌ | Excluded from MVM |
| item_catalog | family | ✅ | ✅ |  |
| item_catalog | sku_master | ✅ | ✅ |  |
| order_management | option_set | ✅ | ❌ | Excluded from MVM |
| order_management | order_line | ✅ | ❌ | Excluded from MVM |
| order_management | plant_data | ✅ | ✅ |  |
| order_management | supply_agreement | ✅ | ❌ | Excluded from MVM |
| product_engineering | bom_header | ✅ | ✅ |  |
| product_engineering | bundle | ✅ | ❌ | Excluded from MVM |
| product_engineering | change_order | ✅ | ❌ | Excluded from MVM |
| product_engineering | configuration | ✅ | ✅ |  |
| product_engineering | lifecycle_stage | ✅ | ❌ | Excluded from MVM |
| product_engineering | product_bom_line | ✅ | ✅ |  |
| product_engineering | product_certification | ✅ | ✅ |  |
| product_engineering | product_revision | ✅ | ✅ |  |
| product_engineering | product_specification | ✅ | ✅ |  |
| product_engineering | substitution | ✅ | ❌ | Excluded from MVM |

<a id="domain-production"></a>
### production

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| floor_resources | routing_operation | ❌ | ✅ | MVM only (stub or new) |
| production_planning | bom_consumption | ✅ | ❌ | Excluded from MVM |
| production_planning | calendar | ✅ | ❌ | Excluded from MVM |
| production_planning | production_schedule | ✅ | ❌ | Excluded from MVM |
| production_planning | routing | ✅ | ✅ |  |
| production_planning | version | ✅ | ❌ | Excluded from MVM |
| production_planning | work_order_allocation | ✅ | ❌ | Excluded from MVM |
| resource_management | plant | ✅ | ✅ | Also in domain(s): asset, inventory, supply |
| resource_management | production_line | ✅ | ✅ |  |
| resource_management | resource_tool | ✅ | ❌ | Excluded from MVM |
| resource_management | work_center | ✅ | ✅ |  |
| resource_management | work_center_group | ✅ | ❌ | Excluded from MVM |
| shop_execution | goods_receipt | ❌ | ✅ | MVM only (stub or new) |
| shop_execution | schedule | ❌ | ✅ | MVM only (stub or new) |
| shop_floor | order_confirmation | ✅ | ❌ | Excluded from MVM |
| shop_floor | production_downtime_event | ✅ | ✅ |  |
| shop_floor | production_goods_receipt | ✅ | ❌ | Excluded from MVM |
| shop_floor | production_work_order | ✅ | ✅ |  |
| shop_floor | run | ✅ | ✅ |  |
| shop_floor | shift | ✅ | ✅ |  |
| shop_floor | shift_report | ✅ | ✅ |  |
| shop_floor | shift_sequence | ✅ | ❌ | Excluded from MVM |
| shop_floor | wip_lot | ✅ | ❌ | Excluded from MVM |

<a id="domain-project"></a>
### project

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| cost_finance | commitment | ✅ | ❌ | Domain not in MVM |
| cost_finance | cost_actual | ✅ | ❌ | Domain not in MVM |
| cost_finance | earned_value_record | ✅ | ❌ | Domain not in MVM |
| cost_finance | invoice_request | ✅ | ❌ | Domain not in MVM |
| cost_finance | project_budget | ✅ | ❌ | Domain not in MVM |
| cost_finance | settlement | ✅ | ❌ | Domain not in MVM |
| cost_finance | timesheet | ✅ | ❌ | Domain not in MVM |
| execution_handover | commissioning_checklist | ✅ | ❌ | Domain not in MVM |
| execution_handover | handover | ✅ | ❌ | Domain not in MVM |
| execution_handover | issue | ✅ | ❌ | Domain not in MVM |
| execution_handover | progress_report | ✅ | ❌ | Domain not in MVM |
| execution_handover | project_document | ✅ | ❌ | Domain not in MVM |
| execution_handover | project_status_event | ✅ | ❌ | Domain not in MVM |
| execution_handover | punch_list_item | ✅ | ❌ | Domain not in MVM |
| execution_handover | resource_assignment | ✅ | ❌ | Domain not in MVM |
| execution_handover | team_member | ✅ | ❌ | Domain not in MVM |
| procurement_contracts | procurement_item | ✅ | ❌ | Domain not in MVM |
| procurement_contracts | project_contract | ✅ | ❌ | Domain not in MVM |
| schedule_planning | activity | ✅ | ❌ | Domain not in MVM |
| schedule_planning | gate_review | ✅ | ❌ | Domain not in MVM |
| schedule_planning | milestone | ✅ | ❌ | Domain not in MVM |
| schedule_planning | phase | ✅ | ❌ | Domain not in MVM |
| schedule_planning | plan_version | ✅ | ❌ | Domain not in MVM |
| schedule_planning | project_change_request | ✅ | ❌ | Domain not in MVM |
| schedule_planning | project_header | ✅ | ❌ | Domain not in MVM |
| schedule_planning | wbs_element | ✅ | ❌ | Domain not in MVM |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_compliance | apqp_project | ✅ | ❌ | Excluded from MVM |
| audit_compliance | audit_checklist | ✅ | ❌ | Excluded from MVM |
| audit_compliance | audit_program | ✅ | ❌ | Excluded from MVM |
| audit_compliance | compliance_test | ✅ | ❌ | Excluded from MVM |
| audit_compliance | fmea | ✅ | ✅ |  |
| audit_compliance | ppap_submission | ✅ | ❌ | Excluded from MVM |
| audit_compliance | quality_audit | ✅ | ✅ |  |
| audit_compliance | supplier_quality_audit | ✅ | ❌ | Excluded from MVM |
| inspection_control | plan_characteristic_assignment | ❌ | ✅ | MVM only (stub or new) |
| inspection_management | control_plan | ✅ | ✅ |  |
| inspection_management | inspection_characteristic | ✅ | ✅ |  |
| inspection_management | inspection_lot | ✅ | ✅ |  |
| inspection_management | inspection_plan | ✅ | ✅ |  |
| inspection_management | inspection_result | ✅ | ✅ |  |
| inspection_management | measurement_system | ✅ | ❌ | Excluded from MVM |
| inspection_management | spc | ✅ | ❌ | Excluded from MVM |
| issue_resolution | capa | ✅ | ✅ |  |
| issue_resolution | certificate_of_conformance | ✅ | ❌ | Excluded from MVM |
| issue_resolution | customer_complaint | ✅ | ✅ |  |
| issue_resolution | ncr | ✅ | ✅ |  |
| issue_resolution | notification | ✅ | ❌ | Excluded from MVM |
| issue_resolution | rma_disposition | ✅ | ❌ | Excluded from MVM |

<a id="domain-sales"></a>
### sales

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| commercial_agreements | contract | ❌ | ✅ | MVM only (stub or new) |
| contract_execution | campaign | ✅ | ❌ | Excluded from MVM |
| contract_execution | channel_partner | ✅ | ❌ | Excluded from MVM |
| contract_execution | device_contract_assignment | ✅ | ❌ | Excluded from MVM |
| contract_execution | order_intake | ✅ | ✅ |  |
| contract_execution | project_rep_assignment | ✅ | ❌ | Excluded from MVM |
| contract_execution | quota | ✅ | ❌ | Excluded from MVM |
| contract_execution | rep | ✅ | ✅ |  |
| contract_execution | sales_contract | ✅ | ❌ | Excluded from MVM |
| contract_execution | sales_team | ✅ | ❌ | Excluded from MVM |
| contract_execution | territory | ✅ | ✅ |  |
| contract_execution | territory_assignment | ✅ | ❌ | Excluded from MVM |
| opportunity_pipeline | forecast | ✅ | ❌ | Excluded from MVM |
| opportunity_pipeline | opportunity | ✅ | ✅ |  |
| opportunity_pipeline | opportunity_component | ✅ | ❌ | Excluded from MVM |
| opportunity_pipeline | proposal | ✅ | ❌ | Excluded from MVM |
| opportunity_pipeline | sales_lead | ✅ | ❌ | Excluded from MVM |
| quote_pricing | discount_schedule | ✅ | ❌ | Excluded from MVM |
| quote_pricing | price_book | ✅ | ✅ |  |
| quote_pricing | price_book_entry | ✅ | ✅ |  |
| quote_pricing | quote | ✅ | ✅ |  |
| quote_pricing | quote_line | ✅ | ✅ |  |
| quote_pricing | quote_template | ✅ | ❌ | Excluded from MVM |

<a id="domain-service"></a>
### service

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_administration | contract_line | ✅ | ❌ | Domain not in MVM |
| contract_administration | installed_base | ✅ | ❌ | Domain not in MVM |
| contract_administration | service_contract | ✅ | ❌ | Domain not in MVM |
| contract_administration | service_contract_line | ✅ | ❌ | Domain not in MVM |
| contract_administration | service_entitlement | ✅ | ❌ | Domain not in MVM |
| contract_administration | service_pm_schedule | ✅ | ❌ | Domain not in MVM |
| contract_administration | service_warranty | ✅ | ❌ | Domain not in MVM |
| contract_administration | sla_milestone | ✅ | ❌ | Domain not in MVM |
| field_services | engineer | ✅ | ❌ | Domain not in MVM |
| field_services | engineer_assignment | ✅ | ❌ | Domain not in MVM |
| field_services | field_service_order | ✅ | ❌ | Domain not in MVM |
| field_services | part_consumption | ✅ | ❌ | Domain not in MVM |
| field_services | remote_diagnostic_session | ✅ | ❌ | Domain not in MVM |
| field_services | request | ✅ | ❌ | Domain not in MVM |
| field_services | satisfaction_survey | ✅ | ❌ | Domain not in MVM |
| field_services | service_capa_record | ✅ | ❌ | Domain not in MVM |
| field_services | service_center | ✅ | ❌ | Domain not in MVM |
| field_services | service_rma | ✅ | ❌ | Domain not in MVM |
| field_services | zone | ✅ | ❌ | Domain not in MVM |
| knowledge_base | bulletin | ✅ | ❌ | Domain not in MVM |
| knowledge_base | holiday_calendar | ✅ | ❌ | Domain not in MVM |
| knowledge_base | knowledge_article | ✅ | ❌ | Domain not in MVM |
| knowledge_base | task_checklist | ✅ | ❌ | Domain not in MVM |

<a id="domain-supplier"></a>
### supplier

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| procurement_operations | invoice_line_item | ❌ | ✅ | In ECM under domain(s): procurement |
| procurement_operations | po_line_item | ❌ | ✅ | In ECM under domain(s): procurement |
| procurement_operations | procurement_goods_receipt | ❌ | ✅ | In ECM under domain(s): procurement |
| procurement_operations | purchase_info_record | ❌ | ✅ | In ECM under domain(s): procurement |
| procurement_operations | purchase_order | ❌ | ✅ | In ECM under domain(s): procurement |
| procurement_operations | purchase_requisition | ❌ | ✅ | In ECM under domain(s): procurement |
| quality_assurance | corrective_action | ✅ | ❌ | Excluded from MVM |
| quality_assurance | development_plan | ✅ | ❌ | Excluded from MVM |
| quality_assurance | scorecard | ✅ | ✅ |  |
| quality_assurance | supplier_audit | ✅ | ✅ |  |
| quality_assurance | supplier_audit_finding | ✅ | ❌ | Excluded from MVM |
| quality_assurance | supplier_certification | ✅ | ✅ |  |
| risk_assessment | change_notification | ✅ | ❌ | Excluded from MVM |
| risk_assessment | risk_rating | ✅ | ❌ | Excluded from MVM |
| site_operations | site | ✅ | ✅ |  |
| site_operations | tooling_asset | ✅ | ❌ | Excluded from MVM |
| vendor_management | agreement | ✅ | ✅ |  |
| vendor_management | approved_vendor_list | ✅ | ✅ |  |
| vendor_management | qualification | ✅ | ✅ |  |
| vendor_management | supplier | ✅ | ✅ |  |
| vendor_management | supplier_contact | ✅ | ✅ |  |
| vendor_management | supplier_onboarding | ✅ | ❌ | Excluded from MVM |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| demand_planning | aps_scenario | ✅ | ❌ | Excluded from MVM |
| demand_planning | demand_forecast | ✅ | ✅ |  |
| demand_planning | demand_plan_version | ✅ | ✅ |  |
| demand_planning | mrp_run | ✅ | ✅ |  |
| demand_planning | planning_calendar | ✅ | ❌ | Excluded from MVM |
| demand_planning | planning_parameter | ✅ | ❌ | Excluded from MVM |
| demand_planning | sop_cycle | ✅ | ❌ | Excluded from MVM |
| network_management | network_node | ✅ | ❌ | Excluded from MVM |
| network_management | plant | ✅ | ❌ | Excluded from MVM |
| network_management | risk_register | ✅ | ❌ | Excluded from MVM |
| network_management | sourcing_rule | ✅ | ✅ |  |
| supply_execution | allocation | ✅ | ❌ | Excluded from MVM |
| supply_execution | aps_schedule | ✅ | ❌ | Excluded from MVM |
| supply_execution | capacity_plan | ✅ | ✅ |  |
| supply_execution | inventory_position | ✅ | ❌ | Excluded from MVM |
| supply_execution | material_requirement | ✅ | ✅ |  |
| supply_execution | moq_constraint | ✅ | ❌ | Excluded from MVM |
| supply_execution | plan | ✅ | ✅ |  |
| supply_execution | planned_order | ✅ | ✅ |  |
| supply_execution | planning_exception | ✅ | ❌ | Excluded from MVM |
| supply_execution | replenishment_proposal | ✅ | ❌ | Excluded from MVM |
| supply_execution | safety_stock_policy | ❌ | ✅ | MVM only (stub or new) |
| supply_execution | supply_safety_stock_policy | ✅ | ❌ | Excluded from MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_payroll | benefit_plan | ✅ | ❌ | Domain not in MVM |
| compensation_payroll | payroll_period | ✅ | ❌ | Domain not in MVM |
| compensation_payroll | payroll_result | ✅ | ❌ | Domain not in MVM |
| compensation_payroll | performance_review | ✅ | ❌ | Domain not in MVM |
| employee_records | assignment | ✅ | ❌ | Domain not in MVM |
| employee_records | employee | ✅ | ❌ | Domain not in MVM |
| employee_records | job_profile | ✅ | ❌ | Domain not in MVM |
| employee_records | labor_agreement | ✅ | ❌ | Domain not in MVM |
| employee_records | org_unit | ✅ | ❌ | Domain not in MVM |
| employee_records | position | ✅ | ❌ | Domain not in MVM |
| employee_records | requisition | ✅ | ❌ | Domain not in MVM |
| training_certification | certification_type | ✅ | ❌ | Domain not in MVM |
| training_certification | training_course | ✅ | ❌ | Domain not in MVM |
| training_certification | workforce_certification | ✅ | ❌ | Domain not in MVM |
| work_scheduling | absence_record | ✅ | ❌ | Domain not in MVM |
| work_scheduling | shift_pattern | ✅ | ❌ | Domain not in MVM |
| work_scheduling | shift_schedule | ✅ | ❌ | Domain not in MVM |
| work_scheduling | time_entry | ✅ | ❌ | Domain not in MVM |
