# Ngo Lakehouse Data Models

**Version 1** | Generated on May 07, 2026 at 03:36 AM

**Industry:** nonprofit

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
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

Nonprofit Organizations are mission-driven entities providing humanitarian aid, disaster relief, health services, education, and community development programs to vulnerable and underserved populations worldwide.

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
| Domains | 12 | 15 |
| Subdomains | 31 | 46 |
| Products (Tables) | 141 | 302 |
| Attributes (Columns) | 6093 | 11608 |
| Foreign Keys | 1413 | 1821 |
| Avg Attributes/Product | 43.2 | 38.4 |

## Domain & Product Comparison

<a id="domain-beneficiary"></a>
### beneficiary

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| case_management | needs_assessment | ❌ | ✅ | MVM only (stub or new) |
| identity_management | biometric_record | ✅ | ❌ | Excluded from MVM |
| identity_management | community | ✅ | ✅ |  |
| identity_management | displacement_history | ✅ | ❌ | Excluded from MVM |
| identity_management | document_record | ✅ | ✅ |  |
| identity_management | exit_record | ✅ | ❌ | Excluded from MVM |
| identity_management | household | ✅ | ✅ |  |
| identity_management | household_member | ✅ | ✅ |  |
| identity_management | protection_flag | ✅ | ✅ |  |
| identity_management | registrant | ✅ | ✅ |  |
| identity_management | registration_event | ✅ | ❌ | Excluded from MVM |
| identity_management | vulnerability_profile | ✅ | ✅ |  |
| service_delivery | beneficiary_needs_assessment | ✅ | ❌ | Excluded from MVM |
| service_delivery | case_action | ✅ | ✅ |  |
| service_delivery | case_record | ✅ | ✅ |  |
| service_delivery | community_intervention | ✅ | ❌ | Excluded from MVM |
| service_delivery | consent_record | ✅ | ✅ |  |
| service_delivery | enrollment | ✅ | ❌ | Excluded from MVM |
| service_delivery | entitlement | ✅ | ❌ | Excluded from MVM |
| service_delivery | household_volunteer_assignment | ✅ | ❌ | Excluded from MVM |
| service_delivery | referral | ✅ | ✅ |  |
| service_delivery | service_assignment | ✅ | ❌ | Excluded from MVM |

<a id="domain-communication"></a>
### communication

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| campaign_management | advocacy_campaign | ✅ | ❌ | Domain not in MVM |
| campaign_management | campaign_media_outreach | ✅ | ❌ | Domain not in MVM |
| campaign_management | campaign_touchpoint | ✅ | ❌ | Domain not in MVM |
| campaign_management | crisis_communication | ✅ | ❌ | Domain not in MVM |
| campaign_management | plan | ✅ | ❌ | Domain not in MVM |
| constituent_engagement | community_engagement_event | ✅ | ❌ | Domain not in MVM |
| constituent_engagement | constituent_consent | ✅ | ❌ | Domain not in MVM |
| constituent_engagement | constituent_message | ✅ | ❌ | Domain not in MVM |
| constituent_engagement | donor_stewardship_touchpoint | ✅ | ❌ | Domain not in MVM |
| constituent_engagement | email_broadcast | ✅ | ❌ | Domain not in MVM |
| constituent_engagement | message_thread | ✅ | ❌ | Domain not in MVM |
| media_relations | digital_content | ✅ | ❌ | Domain not in MVM |
| media_relations | feedback_case | ✅ | ❌ | Domain not in MVM |
| media_relations | feedback_submission | ✅ | ❌ | Domain not in MVM |
| media_relations | impact_story | ✅ | ❌ | Domain not in MVM |
| media_relations | media_activity | ✅ | ❌ | Domain not in MVM |
| media_relations | media_contact | ✅ | ❌ | Domain not in MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_findings | incident | ❌ | ✅ | MVM only (stub or new) |
| audit_management | audit_finding | ✅ | ✅ |  |
| audit_management | corrective_action_plan | ✅ | ✅ |  |
| audit_management | internal_review | ✅ | ✅ |  |
| audit_management | nicra_agreement | ✅ | ❌ | Excluded from MVM |
| audit_management | single_audit | ✅ | ✅ |  |
| donor_accountability | chs_self_assessment | ✅ | ❌ | Excluded from MVM |
| donor_accountability | donor_requirement | ✅ | ✅ |  |
| donor_accountability | iati_publication | ✅ | ❌ | Excluded from MVM |
| donor_accountability | sanctions_screening | ✅ | ✅ |  |
| governance_oversight | compliance_incident | ✅ | ❌ | Excluded from MVM |
| governance_oversight | governance_policy | ✅ | ✅ |  |
| regulatory_reporting | cognizant_agency | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | obligation | ✅ | ✅ |  |
| regulatory_reporting | obligation_schedule | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | regulatory_filing | ✅ | ✅ |  |
| regulatory_reporting | statutory_registration | ✅ | ✅ |  |

