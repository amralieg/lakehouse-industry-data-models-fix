-- Metric views for domain: sponsor | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-06 23:23:25

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`sponsor_bid_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid request pipeline metrics tracking win rates, bid volumes, and competitive positioning for sponsor RFP responses."
  source: "`clinical_trials_ecm`.`sponsor`.`bid_request`"
  dimensions:
    - name: "bid_status"
      expr: bid_status
      comment: "Current status of the bid request (e.g., Won, Lost, Pending, No Bid)"
    - name: "study_phase"
      expr: study_phase
      comment: "Clinical trial phase (Phase I, II, III, IV) for the requested study"
    - name: "study_type"
      expr: study_type
      comment: "Type of clinical study (e.g., interventional, observational)"
    - name: "service_model"
      expr: service_model
      comment: "Service delivery model requested (e.g., FSP, full-service, hybrid)"
    - name: "region_scope"
      expr: region_scope
      comment: "Geographic region scope of the bid request"
    - name: "receipt_year"
      expr: YEAR(receipt_date)
      comment: "Year the bid request was received"
    - name: "receipt_quarter"
      expr: CONCAT('Q', QUARTER(receipt_date))
      comment: "Quarter the bid request was received"
    - name: "is_resubmission"
      expr: is_resubmission
      comment: "Whether this bid is a resubmission of a prior bid"
  measures:
    - name: "total_bid_requests"
      expr: COUNT(1)
      comment: "Total number of bid requests received, indicating pipeline volume"
    - name: "total_submitted_bid_amount_usd"
      expr: SUM(CAST(submitted_bid_amount AS DOUBLE))
      comment: "Total dollar value of all submitted bids representing pipeline value"
    - name: "avg_win_probability_pct"
      expr: AVG(CAST(win_probability_pct AS DOUBLE))
      comment: "Average win probability across bids, indicating pipeline quality and confidence"
    - name: "total_estimated_budget_amount"
      expr: SUM(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Total estimated sponsor budget across all bid requests"
    - name: "avg_submitted_bid_amount"
      expr: AVG(CAST(submitted_bid_amount AS DOUBLE))
      comment: "Average submitted bid amount indicating deal size trends"
    - name: "total_sponsor_budget_ceiling"
      expr: SUM(CAST(sponsor_budget_ceiling AS DOUBLE))
      comment: "Total sponsor budget ceiling across bids, representing maximum addressable pipeline"
    - name: "bid_to_budget_ratio"
      expr: ROUND(SUM(CAST(submitted_bid_amount AS DOUBLE)) / NULLIF(SUM(CAST(estimated_budget_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of submitted bid amounts to estimated budgets, indicating pricing competitiveness"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`sponsor_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Proposal performance metrics tracking win rates, proposal values, and business development effectiveness."
  source: "`clinical_trials_ecm`.`sponsor`.`proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the proposal (e.g., Submitted, Won, Lost, Draft)"
    - name: "proposal_type"
      expr: proposal_type
      comment: "Type of proposal (e.g., full-service, functional, consulting)"
    - name: "phase"
      expr: phase
      comment: "Clinical trial phase for the proposed study"
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model used (e.g., unit-based, fixed-fee, time-and-materials)"
    - name: "is_competitive_bid"
      expr: is_competitive_bid
      comment: "Whether the proposal was submitted in a competitive bid scenario"
    - name: "is_rebid"
      expr: is_rebid
      comment: "Whether this is a rebid of a previously lost or expired proposal"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the proposal was submitted"
    - name: "submission_quarter"
      expr: CONCAT('Q', QUARTER(submission_date))
      comment: "Quarter the proposal was submitted"
  measures:
    - name: "total_proposals"
      expr: COUNT(1)
      comment: "Total number of proposals, indicating business development activity volume"
    - name: "total_proposed_budget_usd"
      expr: SUM(CAST(total_proposed_budget AS DOUBLE))
      comment: "Total proposed budget across all proposals representing potential revenue"
    - name: "avg_proposed_budget_usd"
      expr: AVG(CAST(total_proposed_budget AS DOUBLE))
      comment: "Average proposed budget per proposal indicating deal size"
    - name: "total_direct_cost"
      expr: SUM(CAST(direct_cost_total AS DOUBLE))
      comment: "Total direct costs across proposals for margin analysis"
    - name: "total_pass_through_cost"
      expr: SUM(CAST(pass_through_cost_total AS DOUBLE))
      comment: "Total pass-through costs across proposals"
    - name: "avg_win_probability_pct"
      expr: AVG(CAST(win_probability_pct AS DOUBLE))
      comment: "Average win probability indicating pipeline quality and confidence level"
    - name: "gross_margin_ratio"
      expr: ROUND((SUM(CAST(total_proposed_budget AS DOUBLE)) - SUM(CAST(direct_cost_total AS DOUBLE)) - SUM(CAST(pass_through_cost_total AS DOUBLE))) / NULLIF(SUM(CAST(total_proposed_budget AS DOUBLE)), 0), 4)
      comment: "Gross margin ratio on proposals indicating pricing health and profitability"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`sponsor_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sponsor engagement health metrics tracking relationship quality, revenue targets, and strategic account performance."
  source: "`clinical_trials_ecm`.`sponsor`.`sponsor_engagement`"
  dimensions:
    - name: "sponsor_engagement_status"
      expr: sponsor_engagement_status
      comment: "Current status of the sponsor engagement (Active, Inactive, Prospective)"
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of engagement (e.g., strategic, transactional, preferred provider)"
    - name: "strategic_account_tier"
      expr: strategic_account_tier
      comment: "Strategic tier classification of the account (e.g., Tier 1, Tier 2, Tier 3)"
    - name: "governance_cadence"
      expr: governance_cadence
      comment: "Frequency of governance meetings with the sponsor"
    - name: "preferred_provider_flag"
      expr: preferred_provider_flag
      comment: "Whether the CRO has preferred provider status with this sponsor"
    - name: "primary_geography"
      expr: primary_geography
      comment: "Primary geographic region of the engagement"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the engagement started"
  measures:
    - name: "total_engagements"
      expr: COUNT(1)
      comment: "Total number of sponsor engagements representing client portfolio breadth"
    - name: "total_annual_revenue_target_usd"
      expr: SUM(CAST(annual_revenue_target AS DOUBLE))
      comment: "Total annual revenue target across all engagements"
    - name: "total_contracted_value_usd"
      expr: SUM(CAST(total_contracted_value AS DOUBLE))
      comment: "Total contracted value across all engagements representing secured revenue"
    - name: "avg_relationship_health_score"
      expr: AVG(CAST(relationship_health_score AS DOUBLE))
      comment: "Average relationship health score indicating overall client satisfaction and retention risk"
    - name: "avg_sponsor_satisfaction_score"
      expr: AVG(CAST(sponsor_satisfaction_score AS DOUBLE))
      comment: "Average sponsor satisfaction score across engagements"
    - name: "total_pipeline_opportunity_value_usd"
      expr: SUM(CAST(pipeline_opportunity_value AS DOUBLE))
      comment: "Total pipeline opportunity value representing future revenue potential"
    - name: "revenue_target_attainment_ratio"
      expr: ROUND(SUM(CAST(total_contracted_value AS DOUBLE)) / NULLIF(SUM(CAST(annual_revenue_target AS DOUBLE)), 0), 4)
      comment: "Ratio of contracted value to revenue target indicating target attainment performance"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`sponsor_escalation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Escalation management metrics tracking issue resolution, severity patterns, and operational risk for sponsor relationships."
  source: "`clinical_trials_ecm`.`sponsor`.`escalation`"
  dimensions:
    - name: "escalation_status"
      expr: escalation_status
      comment: "Current status of the escalation (Open, In Progress, Resolved, Closed)"
    - name: "escalation_type"
      expr: escalation_type
      comment: "Category of escalation (e.g., quality, timeline, resource, compliance)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the escalation (Critical, High, Medium, Low)"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the escalation"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification for trend analysis and prevention"
    - name: "impacted_functional_area"
      expr: impacted_functional_area
      comment: "Functional area impacted by the escalation (e.g., data management, clinical ops)"
    - name: "is_regulatory_reportable"
      expr: is_regulatory_reportable
      comment: "Whether the escalation requires regulatory reporting"
    - name: "is_safety_related"
      expr: is_safety_related
      comment: "Whether the escalation is safety-related"
    - name: "escalation_year"
      expr: YEAR(escalation_date)
      comment: "Year the escalation was raised"
    - name: "escalation_quarter"
      expr: CONCAT('Q', QUARTER(escalation_date))
      comment: "Quarter the escalation was raised"
  measures:
    - name: "total_escalations"
      expr: COUNT(1)
      comment: "Total number of escalations indicating operational issue volume"
    - name: "total_financial_impact_usd"
      expr: SUM(CAST(financial_impact_usd AS DOUBLE))
      comment: "Total financial impact of escalations representing cost of quality failures"
    - name: "avg_financial_impact_usd"
      expr: AVG(CAST(financial_impact_usd AS DOUBLE))
      comment: "Average financial impact per escalation for severity benchmarking"
    - name: "recurring_escalation_count"
      expr: SUM(CASE WHEN recurrence_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of recurring escalations indicating systemic issues requiring CAPA"
    - name: "regulatory_reportable_count"
      expr: SUM(CASE WHEN is_regulatory_reportable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of regulatory-reportable escalations representing compliance risk"
    - name: "safety_related_count"
      expr: SUM(CASE WHEN is_safety_related = TRUE THEN 1 ELSE 0 END)
      comment: "Count of safety-related escalations requiring immediate attention"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`sponsor_pipeline_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pipeline asset metrics tracking sponsor drug development portfolio, regulatory designations, and development stage distribution."
  source: "`clinical_trials_ecm`.`sponsor`.`pipeline_asset`"
  dimensions:
    - name: "development_phase"
      expr: development_phase
      comment: "Current development phase of the asset (Preclinical, Phase I, II, III, Filed, Approved)"
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the pipeline asset (Active, Discontinued, Approved)"
    - name: "modality"
      expr: modality
      comment: "Drug modality (e.g., small molecule, biologic, gene therapy, cell therapy)"
    - name: "drug_class"
      expr: drug_class
      comment: "Pharmacological drug class"
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration (oral, IV, subcutaneous, etc.)"
    - name: "filing_status"
      expr: filing_status
      comment: "Regulatory filing status of the asset"
    - name: "primary_regulatory_authority"
      expr: primary_regulatory_authority
      comment: "Primary regulatory authority for the asset (FDA, EMA, PMDA, etc.)"
  measures:
    - name: "total_pipeline_assets"
      expr: COUNT(1)
      comment: "Total number of pipeline assets representing sponsor portfolio breadth"
    - name: "breakthrough_therapy_count"
      expr: SUM(CASE WHEN breakthrough_therapy_designation = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assets with breakthrough therapy designation indicating high-value opportunities"
    - name: "fast_track_count"
      expr: SUM(CASE WHEN fast_track_designation = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assets with fast track designation"
    - name: "orphan_drug_count"
      expr: SUM(CASE WHEN orphan_drug_designation = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assets with orphan drug designation representing rare disease portfolio"
    - name: "accelerated_approval_count"
      expr: SUM(CASE WHEN accelerated_approval = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assets on accelerated approval pathway"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`sponsor_pipeline_asset_phase`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pipeline asset phase transition metrics tracking development spend, enrollment performance, and phase progression decisions."
  source: "`clinical_trials_ecm`.`sponsor`.`pipeline_asset_phase`"
  dimensions:
    - name: "phase_status"
      expr: phase_status
      comment: "Current status of the phase (Active, Completed, Terminated, On Hold)"
    - name: "phase_name"
      expr: phase_name
      comment: "Name of the development phase"
    - name: "go_no_go_decision"
      expr: go_no_go_decision
      comment: "Go/No-Go decision outcome for phase transition"
    - name: "geography_scope"
      expr: geography_scope
      comment: "Geographic scope of the phase (Global, Regional, Single-country)"
    - name: "lead_regulatory_agency"
      expr: lead_regulatory_agency
      comment: "Lead regulatory agency for this phase"
    - name: "primary_endpoint_met"
      expr: primary_endpoint_met
      comment: "Whether the primary endpoint was met in this phase"
  measures:
    - name: "total_phase_records"
      expr: COUNT(1)
      comment: "Total number of phase records for portfolio tracking"
    - name: "total_phase_budget_usd"
      expr: SUM(CAST(phase_budget_usd AS DOUBLE))
      comment: "Total budgeted spend across all phases representing development investment"
    - name: "total_actual_spend_usd"
      expr: SUM(CAST(actual_spend_usd AS DOUBLE))
      comment: "Total actual spend across phases for budget variance analysis"
    - name: "avg_phase_budget_usd"
      expr: AVG(CAST(phase_budget_usd AS DOUBLE))
      comment: "Average phase budget for benchmarking and forecasting"
    - name: "budget_utilization_ratio"
      expr: ROUND(SUM(CAST(actual_spend_usd AS DOUBLE)) / NULLIF(SUM(CAST(phase_budget_usd AS DOUBLE)), 0), 4)
      comment: "Ratio of actual spend to budget indicating financial discipline and forecasting accuracy"
    - name: "endpoint_success_count"
      expr: SUM(CASE WHEN primary_endpoint_met = TRUE THEN 1 ELSE 0 END)
      comment: "Count of phases where primary endpoint was met indicating clinical success rate"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`sponsor_master_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Master agreement metrics tracking strategic partnership value, volume commitments, and contract portfolio health."
  source: "`clinical_trials_ecm`.`sponsor`.`master_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement (Active, Expired, Terminated, Pending)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of master agreement (MSA, PPA, Framework, etc.)"
    - name: "strategic_partnership_level"
      expr: strategic_partnership_level
      comment: "Strategic partnership tier level with the sponsor"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the agreement (Global, Regional, Country-specific)"
    - name: "volume_commitment_tier"
      expr: volume_commitment_tier
      comment: "Volume commitment tier classification"
    - name: "governing_law_country"
      expr: governing_law_country
      comment: "Country whose law governs the agreement"
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of master agreements representing strategic relationship portfolio"
    - name: "total_minimum_volume_commitment_usd"
      expr: SUM(CAST(minimum_volume_commitment_usd AS DOUBLE))
      comment: "Total minimum volume commitments representing guaranteed revenue floor"
    - name: "total_indemnification_cap_usd"
      expr: SUM(CAST(indemnification_cap_usd AS DOUBLE))
      comment: "Total indemnification cap exposure across agreements"
    - name: "avg_preferred_pricing_discount_pct"
      expr: AVG(CAST(preferred_pricing_discount_pct AS DOUBLE))
      comment: "Average preferred pricing discount indicating competitive positioning and margin pressure"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`sponsor_proposal_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Proposal line-level metrics tracking service mix, pricing, and resource allocation across proposals."
  source: "`clinical_trials_ecm`.`sponsor`.`proposal_line`"
  dimensions:
    - name: "service_category"
      expr: service_category
      comment: "Service category (e.g., clinical monitoring, data management, biostatistics)"
    - name: "service_subcategory"
      expr: service_subcategory
      comment: "Service subcategory for granular service mix analysis"
    - name: "cost_type"
      expr: cost_type
      comment: "Cost type classification (direct, pass-through, overhead)"
    - name: "line_status"
      expr: line_status
      comment: "Status of the proposal line item"
    - name: "region"
      expr: region
      comment: "Geographic region for the line item"
    - name: "is_optional"
      expr: is_optional
      comment: "Whether the line item is optional or core scope"
    - name: "resource_type"
      expr: resource_type
      comment: "Type of resource allocated (e.g., CRA, DM, Biostatistician)"
  measures:
    - name: "total_line_items"
      expr: COUNT(1)
      comment: "Total number of proposal line items for scope complexity analysis"
    - name: "total_line_amount_usd"
      expr: SUM(CAST(total_line_amount AS DOUBLE))
      comment: "Total value across all proposal line items"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across line items for rate benchmarking"
    - name: "total_estimated_quantity"
      expr: SUM(CAST(estimated_quantity AS DOUBLE))
      comment: "Total estimated quantity of units across line items"
    - name: "avg_discount_pct"
      expr: AVG(CAST(discount_pct AS DOUBLE))
      comment: "Average discount percentage indicating pricing pressure from sponsors"
    - name: "effective_rate_per_unit"
      expr: ROUND(SUM(CAST(total_line_amount AS DOUBLE)) / NULLIF(SUM(CAST(estimated_quantity AS DOUBLE)), 0), 2)
      comment: "Effective blended rate per unit across line items for pricing analysis"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`sponsor_account_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Account plan metrics tracking strategic account revenue targets, satisfaction, and growth planning."
  source: "`clinical_trials_ecm`.`sponsor`.`account_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the account plan (Active, Draft, Expired, Approved)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of account plan (Strategic, Tactical, Growth)"
    - name: "account_tier"
      expr: account_tier
      comment: "Account tier classification for strategic prioritization"
    - name: "plan_year"
      expr: plan_year
      comment: "Planning year for the account plan"
    - name: "preferred_provider_status"
      expr: preferred_provider_status
      comment: "Preferred provider status with the sponsor"
  measures:
    - name: "total_account_plans"
      expr: COUNT(1)
      comment: "Total number of account plans representing strategic planning coverage"
    - name: "total_revenue_target_usd"
      expr: SUM(CAST(revenue_target_usd AS DOUBLE))
      comment: "Total revenue target across all account plans"
    - name: "total_pipeline_opportunity_value_usd"
      expr: SUM(CAST(pipeline_opportunity_value_usd AS DOUBLE))
      comment: "Total pipeline opportunity value representing growth potential"
    - name: "avg_sponsor_satisfaction_score"
      expr: AVG(CAST(sponsor_satisfaction_score AS DOUBLE))
      comment: "Average sponsor satisfaction score across account plans indicating relationship health"
    - name: "pipeline_to_target_ratio"
      expr: ROUND(SUM(CAST(pipeline_opportunity_value_usd AS DOUBLE)) / NULLIF(SUM(CAST(revenue_target_usd AS DOUBLE)), 0), 4)
      comment: "Ratio of pipeline value to revenue target indicating growth coverage and plan achievability"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`sponsor_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sponsor interaction metrics tracking engagement frequency, governance compliance, and relationship touchpoint quality."
  source: "`clinical_trials_ecm`.`sponsor`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of interaction (e.g., governance meeting, ad-hoc call, site visit)"
    - name: "interaction_status"
      expr: interaction_status
      comment: "Status of the interaction (Completed, Scheduled, Cancelled)"
    - name: "governance_tier"
      expr: governance_tier
      comment: "Governance tier level of the interaction (Executive, Operational, Project)"
    - name: "channel"
      expr: channel
      comment: "Communication channel (In-person, Virtual, Phone, Email)"
    - name: "cadence_compliant"
      expr: cadence_compliant
      comment: "Whether the interaction met the required governance cadence"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether an escalation was raised during the interaction"
    - name: "interaction_year"
      expr: YEAR(interaction_date)
      comment: "Year of the interaction"
    - name: "interaction_quarter"
      expr: CONCAT('Q', QUARTER(interaction_date))
      comment: "Quarter of the interaction"
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total number of sponsor interactions indicating engagement intensity"
    - name: "cadence_compliant_count"
      expr: SUM(CASE WHEN cadence_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of interactions that met governance cadence requirements"
    - name: "escalation_raised_count"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of interactions where escalations were raised indicating relationship friction"
    - name: "follow_up_required_count"
      expr: SUM(CASE WHEN follow_up_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of interactions requiring follow-up indicating action density"
$$;