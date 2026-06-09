-- Metric views for domain: claim | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 19:31:38

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`claim_cargo_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core cargo claim metrics tracking claim volumes, financial exposure, settlement efficiency, and recovery performance for the transport shipping claims domain."
  source: "`transport_shipping_ecm`.`claim`.`cargo_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the cargo claim (e.g., Open, Under Review, Settled, Closed, Rejected)"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of cargo claim (e.g., Damage, Loss, Shortage, Delay)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (Air, Sea, Road, Rail) for segmenting claims by logistics channel"
    - name: "liability_determination"
      expr: liability_determination
      comment: "Outcome of liability assessment (e.g., Carrier Liable, Shipper Liable, Shared)"
    - name: "liability_convention"
      expr: liability_convention
      comment: "International liability convention applied (e.g., Montreal, Hague-Visby, CMR, Warsaw)"
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of origin for geographic claim analysis"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Country of destination for geographic claim analysis"
    - name: "incident_country_code"
      expr: incident_country_code
      comment: "Country where the cargo incident occurred"
    - name: "subrogation_status"
      expr: subrogation_status
      comment: "Status of subrogation recovery efforts against third parties"
    - name: "is_dangerous_goods"
      expr: is_dangerous_goods
      comment: "Flag indicating whether the claim involves dangerous goods cargo"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the claim amounts for financial reporting segmentation"
    - name: "incident_month"
      expr: DATE_TRUNC('month', incident_date)
      comment: "Month of the cargo incident for time-series trending"
    - name: "registration_month"
      expr: DATE_TRUNC('month', registration_timestamp)
      comment: "Month when the claim was registered for intake volume trending"
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of cargo claims filed — baseline volume indicator for claims operations"
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total value of all amounts claimed by claimants — represents gross financial exposure"
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total value of approved claim amounts — represents validated financial liability"
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total value of settled claims — actual financial outflow for claim resolution"
    - name: "total_subrogation_recovery"
      expr: SUM(CAST(subrogation_recovery_amount AS DOUBLE))
      comment: "Total recovered through subrogation — offsets claim costs via third-party recovery"
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductibles applied — portion of claims borne by the policyholder"
    - name: "avg_claimed_amount"
      expr: AVG(CAST(claimed_amount AS DOUBLE))
      comment: "Average claim value — indicates severity trend and helps set reserve benchmarks"
    - name: "avg_settlement_amount"
      expr: AVG(CAST(settlement_amount AS DOUBLE))
      comment: "Average settlement value per claim — key efficiency metric for claims adjusters"
    - name: "settlement_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(settlement_amount AS DOUBLE)) / NULLIF(SUM(CAST(claimed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of claimed amount actually settled — measures negotiation effectiveness and liability containment"
    - name: "approval_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(approved_amount AS DOUBLE)) / NULLIF(SUM(CAST(claimed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of claimed amount approved — indicates claim validity rate and adjudication rigor"
    - name: "net_claim_cost"
      expr: SUM((CAST(settlement_amount AS DOUBLE)) - (CAST(subrogation_recovery_amount AS DOUBLE)))
      comment: "Net financial impact after subrogation recoveries — true cost of claims to the business"
    - name: "total_finance_reserve"
      expr: SUM(CAST(finance_reserve_amount AS DOUBLE))
      comment: "Total financial reserves held for outstanding claims — key balance sheet and solvency indicator"
    - name: "dangerous_goods_claim_count"
      expr: COUNT(CASE WHEN is_dangerous_goods = true THEN 1 END)
      comment: "Number of claims involving dangerous goods — regulatory risk and safety compliance indicator"
    - name: "avg_claimed_weight_kg"
      expr: AVG(CAST(claimed_weight_kg AS DOUBLE))
      comment: "Average weight of cargo in claims — helps identify whether heavier shipments correlate with higher claim rates"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`claim_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Settlement performance metrics tracking payment efficiency, financial accuracy, and resolution speed for cargo claim settlements."
  source: "`transport_shipping_ecm`.`claim`.`settlement`"
  dimensions:
    - name: "settlement_status"
      expr: settlement_status
      comment: "Current status of the settlement (e.g., Pending, Approved, Paid, Disputed)"
    - name: "settlement_type"
      expr: settlement_type
      comment: "Type of settlement (e.g., Full, Partial, Ex-Gratia, Without Prejudice)"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of underlying claim for settlement segmentation"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode associated with the settled claim"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of settlement payment (e.g., Bank Transfer, Credit Note, Offset)"
    - name: "acceptance_status"
      expr: acceptance_status
      comment: "Whether the claimant accepted or disputed the settlement offer"
    - name: "currency"
      expr: currency
      comment: "Settlement currency for financial reporting"
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Whether the settlement relates to a dangerous goods claim"
    - name: "subrogation_initiated_flag"
      expr: subrogation_initiated_flag
      comment: "Whether subrogation recovery has been initiated post-settlement"
    - name: "settlement_month"
      expr: DATE_TRUNC('month', settlement_date)
      comment: "Month of settlement for time-series financial reporting"
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of actual payment for cash flow analysis"
  measures:
    - name: "total_settlements"
      expr: COUNT(1)
      comment: "Total number of settlements processed — operational throughput indicator"
    - name: "total_settlement_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross settlement amount paid — primary financial outflow metric"
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net settlement after deductibles and recoveries — true cost to the business"
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total originally claimed amounts for settlements — basis for settlement efficiency calculation"
    - name: "total_deductible_applied"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductibles applied across settlements — policyholder cost share"
    - name: "total_insurer_recovery"
      expr: SUM(CAST(insurer_recovery_amount AS DOUBLE))
      comment: "Total amounts recovered from insurers — reduces net exposure"
    - name: "total_subrogation_amount"
      expr: SUM(CAST(subrogation_amount AS DOUBLE))
      comment: "Total subrogation amounts pursued post-settlement — recovery pipeline value"
    - name: "total_reserve_released"
      expr: SUM(CAST(reserve_release_amount AS DOUBLE))
      comment: "Total reserves released upon settlement — frees capital back to the business"
    - name: "avg_settlement_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average settlement value — benchmark for adjuster performance and claim severity"
    - name: "settlement_to_claimed_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(amount AS DOUBLE)) / NULLIF(SUM(CAST(claimed_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of settled to claimed amounts — measures negotiation effectiveness and liability containment"
    - name: "net_to_gross_settlement_pct"
      expr: ROUND(100.0 * SUM(CAST(net_settlement_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Net settlement as percentage of gross — shows effectiveness of deductibles and recoveries in reducing outflow"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`claim_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial reserve metrics for claims provisioning, adequacy monitoring, and balance sheet impact assessment."
  source: "`transport_shipping_ecm`.`claim`.`reserve`"
  dimensions:
    - name: "reserve_status"
      expr: reserve_status
      comment: "Current status of the reserve (e.g., Active, Released, Adjusted)"
    - name: "reserve_type"
      expr: reserve_type
      comment: "Type of reserve (e.g., Indemnity, Legal Costs, Subrogation)"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of underlying claim for reserve segmentation"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for operational segmentation of reserves"
    - name: "currency"
      expr: currency
      comment: "Reserve currency for financial reporting"
    - name: "liability_convention"
      expr: liability_convention
      comment: "Applicable liability convention governing the reserve calculation"
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Whether the reserve relates to a dangerous goods incident"
    - name: "subrogation_potential"
      expr: subrogation_potential
      comment: "Whether there is potential for subrogation recovery to offset the reserve"
    - name: "insurer_notified"
      expr: insurer_notified
      comment: "Whether the insurer has been notified of the reserve — compliance indicator"
    - name: "establishment_month"
      expr: DATE_TRUNC('month', establishment_date)
      comment: "Month when reserve was established for aging analysis"
  measures:
    - name: "total_reserves"
      expr: COUNT(1)
      comment: "Total number of active reserve records — portfolio size indicator"
    - name: "total_current_reserve_amount"
      expr: SUM(CAST(current_reserve_amount AS DOUBLE))
      comment: "Total current reserve balance — key balance sheet liability and solvency metric"
    - name: "total_initial_reserve_amount"
      expr: SUM(CAST(initial_reserve_amount AS DOUBLE))
      comment: "Total initial reserves set — baseline for reserve development analysis"
    - name: "total_adjustments_amount"
      expr: SUM(CAST(total_adjustments_amount AS DOUBLE))
      comment: "Total cumulative adjustments to reserves — indicates estimation accuracy over time"
    - name: "total_released_amount"
      expr: SUM(CAST(release_amount AS DOUBLE))
      comment: "Total reserves released — capital freed upon claim closure or favorable development"
    - name: "total_subrogation_recovery"
      expr: SUM(CAST(subrogation_recovery_amount AS DOUBLE))
      comment: "Total subrogation recoveries applied against reserves"
    - name: "avg_current_reserve"
      expr: AVG(CAST(current_reserve_amount AS DOUBLE))
      comment: "Average reserve per claim — severity benchmark for actuarial analysis"
    - name: "reserve_development_ratio"
      expr: ROUND(SUM(CAST(current_reserve_amount AS DOUBLE)) / NULLIF(SUM(CAST(initial_reserve_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of current to initial reserves — values >1 indicate adverse development (under-reserving), <1 indicate favorable development"
    - name: "total_liability_limit_exposure"
      expr: SUM(CAST(liability_limit_amount AS DOUBLE))
      comment: "Total liability limit exposure across all reserves — maximum potential financial impact"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`claim_subrogation_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subrogation recovery performance metrics tracking recovery rates, legal costs, and third-party claim pursuit effectiveness."
  source: "`transport_shipping_ecm`.`claim`.`subrogation_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the subrogation case (e.g., Open, Demand Sent, In Litigation, Settled, Closed)"
    - name: "case_type"
      expr: case_type
      comment: "Type of subrogation case (e.g., Carrier Recovery, Insurer Recovery, Third Party)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for segmenting recovery performance by logistics channel"
    - name: "liability_convention"
      expr: liability_convention
      comment: "Applicable liability convention governing the subrogation claim"
    - name: "respondent_party_type"
      expr: respondent_party_type
      comment: "Type of party being pursued for recovery (e.g., Carrier, Warehouse, Subcontractor)"
    - name: "loss_event_country_code"
      expr: loss_event_country_code
      comment: "Country where the loss event occurred — jurisdictional analysis"
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Whether the subrogation involves dangerous goods — regulatory complexity indicator"
    - name: "closure_reason"
      expr: closure_reason
      comment: "Reason for case closure (e.g., Recovered, Statute Barred, Uneconomical, Settled)"
    - name: "opened_month"
      expr: DATE_TRUNC('month', opened_date)
      comment: "Month case was opened for pipeline trending"
  measures:
    - name: "total_subrogation_cases"
      expr: COUNT(1)
      comment: "Total number of subrogation cases — recovery pipeline volume"
    - name: "total_recovery_sought"
      expr: SUM(CAST(recovery_amount_sought AS DOUBLE))
      comment: "Total amount being pursued through subrogation — gross recovery pipeline value"
    - name: "total_recovery_received"
      expr: SUM(CAST(recovery_amount_received AS DOUBLE))
      comment: "Total amount actually recovered — realized financial benefit from subrogation efforts"
    - name: "total_legal_costs"
      expr: SUM(CAST(legal_costs_incurred AS DOUBLE))
      comment: "Total legal costs incurred in pursuing subrogation — cost of recovery efforts"
    - name: "net_recovery_value"
      expr: SUM((CAST(recovery_amount_received AS DOUBLE)) - (CAST(legal_costs_incurred AS DOUBLE)))
      comment: "Net recovery after legal costs — true economic benefit of subrogation program"
    - name: "recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(recovery_amount_received AS DOUBLE)) / NULLIF(SUM(CAST(recovery_amount_sought AS DOUBLE)), 0), 2)
      comment: "Percentage of sought amount actually recovered — key effectiveness metric for the subrogation team"
    - name: "avg_recovery_amount"
      expr: AVG(CAST(recovery_amount_received AS DOUBLE))
      comment: "Average recovery per case — benchmark for case prioritization and resource allocation"
    - name: "total_reserve_held"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total reserves held for open subrogation cases — expected future recovery value"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`claim_liability_determination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Liability determination metrics tracking assessment outcomes, liability allocation, and dispute patterns across transport modes and conventions."
  source: "`transport_shipping_ecm`.`claim`.`liability_determination`"
  dimensions:
    - name: "determination_status"
      expr: determination_status
      comment: "Status of the liability determination (e.g., Pending, Completed, Disputed, Overturned)"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim being assessed for liability"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode — different conventions and liability limits apply per mode"
    - name: "liability_convention"
      expr: liability_convention
      comment: "International convention applied (Montreal, Hague-Visby, CMR, Warsaw)"
    - name: "liability_basis"
      expr: liability_basis
      comment: "Legal basis for liability (e.g., Strict, Fault-based, Presumed)"
    - name: "liability_exclusion_type"
      expr: liability_exclusion_type
      comment: "Type of exclusion applied (e.g., Force Majeure, Inherent Vice, Packaging Defect)"
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms governing the shipment — affects risk transfer point"
    - name: "subrogation_flag"
      expr: subrogation_flag
      comment: "Whether subrogation is applicable based on the determination"
    - name: "contributory_negligence_flag"
      expr: contributory_negligence_flag
      comment: "Whether contributory negligence was found — affects liability split"
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Whether dangerous goods are involved — stricter liability regimes apply"
    - name: "determination_month"
      expr: DATE_TRUNC('month', determination_date)
      comment: "Month of determination for trending analysis"
  measures:
    - name: "total_determinations"
      expr: COUNT(1)
      comment: "Total liability determinations completed — operational throughput of the liability team"
    - name: "total_maximum_liability"
      expr: SUM(CAST(maximum_liability_amount AS DOUBLE))
      comment: "Total maximum liability exposure across all determinations — worst-case financial impact"
    - name: "total_settlement_recommendation"
      expr: SUM(CAST(settlement_recommendation_amount AS DOUBLE))
      comment: "Total recommended settlement amounts — expected financial outflow from liability assessments"
    - name: "total_subrogation_amount"
      expr: SUM(CAST(subrogation_amount AS DOUBLE))
      comment: "Total subrogation amounts identified — recovery opportunity pipeline"
    - name: "avg_carrier_liability_pct"
      expr: AVG(CAST(carrier_liability_pct AS DOUBLE))
      comment: "Average carrier liability percentage — indicates how often carriers bear primary responsibility"
    - name: "avg_shipper_liability_pct"
      expr: AVG(CAST(shipper_liability_pct AS DOUBLE))
      comment: "Average shipper liability percentage — indicates shipper-side fault patterns"
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total reserves set based on liability determinations — financial provisioning requirement"
    - name: "disputed_determination_count"
      expr: COUNT(CASE WHEN dispute_raised_date IS NOT NULL THEN 1 END)
      comment: "Number of determinations that were disputed — quality indicator for the liability assessment process"
    - name: "contributory_negligence_count"
      expr: COUNT(CASE WHEN contributory_negligence_flag = true THEN 1 END)
      comment: "Number of cases with contributory negligence — indicates shared-fault patterns requiring process improvement"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`claim_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appeal metrics tracking escalation volumes, outcomes, financial impact of appeals, and SLA compliance for the claims dispute resolution process."
  source: "`transport_shipping_ecm`.`claim`.`appeal`"
  dimensions:
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal (e.g., Filed, Under Review, Upheld, Overturned, Withdrawn)"
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal (e.g., Liability, Quantum, Rejection, Partial Settlement)"
    - name: "review_outcome"
      expr: review_outcome
      comment: "Outcome of the appeal review (e.g., Upheld, Overturned, Partially Upheld)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for segmenting appeal patterns by logistics channel"
    - name: "liability_convention"
      expr: liability_convention
      comment: "Applicable liability convention for the appealed claim"
    - name: "priority"
      expr: priority
      comment: "Priority level of the appeal for workload management"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the appeal has been escalated beyond normal process"
    - name: "sla_breached_flag"
      expr: sla_breached_flag
      comment: "Whether the SLA for appeal resolution has been breached"
    - name: "original_claim_decision"
      expr: original_claim_decision
      comment: "The original claim decision being appealed"
    - name: "appeal_month"
      expr: DATE_TRUNC('month', appeal_date)
      comment: "Month of appeal filing for volume trending"
  measures:
    - name: "total_appeals"
      expr: COUNT(1)
      comment: "Total number of appeals filed — indicates claimant dissatisfaction and process quality issues"
    - name: "total_claimed_appeal_amount"
      expr: SUM(CAST(claimed_appeal_amount AS DOUBLE))
      comment: "Total financial value at stake in appeals — potential additional liability exposure"
    - name: "total_revised_settlement_amount"
      expr: SUM(CAST(revised_settlement_amount AS DOUBLE))
      comment: "Total revised settlement amounts after appeal — additional cost from overturned decisions"
    - name: "avg_appeal_amount"
      expr: AVG(CAST(claimed_appeal_amount AS DOUBLE))
      comment: "Average appeal value — indicates severity of disputed decisions"
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breached_flag = true THEN 1 END)
      comment: "Number of appeals with SLA breaches — operational compliance and resource adequacy indicator"
    - name: "escalated_appeal_count"
      expr: COUNT(CASE WHEN escalation_flag = true THEN 1 END)
      comment: "Number of escalated appeals — indicates cases requiring senior management intervention"
    - name: "total_finance_reserve"
      expr: SUM(CAST(finance_reserve_amount AS DOUBLE))
      comment: "Total financial reserves held for pending appeals — contingent liability on balance sheet"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`claim_recovery_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recovery action metrics tracking the effectiveness and financial performance of claim recovery efforts including subrogation, salvage, and third-party recoveries."
  source: "`transport_shipping_ecm`.`claim`.`recovery_action`"
  dimensions:
    - name: "action_status"
      expr: action_status
      comment: "Current status of the recovery action (e.g., Initiated, In Progress, Completed, Abandoned)"
    - name: "action_type"
      expr: action_type
      comment: "Type of recovery action (e.g., Demand Letter, Arbitration, Litigation, Negotiation)"
    - name: "action_outcome"
      expr: action_outcome
      comment: "Outcome of the recovery action (e.g., Full Recovery, Partial Recovery, Failed, Settled)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for segmenting recovery performance"
    - name: "liability_convention"
      expr: liability_convention
      comment: "Applicable liability convention governing the recovery"
    - name: "liable_party_type"
      expr: liable_party_type
      comment: "Type of party being pursued (e.g., Carrier, Warehouse, Subcontractor)"
    - name: "loss_type"
      expr: loss_type
      comment: "Type of loss being recovered (e.g., Damage, Shortage, Delay, Total Loss)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority of the recovery action for resource allocation"
    - name: "jurisdiction_country"
      expr: jurisdiction_country
      comment: "Country of jurisdiction for legal recovery actions"
    - name: "action_month"
      expr: DATE_TRUNC('month', action_date)
      comment: "Month of recovery action for pipeline trending"
  measures:
    - name: "total_recovery_actions"
      expr: COUNT(1)
      comment: "Total number of recovery actions initiated — recovery team workload indicator"
    - name: "total_demanded_amount"
      expr: SUM(CAST(demanded_amount AS DOUBLE))
      comment: "Total amounts demanded from liable parties — gross recovery pipeline"
    - name: "total_recovered_amount"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Total amounts actually recovered — realized financial benefit"
    - name: "total_net_recovery"
      expr: SUM(CAST(net_recovery_amount AS DOUBLE))
      comment: "Total net recovery after costs — true economic value of recovery efforts"
    - name: "total_legal_costs"
      expr: SUM(CAST(legal_costs AS DOUBLE))
      comment: "Total legal costs incurred in recovery actions — cost of pursuing recoveries"
    - name: "recovery_success_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(recovered_amount AS DOUBLE)) / NULLIF(SUM(CAST(demanded_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of demanded amounts recovered — key effectiveness metric for recovery operations"
    - name: "avg_net_recovery"
      expr: AVG(CAST(net_recovery_amount AS DOUBLE))
      comment: "Average net recovery per action — helps prioritize which actions are worth pursuing"
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total reserves held for pending recovery actions — expected future inflows"
    - name: "escalated_action_count"
      expr: COUNT(CASE WHEN escalation_flag = true THEN 1 END)
      comment: "Number of escalated recovery actions — indicates complex or high-value cases requiring senior attention"
$$;