<a id="domain-donor"></a>
### donor

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| financial_transactions | gift | ✅ | ✅ |  |
| financial_transactions | major_gift_opportunity | ✅ | ❌ | Excluded from MVM |
| financial_transactions | planned_giving | ✅ | ❌ | Excluded from MVM |
| financial_transactions | pledge | ✅ | ✅ |  |
| financial_transactions | soft_credit | ✅ | ❌ | Excluded from MVM |
| fundraising_operations | appeal | ✅ | ✅ |  |
| fundraising_operations | appeal_targeting | ✅ | ❌ | Excluded from MVM |
| fundraising_operations | campaign | ✅ | ✅ |  |
| fundraising_operations | donor_fund | ✅ | ✅ |  |
| fundraising_operations | event_registration | ✅ | ❌ | Excluded from MVM |
| fundraising_operations | event_volunteer_assignment | ✅ | ❌ | Excluded from MVM |
| fundraising_operations | fundraising_event | ✅ | ✅ |  |
| fundraising_operations | indicator_funding | ✅ | ❌ | Excluded from MVM |
| fundraising_operations | participation | ✅ | ❌ | Excluded from MVM |
| relationship_management | constituent | ✅ | ✅ |  |
| relationship_management | portfolio_assignment | ✅ | ✅ |  |
| relationship_management | prospect | ✅ | ✅ |  |
| relationship_management | segment | ✅ | ✅ |  |
| relationship_management | segment_membership | ✅ | ❌ | Excluded from MVM |
| relationship_management | stewardship_activity | ✅ | ✅ |  |
| relationship_management | wealth_screening | ✅ | ❌ | Excluded from MVM |

<a id="domain-field"></a>
### field

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| aid_distribution | distribution_line | ❌ | ✅ | MVM only (stub or new) |
| monitoring_evaluation | assessment | ✅ | ✅ |  |
| monitoring_evaluation | assessment_participation | ✅ | ❌ | Excluded from MVM |
| monitoring_evaluation | assessment_response | ✅ | ✅ |  |
| monitoring_evaluation | distribution_participation | ✅ | ❌ | Excluded from MVM |
| monitoring_evaluation | pdm_survey | ✅ | ❌ | Excluded from MVM |
| program_delivery | distribution_event | ✅ | ✅ |  |
| program_delivery | field_distribution_line | ✅ | ❌ | Excluded from MVM |
| program_delivery | mobile_health_outreach | ✅ | ❌ | Excluded from MVM |
| program_delivery | wash_intervention | ✅ | ❌ | Excluded from MVM |
| risk_intelligence | access_constraint | ✅ | ✅ |  |
| risk_intelligence | country | ✅ | ✅ |  |
| risk_intelligence | emergency | ✅ | ✅ |  |
| risk_intelligence | security_incident | ✅ | ✅ |  |
| risk_intelligence | sitrep | ✅ | ✅ |  |
| site_operations | cluster_coordination | ✅ | ❌ | Excluded from MVM |
| site_operations | country_office | ✅ | ✅ |  |
| site_operations | field_deployment | ✅ | ✅ |  |
| site_operations | field_team | ✅ | ✅ |  |
| site_operations | project_site | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| budget_planning | budget | ✅ | ✅ |  |
| budget_planning | budget_line | ✅ | ✅ |  |
| budget_planning | budget_version | ✅ | ❌ | Excluded from MVM |
| budget_planning | cost_allocation | ✅ | ✅ |  |
| budget_planning | fund_compliance_tracking | ✅ | ❌ | Excluded from MVM |
| budget_planning | grant_budget | ✅ | ✅ |  |
| budget_planning | nicra_rate | ✅ | ❌ | Excluded from MVM |
| fund_accounting | cost_center | ✅ | ✅ |  |
| fund_accounting | finance_fund | ✅ | ✅ |  |
| fund_accounting | fiscal_period | ✅ | ✅ |  |
| fund_accounting | gl_account | ✅ | ✅ |  |
| fund_accounting | journal_entry | ✅ | ✅ |  |
| fund_accounting | journal_entry_line | ✅ | ✅ |  |
| payment_operations | bank_account | ✅ | ✅ |  |
| payment_operations | bank_reconciliation | ✅ | ❌ | Excluded from MVM |
| payment_operations | bank_transaction | ✅ | ❌ | Excluded from MVM |
| payment_operations | exchange_rate | ✅ | ❌ | Excluded from MVM |
| payment_operations | payable | ✅ | ✅ |  |
| payment_operations | payable_payment | ✅ | ✅ |  |
| payment_operations | payment_run | ✅ | ❌ | Excluded from MVM |
| payment_operations | receivable | ✅ | ✅ |  |
| payment_operations | receivable_receipt | ✅ | ✅ |  |

