# Pharmaceuticals Lakehouse Data Models

**Version 1** | Generated on May 05, 2026 at 09:10 PM

**Industry:** pharmaceuticals

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Clinical](#domain-clinical)
  - [Commercial](#domain-commercial)
  - [Compliance](#domain-compliance)
  - [Discovery](#domain-discovery)
  - [Finance](#domain-finance)
  - [Hcp](#domain-hcp)
  - [Intellectual](#domain-intellectual)
  - [Manufacturing](#domain-manufacturing)
  - [Market](#domain-market)
  - [Masterdata](#domain-masterdata)
  - [Medical](#domain-medical)
  - [Patient](#domain-patient)
  - [Pharmacovigilance](#domain-pharmacovigilance)
  - [Procurement](#domain-procurement)
  - [Product](#domain-product)
  - [Quality](#domain-quality)
  - [Regulatory](#domain-regulatory)
  - [Supply](#domain-supply)
  - [Workforce](#domain-workforce)


## Business Description

Pharmaceuticals is a research-intensive industry focused on discovering, developing, and manufacturing medicines, vaccines, and consumer health products to treat and prevent diseases across therapeutic areas including oncology, immunology, and rare diseases.

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
| Subdomains | 46 | 72 |
| Products (Tables) | 213 | 441 |
| Attributes (Columns) | 8874 | 16563 |
| Foreign Keys | 2423 | 2987 |
| Avg Attributes/Product | 41.7 | 37.6 |

## Domain & Product Comparison

<a id="domain-clinical"></a>
### clinical

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| patient_observation | biobank | ✅ | ❌ | Excluded from MVM |
| patient_observation | biospecimen | ✅ | ✅ |  |
| patient_observation | clinical_enrollment | ✅ | ✅ |  |
| patient_observation | crf_form | ✅ | ✅ |  |
| patient_observation | econsent_document | ✅ | ❌ | Excluded from MVM |
| patient_observation | lab_result | ✅ | ✅ |  |
| patient_observation | monitoring_visit | ✅ | ❌ | Excluded from MVM |
| patient_observation | subject_observation | ✅ | ✅ |  |
| patient_observation | trial_adverse_event | ✅ | ✅ |  |
| patient_observation | trial_consent | ✅ | ✅ |  |
| patient_observation | trial_endpoint | ✅ | ✅ |  |
| patient_observation | visit | ✅ | ✅ |  |
| product_accountability | imp_accountability | ✅ | ❌ | Excluded from MVM |
| product_accountability | imp_administration | ✅ | ❌ | Excluded from MVM |
| product_accountability | investigational_product | ✅ | ✅ |  |
| product_accountability | site_imp_accountability | ✅ | ❌ | Excluded from MVM |
| study_management | cdisc_domain_map | ✅ | ❌ | Excluded from MVM |
| study_management | clinical_advisory_board_membership | ✅ | ❌ | Excluded from MVM |
| study_management | data_management_plan | ✅ | ❌ | Excluded from MVM |
| study_management | investigational_site | ✅ | ✅ |  |
| study_management | principal_investigator | ✅ | ✅ |  |
| study_management | protocol | ✅ | ✅ |  |
| study_management | randomization_schedule | ✅ | ❌ | Excluded from MVM |
| study_management | site_affiliation | ✅ | ❌ | Excluded from MVM |
| study_management | site_protocol_activation | ✅ | ❌ | Excluded from MVM |
| study_management | trial | ✅ | ✅ |  |
| study_management | trial_investigator | ✅ | ❌ | Excluded from MVM |
| study_management | trial_milestone | ✅ | ✅ |  |
| study_management | trial_vendor_engagement | ✅ | ❌ | Excluded from MVM |
| trial_management | site_activation | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-commercial"></a>
### commercial

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| brand_management | brand | ✅ | ✅ |  |
| brand_management | brand_plan | ✅ | ✅ |  |
| brand_management | brand_supply_agreement | ✅ | ❌ | Excluded from MVM |
| brand_management | commercial_formulary_position | ✅ | ❌ | Excluded from MVM |
| brand_management | mlr_review | ✅ | ✅ |  |
| brand_management | promo_material | ✅ | ✅ |  |
| field_operations | call_activity | ✅ | ✅ |  |
| field_operations | district | ✅ | ❌ | Excluded from MVM |
| field_operations | hcp_target | ✅ | ✅ |  |
| field_operations | region | ✅ | ❌ | Excluded from MVM |
| field_operations | sales_rep | ✅ | ✅ |  |
| field_operations | sample_management | ✅ | ✅ |  |
| field_operations | territory | ✅ | ✅ |  |
| patient_access | copay_program | ✅ | ✅ |  |
| patient_access | copay_redemption | ✅ | ✅ |  |
| patient_access | patient_support_program | ✅ | ✅ |  |
| patient_access | psp_enrollment | ✅ | ✅ |  |
| performance_incentives | incentive_compensation | ✅ | ❌ | Excluded from MVM |
| performance_incentives | performance_period | ✅ | ❌ | Excluded from MVM |
| performance_incentives | sales_order | ✅ | ✅ |  |
| performance_incentives | sales_performance | ✅ | ✅ |  |
| stakeholder_engagement | commercial_speaker_program | ✅ | ❌ | Excluded from MVM |
| stakeholder_engagement | contract_account | ✅ | ✅ |  |
| stakeholder_engagement | kol_engagement | ✅ | ✅ |  |
| stakeholder_engagement | speaker_engagement | ✅ | ❌ | Excluded from MVM |
| stakeholder_engagement | sunshine_disclosure | ✅ | ❌ | Excluded from MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| authority_inspections | inspection_observation | ✅ | ❌ | Domain not in MVM |
| authority_inspections | inspection_readiness | ✅ | ❌ | Domain not in MVM |
| authority_inspections | inspection_response | ✅ | ❌ | Domain not in MVM |
| authority_inspections | monitoring_activity | ✅ | ❌ | Domain not in MVM |
| authority_inspections | regulatory_inspection | ✅ | ❌ | Domain not in MVM |
| authority_inspections | warning_letter | ✅ | ❌ | Domain not in MVM |
| electronic_records | audit_trail | ✅ | ❌ | Domain not in MVM |
| electronic_records | document_template | ✅ | ❌ | Domain not in MVM |
| electronic_records | esignature_event | ✅ | ❌ | Domain not in MVM |
| electronic_records | esignature_session | ✅ | ❌ | Domain not in MVM |
| electronic_records | part11_system | ✅ | ❌ | Domain not in MVM |
| electronic_records | workflow_step | ✅ | ❌ | Domain not in MVM |
| privacy_protection | attestation | ✅ | ❌ | Domain not in MVM |
| privacy_protection | conflict_of_interest | ✅ | ❌ | Domain not in MVM |
| privacy_protection | data_processing_activity | ✅ | ❌ | Domain not in MVM |
| privacy_protection | disclosure | ✅ | ❌ | Domain not in MVM |
| privacy_protection | privacy_impact_assessment | ✅ | ❌ | Domain not in MVM |
| privacy_protection | privacy_obligation | ✅ | ❌ | Domain not in MVM |
| regulatory_obligations | business_process | ✅ | ❌ | Domain not in MVM |
| regulatory_obligations | control_assessment | ✅ | ❌ | Domain not in MVM |
| regulatory_obligations | gxp_obligation | ✅ | ❌ | Domain not in MVM |
| regulatory_obligations | internal_control | ✅ | ❌ | Domain not in MVM |
| regulatory_obligations | policy_document | ✅ | ❌ | Domain not in MVM |
| regulatory_obligations | program | ✅ | ❌ | Domain not in MVM |
| regulatory_obligations | program_obligation_scope | ✅ | ❌ | Domain not in MVM |
| regulatory_obligations | sox_control_test | ✅ | ❌ | Domain not in MVM |
| regulatory_obligations | workflow_template | ✅ | ❌ | Domain not in MVM |
| risk_remediation | compliance_capa | ✅ | ❌ | Domain not in MVM |
| risk_remediation | debarment_check | ✅ | ❌ | Domain not in MVM |
| risk_remediation | fmv_assessment | ✅ | ❌ | Domain not in MVM |
| risk_remediation | incident | ✅ | ❌ | Domain not in MVM |
| risk_remediation | notification_template | ✅ | ❌ | Domain not in MVM |
| risk_remediation | risk_register | ✅ | ❌ | Domain not in MVM |
| risk_remediation | third_party_due_diligence | ✅ | ❌ | Domain not in MVM |
| risk_remediation | triggering_event | ✅ | ❌ | Domain not in MVM |

<a id="domain-discovery"></a>
### discovery

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| chemical_library | compound | ✅ | ✅ |  |
| chemical_library | compound_library | ✅ | ❌ | Excluded from MVM |
| chemical_library | compound_supply_agreement | ✅ | ❌ | Excluded from MVM |
| chemical_library | compound_synthesis | ✅ | ✅ |  |
| chemical_library | lead_series | ✅ | ✅ |  |
| chemical_library | sar_study | ✅ | ✅ |  |
| chemical_library | synthesis_route | ✅ | ❌ | Excluded from MVM |
| preclinical_testing | adme_profile | ✅ | ✅ |  |
| preclinical_testing | candidate_nomination | ✅ | ✅ |  |
| preclinical_testing | compound_exposure | ✅ | ❌ | Excluded from MVM |
| preclinical_testing | in_vitro_study | ✅ | ❌ | Excluded from MVM |
| preclinical_testing | in_vivo_study | ✅ | ❌ | Excluded from MVM |
| screening_operations | assay | ✅ | ✅ |  |
| screening_operations | assay_panel | ✅ | ❌ | Excluded from MVM |
| screening_operations | computational_model | ✅ | ❌ | Excluded from MVM |
| screening_operations | hts_campaign | ✅ | ✅ |  |
| screening_operations | screening_result | ✅ | ✅ |  |
| target_identification | molecular_target | ✅ | ✅ |  |
| target_identification | project | ✅ | ✅ |  |
| target_identification | target_validation_study | ✅ | ❌ | Excluded from MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| accounting_operations | accounts_payable | ✅ | ✅ |  |
| accounting_operations | accounts_receivable | ✅ | ✅ |  |
| accounting_operations | general_ledger | ✅ | ✅ |  |
| accounting_operations | journal_entry | ✅ | ✅ |  |
| accounting_operations | ledger | ✅ | ❌ | Excluded from MVM |
| asset_management | cogs_entry | ✅ | ❌ | Excluded from MVM |
| asset_management | fixed_asset | ✅ | ✅ |  |
| asset_management | rd_capitalization | ✅ | ❌ | Excluded from MVM |
| partnership_revenue | intercompany_agreement | ✅ | ❌ | Excluded from MVM |
| partnership_revenue | intercompany_transaction | ✅ | ❌ | Excluded from MVM |
| partnership_revenue | milestone_payment | ✅ | ✅ |  |
| partnership_revenue | royalty_agreement | ✅ | ✅ |  |
| partnership_revenue | transfer_price | ✅ | ✅ |  |
| payment_processing | bank_account | ✅ | ✅ |  |
| payment_processing | invoice | ✅ | ✅ |  |
| payment_processing | payment_batch | ✅ | ❌ | Excluded from MVM |
| payment_processing | payment_run | ✅ | ✅ |  |
| payment_processing | tax_posting | ✅ | ❌ | Excluded from MVM |
| planning_control | budget | ✅ | ✅ |  |
| planning_control | costing_run | ✅ | ❌ | Excluded from MVM |
| planning_control | internal_order | ✅ | ✅ |  |
| planning_control | wbs_element | ✅ | ❌ | Excluded from MVM |

<a id="domain-hcp"></a>
### hcp

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_reporting | contract | ✅ | ✅ |  |
| compliance_reporting | hcp_advisory_board | ✅ | ❌ | Excluded from MVM |
| compliance_reporting | hcp_speaker_program | ✅ | ❌ | Excluded from MVM |
| compliance_reporting | med_info_request | ✅ | ❌ | Excluded from MVM |
| compliance_reporting | speaker_program_presentation | ✅ | ❌ | Excluded from MVM |
| compliance_reporting | sunshine_transfer | ✅ | ✅ |  |
| field_engagement | consent_record | ✅ | ✅ |  |
| field_engagement | engagement | ✅ | ✅ |  |
| field_engagement | hcp_engagement | ✅ | ❌ | Excluded from MVM |
| field_engagement | sample_request | ✅ | ✅ |  |
| field_engagement | speaker_program | ❌ | ✅ | MVM only (stub or new) |
| provider_registry | affiliation | ✅ | ✅ |  |
| provider_registry | hco_master | ✅ | ✅ |  |
| provider_registry | hcp_kol_profile | ✅ | ❌ | Excluded from MVM |
| provider_registry | hcp_publication | ✅ | ❌ | Excluded from MVM |
| provider_registry | investigator | ✅ | ✅ |  |
| provider_registry | kol_profile | ❌ | ✅ | MVM only (stub or new) |
| provider_registry | license | ✅ | ✅ |  |
| provider_registry | master | ✅ | ✅ |  |
| provider_registry | prescribing_pattern | ✅ | ❌ | Excluded from MVM |

<a id="domain-intellectual"></a>
### intellectual

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| commercial_agreements | ip_agreement_milestone | ✅ | ❌ | Excluded from MVM |
| commercial_agreements | licensing_agreement | ✅ | ✅ |  |
| commercial_agreements | royalty_payment | ✅ | ✅ |  |
| licensing_agreements | licensed_patent_schedule | ❌ | ✅ | MVM only (stub or new) |
| patent_portfolio | annuity_fee | ✅ | ❌ | Excluded from MVM |
| patent_portfolio | orange_book_listing | ✅ | ✅ |  |
| patent_portfolio | patent | ✅ | ✅ |  |
| patent_portfolio | patent_claim | ✅ | ✅ |  |
| patent_portfolio | patent_family | ✅ | ✅ |  |
| patent_portfolio | patent_license | ✅ | ❌ | Excluded from MVM |
| patent_portfolio | patent_prosecution | ✅ | ✅ |  |
| patent_portfolio | patent_term_extension | ✅ | ✅ |  |
| patent_portfolio | spc_filing | ✅ | ❌ | Excluded from MVM |
| regulatory_protection | drug_master_file | ✅ | ✅ |  |
| regulatory_protection | exclusivity_period | ✅ | ✅ |  |
| regulatory_protection | trademark | ✅ | ✅ |  |
| strategic_intelligence | blocking_patent_assessment | ✅ | ❌ | Excluded from MVM |
| strategic_intelligence | fto_analysis | ✅ | ✅ |  |
| strategic_intelligence | invention_disclosure | ✅ | ❌ | Excluded from MVM |
| strategic_intelligence | ip_valuation | ✅ | ❌ | Excluded from MVM |
| strategic_intelligence | ip_watch | ✅ | ❌ | Excluded from MVM |
| strategic_intelligence | patent_litigation | ✅ | ✅ |  |

<a id="domain-manufacturing"></a>
### manufacturing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_infrastructure | equipment | ✅ | ✅ |  |
| asset_infrastructure | equipment_qualification | ✅ | ✅ |  |
| asset_infrastructure | line | ✅ | ✅ |  |
| asset_infrastructure | site | ✅ | ✅ |  |
| execution_operations | batch_record | ✅ | ✅ |  |
| execution_operations | bill_of_materials | ✅ | ✅ |  |
| execution_operations | campaign | ✅ | ❌ | Excluded from MVM |
| execution_operations | manufacturing_deviation | ✅ | ✅ |  |
| execution_operations | master_batch_record | ✅ | ✅ |  |
| execution_operations | process_parameter | ✅ | ✅ |  |
| execution_operations | process_parameter_result | ✅ | ✅ |  |
| execution_operations | process_step | ✅ | ❌ | Excluded from MVM |
| execution_operations | production_order | ✅ | ✅ |  |
| execution_operations | production_schedule | ✅ | ✅ |  |
| execution_operations | routing | ✅ | ❌ | Excluded from MVM |
| partner_network | cmo_oversight | ✅ | ❌ | Excluded from MVM |
| partner_network | investigational_product_supply | ✅ | ❌ | Excluded from MVM |
| partner_network | technology_transfer | ✅ | ❌ | Excluded from MVM |
| quality_compliance | environmental_monitoring | ✅ | ✅ |  |
| quality_compliance | process_validation | ✅ | ✅ |  |
| quality_compliance | sample | ✅ | ❌ | Excluded from MVM |

<a id="domain-market"></a>
### market

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_management | market_payer_contract | ✅ | ❌ | Excluded from MVM |
| contract_management | outcomes_based_contract | ✅ | ❌ | Excluded from MVM |
| contract_management | rebate_claim | ✅ | ✅ |  |
| contract_management | tender_submission | ✅ | ❌ | Excluded from MVM |
| evidence_generation | market_heor_study | ✅ | ❌ | Excluded from MVM |
| evidence_generation | rwe_dataset | ✅ | ❌ | Excluded from MVM |
| evidence_generation | study_data_sourcing | ✅ | ❌ | Excluded from MVM |
| market_access | heor_study | ❌ | ✅ | MVM only (stub or new) |
| payer_engagement | formulary_position | ❌ | ✅ | MVM only (stub or new) |
| payer_engagement | payer_contract | ❌ | ✅ | MVM only (stub or new) |
| payer_relations | coverage_decision | ✅ | ✅ |  |
| payer_relations | formulary | ✅ | ✅ |  |
| payer_relations | market_formulary_position | ✅ | ❌ | Excluded from MVM |
| payer_relations | payer_account | ✅ | ✅ |  |
| payer_relations | payer_engagement | ✅ | ✅ |  |
| payer_relations | pbm | ✅ | ❌ | Excluded from MVM |
| payer_relations | reimbursement_policy | ✅ | ✅ |  |
| revenue_operations | gross_to_net_adjustment | ✅ | ✅ |  |
| revenue_operations | pharmacy | ✅ | ❌ | Excluded from MVM |
| revenue_operations | pricing_decision | ✅ | ✅ |  |
| strategy_planning | access_strategy | ✅ | ✅ |  |
| strategy_planning | hta_submission | ✅ | ✅ |  |
| strategy_planning | kol_engagement_plan | ✅ | ❌ | Excluded from MVM |
| strategy_planning | patient_access_program | ✅ | ✅ |  |
| strategy_planning | value_dossier | ✅ | ✅ |  |

<a id="domain-masterdata"></a>
### masterdata

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| corporate_structure | business_area | ✅ | ❌ | Excluded from MVM |
| corporate_structure | chart_of_accounts | ✅ | ✅ |  |
| corporate_structure | cost_center | ✅ | ✅ |  |
| corporate_structure | entity_registration | ✅ | ❌ | Excluded from MVM |
| corporate_structure | functional_area | ✅ | ❌ | Excluded from MVM |
| corporate_structure | legal_entity | ✅ | ✅ |  |
| corporate_structure | mapping_rule | ✅ | ❌ | Excluded from MVM |
| corporate_structure | merger_acquisition_event | ✅ | ❌ | Excluded from MVM |
| corporate_structure | org_unit | ✅ | ✅ |  |
| corporate_structure | profit_center | ✅ | ✅ |  |
| corporate_structure | system_crosswalk | ✅ | ❌ | Excluded from MVM |
| facility_network | material_plant_data | ✅ | ❌ | Excluded from MVM |
| facility_network | material_storage_location_data | ✅ | ❌ | Excluded from MVM |
| facility_network | plant | ✅ | ✅ |  |
| facility_network | storage_location | ✅ | ✅ |  |
| partner_management | address | ✅ | ✅ |  |
| partner_management | business_partner | ✅ | ✅ |  |
| partner_management | country | ✅ | ✅ |  |
| partner_management | supply_agreement | ✅ | ❌ | Excluded from MVM |
| product_catalog | atc_classification | ✅ | ✅ |  |
| product_catalog | inn_registry | ✅ | ✅ |  |
| product_catalog | masterdata_ndc_code | ✅ | ✅ |  |
| product_catalog | material | ✅ | ✅ |  |
| product_catalog | unit_of_measure | ✅ | ✅ |  |

<a id="domain-medical"></a>
### medical

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| field_engagement | congress_attendance | ✅ | ❌ | Domain not in MVM |
| field_engagement | medical_kol_profile | ✅ | ❌ | Domain not in MVM |
| field_engagement | msl_engagement | ✅ | ❌ | Domain not in MVM |
| field_engagement | msl_profile | ✅ | ❌ | Domain not in MVM |
| information_services | content | ✅ | ❌ | Domain not in MVM |
| information_services | inquiry | ✅ | ❌ | Domain not in MVM |
| information_services | named_patient_request | ✅ | ❌ | Domain not in MVM |
| research_operations | evidence_gap | ✅ | ❌ | Domain not in MVM |
| research_operations | iit_submission | ✅ | ❌ | Domain not in MVM |
| research_operations | medical_heor_study | ✅ | ❌ | Domain not in MVM |
| research_operations | medical_publication | ✅ | ❌ | Domain not in MVM |
| strategic_programs | affairs_plan | ✅ | ❌ | Domain not in MVM |
| strategic_programs | congress_event | ✅ | ❌ | Domain not in MVM |
| strategic_programs | grant | ✅ | ❌ | Domain not in MVM |
| strategic_programs | med_education_program | ✅ | ❌ | Domain not in MVM |
| strategic_programs | medical_advisory_board | ✅ | ❌ | Domain not in MVM |
| strategic_programs | medical_advisory_board_membership | ✅ | ❌ | Domain not in MVM |
| strategic_programs | review_committee | ✅ | ❌ | Domain not in MVM |

<a id="domain-patient"></a>
### patient

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| clinical_assessment | biomarker_result | ✅ | ✅ |  |
| clinical_assessment | clinical_observation | ✅ | ✅ |  |
| clinical_assessment | endpoint_assessment | ✅ | ❌ | Excluded from MVM |
| clinical_assessment | reported_outcome | ✅ | ✅ |  |
| participant_identity | caregiver | ✅ | ❌ | Excluded from MVM |
| participant_identity | diagnosis | ✅ | ❌ | Excluded from MVM |
| participant_identity | informed_consent | ✅ | ✅ |  |
| participant_identity | patient | ✅ | ✅ |  |
| participant_identity | patient_enrollment | ✅ | ✅ |  |
| program_management | patient_enrollment2 | ✅ | ❌ | Excluded from MVM |
| program_management | registry | ✅ | ✅ |  |
| program_management | registry_enrollment | ✅ | ❌ | Excluded from MVM |
| program_management | support_program | ✅ | ✅ |  |
| treatment_administration | adverse_event | ✅ | ✅ |  |
| treatment_administration | concomitant_medication | ✅ | ✅ |  |
| treatment_administration | protocol_deviation | ✅ | ✅ |  |
| treatment_administration | treatment_exposure | ✅ | ✅ |  |

<a id="domain-pharmacovigilance"></a>
### pharmacovigilance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| case_reporting | icsr | ✅ | ✅ |  |
| case_reporting | pv_adverse_reaction | ✅ | ✅ |  |
| case_reporting | reporter | ✅ | ✅ |  |
| case_reporting | sae_report | ✅ | ✅ |  |
| case_reporting | susar | ✅ | ✅ |  |
| case_reporting | suspect_drug | ✅ | ✅ |  |
| regulatory_compliance | pass_study | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | product_listedness | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | psur | ✅ | ✅ |  |
| regulatory_compliance | pv_action | ✅ | ✅ |  |
| regulatory_compliance | pv_agreement | ✅ | ✅ |  |
| regulatory_compliance | pv_agreement_product_scope | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | pv_submission | ✅ | ✅ |  |
| regulatory_compliance | rmp | ✅ | ✅ |  |
| regulatory_compliance | rmp_review | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | rsi | ✅ | ❌ | Excluded from MVM |
| signal_detection | pv_product | ✅ | ✅ |  |
| signal_detection | safety_signal | ✅ | ✅ |  |
| signal_detection | signal_expert_consultation | ✅ | ❌ | Excluded from MVM |
| signal_detection | signal_indication_assessment | ✅ | ❌ | Excluded from MVM |
| signal_management | signal_case_series | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| order_fulfillment | delivery_schedule | ✅ | ❌ | Domain not in MVM |
| order_fulfillment | goods_receipt | ✅ | ❌ | Domain not in MVM |
| order_fulfillment | incoming_inspection | ✅ | ❌ | Domain not in MVM |
| order_fulfillment | po_line_item | ✅ | ❌ | Domain not in MVM |
| order_fulfillment | purchase_order | ✅ | ❌ | Domain not in MVM |
| order_fulfillment | purchase_requisition | ✅ | ❌ | Domain not in MVM |
| order_fulfillment | service_entry_sheet | ✅ | ❌ | Domain not in MVM |
| strategic_sourcing | contract_price_schedule | ✅ | ❌ | Domain not in MVM |
| strategic_sourcing | sourcing_bid | ✅ | ❌ | Domain not in MVM |
| strategic_sourcing | sourcing_event | ✅ | ❌ | Domain not in MVM |
| strategic_sourcing | sourcing_material | ✅ | ❌ | Domain not in MVM |
| strategic_sourcing | supply_contract | ✅ | ❌ | Domain not in MVM |
| supplier_management | approved_vendor_list | ✅ | ❌ | Domain not in MVM |
| supplier_management | approved_vendor_material | ✅ | ❌ | Domain not in MVM |
| supplier_management | audit_finding | ✅ | ❌ | Domain not in MVM |
| supplier_management | cro_cmo_engagement | ✅ | ❌ | Domain not in MVM |
| supplier_management | invoice_line_item | ✅ | ❌ | Domain not in MVM |
| supplier_management | supplier_audit | ✅ | ❌ | Domain not in MVM |
| supplier_management | supplier_quality_agreement | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_complaint | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_gxp_qualification | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_invoice | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_performance | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_qualification | ✅ | ❌ | Domain not in MVM |
| supplier_management | vendor_site | ✅ | ❌ | Domain not in MVM |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| commercial_operations | approved_vendor | ✅ | ❌ | Excluded from MVM |
| commercial_operations | contract_pricing | ✅ | ❌ | Excluded from MVM |
| commercial_operations | drug_product_assay_specification | ✅ | ❌ | Excluded from MVM |
| commercial_operations | formulary_listing | ✅ | ❌ | Excluded from MVM |
| commercial_operations | kol_product_engagement | ✅ | ❌ | Excluded from MVM |
| commercial_operations | prescription | ✅ | ❌ | Excluded from MVM |
| commercial_operations | product_payer_contract | ✅ | ❌ | Excluded from MVM |
| commercial_operations | supply_allocation | ✅ | ❌ | Excluded from MVM |
| product_definition | combination_product | ✅ | ✅ |  |
| product_definition | device_component | ✅ | ❌ | Excluded from MVM |
| product_definition | drug_product | ✅ | ✅ |  |
| product_definition | drug_substance | ✅ | ✅ |  |
| product_definition | excipient | ✅ | ✅ |  |
| product_definition | formulation | ✅ | ✅ |  |
| product_definition | formulation_ingredient | ✅ | ✅ |  |
| product_definition | medicinal_product | ✅ | ✅ |  |
| product_definition | packaging_configuration | ✅ | ✅ |  |
| product_definition | pharmaceutical_product | ✅ | ❌ | Excluded from MVM |
| product_definition | sku | ✅ | ✅ |  |
| product_definition | specified_substance | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | bioequivalence_study | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | indication | ✅ | ✅ |  |
| regulatory_compliance | labeling | ✅ | ✅ |  |
| regulatory_compliance | lifecycle | ✅ | ✅ |  |
| regulatory_compliance | product_change_control | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | product_ndc_code | ✅ | ✅ |  |
| regulatory_compliance | regulatory_identifier | ✅ | ✅ |  |
| regulatory_compliance | therapeutic_area | ✅ | ✅ |  |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_management | capa | ❌ | ✅ | MVM only (stub or new) |
| compliance_management | change_control | ❌ | ✅ | MVM only (stub or new) |
| compliance_oversight | audit | ✅ | ✅ |  |
| compliance_oversight | audit_site_inspection | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | product_quality_review | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | quality_agreement | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | supplier_qualification | ✅ | ✅ |  |
| compliance_oversight | validation | ✅ | ✅ |  |
| event_management | complaint | ✅ | ✅ |  |
| event_management | oos_investigation | ✅ | ✅ |  |
| event_management | quality_capa | ✅ | ❌ | Excluded from MVM |
| event_management | quality_change_control | ✅ | ❌ | Excluded from MVM |
| event_management | quality_deviation | ✅ | ✅ |  |
| event_management | quality_event | ✅ | ❌ | Excluded from MVM |
| event_management | root_cause_analysis | ✅ | ❌ | Excluded from MVM |
| laboratory_testing | analytical_method | ✅ | ❌ | Excluded from MVM |
| laboratory_testing | lab_test_result | ✅ | ✅ |  |
| laboratory_testing | method_validation | ✅ | ✅ |  |
| laboratory_testing | sample | ✅ | ❌ | Excluded from MVM |
| laboratory_testing | stability_study | ✅ | ✅ |  |
| release_authorization | batch_disposition | ✅ | ✅ |  |
| release_authorization | coa | ✅ | ✅ |  |
| release_authorization | qms_document | ✅ | ❌ | Excluded from MVM |
| release_authorization | sop | ✅ | ❌ | Excluded from MVM |
| release_authorization | specification | ✅ | ✅ |  |

<a id="domain-regulatory"></a>
### regulatory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agency_relations | correspondence | ✅ | ❌ | Excluded from MVM |
| agency_relations | dmf | ✅ | ✅ |  |
| agency_relations | ha_interaction | ✅ | ✅ |  |
| agency_relations | pai | ✅ | ❌ | Excluded from MVM |
| development_strategy | dmf_cross_reference | ❌ | ✅ | MVM only (stub or new) |
| filing_operations | application | ✅ | ✅ |  |
| filing_operations | approval | ✅ | ✅ |  |
| filing_operations | health_authority | ✅ | ✅ |  |
| filing_operations | milestone | ✅ | ✅ |  |
| filing_operations | submission | ✅ | ✅ |  |
| filing_operations | submission_sequence | ✅ | ✅ |  |
| product_lifecycle | application_indication | ✅ | ❌ | Excluded from MVM |
| product_lifecycle | application_site_authorization | ✅ | ❌ | Excluded from MVM |
| product_lifecycle | commitment_action | ✅ | ❌ | Excluded from MVM |
| product_lifecycle | designation | ✅ | ✅ |  |
| product_lifecycle | dossier_document | ✅ | ❌ | Excluded from MVM |
| product_lifecycle | label | ✅ | ✅ |  |
| product_lifecycle | label_change | ✅ | ✅ |  |
| product_lifecycle | payer_coverage | ✅ | ❌ | Excluded from MVM |
| product_lifecycle | post_approval_commitment | ✅ | ✅ |  |
| product_lifecycle | product_registration | ✅ | ✅ |  |
| product_lifecycle | rems | ✅ | ✅ |  |
| product_lifecycle | renewal | ✅ | ❌ | Excluded from MVM |
| product_lifecycle | service_engagement | ✅ | ❌ | Excluded from MVM |
| product_lifecycle | strategy | ✅ | ✅ |  |
| product_lifecycle | variation | ✅ | ✅ |  |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| clinical_operations | clinical_supply_order | ✅ | ✅ |  |
| clinical_operations | cold_chain_record | ✅ | ✅ |  |
| clinical_operations | drug_dispensation | ✅ | ❌ | Excluded from MVM |
| distribution_logistics | delivery_order | ✅ | ✅ |  |
| distribution_logistics | distribution_network | ✅ | ✅ |  |
| distribution_logistics | fulfillment_event | ✅ | ❌ | Excluded from MVM |
| distribution_logistics | shipment | ✅ | ✅ |  |
| inventory_management | goods_issue | ✅ | ✅ |  |
| inventory_management | inventory_lot | ✅ | ✅ |  |
| inventory_management | stock_transfer_order | ✅ | ✅ |  |
| inventory_management | warehouse_receipt | ✅ | ✅ |  |
| planning_forecasting | allocation | ✅ | ❌ | Excluded from MVM |
| planning_forecasting | contract_fulfillment_allocation | ✅ | ❌ | Excluded from MVM |
| planning_forecasting | demand_plan | ✅ | ✅ |  |
| planning_forecasting | distribution_service_agreement | ✅ | ❌ | Excluded from MVM |
| planning_forecasting | lot_traceability | ✅ | ❌ | Excluded from MVM |
| planning_forecasting | plan | ✅ | ✅ |  |
| planning_forecasting | product_recall | ✅ | ✅ |  |
| planning_forecasting | serialization_record | ✅ | ✅ |  |
| planning_forecasting | service_agreement | ✅ | ❌ | Excluded from MVM |
| quality_compliance | recall_lot_scope | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| learning_compliance | competency_framework | ✅ | ❌ | Domain not in MVM |
| learning_compliance | gxp_training_record | ✅ | ❌ | Domain not in MVM |
| learning_compliance | system_access | ✅ | ❌ | Domain not in MVM |
| learning_compliance | training_assignment | ✅ | ❌ | Domain not in MVM |
| learning_compliance | training_course | ✅ | ❌ | Domain not in MVM |
| personnel_administration | department | ✅ | ❌ | Domain not in MVM |
| personnel_administration | employee | ✅ | ❌ | Domain not in MVM |
| personnel_administration | employee_movement | ✅ | ❌ | Domain not in MVM |
| personnel_administration | employment_contract | ✅ | ❌ | Domain not in MVM |
| personnel_administration | job_family | ✅ | ❌ | Domain not in MVM |
| personnel_administration | job_profile | ✅ | ❌ | Domain not in MVM |
| personnel_administration | leave_request | ✅ | ❌ | Domain not in MVM |
| personnel_administration | position | ✅ | ❌ | Domain not in MVM |
| personnel_administration | qualification | ✅ | ❌ | Domain not in MVM |
| personnel_administration | time_attendance | ✅ | ❌ | Domain not in MVM |
| rewards_operations | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| rewards_operations | compensation_plan | ✅ | ❌ | Domain not in MVM |
| rewards_operations | payroll_period | ✅ | ❌ | Domain not in MVM |
| rewards_operations | payroll_run | ✅ | ❌ | Domain not in MVM |
| rewards_operations | payslip | ✅ | ❌ | Domain not in MVM |
| talent_development | candidate | ✅ | ❌ | Domain not in MVM |
| talent_development | headcount_plan | ✅ | ❌ | Domain not in MVM |
| talent_development | job_application | ✅ | ❌ | Domain not in MVM |
| talent_development | performance_review | ✅ | ❌ | Domain not in MVM |
| talent_development | recruitment_requisition | ✅ | ❌ | Domain not in MVM |
| talent_development | succession_plan | ✅ | ❌ | Domain not in MVM |
