# Real Estate Lakehouse Data Models

**Version 1** | Generated on May 02, 2026 at 05:06 AM

**Industry:** real-estate

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Brokerage](#domain-brokerage)
  - [Compliance](#domain-compliance)
  - [Development](#domain-development)
  - [Finance](#domain-finance)
  - [Insurance](#domain-insurance)
  - [Investment](#domain-investment)
  - [Lease](#domain-lease)
  - [Maintenance](#domain-maintenance)
  - [Marketing](#domain-marketing)
  - [Owner](#domain-owner)
  - [Property](#domain-property)
  - [Reference](#domain-reference)
  - [Tenant](#domain-tenant)
  - [Transaction](#domain-transaction)
  - [Valuation](#domain-valuation)
  - [Workforce](#domain-workforce)


## Business Description

Real Estate is a capital-intensive industry encompassing commercial and residential property sales, leasing, valuations, property management, development, and investment advisory services for owners, investors, and tenants.

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
| Domains | 14 | 16 |
| Subdomains | 41 | 48 |
| Products (Tables) | 177 | 344 |
| Attributes (Columns) | 8681 | 14564 |
| Foreign Keys | 2410 | 2970 |
| Avg Attributes/Product | 49.0 | 42.3 |

## Domain & Product Comparison

<a id="domain-brokerage"></a>
### brokerage

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agent_operations | broker_license | ✅ | ✅ |  |
| agent_operations | broker_market_coverage | ✅ | ❌ | Excluded from MVM |
| agent_operations | broker_program_enrollment | ✅ | ❌ | Excluded from MVM |
| agent_operations | brokerage_broker | ✅ | ❌ | Excluded from MVM |
| broker_licensing | broker | ❌ | ✅ | MVM only (stub or new) |
| compensation_distribution | broker_commission | ✅ | ❌ | Excluded from MVM |
| compensation_distribution | commission | ✅ | ✅ |  |
| compensation_distribution | commission_plan | ✅ | ❌ | Excluded from MVM |
| compensation_distribution | commission_split | ✅ | ✅ |  |
| property_marketing | listing | ✅ | ✅ |  |
| property_marketing | listing_agreement | ✅ | ✅ |  |
| property_marketing | listing_disclosure | ✅ | ❌ | Excluded from MVM |
| property_marketing | mls_syndication | ✅ | ❌ | Excluded from MVM |
| property_marketing | showing | ✅ | ✅ |  |
| transaction_management | brokerage_deal | ✅ | ✅ |  |
| transaction_management | brokerage_deal_document | ✅ | ❌ | Excluded from MVM |
| transaction_management | brokerage_prospect | ✅ | ✅ |  |
| transaction_management | buyer_representation | ✅ | ✅ |  |
| transaction_management | co_broker_agreement | ✅ | ✅ |  |
| transaction_management | deal_compliance | ✅ | ❌ | Excluded from MVM |
| transaction_management | negotiation_instrument | ✅ | ❌ | Excluded from MVM |
| transaction_management | referral | ✅ | ✅ |  |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| incident_resolution | fair_housing_record | ✅ | ✅ |  |
| incident_resolution | osha_incident | ✅ | ❌ | Excluded from MVM |
| incident_resolution | privacy_request | ✅ | ❌ | Excluded from MVM |
| incident_resolution | remediation_action | ✅ | ✅ |  |
| incident_resolution | violation | ✅ | ✅ |  |
| operational_monitoring | assessment | ✅ | ✅ |  |
| operational_monitoring | audit_engagement | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | compliance_training | ✅ | ❌ | Excluded from MVM |
| operational_monitoring | esg_metric | ✅ | ✅ |  |
| operational_monitoring | regulatory_filing | ✅ | ✅ |  |
| regulatory_framework | compliance_program | ✅ | ❌ | Excluded from MVM |
| regulatory_framework | green_certification | ✅ | ✅ |  |
| regulatory_framework | jurisdiction | ✅ | ✅ |  |
| regulatory_framework | permit | ✅ | ✅ |  |
| regulatory_framework | regulatory_obligation | ✅ | ✅ |  |
| regulatory_framework | requirement | ✅ | ✅ |  |
| regulatory_framework | sox_control | ✅ | ❌ | Excluded from MVM |

<a id="domain-development"></a>
### development

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_administration | change_order | ✅ | ✅ |  |
| contract_administration | construction_budget | ✅ | ✅ |  |
| contract_administration | construction_contract | ✅ | ✅ |  |
| contract_administration | contractor | ✅ | ✅ |  |
| contract_administration | draw_request | ✅ | ✅ |  |
| field_operations | inspection_event | ✅ | ✅ |  |
| field_operations | rfi | ✅ | ❌ | Excluded from MVM |
| field_operations | submittal | ✅ | ❌ | Excluded from MVM |
| project_governance | construction_permit | ✅ | ✅ |  |
| project_governance | design_document | ✅ | ❌ | Excluded from MVM |
| project_governance | dev_project | ✅ | ✅ |  |
| project_governance | entitlement | ✅ | ✅ |  |
| project_governance | environmental_review | ✅ | ❌ | Excluded from MVM |
| project_governance | proforma | ✅ | ❌ | Excluded from MVM |
| project_governance | project_assignment | ✅ | ❌ | Excluded from MVM |
| project_governance | project_broker_engagement | ✅ | ❌ | Excluded from MVM |
| project_governance | project_schedule | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| budget_planning | budget | ❌ | ✅ | MVM only (stub or new) |
| debt_management | debt_instrument | ✅ | ✅ |  |
| debt_management | debt_service_payment | ✅ | ✅ |  |
| debt_management | lender | ✅ | ✅ |  |
| general_ledger | bank_account | ✅ | ✅ |  |
| general_ledger | budget_line | ✅ | ✅ |  |
| general_ledger | chart_of_accounts | ✅ | ✅ |  |
| general_ledger | cost_allocation | ✅ | ❌ | Excluded from MVM |
| general_ledger | cost_center | ✅ | ✅ |  |
| general_ledger | finance_budget | ✅ | ❌ | Excluded from MVM |
| general_ledger | financial_forecast | ✅ | ❌ | Excluded from MVM |
| general_ledger | financial_period_close | ✅ | ❌ | Excluded from MVM |
| general_ledger | fixed_asset | ✅ | ✅ |  |
| general_ledger | intercompany_transaction | ✅ | ❌ | Excluded from MVM |
| general_ledger | journal_entry | ✅ | ✅ |  |
| general_ledger | journal_entry_line | ✅ | ✅ |  |
| general_ledger | ledger | ✅ | ✅ |  |
| general_ledger | legal_entity | ✅ | ✅ |  |
| general_ledger | noi_statement | ✅ | ✅ |  |
| general_ledger | profit_center | ✅ | ❌ | Excluded from MVM |
| general_ledger | reporting_period | ✅ | ✅ |  |
| general_ledger | segment | ✅ | ❌ | Excluded from MVM |
| general_ledger | source_document | ✅ | ❌ | Excluded from MVM |
| general_ledger | tax_provision | ✅ | ❌ | Excluded from MVM |
| payables_receivables | ap_invoice | ✅ | ✅ |  |
| payables_receivables | ap_payment | ✅ | ✅ |  |
| payables_receivables | ar_invoice | ✅ | ✅ |  |
| payables_receivables | ar_receipt | ✅ | ✅ |  |
| payables_receivables | lockbox_batch | ✅ | ❌ | Excluded from MVM |
| payables_receivables | netting_run | ✅ | ❌ | Excluded from MVM |
| payables_receivables | payment_run | ✅ | ✅ |  |
| payables_receivables | purchase_order | ✅ | ✅ |  |
| payables_receivables | requisition | ✅ | ❌ | Excluded from MVM |

<a id="domain-insurance"></a>
### insurance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| claims_management | adjuster | ✅ | ❌ | Domain not in MVM |
| claims_management | claim | ✅ | ❌ | Domain not in MVM |
| claims_management | claim_payment | ✅ | ❌ | Domain not in MVM |
| claims_management | claim_reserve | ✅ | ❌ | Domain not in MVM |
| claims_management | liability_event | ✅ | ❌ | Domain not in MVM |
| claims_management | loss_run | ✅ | ❌ | Domain not in MVM |
| claims_management | subrogation | ✅ | ❌ | Domain not in MVM |
| policy_administration | blanket_group | ✅ | ❌ | Domain not in MVM |
| policy_administration | certificate_of_insurance | ✅ | ❌ | Domain not in MVM |
| policy_administration | coverage | ✅ | ❌ | Domain not in MVM |
| policy_administration | endorsement | ✅ | ❌ | Domain not in MVM |
| policy_administration | excess_layer | ✅ | ❌ | Domain not in MVM |
| policy_administration | insurance_program | ✅ | ❌ | Domain not in MVM |
| policy_administration | insured_property | ✅ | ❌ | Domain not in MVM |
| policy_administration | policy | ✅ | ❌ | Domain not in MVM |
| policy_administration | policy_assignment | ✅ | ❌ | Domain not in MVM |
| policy_administration | policy_document | ✅ | ❌ | Domain not in MVM |
| policy_administration | premium | ✅ | ❌ | Domain not in MVM |
| policy_administration | premium_allocation | ✅ | ❌ | Domain not in MVM |
| policy_administration | renewal | ✅ | ❌ | Domain not in MVM |
| policy_administration | statement_of_values | ✅ | ❌ | Domain not in MVM |
| risk_underwriting | captive_account | ✅ | ❌ | Domain not in MVM |
| risk_underwriting | risk_assessment | ✅ | ❌ | Domain not in MVM |
| vendor_relations | insurance_broker | ✅ | ❌ | Domain not in MVM |
| vendor_relations | insurer | ✅ | ❌ | Domain not in MVM |

<a id="domain-investment"></a>
### investment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| capital_structure | capital_account | ✅ | ✅ |  |
| capital_structure | capital_call | ✅ | ✅ |  |
| capital_structure | commitment | ✅ | ✅ |  |
| capital_structure | fee_structure | ✅ | ❌ | Excluded from MVM |
| capital_structure | fund | ✅ | ✅ |  |
| capital_structure | investment_distribution | ✅ | ✅ |  |
| capital_structure | investor | ✅ | ✅ |  |
| capital_structure | offering | ✅ | ❌ | Excluded from MVM |
| capital_structure | portfolio | ✅ | ✅ |  |
| capital_structure | vehicle | ✅ | ❌ | Excluded from MVM |
| capital_structure | waterfall | ✅ | ❌ | Excluded from MVM |
| debt_management | debt_covenant | ✅ | ✅ |  |
| debt_management | debt_facility | ✅ | ✅ |  |
| debt_management | tax_allocation | ✅ | ❌ | Excluded from MVM |
| performance_reporting | asset_performance | ✅ | ✅ |  |
| performance_reporting | fund_performance | ✅ | ✅ |  |
| performance_reporting | ic_memo | ✅ | ❌ | Excluded from MVM |
| performance_reporting | investment_deal | ✅ | ✅ |  |
| performance_reporting | portfolio_asset | ✅ | ✅ |  |

<a id="domain-lease"></a>
### lease

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_administration | amendment | ✅ | ✅ |  |
| contract_administration | clause | ✅ | ✅ |  |
| contract_administration | ground_lease | ✅ | ❌ | Excluded from MVM |
| contract_administration | guaranty | ✅ | ✅ |  |
| contract_administration | lease_agreement | ✅ | ✅ |  |
| contract_administration | lease_demised_space | ✅ | ❌ | Excluded from MVM |
| contract_administration | loi | ✅ | ❌ | Excluded from MVM |
| contract_administration | renewal_option | ✅ | ✅ |  |
| contract_administration | security_deposit | ✅ | ✅ |  |
| contract_administration | snda_agreement | ✅ | ❌ | Excluded from MVM |
| contract_administration | sublease | ✅ | ✅ |  |
| contract_administration | termination | ✅ | ✅ |  |
| financial_operations | accounting_entry | ✅ | ✅ |  |
| financial_operations | cam_estimate | ✅ | ❌ | Excluded from MVM |
| financial_operations | cam_pool | ✅ | ❌ | Excluded from MVM |
| financial_operations | cam_schedule | ✅ | ✅ |  |
| financial_operations | disclosure | ✅ | ❌ | Excluded from MVM |
| financial_operations | payment | ✅ | ✅ |  |
| financial_operations | percentage_rent | ✅ | ✅ |  |
| financial_operations | rent_schedule | ✅ | ✅ |  |
| financial_operations | ti_allowance | ✅ | ✅ |  |
| lease_administration | demised_space | ❌ | ✅ | MVM only (stub or new) |
| relationship_mapping | cam_charge_allocation | ✅ | ❌ | Excluded from MVM |
| relationship_mapping | collateral_assignment | ✅ | ❌ | Excluded from MVM |
| relationship_mapping | coverage_requirement | ✅ | ❌ | Excluded from MVM |
| relationship_mapping | enrollment | ✅ | ❌ | Excluded from MVM |
| relationship_mapping | lease_representation | ✅ | ❌ | Excluded from MVM |
| relationship_mapping | meter_allocation | ✅ | ❌ | Excluded from MVM |
| relationship_mapping | regulatory_applicability | ✅ | ❌ | Excluded from MVM |
| relationship_mapping | underwriting_input | ✅ | ❌ | Excluded from MVM |

<a id="domain-maintenance"></a>
### maintenance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | contract_asset_coverage | ❌ | ✅ | MVM only (stub or new) |
| asset_planning | asset_coverage_schedule | ✅ | ❌ | Excluded from MVM |
| asset_planning | asset_service_coverage | ✅ | ❌ | Excluded from MVM |
| asset_planning | building_asset | ✅ | ✅ |  |
| asset_planning | capex_project | ✅ | ✅ |  |
| asset_planning | energy_meter | ✅ | ✅ |  |
| asset_planning | hvac_zone | ✅ | ❌ | Excluded from MVM |
| asset_planning | parts_inventory | ✅ | ❌ | Excluded from MVM |
| asset_planning | pm_schedule | ✅ | ✅ |  |
| asset_planning | service_contract | ✅ | ✅ |  |
| asset_planning | sla_policy | ✅ | ❌ | Excluded from MVM |
| asset_planning | warehouse | ✅ | ❌ | Excluded from MVM |
| work_execution | billable_charge | ✅ | ✅ |  |
| work_execution | ops_inspection | ✅ | ✅ |  |
| work_execution | parts_usage | ✅ | ❌ | Excluded from MVM |
| work_execution | pm_execution | ✅ | ❌ | Excluded from MVM |
| work_execution | safety_incident | ✅ | ✅ |  |
| work_execution | service_request | ✅ | ✅ |  |
| work_execution | vendor_dispatch | ✅ | ✅ |  |
| work_execution | work_order | ✅ | ✅ |  |

<a id="domain-marketing"></a>
### marketing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| brand_strategy | audience_segment | ✅ | ❌ | Excluded from MVM |
| brand_strategy | brand | ✅ | ❌ | Excluded from MVM |
| brand_strategy | channel | ✅ | ✅ |  |
| brand_strategy | press_release | ✅ | ❌ | Excluded from MVM |
| brand_strategy | vendor | ✅ | ❌ | Excluded from MVM |
| campaign_execution | ad_creative | ✅ | ✅ |  |
| campaign_execution | ad_spend | ✅ | ❌ | Excluded from MVM |
| campaign_execution | campaign | ✅ | ✅ |  |
| campaign_execution | campaign_contribution | ✅ | ❌ | Excluded from MVM |
| campaign_execution | campaign_flight | ✅ | ✅ |  |
| campaign_execution | campaign_property | ✅ | ❌ | Excluded from MVM |
| campaign_execution | campaign_unit_inclusion | ✅ | ❌ | Excluded from MVM |
| campaign_execution | content_calendar | ✅ | ❌ | Excluded from MVM |
| campaign_execution | digital_listing | ✅ | ❌ | Excluded from MVM |
| campaign_execution | email_campaign | ✅ | ❌ | Excluded from MVM |
| campaign_execution | listing_syndication | ✅ | ✅ |  |
| campaign_execution | marketing_budget | ✅ | ❌ | Excluded from MVM |
| campaign_execution | social_post | ✅ | ❌ | Excluded from MVM |
| lead_management | event | ✅ | ✅ |  |
| lead_management | event_registration | ✅ | ✅ |  |
| lead_management | lead | ✅ | ✅ |  |
| lead_management | lead_activity | ✅ | ✅ |  |
| lead_management | lead_attribution | ✅ | ❌ | Excluded from MVM |
| market_intelligence | competitor_property | ✅ | ❌ | Excluded from MVM |
| market_intelligence | market_research | ✅ | ✅ |  |
| market_intelligence | market_survey | ✅ | ✅ |  |
| market_intelligence | seo_keyword | ✅ | ❌ | Excluded from MVM |

<a id="domain-owner"></a>
### owner

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| capital_transactions | capital_contribution | ✅ | ✅ |  |
| capital_transactions | owner_distribution | ✅ | ✅ |  |
| capital_transactions | ownership_transfer | ✅ | ✅ |  |
| compliance_verification | accreditation | ✅ | ❌ | Excluded from MVM |
| compliance_verification | kyc_profile | ✅ | ❌ | Excluded from MVM |
| compliance_verification | owner_agreement | ✅ | ✅ |  |
| compliance_verification | owner_representation | ✅ | ❌ | Excluded from MVM |
| compliance_verification | subscription | ✅ | ❌ | Excluded from MVM |
| compliance_verification | tax_record | ✅ | ✅ |  |
| entity_management | beneficial_owner | ✅ | ❌ | Excluded from MVM |
| entity_management | entity_hierarchy | ✅ | ✅ |  |
| entity_management | owner | ✅ | ✅ |  |
| entity_management | owner_contact | ✅ | ✅ |  |
| entity_management | owner_ownership_interest | ✅ | ✅ |  |
| entity_management | ownership_structure | ✅ | ✅ |  |
| entity_management | power_of_attorney | ✅ | ❌ | Excluded from MVM |

<a id="domain-property"></a>
### property

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_registry | address | ✅ | ✅ |  |
| asset_registry | asset | ✅ | ✅ |  |
| asset_registry | asset_hierarchy | ✅ | ❌ | Excluded from MVM |
| asset_registry | building | ✅ | ✅ |  |
| asset_registry | floor | ✅ | ✅ |  |
| asset_registry | parcel | ✅ | ✅ |  |
| asset_registry | property_ownership_interest | ✅ | ✅ |  |
| asset_registry | site_coverage | ❌ | ✅ | MVM only (stub or new) |
| asset_registry | space | ✅ | ✅ |  |
| asset_registry | title_record | ✅ | ✅ |  |
| asset_registry | unit | ✅ | ✅ |  |
| facility_management | amenity | ✅ | ✅ |  |
| facility_management | common_area | ✅ | ❌ | Excluded from MVM |
| facility_management | inspection | ✅ | ✅ |  |
| facility_management | occupancy_record | ✅ | ✅ |  |
| facility_management | parking | ✅ | ❌ | Excluded from MVM |
| operational_relationships | allocation | ✅ | ❌ | Excluded from MVM |
| operational_relationships | asset_audit_scope | ✅ | ❌ | Excluded from MVM |
| operational_relationships | assignment | ✅ | ❌ | Excluded from MVM |
| operational_relationships | building_certification | ✅ | ❌ | Excluded from MVM |
| operational_relationships | building_compliance_obligation | ✅ | ❌ | Excluded from MVM |
| operational_relationships | building_policy_coverage | ✅ | ❌ | Excluded from MVM |
| operational_relationships | deal_asset | ✅ | ❌ | Excluded from MVM |
| operational_relationships | property_demised_space | ✅ | ❌ | Excluded from MVM |
| operational_relationships | property_occupancy | ✅ | ❌ | Excluded from MVM |
| operational_relationships | space_campaign_inclusion | ✅ | ❌ | Excluded from MVM |

<a id="domain-reference"></a>
### reference

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_classification | amenity_type | ✅ | ✅ |  |
| asset_classification | building_class | ✅ | ✅ |  |
| asset_classification | construction_type | ✅ | ✅ |  |
| asset_classification | investment_vehicle | ✅ | ❌ | Excluded from MVM |
| asset_classification | lease_type | ✅ | ✅ |  |
| asset_classification | market_segment | ✅ | ✅ |  |
| asset_classification | property_type | ✅ | ✅ |  |
| asset_classification | space_use_type | ✅ | ✅ |  |
| asset_classification | tenure_type | ✅ | ❌ | Excluded from MVM |
| asset_classification | transaction_type | ✅ | ✅ |  |
| location_standards | country | ✅ | ✅ |  |
| location_standards | geographic_hierarchy | ✅ | ✅ |  |
| location_standards | zoning_code | ✅ | ✅ |  |
| operational_reference | currency_code | ✅ | ✅ |  |
| operational_reference | document_type | ✅ | ❌ | Excluded from MVM |
| operational_reference | industry_classification | ✅ | ✅ |  |
| operational_reference | program_property_type_coverage | ✅ | ❌ | Excluded from MVM |
| operational_reference | regulatory_framework | ✅ | ❌ | Excluded from MVM |
| operational_reference | sustainability_rating | ✅ | ❌ | Excluded from MVM |
| operational_reference | uom | ✅ | ✅ |  |

<a id="domain-tenant"></a>
### tenant

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| identity_management | corporate_entity | ✅ | ✅ |  |
| identity_management | credit_profile | ✅ | ✅ |  |
| identity_management | document | ✅ | ✅ |  |
| identity_management | guarantor | ✅ | ✅ |  |
| identity_management | household | ✅ | ❌ | Excluded from MVM |
| identity_management | tenant | ✅ | ✅ |  |
| identity_management | tenant_contact | ✅ | ✅ |  |
| leasing_operations | application | ✅ | ✅ |  |
| leasing_operations | screening | ✅ | ✅ |  |
| leasing_operations | tenant_occupancy | ✅ | ❌ | Excluded from MVM |
| leasing_operations | tenant_prospect | ✅ | ✅ |  |
| leasing_pipeline | occupancy | ❌ | ✅ | MVM only (stub or new) |
| relationship_services | arrears_event | ✅ | ❌ | Excluded from MVM |
| relationship_services | interaction | ✅ | ❌ | Excluded from MVM |
| relationship_services | notice | ✅ | ✅ |  |
| relationship_services | retention_action | ✅ | ❌ | Excluded from MVM |

<a id="domain-transaction"></a>
### transaction

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| sale_execution | auction | ✅ | ❌ | Excluded from MVM |
| sale_execution | bulk_sale_pool | ✅ | ❌ | Excluded from MVM |
| sale_execution | offer | ✅ | ✅ |  |
| sale_execution | property_sale | ✅ | ✅ |  |
| sale_execution | purchase_agreement | ✅ | ✅ |  |
| sale_execution | reo_disposition | ✅ | ❌ | Excluded from MVM |
| sale_execution | sale_attribution | ✅ | ❌ | Excluded from MVM |
| sale_execution | sale_type | ✅ | ❌ | Excluded from MVM |
| settlement_processing | closing_statement | ✅ | ✅ |  |
| settlement_processing | closing_statement_line | ✅ | ❌ | Excluded from MVM |
| settlement_processing | deal_party | ✅ | ✅ |  |
| settlement_processing | deed_transfer | ✅ | ✅ |  |
| settlement_processing | due_diligence_item | ✅ | ✅ |  |
| settlement_processing | escrow_account | ✅ | ✅ |  |
| settlement_processing | escrow_disbursement | ✅ | ✅ |  |
| settlement_processing | exchange_1031 | ✅ | ✅ |  |
| settlement_processing | financing | ✅ | ✅ |  |
| settlement_processing | title_search | ✅ | ✅ |  |
| settlement_processing | transaction_deal_document | ✅ | ❌ | Excluded from MVM |

<a id="domain-valuation"></a>
### valuation

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| appraisal_services | appraisal | ✅ | ✅ |  |
| appraisal_services | appraisal_report | ✅ | ✅ |  |
| appraisal_services | appraisal_review | ✅ | ❌ | Excluded from MVM |
| appraisal_services | appraiser | ✅ | ❌ | Excluded from MVM |
| market_analysis | bpo | ✅ | ✅ |  |
| market_analysis | cma | ✅ | ✅ |  |
| market_analysis | comparable_lease | ✅ | ✅ |  |
| market_analysis | comparable_sale | ✅ | ✅ |  |
| tax_administration | tax_appeal | ✅ | ❌ | Excluded from MVM |
| tax_administration | tax_assessment | ✅ | ✅ |  |
| valuation_models | approach | ✅ | ✅ |  |
| valuation_models | cap_rate_benchmark | ✅ | ✅ |  |
| valuation_models | cost_approach | ✅ | ❌ | Excluded from MVM |
| valuation_models | dcf_model | ✅ | ✅ |  |
| valuation_models | nav_appraisal_input | ✅ | ✅ |  |
| valuation_models | nav_calculation | ✅ | ✅ |  |
| valuation_models | value_history | ✅ | ❌ | Excluded from MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_administration | applicant | ✅ | ❌ | Domain not in MVM |
| compensation_administration | benefit | ✅ | ❌ | Domain not in MVM |
| compensation_administration | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| compensation_administration | commission_record | ✅ | ❌ | Domain not in MVM |
| compensation_administration | compensation_plan | ✅ | ❌ | Domain not in MVM |
| compensation_administration | leave_request | ✅ | ❌ | Domain not in MVM |
| compensation_administration | payroll | ✅ | ❌ | Domain not in MVM |
| compensation_administration | payroll_result | ✅ | ❌ | Domain not in MVM |
| compensation_administration | performance_review | ✅ | ❌ | Domain not in MVM |
| compensation_administration | recruiting | ✅ | ❌ | Domain not in MVM |
| compensation_administration | time_entry | ✅ | ❌ | Domain not in MVM |
| personnel_management | employee | ✅ | ❌ | Domain not in MVM |
| personnel_management | employment_event | ✅ | ❌ | Domain not in MVM |
| personnel_management | grade_band | ✅ | ❌ | Domain not in MVM |
| personnel_management | headcount_plan | ✅ | ❌ | Domain not in MVM |
| personnel_management | job_profile | ✅ | ❌ | Domain not in MVM |
| personnel_management | org_unit | ✅ | ❌ | Domain not in MVM |
| personnel_management | position | ✅ | ❌ | Domain not in MVM |
| personnel_management | work_assignment | ✅ | ❌ | Domain not in MVM |
| professional_development | license_certification | ✅ | ❌ | Domain not in MVM |
| professional_development | license_renewal | ✅ | ❌ | Domain not in MVM |
| professional_development | role_training_requirement | ✅ | ❌ | Domain not in MVM |
| professional_development | training_enrollment | ✅ | ❌ | Domain not in MVM |
| professional_development | training_program | ✅ | ❌ | Domain not in MVM |
| professional_development | training_session | ✅ | ❌ | Domain not in MVM |
| professional_development | workforce_training | ✅ | ❌ | Domain not in MVM |