<a id="domain-grant"></a>
### grant

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| award_management | asset_allocation | ✅ | ❌ | Excluded from MVM |
| award_management | award | ✅ | ✅ |  |
| award_management | award_budget | ✅ | ✅ |  |
| award_management | award_budget_line | ✅ | ✅ |  |
| award_management | award_position_funding | ✅ | ❌ | Excluded from MVM |
| award_management | award_site_allocation | ✅ | ❌ | Excluded from MVM |
| award_management | cost_share_commitment | ✅ | ✅ |  |
| award_management | donor_condition | ✅ | ✅ |  |
| award_management | donor_report | ✅ | ✅ |  |
| award_management | grant_amendment | ✅ | ✅ |  |
| award_management | grant_closeout | ✅ | ❌ | Excluded from MVM |
| award_management | prior_approval | ✅ | ❌ | Excluded from MVM |
| funding_acquisition | funding_source | ✅ | ✅ |  |
| funding_acquisition | proposal | ✅ | ✅ |  |
| funding_acquisition | solicitation | ✅ | ❌ | Excluded from MVM |
| partner_disbursement | grant_staff_assignment | ✅ | ❌ | Excluded from MVM |
| partner_disbursement | sub_award_disbursement | ✅ | ❌ | Excluded from MVM |
| partner_disbursement | subaward | ✅ | ✅ |  |

<a id="domain-mel"></a>
### mel

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| impact_assessment | data_quality_assessment | ✅ | ✅ |  |
| impact_assessment | dhis2_aggregate_report | ✅ | ❌ | Excluded from MVM |
| impact_assessment | evaluation | ✅ | ✅ |  |
| impact_assessment | evaluation_finding | ✅ | ✅ |  |
| impact_assessment | learning_agenda | ✅ | ❌ | Excluded from MVM |
| impact_assessment | mel_needs_assessment | ✅ | ❌ | Excluded from MVM |
| impact_assessment | qualitative_record | ✅ | ✅ |  |
| indicator_management | logframe | ❌ | ✅ | MVM only (stub or new) |
| performance_measurement | data_collection_tool | ✅ | ✅ |  |
| performance_measurement | geographic_scope | ✅ | ❌ | Excluded from MVM |
| performance_measurement | indicator | ✅ | ✅ |  |
| performance_measurement | indicator_result | ✅ | ✅ |  |
| performance_measurement | indicator_target | ✅ | ✅ |  |
| performance_measurement | meal_plan | ✅ | ✅ |  |
| performance_measurement | mel_logframe | ✅ | ❌ | Excluded from MVM |
| performance_measurement | reporting_period | ✅ | ✅ |  |

