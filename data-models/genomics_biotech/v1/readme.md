# Genomics Biotech Lakehouse Data Models

**Version 1** | Generated on May 06, 2026 at 03:33 PM

**Industry:** genomics-biotechnology

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Bioinformatics](#domain-bioinformatics)
  - [Clinical](#domain-clinical)
  - [Commercial](#domain-commercial)
  - [Customer](#domain-customer)
  - [Data](#domain-data)
  - [Finance](#domain-finance)
  - [Instrument](#domain-instrument)
  - [Manufacturing](#domain-manufacturing)
  - [Order](#domain-order)
  - [Product](#domain-product)
  - [Quality](#domain-quality)
  - [Reagent](#domain-reagent)
  - [Reference](#domain-reference)
  - [Regulatory](#domain-regulatory)
  - [Research](#domain-research)
  - [Sample](#domain-sample)
  - [Sequencing](#domain-sequencing)
  - [Supply](#domain-supply)
  - [Workforce](#domain-workforce)


## Business Description

Genomics and Biotechnology is a rapidly evolving industry developing sequencing, array-based, and gene-editing solutions for genetic analysis, enabling advances in precision medicine, drug development, agricultural genomics, and diagnostics.

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
| Subdomains | 40 | 61 |
| Products (Tables) | 182 | 403 |
| Attributes (Columns) | 7884 | 15490 |
| Foreign Keys | 1906 | 2714 |
| Avg Attributes/Product | 43.3 | 38.4 |

## Domain & Product Comparison

<a id="domain-bioinformatics"></a>
### bioinformatics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| artifact_catalog | artifact_tag_assignment | ✅ | ❌ | Excluded from MVM |
| artifact_catalog | data_lineage_event | ✅ | ✅ |  |
| artifact_catalog | genomic_artifact | ✅ | ✅ |  |
| data_processing | alignment_result | ✅ | ✅ |  |
| data_processing | bioinformatics_pipeline_run | ✅ | ❌ | Excluded from MVM |
| data_processing | cnv_result | ✅ | ❌ | Excluded from MVM |
| data_processing | compute_job | ✅ | ✅ |  |
| data_processing | maf_record | ✅ | ❌ | Excluded from MVM |
| data_processing | pipeline_run_step | ✅ | ✅ |  |
| data_processing | snp_genotype_result | ✅ | ❌ | Excluded from MVM |
| data_processing | variant_annotation | ✅ | ✅ |  |
| data_processing | variant_call_result | ✅ | ✅ |  |
| pipeline_management | pipeline | ✅ | ✅ |  |
| pipeline_management | pipeline_authorization | ✅ | ❌ | Excluded from MVM |
| pipeline_management | pipeline_qc_metric | ✅ | ✅ |  |
| pipeline_management | pipeline_validation_study | ✅ | ✅ |  |
| pipeline_management | pipeline_version | ✅ | ✅ |  |
| pipeline_registry | pipeline_run | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-clinical"></a>
### clinical

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| assay_management | assay | ❌ | ✅ | MVM only (stub or new) |
| assay_management | test_site_authorization | ❌ | ✅ | MVM only (stub or new) |
| laboratory_operations | analytical_validation | ✅ | ✅ |  |
| laboratory_operations | assay_qc_run | ✅ | ✅ |  |
| laboratory_operations | clia_accreditation | ✅ | ✅ |  |
| laboratory_operations | clinical_assay | ✅ | ❌ | Excluded from MVM |
| laboratory_operations | clinical_pipeline_run | ✅ | ❌ | Excluded from MVM |
| laboratory_operations | clinical_specimen | ✅ | ✅ |  |
| laboratory_operations | performing_laboratory | ✅ | ✅ |  |
| laboratory_operations | proficiency_testing | ✅ | ❌ | Excluded from MVM |
| patient_care | clinical_consent_record | ✅ | ✅ |  |
| patient_care | clinical_enrollment | ✅ | ❌ | Excluded from MVM |
| patient_care | genetic_counseling_session | ✅ | ❌ | Excluded from MVM |
| patient_care | incidental_finding | ✅ | ❌ | Excluded from MVM |
| patient_care | patient | ✅ | ✅ |  |
| patient_care | visit | ✅ | ❌ | Excluded from MVM |
| result_reporting | genomic_result | ✅ | ✅ |  |
| result_reporting | pgx_report | ✅ | ❌ | Excluded from MVM |
| result_reporting | report | ✅ | ✅ |  |
| result_reporting | report_amendment | ✅ | ❌ | Excluded from MVM |
| result_reporting | variant_interpretation | ✅ | ✅ |  |
| result_reporting | variant_knowledge_base | ✅ | ✅ |  |
| test_management | assay_version | ✅ | ✅ |  |
| test_management | authorized_orderer | ✅ | ✅ |  |
| test_management | insurance_payer | ✅ | ❌ | Excluded from MVM |
| test_management | orderer_authorization | ✅ | ❌ | Excluded from MVM |
| test_management | orderer_territory_assignment | ✅ | ❌ | Excluded from MVM |
| test_management | test_catalog | ✅ | ✅ |  |
| test_management | test_order | ✅ | ✅ |  |
| test_management | test_service_agreement | ✅ | ❌ | Excluded from MVM |

<a id="domain-commercial"></a>
### commercial

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| marketing_campaign | campaign | ✅ | ❌ | Domain not in MVM |
| marketing_campaign | campaign_allocation | ✅ | ❌ | Domain not in MVM |
| marketing_campaign | campaign_participation | ✅ | ❌ | Domain not in MVM |
| marketing_campaign | campaign_response | ✅ | ❌ | Domain not in MVM |
| marketing_campaign | competitive_intel | ✅ | ❌ | Domain not in MVM |
| marketing_campaign | conference_event | ✅ | ❌ | Domain not in MVM |
| marketing_campaign | key_opinion_leader | ✅ | ❌ | Domain not in MVM |
| marketing_campaign | kol_engagement | ✅ | ❌ | Domain not in MVM |
| marketing_campaign | lead | ✅ | ❌ | Domain not in MVM |
| marketing_campaign | market_development_fund | ✅ | ❌ | Domain not in MVM |
| marketing_campaign | market_segment_target | ✅ | ❌ | Domain not in MVM |
| partner_management | channel_partner | ✅ | ❌ | Domain not in MVM |
| partner_management | partner_deal_registration | ✅ | ❌ | Domain not in MVM |
| partner_management | partner_genomic_access_authorization | ✅ | ❌ | Domain not in MVM |
| pricing_contracts | contract | ✅ | ❌ | Domain not in MVM |
| pricing_contracts | discount_approval | ✅ | ❌ | Domain not in MVM |
| pricing_contracts | price_book | ✅ | ❌ | Domain not in MVM |
| pricing_contracts | price_book_entry | ✅ | ❌ | Domain not in MVM |
| pricing_contracts | reagent_subscription | ✅ | ❌ | Domain not in MVM |
| pricing_contracts | reagent_subscription_order | ✅ | ❌ | Domain not in MVM |
| sales_operations | field_application_activity | ✅ | ❌ | Domain not in MVM |
| sales_operations | forecast | ✅ | ❌ | Domain not in MVM |
| sales_operations | opportunity | ✅ | ❌ | Domain not in MVM |
| sales_operations | opportunity_line | ✅ | ❌ | Domain not in MVM |
| sales_operations | opportunity_team_member | ✅ | ❌ | Domain not in MVM |
| sales_operations | sales_quota | ✅ | ❌ | Domain not in MVM |
| sales_operations | territory | ✅ | ❌ | Domain not in MVM |
| sales_operations | territory_assignment | ✅ | ❌ | Domain not in MVM |
| sales_operations | win_loss_review | ✅ | ❌ | Domain not in MVM |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| customer_management | account | ✅ | ✅ |  |
| customer_management | account_hierarchy | ✅ | ❌ | Excluded from MVM |
| customer_management | address | ✅ | ✅ |  |
| customer_management | contact | ✅ | ✅ |  |
| customer_management | credit_profile | ✅ | ❌ | Excluded from MVM |
| customer_management | customer_consent_record | ✅ | ❌ | Excluded from MVM |
| customer_management | segment | ✅ | ✅ |  |
| research_collaboration | evaluation_program | ✅ | ❌ | Excluded from MVM |
| research_collaboration | research_collaboration | ✅ | ❌ | Excluded from MVM |
| service_delivery | accreditation | ✅ | ✅ |  |
| service_delivery | contracted_material | ✅ | ❌ | Excluded from MVM |
| service_delivery | installed_instrument | ✅ | ✅ |  |
| service_delivery | interaction | ✅ | ✅ |  |
| service_delivery | nda_record | ✅ | ❌ | Excluded from MVM |
| service_delivery | service_agreement | ✅ | ✅ |  |
| service_delivery | support_case | ✅ | ✅ |  |
| service_delivery | technical_requirement | ✅ | ✅ |  |
| service_delivery | training_enrollment | ✅ | ❌ | Excluded from MVM |

<a id="domain-data"></a>
### data

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| access_management | access_control_dpia_assessment | ✅ | ❌ | Domain not in MVM |
| access_management | access_request | ✅ | ❌ | Domain not in MVM |
| access_management | genomic_access_control | ✅ | ❌ | Domain not in MVM |
| governance_framework | dpia | ✅ | ❌ | Domain not in MVM |
| governance_framework | fair_assessment | ✅ | ❌ | Domain not in MVM |
| governance_framework | mdm_policy | ✅ | ❌ | Domain not in MVM |
| governance_framework | retention_policy | ✅ | ❌ | Domain not in MVM |
| metadata_services | asset_tag_assignment | ✅ | ❌ | Domain not in MVM |
| metadata_services | catalog_tag | ✅ | ❌ | Domain not in MVM |
| metadata_services | data_use_agreement | ✅ | ❌ | Domain not in MVM |
| metadata_services | dataset | ✅ | ❌ | Domain not in MVM |
| metadata_services | glossary_term | ✅ | ❌ | Domain not in MVM |
| metadata_services | metadata_schema | ✅ | ❌ | Domain not in MVM |
| quality_assurance | quality_assessment | ✅ | ❌ | Domain not in MVM |
| quality_assurance | quality_issue | ✅ | ❌ | Domain not in MVM |
| quality_assurance | quality_rule | ✅ | ❌ | Domain not in MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_planning | capex_request | ✅ | ❌ | Excluded from MVM |
| asset_planning | finance_budget | ✅ | ❌ | Excluded from MVM |
| asset_planning | fixed_asset | ✅ | ❌ | Excluded from MVM |
| asset_planning | rd_capitalization | ✅ | ❌ | Excluded from MVM |
| cost_management | cost_center | ✅ | ❌ | Excluded from MVM |
| cost_management | internal_order | ✅ | ❌ | Excluded from MVM |
| cost_management | profit_center | ✅ | ❌ | Excluded from MVM |
| cost_management | sox_control | ✅ | ❌ | Excluded from MVM |
| cost_management | wbs_element | ✅ | ❌ | Excluded from MVM |
| financial_accounting | accounts_payable | ✅ | ❌ | Excluded from MVM |
| financial_accounting | accounts_receivable | ✅ | ❌ | Excluded from MVM |
| financial_accounting | general_ledger | ✅ | ❌ | Excluded from MVM |
| financial_accounting | intercompany_transaction | ✅ | ❌ | Excluded from MVM |
| financial_accounting | journal_entry | ✅ | ❌ | Excluded from MVM |
| financial_accounting | payment | ✅ | ❌ | Excluded from MVM |
| financial_accounting | performance_obligation | ✅ | ❌ | Excluded from MVM |
| financial_accounting | revenue_recognition | ✅ | ❌ | Excluded from MVM |
| financial_accounting | tax_posting | ✅ | ❌ | Excluded from MVM |

<a id="domain-instrument"></a>
### instrument

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | asset | ✅ | ✅ |  |
| asset_management | calibration_record | ✅ | ✅ |  |
| asset_management | cartridge | ✅ | ❌ | Excluded from MVM |
| asset_management | configuration | ✅ | ✅ |  |
| asset_management | firmware_deployment | ✅ | ❌ | Excluded from MVM |
| asset_management | firmware_version | ✅ | ❌ | Excluded from MVM |
| asset_management | installation_qualification | ✅ | ✅ |  |
| asset_management | maintenance_event | ✅ | ✅ |  |
| asset_management | maintenance_plan | ✅ | ❌ | Excluded from MVM |
| asset_management | model | ✅ | ✅ |  |
| asset_management | pm_schedule | ✅ | ✅ |  |
| asset_management | spare_part | ✅ | ❌ | Excluded from MVM |
| quality_assurance | batch_test | ✅ | ❌ | Excluded from MVM |
| quality_assurance | test_qualification | ✅ | ❌ | Excluded from MVM |
| service_operations | blanket_agreement | ✅ | ❌ | Excluded from MVM |
| service_operations | field_service_request | ✅ | ✅ |  |
| service_operations | instrument_run | ✅ | ✅ |  |
| service_operations | part_consumption | ✅ | ❌ | Excluded from MVM |
| service_operations | performance_telemetry | ✅ | ❌ | Excluded from MVM |
| service_operations | service_contract | ✅ | ✅ |  |
| service_operations | spare_parts_supply_agreement | ✅ | ❌ | Excluded from MVM |

<a id="domain-manufacturing"></a>
### manufacturing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | equipment | ✅ | ✅ |  |
| asset_management | equipment_qualification | ✅ | ✅ |  |
| asset_management | instrument_build_record | ✅ | ❌ | Excluded from MVM |
| asset_management | monitoring_event | ✅ | ❌ | Excluded from MVM |
| asset_management | monitoring_location | ✅ | ❌ | Excluded from MVM |
| production_execution | site | ❌ | ✅ | MVM only (stub or new) |
| production_planning | bom_component | ✅ | ✅ |  |
| production_planning | manufacturing_bom | ✅ | ✅ |  |
| production_planning | manufacturing_campaign | ✅ | ❌ | Excluded from MVM |
| production_planning | manufacturing_site | ✅ | ❌ | Excluded from MVM |
| production_planning | packaging_execution | ✅ | ❌ | Excluded from MVM |
| production_planning | production_batch | ✅ | ✅ |  |
| production_planning | production_line | ✅ | ❌ | Excluded from MVM |
| production_planning | production_operation | ✅ | ✅ |  |
| production_planning | production_routing | ✅ | ✅ |  |
| production_planning | work_center | ✅ | ✅ |  |
| production_planning | work_center_qualification | ✅ | ❌ | Excluded from MVM |
| production_planning | work_order | ✅ | ✅ |  |
| quality_assurance | batch_record | ✅ | ✅ |  |
| quality_assurance | env_monitoring_result | ✅ | ❌ | Excluded from MVM |
| quality_assurance | finished_goods_release | ✅ | ✅ |  |
| quality_assurance | inprocess_qc_result | ✅ | ✅ |  |
| quality_assurance | process_validation | ✅ | ✅ |  |
| quality_assurance | qualification_participation | ✅ | ❌ | Excluded from MVM |
| quality_compliance | validation_run | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-order"></a>
### order

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| logistics_compliance | customer_acceptance | ✅ | ❌ | Excluded from MVM |
| logistics_compliance | delivery | ✅ | ✅ |  |
| logistics_compliance | delivery_line | ✅ | ✅ |  |
| logistics_compliance | fulfillment_instruction | ✅ | ✅ |  |
| logistics_compliance | shipment | ✅ | ✅ |  |
| logistics_compliance | status_event | ✅ | ✅ |  |
| logistics_compliance | trade_compliance_check | ✅ | ❌ | Excluded from MVM |
| order_capture | blanket_order | ✅ | ❌ | Excluded from MVM |
| order_capture | customer_po | ✅ | ✅ |  |
| order_capture | header | ✅ | ✅ |  |
| order_capture | line | ✅ | ✅ |  |
| order_capture | quotation | ✅ | ✅ |  |
| order_capture | quotation_line | ✅ | ✅ |  |
| return_processing | credit_memo | ✅ | ✅ |  |
| return_processing | return_authorization | ✅ | ✅ |  |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| catalog_management | bundle_component | ❌ | ✅ | MVM only (stub or new) |
| manufacturing_operations | service_offering | ✅ | ✅ |  |
| manufacturing_operations | sku_work_center_qualification | ✅ | ❌ | Excluded from MVM |
| pricing_management | change_notice | ✅ | ❌ | Excluded from MVM |
| pricing_management | eol_plan | ✅ | ❌ | Excluded from MVM |
| pricing_management | launch_plan | ✅ | ❌ | Excluded from MVM |
| pricing_management | pricing | ✅ | ✅ |  |
| pricing_management | supply_agreement | ✅ | ❌ | Excluded from MVM |
| product_catalog | bom_line | ✅ | ✅ |  |
| product_catalog | bundle | ✅ | ✅ |  |
| product_catalog | catalog_item | ✅ | ✅ |  |
| product_catalog | compatibility_matrix | ✅ | ❌ | Excluded from MVM |
| product_catalog | family | ✅ | ✅ |  |
| product_catalog | license_entitlement | ✅ | ✅ |  |
| product_catalog | product_bom | ✅ | ✅ |  |
| product_catalog | sku | ✅ | ✅ |  |
| product_catalog | software_release | ✅ | ✅ |  |
| product_catalog | specification | ✅ | ✅ |  |
| regulatory_compliance | citation | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | regulatory_classification | ✅ | ✅ |  |
| regulatory_compliance | retention_assignment | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | validation | ✅ | ❌ | Excluded from MVM |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_management | audit | ✅ | ✅ |  |
| audit_management | audit_finding | ✅ | ✅ |  |
| audit_management | audit_program | ✅ | ❌ | Excluded from MVM |
| audit_management | audit_report | ✅ | ❌ | Excluded from MVM |
| corrective_action | capa | ✅ | ✅ |  |
| corrective_action | change_control | ✅ | ✅ |  |
| corrective_action | complaint | ✅ | ✅ |  |
| corrective_action | deviation | ✅ | ✅ |  |
| corrective_action | internal_investigation | ✅ | ❌ | Excluded from MVM |
| corrective_action | investigation | ✅ | ❌ | Excluded from MVM |
| corrective_action | nonconformance | ✅ | ✅ |  |
| corrective_action | risk_assessment | ✅ | ✅ |  |
| quality_testing | oos_investigation | ✅ | ✅ |  |
| quality_testing | qc_result | ✅ | ✅ |  |
| quality_testing | qualification_protocol | ✅ | ❌ | Excluded from MVM |
| quality_testing | stability_study | ✅ | ❌ | Excluded from MVM |
| quality_testing | test_method | ✅ | ✅ |  |
| quality_testing | validation_study | ✅ | ✅ |  |
| training_documentation | controlled_document | ✅ | ✅ |  |
| training_documentation | quality_training_curriculum | ✅ | ❌ | Excluded from MVM |
| training_documentation | training_curriculum | ❌ | ✅ | MVM only (stub or new) |
| training_documentation | training_record | ✅ | ✅ |  |

<a id="domain-reagent"></a>
### reagent

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| catalog_management | catalog | ✅ | ✅ |  |
| catalog_management | coa | ✅ | ✅ |  |
| catalog_management | facility | ✅ | ❌ | Excluded from MVM |
| catalog_management | kit_component | ✅ | ✅ |  |
| catalog_management | lot | ✅ | ✅ |  |
| catalog_management | sds | ✅ | ❌ | Excluded from MVM |
| catalog_management | storage_location | ✅ | ✅ |  |
| inventory_control | dispensing_event | ✅ | ✅ |  |
| inventory_control | disposal_authorization | ✅ | ❌ | Excluded from MVM |
| inventory_control | disposal_record | ✅ | ❌ | Excluded from MVM |
| inventory_control | inventory_balance | ✅ | ✅ |  |
| inventory_control | inventory_transaction | ✅ | ✅ |  |
| inventory_control | recall_event | ✅ | ❌ | Excluded from MVM |
| quality_assurance | qc_specification | ✅ | ✅ |  |
| quality_assurance | tag_assignment | ✅ | ❌ | Excluded from MVM |

<a id="domain-reference"></a>
### reference

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| genome_reference | gene_annotation_track | ✅ | ❌ | Domain not in MVM |
| genome_reference | gene_model | ✅ | ❌ | Domain not in MVM |
| genome_reference | genome_assembly | ✅ | ❌ | Domain not in MVM |
| genome_reference | genome_assembly_version | ✅ | ❌ | Domain not in MVM |
| genome_reference | genomic_region | ✅ | ❌ | Domain not in MVM |
| genome_reference | transcript_model | ✅ | ❌ | Domain not in MVM |
| pathway_ontology | gene_pathway_link | ✅ | ❌ | Domain not in MVM |
| pathway_ontology | gene_tag_assignment | ✅ | ❌ | Domain not in MVM |
| pathway_ontology | ontology_term | ✅ | ❌ | Domain not in MVM |
| pathway_ontology | pathway | ✅ | ❌ | Domain not in MVM |
| pathway_ontology | pathway_database | ✅ | ❌ | Domain not in MVM |
| variant_knowledge | acmg_classification_rule | ✅ | ❌ | Domain not in MVM |
| variant_knowledge | pharmacogenomics_marker | ✅ | ❌ | Domain not in MVM |
| variant_knowledge | population_allele_frequency | ✅ | ❌ | Domain not in MVM |
| variant_knowledge | variant_database | ✅ | ❌ | Domain not in MVM |
| variant_knowledge | variant_database_qualification | ✅ | ❌ | Domain not in MVM |
| variant_knowledge | variant_database_version | ✅ | ❌ | Domain not in MVM |

<a id="domain-regulatory"></a>
### regulatory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| market_surveillance | adverse_event_report | ✅ | ✅ |  |
| market_surveillance | conformity_assessment | ✅ | ❌ | Excluded from MVM |
| market_surveillance | device_identifier | ✅ | ✅ |  |
| market_surveillance | establishment_registration | ✅ | ✅ |  |
| market_surveillance | eudamed_registration | ✅ | ❌ | Excluded from MVM |
| market_surveillance | field_safety_action | ✅ | ✅ |  |
| market_surveillance | inspection | ✅ | ❌ | Excluded from MVM |
| market_surveillance | ivd_registration | ✅ | ✅ |  |
| market_surveillance | post_market_surveillance | ✅ | ✅ |  |
| regulatory_documentation | clinical_evidence | ✅ | ❌ | Excluded from MVM |
| regulatory_documentation | commitment | ✅ | ❌ | Excluded from MVM |
| regulatory_documentation | document | ✅ | ✅ |  |
| regulatory_documentation | intelligence | ✅ | ❌ | Excluded from MVM |
| regulatory_documentation | labeling | ✅ | ✅ |  |
| regulatory_documentation | notified_body | ✅ | ❌ | Excluded from MVM |
| submission_management | agency_correspondence | ✅ | ✅ |  |
| submission_management | approval | ✅ | ✅ |  |
| submission_management | strategy | ✅ | ❌ | Excluded from MVM |
| submission_management | submission | ✅ | ✅ |  |
| submission_management | submission_event | ✅ | ✅ |  |

<a id="domain-research"></a>
### research

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| experiment_operations | assay_development | ✅ | ✅ |  |
| experiment_operations | crispr_construct | ✅ | ✅ |  |
| experiment_operations | experiment | ✅ | ✅ |  |
| experiment_operations | experiment_analysis | ✅ | ❌ | Excluded from MVM |
| experiment_operations | material_request | ✅ | ❌ | Excluded from MVM |
| experiment_operations | molecular_design | ✅ | ✅ |  |
| experiment_operations | notebook_entry | ✅ | ❌ | Excluded from MVM |
| experiment_operations | research_protocol | ✅ | ✅ |  |
| experiment_operations | sample_request | ✅ | ❌ | Excluded from MVM |
| funding_compliance | collaboration_agreement | ✅ | ✅ |  |
| funding_compliance | grant | ✅ | ✅ |  |
| funding_compliance | grant_report | ✅ | ❌ | Excluded from MVM |
| funding_compliance | irb_submission | ✅ | ✅ |  |
| funding_compliance | review_board | ✅ | ❌ | Excluded from MVM |
| funding_compliance | spend | ✅ | ✅ |  |
| funding_compliance | trl_assessment | ✅ | ❌ | Excluded from MVM |
| intellectual_property | ip_disclosure | ✅ | ✅ |  |
| intellectual_property | publication | ✅ | ✅ |  |
| intellectual_property | technology_transfer | ✅ | ❌ | Excluded from MVM |
| project_management | milestone | ✅ | ✅ |  |
| project_management | program | ✅ | ❌ | Excluded from MVM |
| project_management | project | ✅ | ✅ |  |
| project_management | project_investigator | ✅ | ❌ | Excluded from MVM |
| project_management | research_assignment | ✅ | ❌ | Excluded from MVM |
| project_management | research_budget | ✅ | ❌ | Excluded from MVM |
| project_management | study | ✅ | ✅ |  |
| scientific_discovery | construct_assay_evaluation | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-sample"></a>
### sample

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| specimen_management | accession | ✅ | ✅ |  |
| specimen_management | aliquot | ✅ | ✅ |  |
| specimen_management | biobank_location | ✅ | ✅ |  |
| specimen_management | container | ✅ | ✅ |  |
| specimen_management | disposal_event | ✅ | ❌ | Excluded from MVM |
| specimen_management | sample_specimen | ✅ | ✅ |  |
| specimen_management | shipment_manifest | ✅ | ❌ | Excluded from MVM |
| specimen_management | storage_event | ✅ | ✅ |  |
| specimen_management | temperature_excursion | ✅ | ❌ | Excluded from MVM |
| subject_consent | cohort | ✅ | ✅ |  |
| subject_consent | lab_site | ✅ | ✅ |  |
| subject_consent | sample_consent_record | ✅ | ✅ |  |
| subject_consent | subject | ✅ | ✅ |  |
| workflow_processing | aliquot_consumption | ✅ | ❌ | Excluded from MVM |
| workflow_processing | collection_event | ✅ | ✅ |  |
| workflow_processing | extraction | ✅ | ✅ |  |
| workflow_processing | lims_workflow | ✅ | ❌ | Excluded from MVM |
| workflow_processing | lims_workflow_assignment | ✅ | ❌ | Excluded from MVM |
| workflow_processing | qc_measurement | ✅ | ✅ |  |
| workflow_processing | run_sample | ✅ | ✅ |  |
| workflow_processing | sample_enrollment | ✅ | ❌ | Excluded from MVM |

<a id="domain-sequencing"></a>
### sequencing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| data_analytics | array_hybridization | ✅ | ❌ | Excluded from MVM |
| data_analytics | array_type | ✅ | ❌ | Excluded from MVM |
| data_analytics | basecall_model | ✅ | ❌ | Excluded from MVM |
| data_analytics | coverage_stat | ✅ | ✅ |  |
| data_analytics | demux_result | ✅ | ✅ |  |
| data_analytics | fastq_file | ✅ | ✅ |  |
| data_analytics | file_quality_evaluation | ✅ | ❌ | Excluded from MVM |
| data_analytics | sequencing_protocol | ✅ | ✅ |  |
| data_analytics | target_panel | ✅ | ❌ | Excluded from MVM |
| library_management | index_set | ✅ | ✅ |  |
| library_management | library | ✅ | ✅ |  |
| library_management | library_prep_run | ✅ | ✅ |  |
| library_management | pool | ✅ | ✅ |  |
| library_management | pool_library | ✅ | ✅ |  |
| run_operations | flow_cell | ✅ | ✅ |  |
| run_operations | run_failure_event | ✅ | ❌ | Excluded from MVM |
| run_operations | run_lane | ✅ | ✅ |  |
| run_operations | run_qc_metric | ✅ | ✅ |  |
| run_operations | run_sample_sheet | ✅ | ✅ |  |
| run_operations | sequencing_run | ✅ | ✅ |  |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_control | goods_receipt | ✅ | ✅ |  |
| inventory_control | inbound_delivery | ✅ | ✅ |  |
| inventory_control | inventory_stock | ✅ | ✅ |  |
| inventory_control | stock_movement | ✅ | ✅ |  |
| inventory_control | warehouse_location | ✅ | ✅ |  |
| material_planning | batch | ✅ | ✅ |  |
| material_planning | batch_quality_test | ✅ | ❌ | Excluded from MVM |
| material_planning | demand_plan | ✅ | ❌ | Excluded from MVM |
| material_planning | material | ✅ | ✅ |  |
| material_planning | material_qualification | ✅ | ❌ | Excluded from MVM |
| material_planning | po_line | ✅ | ✅ |  |
| material_planning | purchase_order | ✅ | ✅ |  |
| material_planning | replenishment_order | ✅ | ❌ | Excluded from MVM |
| supplier_management | contract_line | ✅ | ❌ | Excluded from MVM |
| supplier_management | sourcing_agreement | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier | ✅ | ✅ |  |
| supplier_management | supplier_contract | ✅ | ✅ |  |
| supplier_management | supplier_performance | ✅ | ❌ | Excluded from MVM |
| supplier_management | supplier_qualification | ✅ | ✅ |  |
| supplier_management | supplier_reagent_qualification | ✅ | ❌ | Excluded from MVM |
| warehouse_operations | plant | ✅ | ✅ |  |
| warehouse_operations | warehouse | ✅ | ✅ |  |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_management | benefit_plan | ✅ | ❌ | Domain not in MVM |
| compensation_management | compensation | ✅ | ❌ | Domain not in MVM |
| compensation_management | compensation_plan | ✅ | ❌ | Domain not in MVM |
| compensation_management | payroll_cycle | ✅ | ❌ | Domain not in MVM |
| compensation_management | payroll_result | ✅ | ❌ | Domain not in MVM |
| compensation_management | payroll_run | ✅ | ❌ | Domain not in MVM |
| employee_records | bargaining_unit | ✅ | ❌ | Domain not in MVM |
| employee_records | collective_bargaining_agreement | ✅ | ❌ | Domain not in MVM |
| employee_records | employee | ✅ | ❌ | Domain not in MVM |
| employee_records | grade | ✅ | ❌ | Domain not in MVM |
| employee_records | job_profile | ✅ | ❌ | Domain not in MVM |
| employee_records | lifecycle_event | ✅ | ❌ | Domain not in MVM |
| employee_records | location | ✅ | ❌ | Domain not in MVM |
| employee_records | org_unit | ✅ | ❌ | Domain not in MVM |
| employee_records | position | ✅ | ❌ | Domain not in MVM |
| employee_records | talent_profile | ✅ | ❌ | Domain not in MVM |
| employee_records | union | ✅ | ❌ | Domain not in MVM |
| employee_records | work_schedule | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | candidate | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | headcount_plan | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | requisition | ✅ | ❌ | Domain not in MVM |
| training_compliance | genome_qualification | ✅ | ❌ | Domain not in MVM |
| training_compliance | genomic_access_grant | ✅ | ❌ | Domain not in MVM |
| training_compliance | gxp_training_record | ✅ | ❌ | Domain not in MVM |
| training_compliance | lab_qualification | ✅ | ❌ | Domain not in MVM |
| training_compliance | training_item | ✅ | ❌ | Domain not in MVM |
| training_compliance | workforce_training_curriculum | ✅ | ❌ | Domain not in MVM |
| workforce_planning | absence_plan | ✅ | ❌ | Domain not in MVM |
| workforce_planning | absence_record | ✅ | ❌ | Domain not in MVM |
| workforce_planning | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| workforce_planning | goal | ✅ | ❌ | Domain not in MVM |
| workforce_planning | performance_review | ✅ | ❌ | Domain not in MVM |
| workforce_planning | review_cycle | ✅ | ❌ | Domain not in MVM |
| workforce_planning | time_entry | ✅ | ❌ | Domain not in MVM |
| workforce_planning | workforce_assignment | ✅ | ❌ | Domain not in MVM |
