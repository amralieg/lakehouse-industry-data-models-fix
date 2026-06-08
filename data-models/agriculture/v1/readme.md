# Agriculture Lakehouse Data Models

**Version 1** | Generated on May 01, 2026 at 06:45 PM

**Industry:** Agriculture

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Compliance](#domain-compliance)
  - [Crop](#domain-crop)
  - [Customer](#domain-customer)
  - [Equipment](#domain-equipment)
  - [Finance](#domain-finance)
  - [Inventory](#domain-inventory)
  - [Invoice](#domain-invoice)
  - [Land](#domain-land)
  - [Livestock](#domain-livestock)
  - [Procurement](#domain-procurement)
  - [Product](#domain-product)
  - [Quality](#domain-quality)
  - [Research](#domain-research)
  - [Sales](#domain-sales)
  - [Supply](#domain-supply)
  - [Sustainability](#domain-sustainability)
  - [Weather](#domain-weather)
  - [Workforce](#domain-workforce)


## Business Description

Agriculture is a global industry encompassing crop cultivation, animal husbandry, and food production, providing essential supply chain solutions from farm to table for food manufacturers and consumers worldwide.

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
| Domains | 14 | 18 |
| Subdomains | 34 | 59 |
| Products (Tables) | 177 | 408 |
| Attributes (Columns) | 7683 | 15996 |
| Foreign Keys | 1995 | 3226 |
| Avg Attributes/Product | 43.4 | 39.2 |

## Domain & Product Comparison

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_oversight | audit_finding | ✅ | ❌ | Domain not in MVM |
| audit_oversight | compliance_audit | ✅ | ❌ | Domain not in MVM |
| audit_oversight | corrective_action_plan | ✅ | ❌ | Domain not in MVM |
| audit_oversight | inspection_record | ✅ | ❌ | Domain not in MVM |
| audit_oversight | regulatory_finding | ✅ | ❌ | Domain not in MVM |
| audit_oversight | violation_record | ✅ | ❌ | Domain not in MVM |
| operational_programs | food_safety_plan | ✅ | ❌ | Domain not in MVM |
| operational_programs | monitoring_result | ✅ | ❌ | Domain not in MVM |
| operational_programs | organic_compliance_record | ✅ | ❌ | Domain not in MVM |
| operational_programs | pesticide_use_record | ✅ | ❌ | Domain not in MVM |
| operational_programs | recall_event | ✅ | ❌ | Domain not in MVM |
| operational_programs | recall_lot | ✅ | ❌ | Domain not in MVM |
| operational_programs | recall_plan | ✅ | ❌ | Domain not in MVM |
| operational_programs | worker_protection_record | ✅ | ❌ | Domain not in MVM |
| regulatory_authorization | bioterrorism_registration | ✅ | ❌ | Domain not in MVM |
| regulatory_authorization | calendar_entry | ✅ | ❌ | Domain not in MVM |
| regulatory_authorization | license | ✅ | ❌ | Domain not in MVM |
| regulatory_authorization | obligated_entity | ✅ | ❌ | Domain not in MVM |
| regulatory_authorization | obligation | ✅ | ❌ | Domain not in MVM |
| regulatory_authorization | outfall | ✅ | ❌ | Domain not in MVM |
| regulatory_authorization | permit | ✅ | ❌ | Domain not in MVM |
| regulatory_authorization | permit_condition | ✅ | ❌ | Domain not in MVM |
| regulatory_authorization | regulatory_agency | ✅ | ❌ | Domain not in MVM |
| regulatory_authorization | regulatory_change | ✅ | ❌ | Domain not in MVM |
| regulatory_authorization | regulatory_requirement | ✅ | ❌ | Domain not in MVM |
| reporting_submission | document | ✅ | ❌ | Domain not in MVM |
| reporting_submission | event | ✅ | ❌ | Domain not in MVM |
| reporting_submission | regulatory_filing | ✅ | ❌ | Domain not in MVM |
| reporting_submission | trade_compliance_record | ✅ | ❌ | Domain not in MVM |

<a id="domain-crop"></a>
### crop

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| field_operations | fertilization_event | ✅ | ✅ |  |
| field_operations | harvest_event | ✅ | ✅ |  |
| field_operations | irrigation_event | ✅ | ✅ |  |
| field_operations | planting_event | ✅ | ✅ |  |
| field_operations | protection_event | ✅ | ✅ |  |
| input_management | crop | ✅ | ✅ |  |
| input_management | prescription_zone_rate | ✅ | ❌ | Excluded from MVM |
| input_management | seed_lot | ✅ | ✅ |  |
| input_management | vra_prescription | ✅ | ❌ | Excluded from MVM |
| input_management | zone_map | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | grain_delivery | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | loss_event | ✅ | ✅ |  |
| performance_monitoring | scouting_observation | ✅ | ✅ |  |
| performance_monitoring | yield_record | ✅ | ✅ |  |
| season_planning | cover_crop | ✅ | ✅ |  |
| season_planning | field_crop_plan | ✅ | ✅ |  |
| season_planning | growing_season | ✅ | ✅ |  |
| season_planning | rotation_plan | ✅ | ✅ |  |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | account | ✅ | ✅ |  |
| account_management | account_hierarchy | ✅ | ❌ | Excluded from MVM |
| account_management | account_relationship | ✅ | ✅ |  |
| account_management | address | ✅ | ✅ |  |
| account_management | contact | ✅ | ✅ |  |
| account_management | credit_profile | ✅ | ✅ |  |
| account_management | delivery_location | ✅ | ✅ |  |
| account_management | preference | ✅ | ❌ | Excluded from MVM |
| account_management | segment | ✅ | ✅ |  |
| compliance_tracking | certification_record | ✅ | ✅ |  |
| compliance_tracking | cool_preference | ✅ | ❌ | Excluded from MVM |
| compliance_tracking | privacy_notice | ✅ | ❌ | Excluded from MVM |
| engagement_operations | case | ✅ | ✅ |  |
| engagement_operations | consent_record | ✅ | ❌ | Excluded from MVM |
| engagement_operations | lead | ✅ | ❌ | Excluded from MVM |
| engagement_operations | onboarding | ✅ | ❌ | Excluded from MVM |
| program_enrollment | account_commodity_program | ✅ | ❌ | Excluded from MVM |
| program_enrollment | audit_participation | ✅ | ❌ | Excluded from MVM |
| program_enrollment | bundle_enrollment | ✅ | ❌ | Excluded from MVM |
| program_enrollment | dual_role_partnership | ✅ | ❌ | Excluded from MVM |
| program_enrollment | location_commodity_authorization | ✅ | ❌ | Excluded from MVM |

<a id="domain-equipment"></a>
### equipment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| field_operations | field_operation | ❌ | ✅ | MVM only (stub or new) |
| fleet_registry | asset | ✅ | ✅ |  |
| fleet_registry | asset_assignment | ✅ | ✅ |  |
| fleet_registry | asset_category | ✅ | ✅ |  |
| fleet_registry | asset_certification_scope | ✅ | ❌ | Excluded from MVM |
| fleet_registry | asset_contract_allocation | ✅ | ❌ | Excluded from MVM |
| fleet_registry | custom_hire_contract | ✅ | ❌ | Excluded from MVM |
| fleet_registry | input_compatibility | ✅ | ❌ | Excluded from MVM |
| fleet_registry | precision_device | ✅ | ✅ |  |
| fleet_registry | rental_lease | ✅ | ✅ |  |
| maintenance_operations | fault | ✅ | ✅ |  |
| maintenance_operations | inspection_checklist_template | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | maintenance_plan | ✅ | ✅ |  |
| maintenance_operations | maintenance_plan_bom | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | parts_inventory | ✅ | ✅ |  |
| maintenance_operations | parts_issue | ✅ | ✅ |  |
| maintenance_operations | warranty_claim | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | work_center | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | work_order | ✅ | ✅ |  |
| performance_monitoring | asset_inspection | ✅ | ✅ |  |
| performance_monitoring | calibration_event | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | equipment_field_operation | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | oee_record | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | telematics_reading | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| enterprise_planning | capital_project | ✅ | ✅ |  |
| enterprise_planning | crop_enterprise_budget | ✅ | ✅ |  |
| enterprise_planning | fixed_asset | ✅ | ✅ |  |
| enterprise_planning | wbs_element | ✅ | ❌ | Excluded from MVM |
| general_accounting | business_unit | ✅ | ❌ | Excluded from MVM |
| general_accounting | close_calendar | ✅ | ❌ | Excluded from MVM |
| general_accounting | company_code | ✅ | ✅ |  |
| general_accounting | controlling_area | ✅ | ❌ | Excluded from MVM |
| general_accounting | cost_center | ✅ | ✅ |  |
| general_accounting | functional_area | ✅ | ❌ | Excluded from MVM |
| general_accounting | gl_account | ✅ | ✅ |  |
| general_accounting | intercompany_transaction | ✅ | ❌ | Excluded from MVM |
| general_accounting | journal_entry | ✅ | ✅ |  |
| general_accounting | journal_entry_line | ✅ | ✅ |  |
| general_accounting | period_close | ✅ | ✅ |  |
| general_accounting | profit_center | ✅ | ✅ |  |
| general_accounting | tax_record | ✅ | ✅ |  |
| payables_management | ap_invoice_line | ✅ | ❌ | Excluded from MVM |
| payables_management | ap_payment | ✅ | ✅ |  |
| payables_management | finance_ap_invoice | ✅ | ✅ |  |
| payables_management | payment_run | ✅ | ✅ |  |
| treasury_operations | bank_account | ✅ | ✅ |  |
| treasury_operations | commodity_hedge | ✅ | ❌ | Excluded from MVM |
| treasury_operations | financing_arrangement | ✅ | ❌ | Excluded from MVM |
| treasury_operations | government_program | ✅ | ✅ |  |
| treasury_operations | loan | ✅ | ✅ |  |
| treasury_operations | patronage_distribution | ✅ | ❌ | Excluded from MVM |

<a id="domain-inventory"></a>
### inventory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| commodity_fulfillment | lot_allocation | ✅ | ❌ | Excluded from MVM |
| commodity_fulfillment | lot_fulfillment | ✅ | ❌ | Excluded from MVM |
| commodity_fulfillment | lot_pesticide_exposure | ✅ | ❌ | Excluded from MVM |
| movement_operations | adjustment | ✅ | ✅ |  |
| movement_operations | cycle_count | ✅ | ✅ |  |
| movement_operations | goods_issue | ✅ | ✅ |  |
| movement_operations | inventory_goods_receipt | ✅ | ✅ |  |
| movement_operations | stock_reservation | ✅ | ❌ | Excluded from MVM |
| movement_operations | stock_transfer | ✅ | ✅ |  |
| movement_operations | warehouse_task | ✅ | ❌ | Excluded from MVM |
| stock_management | approved_vendor_material | ✅ | ❌ | Excluded from MVM |
| stock_management | bin_location | ✅ | ❌ | Excluded from MVM |
| stock_management | commodity_lot | ✅ | ✅ |  |
| stock_management | material_master | ✅ | ✅ |  |
| stock_management | quarantine_hold | ✅ | ✅ |  |
| stock_management | reorder_policy | ✅ | ❌ | Excluded from MVM |
| stock_management | stock_position | ✅ | ✅ |  |
| stock_management | storage_location | ✅ | ✅ |  |

<a id="domain-invoice"></a>
### invoice

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| adjustment_management | credit_memo | ✅ | ❌ | Excluded from MVM |
| adjustment_management | debit_memo | ✅ | ❌ | Excluded from MVM |
| adjustment_management | dispute | ✅ | ✅ |  |
| adjustment_management | dunning_notice | ✅ | ❌ | Excluded from MVM |
| adjustment_management | receivable_financing | ✅ | ❌ | Excluded from MVM |
| adjustment_management | revenue_recognition | ✅ | ❌ | Excluded from MVM |
| adjustment_management | write_off | ✅ | ❌ | Excluded from MVM |
| billing_operations | billing_account | ✅ | ✅ |  |
| billing_operations | billing_schedule | ✅ | ✅ |  |
| billing_operations | invoice | ✅ | ✅ |  |
| billing_operations | line | ✅ | ✅ |  |
| billing_operations | price_adjustment | ✅ | ✅ |  |
| billing_operations | price_basis | ✅ | ✅ |  |
| billing_operations | settlement_statement | ✅ | ✅ |  |
| billing_operations | weight_ticket | ✅ | ✅ |  |
| payment_processing | advance_payment | ✅ | ❌ | Excluded from MVM |
| payment_processing | payment | ✅ | ✅ |  |
| payment_processing | payment_allocation | ✅ | ✅ |  |
| payment_processing | payment_term | ✅ | ✅ |  |

<a id="domain-land"></a>
### land

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| field_operations | soil_sample | ❌ | ✅ | MVM only (stub or new) |
| legal_rights | easement | ✅ | ❌ | Excluded from MVM |
| legal_rights | field_certification_scope | ✅ | ❌ | Excluded from MVM |
| legal_rights | field_input_restriction | ✅ | ❌ | Excluded from MVM |
| legal_rights | lease | ✅ | ✅ |  |
| legal_rights | ownership | ✅ | ✅ |  |
| legal_rights | water_right | ✅ | ✅ |  |
| operational_planning | conservation_practice | ✅ | ✅ |  |
| operational_planning | farm_operation | ✅ | ✅ |  |
| operational_planning | farm_unit | ✅ | ✅ |  |
| operational_planning | farm_vendor_approval | ✅ | ❌ | Excluded from MVM |
| operational_planning | land_field_operation | ✅ | ❌ | Excluded from MVM |
| operational_planning | use_plan | ✅ | ❌ | Excluded from MVM |
| spatial_assets | field | ✅ | ✅ |  |
| spatial_assets | field_boundary | ✅ | ✅ |  |
| spatial_assets | irrigation_zone | ✅ | ✅ |  |
| spatial_assets | land_soil_sample | ✅ | ❌ | Excluded from MVM |
| spatial_assets | management_zone | ✅ | ✅ |  |
| spatial_assets | parcel | ✅ | ✅ |  |
| spatial_assets | soil_profile | ✅ | ✅ |  |

<a id="domain-livestock"></a>
### livestock

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| animal_health | animal_hold | ✅ | ❌ | Excluded from MVM |
| animal_health | animal_welfare_assessment | ✅ | ❌ | Excluded from MVM |
| animal_health | health_protocol | ✅ | ✅ |  |
| animal_health | health_treatment | ✅ | ✅ |  |
| animal_health | herd_vaccination_schedule | ✅ | ❌ | Excluded from MVM |
| animal_health | protocol_drug_authorization | ✅ | ❌ | Excluded from MVM |
| animal_health | vaccination_record | ✅ | ✅ |  |
| animal_health | veterinary_prescription | ✅ | ✅ |  |
| herd_management | animal | ✅ | ✅ |  |
| herd_management | barn | ✅ | ❌ | Excluded from MVM |
| herd_management | breed | ✅ | ✅ |  |
| herd_management | herd | ✅ | ✅ |  |
| herd_management | pen_location | ✅ | ✅ |  |
| herd_management | production_group | ✅ | ❌ | Excluded from MVM |
| production_operations | animal_disposition | ✅ | ✅ |  |
| production_operations | animal_movement | ✅ | ✅ |  |
| production_operations | animal_transaction | ✅ | ✅ |  |
| production_operations | bulk_tank | ✅ | ❌ | Excluded from MVM |
| production_operations | feed_delivery | ✅ | ✅ |  |
| production_operations | feed_ration | ✅ | ✅ |  |
| production_operations | milk_production_record | ✅ | ✅ |  |
| production_operations | ration_ingredient | ✅ | ✅ |  |
| production_operations | weight_measurement | ✅ | ✅ |  |
| reproductive_services | breeding_event | ✅ | ✅ |  |
| reproductive_services | genomic_test | ✅ | ❌ | Excluded from MVM |
| reproductive_services | parturition_record | ✅ | ✅ |  |
| reproductive_services | semen_canister | ✅ | ❌ | Excluded from MVM |
| reproductive_services | semen_inventory | ✅ | ❌ | Excluded from MVM |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| catalog_compliance | budget | ✅ | ✅ |  |
| catalog_compliance | chemical_compliance | ✅ | ✅ |  |
| catalog_compliance | input_catalog | ✅ | ✅ |  |
| catalog_compliance | purchasing_group | ✅ | ❌ | Excluded from MVM |
| catalog_compliance | purchasing_org | ✅ | ❌ | Excluded from MVM |
| order_processing | delivery_schedule | ✅ | ✅ |  |
| order_processing | procurement_ap_invoice | ✅ | ✅ |  |
| order_processing | procurement_goods_receipt | ✅ | ✅ |  |
| order_processing | purchase_order | ✅ | ✅ |  |
| order_processing | purchase_requisition | ✅ | ✅ |  |
| order_processing | return_claim | ✅ | ❌ | Excluded from MVM |
| order_processing | rfq | ✅ | ❌ | Excluded from MVM |
| supplier_management | approved_vendor_item | ✅ | ❌ | Excluded from MVM |
| supplier_management | vendor | ✅ | ✅ |  |
| supplier_management | vendor_audit | ✅ | ❌ | Excluded from MVM |
| supplier_management | vendor_certification | ✅ | ❌ | Excluded from MVM |
| supplier_management | vendor_commodity_approval | ✅ | ❌ | Excluded from MVM |
| supplier_management | vendor_contract | ✅ | ✅ |  |
| supplier_management | vendor_product_approval | ✅ | ❌ | Excluded from MVM |
| supplier_management | vendor_quotation | ✅ | ❌ | Excluded from MVM |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| input_catalog | agrochemical_practice_compatibility | ✅ | ❌ | Excluded from MVM |
| input_catalog | agrochemical_product | ✅ | ✅ |  |
| input_catalog | bundle | ✅ | ❌ | Excluded from MVM |
| input_catalog | bundle_component | ✅ | ❌ | Excluded from MVM |
| input_catalog | commodity | ✅ | ✅ |  |
| input_catalog | commodity_broker_authorization | ✅ | ❌ | Excluded from MVM |
| input_catalog | hierarchy | ✅ | ✅ |  |
| input_catalog | input_product | ✅ | ❌ | Excluded from MVM |
| input_catalog | livestock_product | ✅ | ❌ | Excluded from MVM |
| input_catalog | master | ✅ | ✅ |  |
| input_catalog | processed_good | ✅ | ❌ | Excluded from MVM |
| input_catalog | product_line | ✅ | ❌ | Excluded from MVM |
| input_catalog | seed_supply_agreement | ✅ | ❌ | Excluded from MVM |
| input_catalog | seed_variety | ✅ | ✅ |  |
| input_catalog | substitution_rule | ✅ | ❌ | Excluded from MVM |
| input_catalog | transformation_event | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | crop_label_registration | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | crop_use_registration | ❌ | ✅ | MVM only (stub or new) |
| regulatory_compliance | gmo_declaration | ✅ | ✅ |  |
| regulatory_compliance | grading_standard | ✅ | ✅ |  |
| regulatory_compliance | label | ✅ | ✅ |  |
| regulatory_compliance | mrl_threshold | ✅ | ✅ |  |
| regulatory_compliance | organic_certification | ✅ | ✅ |  |
| regulatory_compliance | product_certification | ✅ | ✅ |  |
| regulatory_compliance | regulatory_status | ✅ | ❌ | Excluded from MVM |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_auditing | corrective_action | ✅ | ✅ |  |
| compliance_auditing | haccp_plan | ✅ | ✅ |  |
| compliance_auditing | inspection | ✅ | ✅ |  |
| compliance_auditing | inspection_finding | ✅ | ✅ |  |
| compliance_auditing | nonconformance | ✅ | ✅ |  |
| compliance_auditing | quality_audit | ✅ | ❌ | Excluded from MVM |
| compliance_auditing | quality_certification | ✅ | ✅ |  |
| compliance_auditing | regulatory_submission | ✅ | ❌ | Excluded from MVM |
| inspection_audit | audit | ❌ | ✅ | MVM only (stub or new) |
| laboratory_testing | certificate_of_analysis | ✅ | ✅ |  |
| laboratory_testing | lab_sample | ✅ | ✅ |  |
| laboratory_testing | laboratory | ✅ | ✅ |  |
| laboratory_testing | sample_site | ✅ | ❌ | Excluded from MVM |
| laboratory_testing | test_panel | ✅ | ❌ | Excluded from MVM |
| laboratory_testing | test_result | ✅ | ✅ |  |
| operational_monitoring | batch | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | environmental_monitoring | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | facility_monitoring | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | hold_record | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | inspection_lot | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | production_order | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | quality_standard | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | supplier_assessment | ✅ | ❌ | Excluded from MVM |

<a id="domain-research"></a>
### research

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| germplasm_development | accession | ✅ | ❌ | Domain not in MVM |
| germplasm_development | breeding_pipeline | ✅ | ❌ | Domain not in MVM |
| germplasm_development | performance_benchmark | ✅ | ❌ | Domain not in MVM |
| germplasm_development | trait_evaluation | ✅ | ❌ | Domain not in MVM |
| germplasm_development | variety | ✅ | ❌ | Domain not in MVM |
| germplasm_development | variety_license | ✅ | ❌ | Domain not in MVM |
| innovation_portfolio | biotech_submission | ✅ | ❌ | Domain not in MVM |
| innovation_portfolio | cooperator | ✅ | ❌ | Domain not in MVM |
| innovation_portfolio | ip_record | ✅ | ❌ | Domain not in MVM |
| innovation_portfolio | precision_ag_pilot | ✅ | ❌ | Domain not in MVM |
| innovation_portfolio | program | ✅ | ❌ | Domain not in MVM |
| innovation_portfolio | research_project | ✅ | ❌ | Domain not in MVM |
| innovation_portfolio | telemetry_event | ✅ | ❌ | Domain not in MVM |
| trial_management | experimental_design | ✅ | ❌ | Domain not in MVM |
| trial_management | input_usage | ✅ | ❌ | Domain not in MVM |
| trial_management | ipm_study | ✅ | ❌ | Domain not in MVM |
| trial_management | research_soil_sample | ✅ | ❌ | Domain not in MVM |
| trial_management | statistical_result | ✅ | ❌ | Domain not in MVM |
| trial_management | treatment | ✅ | ❌ | Domain not in MVM |
| trial_management | treatment_application | ✅ | ❌ | Domain not in MVM |
| trial_management | trial | ✅ | ❌ | Domain not in MVM |
| trial_management | trial_observation | ✅ | ❌ | Domain not in MVM |
| trial_management | trial_plot | ✅ | ❌ | Domain not in MVM |
| trial_management | trial_protocol | ✅ | ❌ | Domain not in MVM |
| trial_management | trial_site | ✅ | ❌ | Domain not in MVM |
| trial_management | trial_staff_assignment | ✅ | ❌ | Domain not in MVM |
| trial_management | trial_treatment | ✅ | ❌ | Domain not in MVM |
| trial_management | yield_measurement | ✅ | ❌ | Domain not in MVM |

<a id="domain-sales"></a>
### sales

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_administration | contract | ✅ | ✅ |  |
| contract_administration | contract_certification_verification | ✅ | ❌ | Excluded from MVM |
| contract_administration | market_price | ✅ | ✅ |  |
| contract_administration | price_agreement | ✅ | ✅ |  |
| order_fulfillment | customer_allocation | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | delivery_order | ✅ | ✅ |  |
| order_fulfillment | demand_forecast | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | order | ✅ | ✅ |  |
| order_fulfillment | order_line | ✅ | ✅ |  |
| order_fulfillment | organization | ❌ | ✅ | MVM only (stub or new) |
| order_fulfillment | origin_declaration | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | return_order | ✅ | ❌ | Excluded from MVM |
| pipeline_management | broker | ✅ | ✅ |  |
| pipeline_management | distribution_channel | ✅ | ✅ |  |
| pipeline_management | opportunity | ✅ | ✅ |  |
| pipeline_management | quote | ✅ | ✅ |  |
| pipeline_management | sales_organization | ✅ | ❌ | Excluded from MVM |
| pipeline_management | territory | ✅ | ✅ |  |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| freight_movement | bill_of_lading | ✅ | ✅ |  |
| freight_movement | carrier | ✅ | ✅ |  |
| freight_movement | carrier_location_approval | ✅ | ❌ | Excluded from MVM |
| freight_movement | carrier_performance | ✅ | ❌ | Excluded from MVM |
| freight_movement | container | ✅ | ❌ | Excluded from MVM |
| freight_movement | contract_commodity_coverage | ✅ | ❌ | Excluded from MVM |
| freight_movement | customs_declaration | ✅ | ❌ | Excluded from MVM |
| freight_movement | delivery_event | ✅ | ✅ |  |
| freight_movement | freight_booking | ✅ | ✅ |  |
| freight_movement | freight_invoice | ✅ | ❌ | Excluded from MVM |
| freight_movement | freight_rate | ✅ | ✅ |  |
| freight_movement | load_plan | ✅ | ❌ | Excluded from MVM |
| freight_movement | route | ✅ | ✅ |  |
| freight_movement | route_stop | ✅ | ❌ | Excluded from MVM |
| freight_movement | service_contract | ✅ | ✅ |  |
| freight_movement | shipment | ✅ | ✅ |  |
| freight_movement | shipment_line | ✅ | ✅ |  |
| freight_movement | transport_order | ✅ | ✅ |  |
| freight_movement | transport_unit | ✅ | ✅ |  |
| network_operations | facility | ✅ | ✅ |  |
| network_operations | facility_commodity_capability | ✅ | ❌ | Excluded from MVM |
| network_operations | inbound_plan | ✅ | ❌ | Excluded from MVM |
| network_operations | logistics_plan | ✅ | ❌ | Excluded from MVM |
| network_operations | plant | ✅ | ✅ |  |
| quality_traceability | cold_chain_reading | ✅ | ❌ | Excluded from MVM |
| quality_traceability | fsma_compliance | ✅ | ❌ | Excluded from MVM |
| quality_traceability | lot_trace | ✅ | ✅ |  |

<a id="domain-sustainability"></a>
### sustainability

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| emission_management | carbon_credit | ✅ | ❌ | Domain not in MVM |
| emission_management | carbon_footprint | ✅ | ❌ | Domain not in MVM |
| emission_management | carbon_project | ✅ | ❌ | Domain not in MVM |
| emission_management | emission_factor | ✅ | ❌ | Domain not in MVM |
| emission_management | ghg_emission | ✅ | ❌ | Domain not in MVM |
| emission_management | scope3_category | ✅ | ❌ | Domain not in MVM |
| performance_tracking | climate_risk_assessment | ✅ | ❌ | Domain not in MVM |
| performance_tracking | environmental_incident | ✅ | ❌ | Domain not in MVM |
| performance_tracking | esg_metric | ✅ | ❌ | Domain not in MVM |
| performance_tracking | esg_report | ✅ | ❌ | Domain not in MVM |
| performance_tracking | organizational_scope | ✅ | ❌ | Domain not in MVM |
| performance_tracking | supplier_sustainability | ✅ | ❌ | Domain not in MVM |
| performance_tracking | sustainability_audit | ✅ | ❌ | Domain not in MVM |
| performance_tracking | sustainability_certification | ✅ | ❌ | Domain not in MVM |
| performance_tracking | target | ✅ | ❌ | Domain not in MVM |
| performance_tracking | target_progress | ✅ | ❌ | Domain not in MVM |
| practice_adoption | initiative | ✅ | ❌ | Domain not in MVM |
| practice_adoption | practice_adoption | ✅ | ❌ | Domain not in MVM |
| practice_adoption | regenerative_practice | ✅ | ❌ | Domain not in MVM |
| resource_stewardship | biodiversity_assessment | ✅ | ❌ | Domain not in MVM |
| resource_stewardship | conservation_enrollment | ✅ | ❌ | Domain not in MVM |
| resource_stewardship | deforestation_risk | ✅ | ❌ | Domain not in MVM |
| resource_stewardship | energy_consumption | ✅ | ❌ | Domain not in MVM |
| resource_stewardship | land_use_change | ✅ | ❌ | Domain not in MVM |
| resource_stewardship | soil_carbon_sequestration | ✅ | ❌ | Domain not in MVM |
| resource_stewardship | waste_event | ✅ | ❌ | Domain not in MVM |
| resource_stewardship | water_stewardship_plan | ✅ | ❌ | Domain not in MVM |
| resource_stewardship | water_usage | ✅ | ❌ | Domain not in MVM |

<a id="domain-weather"></a>
### weather

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agronomic_analytics | climate_risk_indicator | ✅ | ❌ | Domain not in MVM |
| agronomic_analytics | drought_index | ✅ | ❌ | Domain not in MVM |
| agronomic_analytics | evapotranspiration | ✅ | ❌ | Domain not in MVM |
| agronomic_analytics | frost_alert | ✅ | ❌ | Domain not in MVM |
| agronomic_analytics | growing_degree_day | ✅ | ❌ | Domain not in MVM |
| agronomic_analytics | irrigation_schedule | ✅ | ❌ | Domain not in MVM |
| agronomic_analytics | planting_window | ✅ | ❌ | Domain not in MVM |
| agronomic_analytics | precipitation_event | ✅ | ❌ | Domain not in MVM |
| agronomic_analytics | soil_temperature | ✅ | ❌ | Domain not in MVM |
| agronomic_analytics | spray_window | ✅ | ❌ | Domain not in MVM |
| observation_infrastructure | alert | ✅ | ❌ | Domain not in MVM |
| observation_infrastructure | calibration_standard | ✅ | ❌ | Domain not in MVM |
| observation_infrastructure | climate_normal | ✅ | ❌ | Domain not in MVM |
| observation_infrastructure | forecast | ✅ | ❌ | Domain not in MVM |
| observation_infrastructure | observation | ✅ | ❌ | Domain not in MVM |
| observation_infrastructure | sensor | ✅ | ❌ | Domain not in MVM |
| observation_infrastructure | sensor_calibration | ✅ | ❌ | Domain not in MVM |
| observation_infrastructure | station | ✅ | ❌ | Domain not in MVM |
| observation_infrastructure | station_network | ✅ | ❌ | Domain not in MVM |
| observation_infrastructure | zone | ✅ | ❌ | Domain not in MVM |
| risk_documentation | insurance_claim | ✅ | ❌ | Domain not in MVM |
| risk_documentation | insurance_policy | ✅ | ❌ | Domain not in MVM |
| risk_documentation | insurance_record | ✅ | ❌ | Domain not in MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_benefits | benefit_enrollment | ✅ | ❌ | Excluded from MVM |
| compensation_benefits | payroll | ✅ | ✅ |  |
| development_safety | leave_request | ✅ | ❌ | Excluded from MVM |
| development_safety | performance_review | ✅ | ❌ | Excluded from MVM |
| development_safety | safety_event | ✅ | ✅ |  |
| development_safety | training_event | ✅ | ✅ |  |
| operations_scheduling | plan | ✅ | ❌ | Excluded from MVM |
| operations_scheduling | shift | ✅ | ✅ |  |
| operations_scheduling | time_entry | ✅ | ✅ |  |
| operations_scheduling | work_assignment | ✅ | ✅ |  |
| personnel_management | crew | ✅ | ✅ |  |
| personnel_management | employee | ✅ | ✅ |  |
| personnel_management | labor_compliance | ✅ | ✅ |  |
| personnel_management | labor_contract | ✅ | ❌ | Excluded from MVM |
| personnel_management | org_unit | ✅ | ❌ | Excluded from MVM |
| personnel_management | position | ✅ | ✅ |  |
| personnel_management | workforce_certification | ✅ | ✅ |  |
| safety_training | training_enrollment | ❌ | ✅ | MVM only (stub or new) |