<a id="domain-partnership"></a>
### partnership

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agreement_administration | agreement_amendment | ✅ | ✅ |  |
| agreement_administration | capacity_building_activity | ✅ | ❌ | Excluded from MVM |
| agreement_administration | capacity_building_plan | ✅ | ✅ |  |
| agreement_administration | field_monitoring_visit | ✅ | ❌ | Excluded from MVM |
| agreement_administration | mou_obligation | ✅ | ❌ | Excluded from MVM |
| agreement_administration | partner_compliance | ✅ | ❌ | Excluded from MVM |
| agreement_administration | partner_performance_review | ✅ | ✅ |  |
| agreement_administration | partner_report_submission | ✅ | ✅ |  |
| agreement_governance | agreement | ❌ | ✅ | MVM only (stub or new) |
| collaborative_coordination | campaign_participation | ✅ | ❌ | Excluded from MVM |
| collaborative_coordination | consortium | ✅ | ✅ |  |
| collaborative_coordination | consortium_communication | ✅ | ❌ | Excluded from MVM |
| collaborative_coordination | consortium_member | ✅ | ❌ | Excluded from MVM |
| collaborative_coordination | coordination_meeting | ✅ | ❌ | Excluded from MVM |
| partner_management | capacity_assessment | ✅ | ✅ |  |
| partner_management | due_diligence_record | ✅ | ✅ |  |
| partner_management | partner_accreditation | ✅ | ❌ | Excluded from MVM |
| partner_management | partner_contact | ✅ | ✅ |  |
| partner_management | partner_org | ✅ | ✅ |  |
| partner_management | partner_risk_register | ✅ | ❌ | Excluded from MVM |
| partner_management | partnership_agreement | ✅ | ❌ | Excluded from MVM |
| partner_registry | consortium_membership | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-program"></a>
### program

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| design_planning | component | ✅ | ✅ |  |
| design_planning | design_assessment | ✅ | ❌ | Excluded from MVM |
| design_planning | implementation_plan | ✅ | ✅ |  |
| design_planning | intervention | ✅ | ✅ |  |
| design_planning | logframe_row | ✅ | ❌ | Excluded from MVM |
| design_planning | program | ✅ | ✅ |  |
| design_planning | program_logframe | ✅ | ❌ | Excluded from MVM |
| design_planning | target_population | ✅ | ✅ |  |
| design_planning | theory_of_change | ✅ | ❌ | Excluded from MVM |
| governance_oversight | budget_plan | ✅ | ✅ |  |
| governance_oversight | budget_plan_line | ✅ | ✅ |  |
| governance_oversight | component_indicator | ✅ | ❌ | Excluded from MVM |
| governance_oversight | component_system_usage | ✅ | ❌ | Excluded from MVM |
| governance_oversight | intervention_compliance | ✅ | ❌ | Excluded from MVM |
| governance_oversight | partner_linkage | ✅ | ✅ |  |
| governance_oversight | program_amendment | ✅ | ✅ |  |
| governance_oversight | program_closeout | ✅ | ❌ | Excluded from MVM |
| governance_oversight | program_partnership | ✅ | ❌ | Excluded from MVM |
| governance_oversight | review_event | ✅ | ✅ |  |
| governance_oversight | risk_register | ✅ | ✅ |  |

