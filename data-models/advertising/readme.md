# Advertising Lakehouse Data Models

**Version 1** | Generated on May 08, 2026 at 03:52 AM

**Industry:** advertising-and-marketing

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Analytics](#domain-analytics)
  - [Audience](#domain-audience)
  - [Brand](#domain-brand)
  - [Campaign](#domain-campaign)
  - [Client](#domain-client)
  - [Contract](#domain-contract)
  - [Creative](#domain-creative)
  - [Finance](#domain-finance)
  - [Media](#domain-media)
  - [Performance](#domain-performance)
  - [Project](#domain-project)
  - [Talent](#domain-talent)
  - [Vendor](#domain-vendor)


## Business Description

Advertising and Marketing is a dynamic industry delivering creative campaigns, media planning and buying, public relations, data-driven analytics, and brand strategy to help organizations reach and engage their target audiences.

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
| Domains | 10 | 13 |
| Subdomains | 20 | 40 |
| Products (Tables) | 95 | 262 |
| Attributes (Columns) | 3760 | 9285 |
| Foreign Keys | 815 | 1544 |
| Avg Attributes/Product | 39.6 | 35.4 |

## Domain & Product Comparison

<a id="domain-analytics"></a>
### analytics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| delivery_operations | analytics_request | ✅ | ❌ | Domain not in MVM |
| delivery_operations | recipient_group | ✅ | ❌ | Domain not in MVM |
| delivery_operations | report_delivery | ✅ | ❌ | Domain not in MVM |
| delivery_operations | report_schedule | ✅ | ❌ | Domain not in MVM |
| performance_measurement | attribution_study | ✅ | ❌ | Domain not in MVM |
| performance_measurement | audience_insight | ✅ | ❌ | Domain not in MVM |
| performance_measurement | brand_lift_study | ✅ | ❌ | Domain not in MVM |
| performance_measurement | budget_optimization_scenario | ✅ | ❌ | Domain not in MVM |
| performance_measurement | competitive_intelligence | ✅ | ❌ | Domain not in MVM |
| performance_measurement | creative_effectiveness_study | ✅ | ❌ | Domain not in MVM |
| performance_measurement | dashboard | ✅ | ❌ | Domain not in MVM |
| performance_measurement | incrementality_test | ✅ | ❌ | Domain not in MVM |
| performance_measurement | insight_finding | ✅ | ❌ | Domain not in MVM |
| performance_measurement | insight_report | ✅ | ❌ | Domain not in MVM |
| performance_measurement | measurement_plan | ✅ | ❌ | Domain not in MVM |
| performance_measurement | mmm_study | ✅ | ❌ | Domain not in MVM |

<a id="domain-audience"></a>
### audience

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audience_segmentation | segment | ❌ | ✅ | MVM only (stub or new) |
| identity_resolution | audience_consent_record | ✅ | ❌ | Excluded from MVM |
| identity_resolution | clean_room | ✅ | ❌ | Excluded from MVM |
| identity_resolution | identity_graph | ✅ | ❌ | Excluded from MVM |
| identity_resolution | pixel | ✅ | ❌ | Excluded from MVM |
| identity_resolution | pixel_event | ✅ | ❌ | Excluded from MVM |
| platform_activation | activation | ✅ | ✅ |  |
| platform_activation | dmp_integration | ✅ | ❌ | Excluded from MVM |
| platform_activation | segment_activation | ✅ | ❌ | Excluded from MVM |
| platform_activation | segment_usage | ✅ | ❌ | Excluded from MVM |
| platform_activation | third_party_feed | ✅ | ❌ | Excluded from MVM |
| segment_management | audience_segment | ✅ | ❌ | Excluded from MVM |
| segment_management | behavioral_profile | ✅ | ✅ |  |
| segment_management | demographic_profile | ✅ | ✅ |  |
| segment_management | holdout_group | ✅ | ❌ | Excluded from MVM |
| segment_management | lookalike_model | ✅ | ✅ |  |
| segment_management | persona | ✅ | ✅ |  |
| segment_management | psychographic_profile | ✅ | ❌ | Excluded from MVM |
| segment_management | segment_membership | ✅ | ✅ |  |
| segment_management | suppression_list | ✅ | ✅ |  |
| segment_management | taxonomy | ✅ | ✅ |  |

<a id="domain-brand"></a>
### brand

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| competitive_intelligence | competitive_brand | ✅ | ❌ | Domain not in MVM |
| competitive_intelligence | competitive_monitoring | ✅ | ❌ | Domain not in MVM |
| competitive_intelligence | health_metric | ✅ | ❌ | Domain not in MVM |
| competitive_intelligence | share_of_voice | ✅ | ❌ | Domain not in MVM |
| identity_management | advertiser_policy | ✅ | ❌ | Domain not in MVM |
| identity_management | architecture | ✅ | ❌ | Domain not in MVM |
| identity_management | brand_asset | ✅ | ❌ | Domain not in MVM |
| identity_management | brand_profile | ✅ | ❌ | Domain not in MVM |
| identity_management | guideline | ✅ | ❌ | Domain not in MVM |
| identity_management | partnership | ✅ | ❌ | Domain not in MVM |
| identity_management | positioning | ✅ | ❌ | Domain not in MVM |
| public_relations | asset_deployment | ✅ | ❌ | Domain not in MVM |
| public_relations | brand_compliance_check | ✅ | ❌ | Domain not in MVM |
| public_relations | brand_spokesperson | ✅ | ❌ | Domain not in MVM |
| public_relations | crisis_event | ✅ | ❌ | Domain not in MVM |
| public_relations | media_coverage | ✅ | ❌ | Domain not in MVM |
| public_relations | pr_campaign | ✅ | ❌ | Domain not in MVM |
| public_relations | press_release | ✅ | ❌ | Domain not in MVM |

<a id="domain-campaign"></a>
### campaign

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| campaign_planning | approval | ✅ | ❌ | Excluded from MVM |
| campaign_planning | budget_allocation | ✅ | ✅ |  |
| campaign_planning | campaign | ✅ | ✅ |  |
| campaign_planning | campaign_brief | ✅ | ❌ | Excluded from MVM |
| campaign_planning | campaign_kpi_target | ✅ | ✅ |  |
| campaign_planning | flight | ✅ | ✅ |  |
| campaign_planning | status_history | ✅ | ❌ | Excluded from MVM |
| campaign_planning | targeting_rule | ✅ | ✅ |  |
| media_execution | ad | ✅ | ✅ |  |
| media_execution | ad_placement_rotation | ✅ | ❌ | Excluded from MVM |
| media_execution | booking | ✅ | ❌ | Excluded from MVM |
| media_execution | campaign_spokesperson | ✅ | ❌ | Excluded from MVM |
| media_execution | competitive_targeting | ✅ | ❌ | Excluded from MVM |
| media_execution | creative_assignment | ✅ | ✅ |  |
| media_execution | creative_usage | ✅ | ❌ | Excluded from MVM |
| media_execution | line_item | ✅ | ✅ |  |
| media_execution | pacing_rule | ✅ | ✅ |  |
| media_execution | trafficking_order | ✅ | ✅ |  |
| performance_optimization | optimization_algorithm | ✅ | ❌ | Excluded from MVM |
| performance_optimization | optimization_event | ✅ | ❌ | Excluded from MVM |
| performance_optimization | optimization_rule | ✅ | ❌ | Excluded from MVM |

<a id="domain-client"></a>
### client

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | account_team | ✅ | ✅ |  |
| account_management | address | ✅ | ❌ | Excluded from MVM |
| account_management | advertiser | ✅ | ✅ |  |
| account_management | advertiser_cost_center_allocation | ✅ | ❌ | Excluded from MVM |
| account_management | advertiser_hierarchy | ✅ | ✅ |  |
| account_management | agency_relationship | ✅ | ✅ |  |
| account_management | client_brand | ✅ | ❌ | Excluded from MVM |
| account_management | client_contact | ✅ | ❌ | Excluded from MVM |
| account_management | client_onboarding | ✅ | ❌ | Excluded from MVM |
| account_management | client_segment | ✅ | ❌ | Excluded from MVM |
| account_management | competitive_conflict | ✅ | ❌ | Excluded from MVM |
| account_management | legal_entity | ✅ | ❌ | Excluded from MVM |
| account_management | preferred_vendor | ✅ | ❌ | Excluded from MVM |
| account_management | revenue_target | ✅ | ✅ |  |
| advertiser_identity | brand | ❌ | ✅ | MVM only (stub or new) |
| engagement_operations | advertiser_segment_license | ✅ | ❌ | Excluded from MVM |
| engagement_operations | brand_supplier_approval | ✅ | ❌ | Excluded from MVM |
| engagement_operations | brief_approver | ✅ | ❌ | Excluded from MVM |
| engagement_operations | client_brief | ✅ | ✅ |  |
| engagement_operations | client_consent_record | ✅ | ❌ | Excluded from MVM |
| engagement_operations | client_engagement | ✅ | ❌ | Excluded from MVM |
| engagement_operations | interaction | ✅ | ❌ | Excluded from MVM |
| engagement_operations | io_authorization | ✅ | ❌ | Excluded from MVM |
| engagement_operations | nps_response | ✅ | ❌ | Excluded from MVM |
| engagement_operations | preference | ✅ | ❌ | Excluded from MVM |
| engagement_operations | relationship_history | ✅ | ❌ | Excluded from MVM |
| engagement_operations | survey | ✅ | ❌ | Excluded from MVM |
| engagement_operations | survey_wave | ✅ | ❌ | Excluded from MVM |

<a id="domain-contract"></a>
### contract

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agreement_management | agreement | ✅ | ✅ |  |
| agreement_management | contract_template | ✅ | ❌ | Excluded from MVM |
| agreement_management | sow | ✅ | ✅ |  |
| agreement_management | term | ✅ | ✅ |  |
| agreement_management | vendor_agreement | ✅ | ❌ | Excluded from MVM |
| agreement_management | vendor_contract | ✅ | ❌ | Excluded from MVM |
| order_execution | amendment | ✅ | ✅ |  |
| order_execution | contract_insertion_order | ✅ | ✅ |  |
| order_execution | renewal | ✅ | ✅ |  |
| order_execution | rfp_response | ✅ | ❌ | Excluded from MVM |
| pricing_terms | compliance_obligation | ✅ | ❌ | Excluded from MVM |
| pricing_terms | contract_rate_card | ✅ | ✅ |  |
| pricing_terms | rate_card_line | ✅ | ✅ |  |
| scope_delivery | contract_deliverable | ✅ | ✅ |  |
| scope_delivery | contract_milestone | ✅ | ❌ | Excluded from MVM |
| scope_delivery | scope_item | ✅ | ❌ | Excluded from MVM |
| scope_delivery | sla | ✅ | ✅ |  |

<a id="domain-creative"></a>
### creative

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | adaptation | ✅ | ❌ | Excluded from MVM |
| asset_management | asset_usage | ✅ | ❌ | Excluded from MVM |
| asset_management | asset_version | ✅ | ✅ |  |
| asset_management | creative_asset | ✅ | ❌ | Excluded from MVM |
| asset_management | rights_clearance | ✅ | ❌ | Excluded from MVM |
| campaign_planning | asset_budget_allocation | ✅ | ❌ | Excluded from MVM |
| campaign_planning | concept | ✅ | ✅ |  |
| campaign_planning | creative_brief | ✅ | ✅ |  |
| campaign_planning | creative_deliverable | ✅ | ✅ |  |
| campaign_planning | creative_request | ✅ | ❌ | Excluded from MVM |
| production_delivery | asset | ❌ | ✅ | MVM only (stub or new) |
| production_operations | brand_guideline | ✅ | ✅ |  |
| production_operations | production_job | ✅ | ✅ |  |
| production_operations | spec | ✅ | ✅ |  |
| review_workflow | creative_compliance_check | ✅ | ❌ | Excluded from MVM |
| review_workflow | proof | ✅ | ✅ |  |
| review_workflow | proof_comment | ✅ | ❌ | Excluded from MVM |
| review_workflow | proof_review | ✅ | ❌ | Excluded from MVM |
| review_workflow | review_cycle | ✅ | ❌ | Excluded from MVM |
| review_workflow | review_group | ✅ | ❌ | Excluded from MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| budget_planning | budget_approval | ✅ | ❌ | Excluded from MVM |
| budget_planning | budget_line | ✅ | ✅ |  |
| budget_planning | cost_center | ✅ | ✅ |  |
| budget_planning | finance_budget | ✅ | ✅ |  |
| ledger_accounting | accrual | ✅ | ❌ | Excluded from MVM |
| ledger_accounting | financial_close | ✅ | ❌ | Excluded from MVM |
| ledger_accounting | gl_account | ✅ | ✅ |  |
| ledger_accounting | intercompany_transaction | ✅ | ❌ | Excluded from MVM |
| ledger_accounting | journal_entry | ✅ | ❌ | Excluded from MVM |
| ledger_accounting | journal_entry_line | ✅ | ❌ | Excluded from MVM |
| payable_management | bank_account | ✅ | ❌ | Excluded from MVM |
| payable_management | media_cost_reconciliation | ✅ | ✅ |  |
| payable_management | payment | ✅ | ✅ |  |
| payable_management | vendor_payable | ✅ | ✅ |  |
| revenue_billing | client_invoice | ✅ | ✅ |  |
| revenue_billing | credit_memo | ✅ | ❌ | Excluded from MVM |
| revenue_billing | invoice_line | ✅ | ✅ |  |
| revenue_billing | revenue_recognition | ✅ | ✅ |  |

<a id="domain-media"></a>
### media

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| campaign_execution | buy | ✅ | ✅ |  |
| campaign_execution | io_creative_trafficking | ✅ | ❌ | Excluded from MVM |
| campaign_execution | media_insertion_order | ✅ | ✅ |  |
| campaign_execution | media_placement | ✅ | ✅ |  |
| campaign_execution | programmatic_deal | ✅ | ✅ |  |
| campaign_execution | schedule | ✅ | ✅ |  |
| campaign_execution | trafficking_instruction | ✅ | ✅ |  |
| inventory_management | ad_channel | ✅ | ✅ |  |
| inventory_management | ad_format | ✅ | ✅ |  |
| inventory_management | availability | ✅ | ❌ | Excluded from MVM |
| inventory_management | category | ✅ | ❌ | Excluded from MVM |
| inventory_management | channel_rate | ✅ | ❌ | Excluded from MVM |
| inventory_management | channel_supplier_agreement | ✅ | ❌ | Excluded from MVM |
| inventory_management | compliance_rule | ✅ | ❌ | Excluded from MVM |
| inventory_management | format_availability | ✅ | ❌ | Excluded from MVM |
| inventory_management | placement | ✅ | ✅ |  |
| inventory_management | publisher_property | ✅ | ✅ |  |
| inventory_management | ssp_platform | ✅ | ❌ | Excluded from MVM |
| strategic_planning | allocation | ✅ | ❌ | Excluded from MVM |
| strategic_planning | audience_rating | ✅ | ❌ | Excluded from MVM |
| strategic_planning | benchmark | ✅ | ❌ | Excluded from MVM |
| strategic_planning | flowchart | ✅ | ❌ | Excluded from MVM |
| strategic_planning | plan | ✅ | ✅ |  |
| strategic_planning | plan_asset_assignment | ✅ | ❌ | Excluded from MVM |
| strategic_planning | plan_line | ✅ | ✅ |  |
| strategic_planning | sov_benchmark | ✅ | ❌ | Excluded from MVM |

<a id="domain-performance"></a>
### performance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| attribution_management | attribution_model | ✅ | ✅ |  |
| attribution_management | model_platform_configuration | ✅ | ❌ | Excluded from MVM |
| attribution_management | performance_kpi_target | ✅ | ✅ |  |
| attribution_management | pixel_deployment | ✅ | ❌ | Excluded from MVM |
| attribution_management | tracking_pixel | ✅ | ✅ |  |
| campaign_delivery | auction | ✅ | ❌ | Excluded from MVM |
| campaign_delivery | click_event | ✅ | ✅ |  |
| campaign_delivery | conversion_event | ✅ | ✅ |  |
| campaign_delivery | delivery_pacing | ✅ | ✅ |  |
| campaign_delivery | impression_event | ✅ | ✅ |  |
| campaign_delivery | rtb_bid_event | ✅ | ❌ | Excluded from MVM |
| campaign_delivery | session | ✅ | ❌ | Excluded from MVM |
| campaign_delivery | video_completion_event | ✅ | ✅ |  |
| campaign_delivery | viewability_measurement | ✅ | ✅ |  |
| quality_assurance | brand_safety_signal | ✅ | ❌ | Excluded from MVM |
| quality_assurance | ivt_classification | ✅ | ❌ | Excluded from MVM |
| quality_assurance | measurement_discrepancy | ✅ | ❌ | Excluded from MVM |

<a id="domain-project"></a>
### project

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| change_governance | approval_workflow | ✅ | ❌ | Excluded from MVM |
| change_governance | change_request | ✅ | ❌ | Excluded from MVM |
| change_governance | dependency | ✅ | ❌ | Excluded from MVM |
| change_governance | risk_register | ✅ | ❌ | Excluded from MVM |
| change_governance | workflow_step | ✅ | ❌ | Excluded from MVM |
| delivery_execution | assignment | ❌ | ✅ | MVM only (stub or new) |
| execution_tracking | deliverable_tracker | ✅ | ✅ |  |
| execution_tracking | project_assignment | ✅ | ❌ | Excluded from MVM |
| execution_tracking | sprint | ✅ | ❌ | Excluded from MVM |
| execution_tracking | status_update | ✅ | ❌ | Excluded from MVM |
| execution_tracking | task | ✅ | ✅ |  |
| execution_tracking | time_entry | ✅ | ✅ |  |
| portfolio_planning | initiative | ✅ | ✅ |  |
| portfolio_planning | project_brief | ✅ | ✅ |  |
| portfolio_planning | project_budget | ✅ | ✅ |  |
| portfolio_planning | project_milestone | ✅ | ❌ | Excluded from MVM |
| portfolio_planning | project_template | ✅ | ❌ | Excluded from MVM |
| portfolio_planning | resource_plan | ✅ | ✅ |  |
| portfolio_planning | schedule_baseline | ✅ | ❌ | Excluded from MVM |
| portfolio_planning | work_package | ✅ | ✅ |  |
| project_planning | milestone | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-talent"></a>
### talent

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| payroll_compensation | payroll_calendar | ✅ | ❌ | Domain not in MVM |
| payroll_compensation | payroll_record | ✅ | ❌ | Domain not in MVM |
| payroll_compensation | payroll_run | ✅ | ❌ | Domain not in MVM |
| resource_operations | capacity_plan | ✅ | ❌ | Domain not in MVM |
| resource_operations | holiday_calendar | ✅ | ❌ | Domain not in MVM |
| resource_operations | leave_request | ✅ | ❌ | Domain not in MVM |
| resource_operations | representation | ✅ | ❌ | Domain not in MVM |
| resource_operations | resource_allocation | ✅ | ❌ | Domain not in MVM |
| resource_operations | talent_assignment | ✅ | ❌ | Domain not in MVM |
| resource_operations | talent_rate_card | ✅ | ❌ | Domain not in MVM |
| resource_operations | timesheet | ✅ | ❌ | Domain not in MVM |
| resource_operations | usage_right | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | acquisition | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | candidate | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | performance_review | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | requisition | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | review_cycle | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | review_template | ✅ | ❌ | Domain not in MVM |
| workforce_management | guild_membership | ✅ | ❌ | Domain not in MVM |
| workforce_management | job_profile | ✅ | ❌ | Domain not in MVM |
| workforce_management | legal_entity | ✅ | ❌ | Domain not in MVM |
| workforce_management | location | ✅ | ❌ | Domain not in MVM |
| workforce_management | org_unit | ✅ | ❌ | Domain not in MVM |
| workforce_management | position | ✅ | ❌ | Domain not in MVM |
| workforce_management | talent_engagement | ✅ | ❌ | Domain not in MVM |
| workforce_management | talent_profile | ✅ | ❌ | Domain not in MVM |
| workforce_management | worker | ✅ | ❌ | Domain not in MVM |

<a id="domain-vendor"></a>
### vendor

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_evaluation | accreditation | ✅ | ✅ |  |
| compliance_evaluation | performance_evaluation | ✅ | ✅ |  |
| compliance_evaluation | platform_activation | ✅ | ❌ | Excluded from MVM |
| compliance_evaluation | preferred_vendor_list | ✅ | ❌ | Excluded from MVM |
| compliance_evaluation | risk_assessment | ✅ | ❌ | Excluded from MVM |
| compliance_evaluation | supply_chain_profile | ✅ | ❌ | Excluded from MVM |
| compliance_evaluation | supply_path_record | ✅ | ❌ | Excluded from MVM |
| compliance_evaluation | vendor_onboarding | ✅ | ❌ | Excluded from MVM |
| financial_settlement | invoice | ✅ | ✅ |  |
| financial_settlement | invoice_dispute | ✅ | ❌ | Excluded from MVM |
| financial_settlement | io_line | ✅ | ✅ |  |
| financial_settlement | reconciliation | ✅ | ✅ |  |
| financial_settlement | vendor_rate_card | ✅ | ✅ |  |
| partner_identity | publisher | ✅ | ✅ |  |
| partner_identity | supplier | ✅ | ✅ |  |
| partner_identity | tech_partner | ✅ | ✅ |  |
| partner_identity | vendor_contact | ✅ | ❌ | Excluded from MVM |
