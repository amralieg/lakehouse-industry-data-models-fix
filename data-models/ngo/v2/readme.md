# Ngo Lakehouse Data Models

**Version 2** | Generated on June 23, 2026 at 02:07 AM

**Industry:** 

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v2_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v2_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Beneficiary](#domain-beneficiary)
  - [Communication](#domain-communication)
  - [Compliance](#domain-compliance)
  - [Donor](#domain-donor)
  - [Field](#domain-field)
  - [Finance](#domain-finance)
  - [Grant](#domain-grant)
  - [Mel](#domain-mel)
  - [Partnership](#domain-partnership)
  - [Program](#domain-program)
  - [Safeguarding](#domain-safeguarding)
  - [Supply](#domain-supply)
  - [Technology](#domain-technology)
  - [Volunteer](#domain-volunteer)
  - [Workforce](#domain-workforce)


## Business Description

ngo industry enterprise data model.

## Model Scope Variations

This data model is available in **two scope variations** — the **MVM (Minimum Viable Model)** and the **ECM (Expanded Coverage Model)** — each designed for different organizational needs and use cases. Both models share the same attribute depth per table; the difference is in breadth (number of domains and tables).

### MVM (Minimum Viable Model) — `v2_mvm`

The **MVM** is a production-ready, core data model that covers all essential business functions with full attribute depth. It is the recommended starting point for organizations that want to deploy quickly and expand incrementally. The MVM is ideal for:

- **Small-to-Mid Businesses** — A thin, efficient model for organizations that need a complete but focused data platform without the overhead of corporate back-office domains
- **Production-Ready Foundation** — Deploy to production from day one and grow by adding domains as business needs evolve
- **Proof-of-Concept & Demos** — Quick deployment for stakeholder presentations and proof-of-concept engagements
- **Targeted Analytics** — Focused analytical workloads centered on core business processes
- **Rapid Onboarding** — Simplified structure for teams getting started with the data platform
- **Development & Testing** — Lightweight model for development environments and integration testing

The MVM prioritizes **Operations** and **Business** division domains, excludes corporate/back-office functions, minimizes association (many-to-many bridge) tables, and relies on direct foreign key relationships for simplicity. Every table in the MVM has the **same attribute depth** as the ECM.

### ECM (Expanded Coverage Model) — `v2_ecm`

The **ECM** is a comprehensive, full-coverage data model that covers the complete breadth of business operations, including corporate functions, detailed audit trails, association tables, and granular reference data. It is designed for:

- **Enterprise-Scale Organizations** — Complete data platform for large-scale enterprises with complex operations
- **Full-Coverage Data Warehousing** — Lakehouse model supporting all business units and divisions
- **Regulatory & Compliance** — Includes audit, legal, and compliance domains required for governance
- **Cross-Functional Analytics** — Enables analysis across all divisions including HR, Finance, IT, and more

The ECM includes all domains from the MVM plus additional **Corporate/Supporting** division domains, many-to-many association tables, helper/lookup tables, and expanded attribute coverage.


## Head-to-Head Comparison

| Dimension | MVM (Minimum Viable Model) | ECM (Expanded Coverage Model) |
|---|---|---|
| **Folder Convention** | `v2/mvm` | `v2/ecm` |
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
| Domains | 9 | 15 |
| Subdomains | 22 | 61 |
| Products (Tables) | 91 | 325 |
| Attributes (Columns) | 3734 | 12329 |
| Foreign Keys | 616 | 2134 |
| Avg Attributes/Product | 41.0 | 37.9 |

## Domain & Product Comparison

<a id="domain-beneficiary"></a>
### beneficiary

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| assistance_entitlement | cva_transfer | ✅ | ❌ | Excluded from MVM |
| assistance_entitlement | cva_transfer_modality | ✅ | ❌ | Excluded from MVM |
| assistance_entitlement | end_user_verification | ✅ | ❌ | Excluded from MVM |
| assistance_entitlement | enrollment | ✅ | ✅ |  |
| assistance_entitlement | entitlement | ✅ | ✅ |  |
| assistance_entitlement | financial_service_provider | ✅ | ❌ | Excluded from MVM |
| assistance_entitlement | minimum_expenditure_basket | ✅ | ❌ | Excluded from MVM |
| case_services | needs_assessment | ❌ | ✅ | MVM only (stub or new) |
| community_engagement | community | ✅ | ❌ | Excluded from MVM |
| community_engagement | community_intervention | ✅ | ❌ | Excluded from MVM |
| community_engagement | household_volunteer_assignment | ✅ | ❌ | Excluded from MVM |
| community_engagement | service_assignment | ✅ | ❌ | Excluded from MVM |
| identity_registry | biometric_record | ✅ | ❌ | Excluded from MVM |
| identity_registry | consent_record | ✅ | ✅ |  |
| identity_registry | displacement_history | ✅ | ❌ | Excluded from MVM |
| identity_registry | document_record | ✅ | ❌ | Excluded from MVM |
| identity_registry | exit_record | ✅ | ❌ | Excluded from MVM |
| identity_registry | household | ✅ | ✅ |  |
| identity_registry | household_member | ✅ | ✅ |  |
| identity_registry | protection_flag | ✅ | ❌ | Excluded from MVM |
| identity_registry | registrant | ✅ | ✅ |  |
| identity_registry | registration_event | ✅ | ✅ |  |
| vulnerability_assessment | beneficiary_needs_assessment | ✅ | ❌ | Excluded from MVM |
| vulnerability_assessment | case_action | ✅ | ❌ | Excluded from MVM |
| vulnerability_assessment | case_record | ✅ | ✅ |  |
| vulnerability_assessment | referral | ✅ | ✅ |  |
| vulnerability_assessment | vulnerability_profile | ✅ | ✅ |  |

<a id="domain-communication"></a>
### communication

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| campaign_outreach | advocacy_campaign | ✅ | ❌ | Domain not in MVM |
| campaign_outreach | campaign_media_outreach | ✅ | ❌ | Domain not in MVM |
| campaign_outreach | campaign_touchpoint | ✅ | ❌ | Domain not in MVM |
| campaign_outreach | email_broadcast | ✅ | ❌ | Domain not in MVM |
| constituent_engagement | community_engagement_event | ✅ | ❌ | Domain not in MVM |
| constituent_engagement | constituent_consent | ✅ | ❌ | Domain not in MVM |
| constituent_engagement | constituent_message | ✅ | ❌ | Domain not in MVM |
| constituent_engagement | donor_stewardship_touchpoint | ✅ | ❌ | Domain not in MVM |
| constituent_engagement | message_thread | ✅ | ❌ | Domain not in MVM |
| content_publishing | digital_content | ✅ | ❌ | Domain not in MVM |
| content_publishing | impact_story | ✅ | ❌ | Domain not in MVM |
| content_publishing | plan | ✅ | ❌ | Domain not in MVM |
| feedback_management | feedback_case | ✅ | ❌ | Domain not in MVM |
| feedback_management | feedback_submission | ✅ | ❌ | Domain not in MVM |
| media_relations | crisis_communication | ✅ | ❌ | Domain not in MVM |
| media_relations | media_activity | ✅ | ❌ | Domain not in MVM |
| media_relations | media_contact | ✅ | ❌ | Domain not in MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_management | audit_finding | ✅ | ❌ | Domain not in MVM |
| audit_management | chs_self_assessment | ✅ | ❌ | Domain not in MVM |
| audit_management | corrective_action_plan | ✅ | ❌ | Domain not in MVM |
| audit_management | internal_review | ✅ | ❌ | Domain not in MVM |
| audit_management | single_audit | ✅ | ❌ | Domain not in MVM |
| donor_oversight | cognizant_agency | ✅ | ❌ | Domain not in MVM |
| donor_oversight | donor_requirement | ✅ | ❌ | Domain not in MVM |
| donor_oversight | nicra_agreement | ✅ | ❌ | Domain not in MVM |
| donor_oversight | sanctions_screening | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | compliance_incident | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | governance_policy | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | iati_publication | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | obligation | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | obligation_schedule | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | regulatory_filing | ✅ | ❌ | Domain not in MVM |
| regulatory_reporting | statutory_registration | ✅ | ❌ | Domain not in MVM |

<a id="domain-donor"></a>
### donor

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| campaign_fundraising | appeal | ✅ | ✅ |  |
| campaign_fundraising | appeal_targeting | ✅ | ❌ | Excluded from MVM |
| campaign_fundraising | campaign | ✅ | ✅ |  |
| campaign_fundraising | participation | ✅ | ❌ | Excluded from MVM |
| constituent_management | constituent | ✅ | ✅ |  |
| constituent_management | portfolio_assignment | ✅ | ❌ | Excluded from MVM |
| constituent_management | prospect | ✅ | ✅ |  |
| constituent_management | segment | ✅ | ❌ | Excluded from MVM |
| constituent_management | segment_membership | ✅ | ❌ | Excluded from MVM |
| constituent_management | wealth_screening | ✅ | ❌ | Excluded from MVM |
| event_stewardship | event_registration | ✅ | ❌ | Excluded from MVM |
| event_stewardship | event_volunteer_assignment | ✅ | ❌ | Excluded from MVM |
| event_stewardship | fundraising_event | ✅ | ❌ | Excluded from MVM |
| event_stewardship | stewardship_activity | ✅ | ✅ |  |
| fundraising_operations | fund | ❌ | ✅ | MVM only (stub or new) |
| gift_giving | donor_fund | ✅ | ❌ | Excluded from MVM |
| gift_giving | gift | ✅ | ✅ |  |
| gift_giving | indicator_funding | ✅ | ❌ | Excluded from MVM |
| gift_giving | major_gift_opportunity | ✅ | ✅ |  |
| gift_giving | planned_giving | ✅ | ❌ | Excluded from MVM |
| gift_giving | pledge | ✅ | ✅ |  |
| gift_giving | soft_credit | ✅ | ❌ | Excluded from MVM |

<a id="domain-field"></a>
### field

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| distribution_activity | distribution_line | ❌ | ✅ | MVM only (stub or new) |
| field_assessment | assessment | ✅ | ✅ |  |
| field_assessment | assessment_participation | ✅ | ❌ | Excluded from MVM |
| field_assessment | assessment_response | ✅ | ✅ |  |
| field_assessment | pdm_survey | ✅ | ❌ | Excluded from MVM |
| geographic_reference | cluster_coordination | ✅ | ❌ | Excluded from MVM |
| geographic_reference | country | ✅ | ✅ |  |
| geographic_reference | country_office | ✅ | ✅ |  |
| geographic_reference | emergency | ✅ | ✅ |  |
| geographic_reference | project_site | ✅ | ✅ |  |
| operational_presence | access_constraint | ✅ | ❌ | Excluded from MVM |
| operational_presence | field_deployment | ✅ | ❌ | Excluded from MVM |
| operational_presence | field_team | ✅ | ✅ |  |
| operational_presence | security_incident | ✅ | ❌ | Excluded from MVM |
| operational_presence | sitrep | ✅ | ✅ |  |
| service_delivery | distribution_event | ✅ | ✅ |  |
| service_delivery | distribution_participation | ✅ | ❌ | Excluded from MVM |
| service_delivery | field_distribution_line | ✅ | ❌ | Excluded from MVM |
| service_delivery | mobile_health_outreach | ✅ | ❌ | Excluded from MVM |
| service_delivery | wash_intervention | ✅ | ❌ | Excluded from MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| banking_treasury | bank_account | ✅ | ❌ | Domain not in MVM |
| banking_treasury | bank_reconciliation | ✅ | ❌ | Domain not in MVM |
| banking_treasury | bank_transaction | ✅ | ❌ | Domain not in MVM |
| banking_treasury | exchange_rate | ✅ | ❌ | Domain not in MVM |
| budget_control | budget | ✅ | ❌ | Domain not in MVM |
| budget_control | budget_line | ✅ | ❌ | Domain not in MVM |
| budget_control | budget_version | ✅ | ❌ | Domain not in MVM |
| budget_control | grant_budget | ✅ | ❌ | Domain not in MVM |
| fund_management | cost_allocation | ✅ | ❌ | Domain not in MVM |
| fund_management | cost_center | ✅ | ❌ | Domain not in MVM |
| fund_management | finance_fund | ✅ | ❌ | Domain not in MVM |
| fund_management | fiscal_period | ✅ | ❌ | Domain not in MVM |
| fund_management | fund_compliance_tracking | ✅ | ❌ | Domain not in MVM |
| fund_management | nicra_rate | ✅ | ❌ | Domain not in MVM |
| fund_management | receivable | ✅ | ❌ | Domain not in MVM |
| fund_management | receivable_receipt | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | gl_account | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | journal_entry | ✅ | ❌ | Domain not in MVM |
| ledger_accounting | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| payables_settlement | payable | ✅ | ❌ | Domain not in MVM |
| payables_settlement | payable_payment | ✅ | ❌ | Domain not in MVM |
| payables_settlement | payment_run | ✅ | ❌ | Domain not in MVM |

<a id="domain-grant"></a>
### grant

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| award_management | award | ✅ | ✅ |  |
| award_management | donor_condition | ✅ | ✅ |  |
| award_management | donor_report | ✅ | ✅ |  |
| award_management | funding_source | ✅ | ✅ |  |
| award_management | grant_amendment | ✅ | ❌ | Excluded from MVM |
| award_management | grant_closeout | ✅ | ❌ | Excluded from MVM |
| award_management | prior_approval | ✅ | ❌ | Excluded from MVM |
| award_management | proposal | ✅ | ✅ |  |
| award_management | solicitation | ✅ | ✅ |  |
| budget_compliance | asset_allocation | ✅ | ❌ | Excluded from MVM |
| budget_compliance | award_budget | ✅ | ✅ |  |
| budget_compliance | award_budget_line | ✅ | ✅ |  |
| budget_compliance | award_position_funding | ✅ | ❌ | Excluded from MVM |
| budget_compliance | award_site_allocation | ✅ | ❌ | Excluded from MVM |
| budget_compliance | cost_share_commitment | ✅ | ❌ | Excluded from MVM |
| partner_funding | grant_staff_assignment | ✅ | ❌ | Excluded from MVM |
| partner_funding | sub_award_disbursement | ✅ | ✅ |  |
| partner_funding | subaward | ✅ | ✅ |  |

<a id="domain-mel"></a>
### mel

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| data_quality | data_collection_tool | ✅ | ✅ |  |
| data_quality | data_quality_assessment | ✅ | ❌ | Excluded from MVM |
| data_quality | dhis2_aggregate_report | ✅ | ❌ | Excluded from MVM |
| data_quality | geographic_scope | ✅ | ❌ | Excluded from MVM |
| data_quality | reporting_period | ✅ | ✅ |  |
| evaluation_learning | evaluation | ✅ | ✅ |  |
| evaluation_learning | evaluation_finding | ✅ | ✅ |  |
| evaluation_learning | learning_agenda | ✅ | ❌ | Excluded from MVM |
| evaluation_learning | meal_plan | ✅ | ✅ |  |
| evaluation_learning | mel_needs_assessment | ✅ | ❌ | Excluded from MVM |
| evaluation_learning | qualitative_record | ✅ | ❌ | Excluded from MVM |
| performance_measurement | indicator | ✅ | ✅ |  |
| performance_measurement | indicator_result | ✅ | ✅ |  |
| performance_measurement | indicator_target | ✅ | ✅ |  |
| performance_measurement | mel_logframe | ✅ | ✅ |  |
| performance_measurement | mel_sdg_indicator_alignment | ✅ | ❌ | Excluded from MVM |

<a id="domain-partnership"></a>
### partnership

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agreement_governance | agreement_amendment | ✅ | ❌ | Excluded from MVM |
| agreement_governance | due_diligence_record | ✅ | ✅ |  |
| agreement_governance | mou_obligation | ✅ | ❌ | Excluded from MVM |
| agreement_governance | partner_compliance | ✅ | ❌ | Excluded from MVM |
| agreement_governance | partner_risk_register | ✅ | ❌ | Excluded from MVM |
| capacity_development | capacity_assessment | ✅ | ✅ |  |
| capacity_development | capacity_building_activity | ✅ | ❌ | Excluded from MVM |
| capacity_development | capacity_building_plan | ✅ | ✅ |  |
| capacity_development | macro_assessment | ✅ | ❌ | Excluded from MVM |
| capacity_development | micro_assessment | ✅ | ❌ | Excluded from MVM |
| consortium_engagement | campaign_participation | ✅ | ❌ | Excluded from MVM |
| consortium_engagement | consortium_communication | ✅ | ❌ | Excluded from MVM |
| consortium_engagement | coordination_meeting | ✅ | ❌ | Excluded from MVM |
| partner_registry | agreement | ❌ | ✅ | MVM only (stub or new) |
| partner_registry | consortium | ✅ | ✅ |  |
| partner_registry | consortium_member | ✅ | ✅ |  |
| partner_registry | partner_accreditation | ✅ | ❌ | Excluded from MVM |
| partner_registry | partner_contact | ✅ | ✅ |  |
| partner_registry | partner_org | ✅ | ✅ |  |
| partner_registry | partnership_agreement | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | face_form | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | field_monitoring_visit | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | partner_performance_review | ✅ | ✅ |  |
| performance_monitoring | partner_report_submission | ✅ | ✅ |  |
| performance_monitoring | programme_visit | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | scheduled_audit | ✅ | ❌ | Excluded from MVM |
| performance_monitoring | spot_check | ✅ | ❌ | Excluded from MVM |

<a id="domain-program"></a>
### program

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| intervention_design | component | ✅ | ✅ |  |
| intervention_design | country_programme_document | ✅ | ❌ | Excluded from MVM |
| intervention_design | design_assessment | ✅ | ❌ | Excluded from MVM |
| intervention_design | humanitarian_response_plan | ✅ | ❌ | Excluded from MVM |
| intervention_design | intervention | ✅ | ✅ |  |
| intervention_design | logframe_row | ✅ | ✅ |  |
| intervention_design | program | ✅ | ✅ |  |
| intervention_design | program_logframe | ✅ | ✅ |  |
| intervention_design | program_sdg_indicator_alignment | ✅ | ❌ | Excluded from MVM |
| intervention_design | strategic_plan_goal_area | ✅ | ❌ | Excluded from MVM |
| intervention_design | target_population | ✅ | ✅ |  |
| intervention_design | theory_of_change | ✅ | ✅ |  |
| intervention_design | unsdcf_outcome | ✅ | ❌ | Excluded from MVM |
| operational_planning | budget_plan | ✅ | ✅ |  |
| operational_planning | budget_plan_line | ✅ | ✅ |  |
| operational_planning | implementation_plan | ✅ | ✅ |  |
| operational_planning | program_amendment | ✅ | ❌ | Excluded from MVM |
| operational_planning | program_closeout | ✅ | ❌ | Excluded from MVM |
| operational_planning | review_event | ✅ | ❌ | Excluded from MVM |
| operational_planning | risk_register | ✅ | ✅ |  |
| partnership_governance | component_indicator | ✅ | ❌ | Excluded from MVM |
| partnership_governance | component_system_usage | ✅ | ❌ | Excluded from MVM |
| partnership_governance | intervention_compliance | ✅ | ❌ | Excluded from MVM |
| partnership_governance | partner_linkage | ✅ | ❌ | Excluded from MVM |
| partnership_governance | program_partnership | ✅ | ❌ | Excluded from MVM |

<a id="domain-safeguarding"></a>
### safeguarding

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| incident_response | alleged_perpetrator | ✅ | ❌ | Domain not in MVM |
| incident_response | disciplinary_outcome | ✅ | ❌ | Domain not in MVM |
| incident_response | investigation | ✅ | ❌ | Domain not in MVM |
| incident_response | investigation_action | ✅ | ❌ | Domain not in MVM |
| incident_response | misconduct_disclosure | ✅ | ❌ | Domain not in MVM |
| incident_response | safeguarding_incident | ✅ | ❌ | Domain not in MVM |
| partner_accountability | community_awareness_session | ✅ | ❌ | Domain not in MVM |
| partner_accountability | donor_safeguarding_requirement | ✅ | ❌ | Domain not in MVM |
| partner_accountability | partner_psea_assessment | ✅ | ❌ | Domain not in MVM |
| partner_accountability | psea_network | ✅ | ❌ | Domain not in MVM |
| partner_accountability | psea_network_membership | ✅ | ❌ | Domain not in MVM |
| policy_governance | focal_point | ✅ | ❌ | Domain not in MVM |
| policy_governance | psea_policy | ✅ | ❌ | Domain not in MVM |
| policy_governance | reporting_channel | ✅ | ❌ | Domain not in MVM |
| policy_governance | risk_assessment | ✅ | ❌ | Domain not in MVM |
| policy_governance | safeguarding_policy_acknowledgment | ✅ | ❌ | Domain not in MVM |
| survivor_support | support_service_referral | ✅ | ❌ | Domain not in MVM |
| survivor_support | survivor_record | ✅ | ❌ | Domain not in MVM |
| survivor_support | survivor_support_plan | ✅ | ❌ | Domain not in MVM |
| training_compliance | audit | ✅ | ❌ | Domain not in MVM |
| training_compliance | audit_recommendation | ✅ | ❌ | Domain not in MVM |
| training_compliance | safeguarding_training_completion | ✅ | ❌ | Domain not in MVM |
| training_compliance | training_program | ✅ | ❌ | Domain not in MVM |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| catalog_management | batch_lot | ✅ | ❌ | Excluded from MVM |
| catalog_management | cold_chain_equipment | ✅ | ❌ | Excluded from MVM |
| catalog_management | commodity | ✅ | ✅ |  |
| catalog_management | commodity_supply_agreement | ✅ | ❌ | Excluded from MVM |
| catalog_management | framework_agreement | ✅ | ❌ | Excluded from MVM |
| catalog_management | gavi_cofinancing | ✅ | ❌ | Excluded from MVM |
| catalog_management | inventory_balance | ✅ | ✅ |  |
| catalog_management | supply_agreement | ✅ | ❌ | Excluded from MVM |
| catalog_management | vaccine_vial_monitor_state | ✅ | ❌ | Excluded from MVM |
| catalog_management | vendor | ✅ | ✅ |  |
| catalog_management | warehouse | ✅ | ✅ |  |
| distribution_operations | distribution_order | ✅ | ✅ |  |
| distribution_operations | distribution_plan | ✅ | ✅ |  |
| distribution_operations | distribution_plan_line | ✅ | ❌ | Excluded from MVM |
| distribution_operations | supply_distribution_line | ✅ | ❌ | Excluded from MVM |
| inventory_movement | goods_receipt | ✅ | ✅ |  |
| inventory_movement | shipment | ✅ | ❌ | Excluded from MVM |
| inventory_movement | stock_movement | ✅ | ✅ |  |
| inventory_movement | temperature_excursion | ✅ | ❌ | Excluded from MVM |
| inventory_movement | waybill | ✅ | ❌ | Excluded from MVM |
| procurement_sourcing | bid | ✅ | ❌ | Excluded from MVM |
| procurement_sourcing | inkind_donation | ✅ | ❌ | Excluded from MVM |
| procurement_sourcing | procurement_request | ✅ | ✅ |  |
| procurement_sourcing | purchase_order | ✅ | ✅ |  |
| procurement_sourcing | purchase_order_line | ✅ | ✅ |  |
| procurement_sourcing | rfq | ✅ | ❌ | Excluded from MVM |
| vendor_procurement | vendor_commodity_agreement | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-technology"></a>
### technology

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| access_identity | access_provisioning | ✅ | ❌ | Domain not in MVM |
| access_identity | access_role | ✅ | ❌ | Domain not in MVM |
| access_identity | user_account | ✅ | ❌ | Domain not in MVM |
| asset_procurement | it_asset | ✅ | ❌ | Domain not in MVM |
| asset_procurement | it_procurement | ✅ | ❌ | Domain not in MVM |
| asset_procurement | it_project | ✅ | ❌ | Domain not in MVM |
| asset_procurement | platform_integration | ✅ | ❌ | Domain not in MVM |
| asset_procurement | software_license | ✅ | ❌ | Domain not in MVM |
| asset_procurement | system_platform | ✅ | ❌ | Domain not in MVM |
| network_connectivity | backup_schedule | ✅ | ❌ | Domain not in MVM |
| network_connectivity | connectivity_log | ✅ | ❌ | Domain not in MVM |
| network_connectivity | network_site | ✅ | ❌ | Domain not in MVM |
| security_compliance | security_assessment | ✅ | ❌ | Domain not in MVM |
| security_compliance | security_control | ✅ | ❌ | Domain not in MVM |
| security_compliance | vulnerability | ✅ | ❌ | Domain not in MVM |
| service_operations | cab_meeting | ✅ | ❌ | Domain not in MVM |
| service_operations | change_request | ✅ | ❌ | Domain not in MVM |
| service_operations | it_incident | ✅ | ❌ | Domain not in MVM |
| service_operations | it_problem | ✅ | ❌ | Domain not in MVM |
| service_operations | it_service | ✅ | ❌ | Domain not in MVM |
| service_operations | knowledge_article | ✅ | ❌ | Domain not in MVM |
| service_operations | service_request | ✅ | ❌ | Domain not in MVM |

<a id="domain-volunteer"></a>
### volunteer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| engagement_accountability | feedback | ✅ | ❌ | Excluded from MVM |
| engagement_accountability | incident_report | ✅ | ❌ | Excluded from MVM |
| engagement_accountability | recognition | ✅ | ❌ | Excluded from MVM |
| field_operations | hour_log | ✅ | ✅ |  |
| field_operations | schedule | ✅ | ❌ | Excluded from MVM |
| field_operations | stipend | ✅ | ❌ | Excluded from MVM |
| field_operations | volunteer_deployment | ✅ | ❌ | Excluded from MVM |
| field_operations | volunteer_deployment2 | ✅ | ❌ | Excluded from MVM |
| field_operations | volunteer_redeployment | ✅ | ❌ | Excluded from MVM |
| learning_development | certification | ✅ | ✅ |  |
| learning_development | tool_authorization | ✅ | ❌ | Excluded from MVM |
| learning_development | training | ✅ | ✅ |  |
| learning_development | training_enrollment | ✅ | ✅ |  |
| learning_development | volunteer_policy_acknowledgment | ✅ | ❌ | Excluded from MVM |
| learning_development | volunteer_training_completion | ✅ | ❌ | Excluded from MVM |
| volunteer_management | deployment | ❌ | ✅ | MVM only (stub or new) |
| volunteer_registry | application | ✅ | ✅ |  |
| volunteer_registry | consent | ✅ | ❌ | Excluded from MVM |
| volunteer_registry | role | ✅ | ✅ |  |
| volunteer_registry | volunteer | ✅ | ✅ |  |
| volunteer_registry | volunteer_team | ✅ | ✅ |  |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| payroll_benefits | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | benefit_plan | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | leave_request | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_run | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payslip | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | timesheet | ✅ | ❌ | Domain not in MVM |
| performance_development | calibration_session | ✅ | ❌ | Domain not in MVM |
| performance_development | competency_framework | ✅ | ❌ | Domain not in MVM |
| performance_development | disciplinary_case | ✅ | ❌ | Domain not in MVM |
| performance_development | learning_course | ✅ | ❌ | Domain not in MVM |
| performance_development | learning_enrollment | ✅ | ❌ | Domain not in MVM |
| performance_development | performance_improvement_plan | ✅ | ❌ | Domain not in MVM |
| performance_development | performance_review | ✅ | ❌ | Domain not in MVM |
| performance_development | rating_scale | ✅ | ❌ | Domain not in MVM |
| performance_development | review_cycle | ✅ | ❌ | Domain not in MVM |
| performance_development | review_template | ✅ | ❌ | Domain not in MVM |
| staff_records | employment_contract | ✅ | ❌ | Domain not in MVM |
| staff_records | expat_package | ✅ | ❌ | Domain not in MVM |
| staff_records | job_profile | ✅ | ❌ | Domain not in MVM |
| staff_records | org_unit | ✅ | ❌ | Domain not in MVM |
| staff_records | position | ✅ | ❌ | Domain not in MVM |
| staff_records | separation_event | ✅ | ❌ | Domain not in MVM |
| staff_records | staff_certification | ✅ | ❌ | Domain not in MVM |
| staff_records | staff_member | ✅ | ❌ | Domain not in MVM |
| staff_records | workforce_staff_assignment | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | candidate | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | job_application | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | recruitment_requisition | ✅ | ❌ | Domain not in MVM |