<a id="domain-safeguarding"></a>
### safeguarding

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| capacity_building | community_awareness_session | ✅ | ❌ | Domain not in MVM |
| capacity_building | focal_point | ✅ | ❌ | Domain not in MVM |
| capacity_building | psea_network | ✅ | ❌ | Domain not in MVM |
| capacity_building | psea_network_membership | ✅ | ❌ | Domain not in MVM |
| capacity_building | safeguarding_training_completion | ✅ | ❌ | Domain not in MVM |
| capacity_building | training_program | ✅ | ❌ | Domain not in MVM |
| incident_management | alleged_perpetrator | ✅ | ❌ | Domain not in MVM |
| incident_management | disciplinary_outcome | ✅ | ❌ | Domain not in MVM |
| incident_management | investigation | ✅ | ❌ | Domain not in MVM |
| incident_management | investigation_action | ✅ | ❌ | Domain not in MVM |
| incident_management | misconduct_disclosure | ✅ | ❌ | Domain not in MVM |
| incident_management | reporting_channel | ✅ | ❌ | Domain not in MVM |
| incident_management | safeguarding_incident | ✅ | ❌ | Domain not in MVM |
| policy_compliance | audit | ✅ | ❌ | Domain not in MVM |
| policy_compliance | audit_recommendation | ✅ | ❌ | Domain not in MVM |
| policy_compliance | donor_safeguarding_requirement | ✅ | ❌ | Domain not in MVM |
| policy_compliance | partner_psea_assessment | ✅ | ❌ | Domain not in MVM |
| policy_compliance | psea_policy | ✅ | ❌ | Domain not in MVM |
| policy_compliance | risk_assessment | ✅ | ❌ | Domain not in MVM |
| policy_compliance | safeguarding_policy_acknowledgment | ✅ | ❌ | Domain not in MVM |
| survivor_support | support_service_referral | ✅ | ❌ | Domain not in MVM |
| survivor_support | survivor_record | ✅ | ❌ | Domain not in MVM |
| survivor_support | survivor_support_plan | ✅ | ❌ | Domain not in MVM |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| catalog_management | commodity | ✅ | ✅ |  |
| catalog_management | framework_agreement | ✅ | ❌ | Excluded from MVM |
| catalog_management | inventory_balance | ✅ | ✅ |  |
| catalog_management | vendor | ✅ | ✅ |  |
| catalog_management | warehouse | ✅ | ✅ |  |
| distribution_logistics | distribution_order | ✅ | ✅ |  |
| distribution_logistics | distribution_order_line | ❌ | ✅ | MVM only (stub or new) |
| distribution_logistics | distribution_plan | ✅ | ✅ |  |
| distribution_logistics | distribution_plan_line | ✅ | ✅ |  |
| distribution_logistics | goods_receipt | ✅ | ✅ |  |
| distribution_logistics | inkind_donation | ✅ | ❌ | Excluded from MVM |
| distribution_logistics | shipment | ✅ | ✅ |  |
| distribution_logistics | stock_movement | ✅ | ✅ |  |
| distribution_logistics | supply_distribution_line | ✅ | ❌ | Excluded from MVM |
| distribution_logistics | waybill | ✅ | ✅ |  |
| procurement_operations | bid | ✅ | ❌ | Excluded from MVM |
| procurement_operations | commodity_supply_agreement | ✅ | ❌ | Excluded from MVM |
| procurement_operations | procurement_request | ✅ | ✅ |  |
| procurement_operations | purchase_order | ✅ | ✅ |  |
| procurement_operations | purchase_order_line | ✅ | ✅ |  |
| procurement_operations | rfq | ✅ | ❌ | Excluded from MVM |
| procurement_operations | supply_agreement | ✅ | ❌ | Excluded from MVM |
| procurement_operations | vendor_catalog_item | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-technology"></a>
### technology

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| infrastructure_operations | backup_schedule | ✅ | ❌ | Domain not in MVM |
| infrastructure_operations | connectivity_log | ✅ | ❌ | Domain not in MVM |
| infrastructure_operations | it_asset | ✅ | ❌ | Domain not in MVM |
| infrastructure_operations | it_procurement | ✅ | ❌ | Domain not in MVM |
| infrastructure_operations | it_project | ✅ | ❌ | Domain not in MVM |
| infrastructure_operations | it_service | ✅ | ❌ | Domain not in MVM |
| infrastructure_operations | network_site | ✅ | ❌ | Domain not in MVM |
| infrastructure_operations | platform_integration | ✅ | ❌ | Domain not in MVM |
| infrastructure_operations | software_license | ✅ | ❌ | Domain not in MVM |
| infrastructure_operations | system_platform | ✅ | ❌ | Domain not in MVM |
| security_governance | access_provisioning | ✅ | ❌ | Domain not in MVM |
| security_governance | access_role | ✅ | ❌ | Domain not in MVM |
| security_governance | security_assessment | ✅ | ❌ | Domain not in MVM |
| security_governance | security_control | ✅ | ❌ | Domain not in MVM |
| security_governance | user_account | ✅ | ❌ | Domain not in MVM |
| security_governance | vulnerability | ✅ | ❌ | Domain not in MVM |
| support_management | cab_meeting | ✅ | ❌ | Domain not in MVM |
| support_management | change_request | ✅ | ❌ | Domain not in MVM |
| support_management | it_incident | ✅ | ❌ | Domain not in MVM |
| support_management | it_problem | ✅ | ❌ | Domain not in MVM |
| support_management | knowledge_article | ✅ | ❌ | Domain not in MVM |
| support_management | service_request | ✅ | ❌ | Domain not in MVM |

<a id="domain-volunteer"></a>
### volunteer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| activity_tracking | feedback | ✅ | ❌ | Excluded from MVM |
| activity_tracking | hour_log | ✅ | ✅ |  |
| activity_tracking | incident_report | ✅ | ❌ | Excluded from MVM |
| activity_tracking | schedule | ✅ | ❌ | Excluded from MVM |
| activity_tracking | stipend | ✅ | ❌ | Excluded from MVM |
| compliance_authorization | consent | ✅ | ❌ | Excluded from MVM |
| compliance_authorization | tool_authorization | ✅ | ❌ | Excluded from MVM |
| compliance_authorization | volunteer_policy_acknowledgment | ✅ | ❌ | Excluded from MVM |
| development_recognition | certification | ✅ | ✅ |  |
| development_recognition | recognition | ✅ | ❌ | Excluded from MVM |
| development_recognition | training | ✅ | ✅ |  |
| development_recognition | training_enrollment | ✅ | ✅ |  |
| development_recognition | volunteer_training_completion | ✅ | ❌ | Excluded from MVM |
| field_operations | team_membership | ❌ | ✅ | MVM only (stub or new) |
| workforce_management | application | ✅ | ✅ |  |
| workforce_management | role | ✅ | ✅ |  |
| workforce_management | volunteer | ✅ | ✅ |  |
| workforce_management | volunteer_deployment | ✅ | ✅ |  |
| workforce_management | volunteer_deployment2 | ✅ | ❌ | Excluded from MVM |
| workforce_management | volunteer_team | ✅ | ✅ |  |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_benefits | benefit_enrollment | ✅ | ❌ | Excluded from MVM |
| compensation_benefits | benefit_plan | ✅ | ❌ | Excluded from MVM |
| compensation_benefits | leave_request | ✅ | ✅ |  |
| compensation_benefits | payroll_run | ✅ | ✅ |  |
| compensation_benefits | payslip | ✅ | ✅ |  |
| compensation_benefits | timesheet | ✅ | ❌ | Excluded from MVM |
| employee_administration | disciplinary_case | ✅ | ❌ | Excluded from MVM |
| employee_administration | employment_contract | ✅ | ✅ |  |
| employee_administration | expat_package | ✅ | ❌ | Excluded from MVM |
| employee_administration | job_profile | ✅ | ✅ |  |
| employee_administration | org_unit | ✅ | ✅ |  |
| employee_administration | position | ✅ | ✅ |  |
| employee_administration | separation_event | ✅ | ❌ | Excluded from MVM |
| employee_administration | staff_certification | ✅ | ❌ | Excluded from MVM |
| employee_administration | staff_member | ✅ | ✅ |  |
| employee_administration | workforce_staff_assignment | ✅ | ❌ | Excluded from MVM |
| payroll_operations | staff_assignment | ❌ | ✅ | MVM only (stub or new) |
| performance_development | calibration_session | ✅ | ❌ | Excluded from MVM |
| performance_development | competency_framework | ✅ | ❌ | Excluded from MVM |
| performance_development | learning_course | ✅ | ❌ | Excluded from MVM |
| performance_development | learning_enrollment | ✅ | ❌ | Excluded from MVM |
| performance_development | performance_improvement_plan | ✅ | ❌ | Excluded from MVM |
| performance_development | performance_review | ✅ | ✅ |  |
| performance_development | rating_scale | ✅ | ❌ | Excluded from MVM |
| performance_development | review_cycle | ✅ | ❌ | Excluded from MVM |
| performance_development | review_template | ✅ | ❌ | Excluded from MVM |
| talent_acquisition | candidate | ✅ | ❌ | Excluded from MVM |
| talent_acquisition | job_application | ✅ | ❌ | Excluded from MVM |
| talent_acquisition | recruitment_requisition | ✅ | ❌ | Excluded from MVM |
