-- Metric views for domain: contract | Business: Legal | Version: 1 | Generated on: 2026-05-07 14:29:57

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core contract portfolio metrics covering contract value, lifecycle status, compliance posture, and renewal exposure. Used by General Counsel, CFO, and Chief Risk Officer to steer contract strategy, monitor financial exposure, and ensure regulatory compliance across the agreement portfolio."
  source: "`legal_ecm`.`contract`.`agreement`"
  dimensions:
    - name: "agreement_type_category"
      expr: agreement_type_id
      comment: "Foreign key to agreement type — used to slice portfolio by agreement type bucket (e.g. MSA, NDA, SOW). BI layer resolves label via agreement_type dimension table."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current lifecycle status of the agreement (e.g. Draft, Active, Expired, Terminated). Primary filter for active portfolio analysis."
    - name: "counterparty_type"
      expr: counterparty_type
      comment: "Classification of the counterparty (e.g. Client, Vendor, Partner, Government). Enables portfolio segmentation by relationship type."
    - name: "governing_law"
      expr: governing_law
      comment: "Jurisdiction whose law governs the agreement. Used for cross-border risk and regulatory exposure analysis."
    - name: "originating_office"
      expr: originating_office
      comment: "Office or practice group that originated the agreement. Enables regional and practice-level portfolio reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the contract value is denominated. Required for multi-currency portfolio aggregation."
    - name: "confidentiality_classification"
      expr: confidentiality_classification
      comment: "Sensitivity classification of the agreement (e.g. Confidential, Restricted, Public). Used for information governance reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval workflow status. Identifies agreements pending sign-off and bottlenecks in the approval pipeline."
    - name: "dispute_resolution_method"
      expr: dispute_resolution_method
      comment: "Contractually agreed dispute resolution mechanism (e.g. Arbitration, Litigation, Mediation). Used for dispute risk profiling."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the agreement auto-renews. Critical for identifying contracts requiring proactive cancellation decisions."
    - name: "gdpr_compliant_flag"
      expr: gdpr_compliant_flag
      comment: "Indicates GDPR compliance status of the agreement. Used for data privacy regulatory reporting."
    - name: "lpp_flag"
      expr: lpp_flag
      comment: "Legal professional privilege flag. Identifies privileged agreements requiring heightened access controls."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the agreement became effective. Enables cohort analysis of contract vintages."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the agreement expires. Used for renewal pipeline and expiry cliff analysis."
  measures:
    - name: "total_active_agreements"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN agreement_id END)
      comment: "Count of currently active agreements. Baseline KPI for portfolio size and capacity planning."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total monetary value of all agreements in scope. Primary financial exposure metric for CFO and General Counsel portfolio reviews."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value per agreement. Benchmarks deal size and identifies outliers requiring enhanced oversight."
    - name: "total_active_contract_value"
      expr: SUM(CASE WHEN agreement_status = 'Active' THEN CAST(contract_value AS DOUBLE) ELSE 0 END)
      comment: "Total contract value of active agreements only. Represents live financial exposure on the books."
    - name: "auto_renewal_exposure_value"
      expr: SUM(CASE WHEN auto_renewal_flag = TRUE THEN CAST(contract_value AS DOUBLE) ELSE 0 END)
      comment: "Total contract value at risk of auto-renewal. Enables proactive cancellation decisions before notice deadlines."
    - name: "auto_renewal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_renewal_flag = TRUE THEN agreement_id END) / NULLIF(COUNT(agreement_id), 0), 2)
      comment: "Percentage of agreements with auto-renewal enabled. High rates signal renewal management risk and potential unintended commitments."
    - name: "gdpr_non_compliant_agreement_count"
      expr: COUNT(CASE WHEN gdpr_compliant_flag = FALSE THEN agreement_id END)
      comment: "Number of agreements not marked GDPR compliant. Directly informs regulatory remediation prioritisation and DPO reporting."
    - name: "gdpr_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gdpr_compliant_flag = TRUE THEN agreement_id END) / NULLIF(COUNT(agreement_id), 0), 2)
      comment: "Percentage of agreements flagged as GDPR compliant. Key data privacy governance KPI for the DPO and General Counsel."
    - name: "pending_approval_agreement_count"
      expr: COUNT(CASE WHEN approval_status NOT IN ('Approved', 'Executed') THEN agreement_id END)
      comment: "Number of agreements awaiting approval. Identifies bottlenecks in the contract execution pipeline affecting deal velocity."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN agreement_id END)
      comment: "Agreements expiring within the next 90 days. Critical renewal pipeline metric for proactive client retention and renegotiation."
    - name: "expiring_within_90_days_value"
      expr: SUM(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN CAST(contract_value AS DOUBLE) ELSE 0 END)
      comment: "Total contract value expiring within 90 days. Quantifies near-term revenue renewal risk for executive decision-making."
    - name: "aml_kyc_verified_agreement_count"
      expr: COUNT(CASE WHEN aml_kyc_verified_flag = TRUE THEN agreement_id END)
      comment: "Number of agreements with AML/KYC verification completed. Compliance KPI for anti-money laundering program governance."
    - name: "aml_kyc_verification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN aml_kyc_verified_flag = TRUE THEN agreement_id END) / NULLIF(COUNT(agreement_id), 0), 2)
      comment: "Percentage of agreements with AML/KYC verification. Regulatory compliance rate reported to compliance officers and regulators."
    - name: "avg_days_to_execution"
      expr: AVG(CAST(DATEDIFF(execution_date, effective_date) AS DOUBLE))
      comment: "Average number of days between effective date and execution date. Measures contract execution velocity and identifies process inefficiencies."
    - name: "indemnity_clause_agreement_count"
      expr: COUNT(CASE WHEN indemnity_clause_flag = TRUE THEN agreement_id END)
      comment: "Number of agreements containing indemnity clauses. Risk exposure metric for the General Counsel and risk management function."
    - name: "limitation_of_liability_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN limitation_of_liability_flag = TRUE THEN agreement_id END) / NULLIF(COUNT(agreement_id), 0), 2)
      comment: "Percentage of agreements with limitation of liability clauses. Measures risk mitigation coverage across the contract portfolio."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Amendment activity metrics tracking contract change frequency, financial impact of modifications, and execution health. Used by contract managers and General Counsel to monitor contract instability, renegotiation costs, and amendment pipeline efficiency."
  source: "`legal_ecm`.`contract`.`amendment`"
  dimensions:
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (e.g. Scope Change, Price Adjustment, Term Extension). Categorises the nature of contract modifications."
    - name: "execution_status"
      expr: execution_status
      comment: "Current execution status of the amendment. Identifies amendments pending execution and pipeline bottlenecks."
    - name: "governing_law"
      expr: governing_law
      comment: "Governing law jurisdiction of the amendment. Used for cross-border modification risk analysis."
    - name: "financial_impact_currency"
      expr: financial_impact_currency
      comment: "Currency of the financial impact amount. Required for multi-currency amendment impact aggregation."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Indicates whether the amendment requires formal approval. Used to track governance compliance in the amendment process."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the amendment is currently active. Filters out superseded or withdrawn amendments."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the amendment became effective. Enables trend analysis of contract modification activity over time."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Sensitivity classification of the amendment. Used for information governance and access control reporting."
  measures:
    - name: "total_amendments"
      expr: COUNT(amendment_id)
      comment: "Total number of amendments processed. Baseline measure of contract modification volume and portfolio instability."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of all amendments. Quantifies the cumulative cost of contract renegotiations for CFO and contract management."
    - name: "avg_financial_impact_per_amendment"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per amendment. Benchmarks the cost of contract changes and identifies high-impact modification patterns."
    - name: "positive_financial_impact_total"
      expr: SUM(CASE WHEN financial_impact_amount > 0 THEN CAST(financial_impact_amount AS DOUBLE) ELSE 0 END)
      comment: "Total positive financial impact from amendments (value-adding modifications). Measures revenue uplift from contract renegotiations."
    - name: "negative_financial_impact_total"
      expr: SUM(CASE WHEN financial_impact_amount < 0 THEN CAST(financial_impact_amount AS DOUBLE) ELSE 0 END)
      comment: "Total negative financial impact from amendments (value-reducing modifications). Quantifies concession costs and discount exposure."
    - name: "pending_execution_amendment_count"
      expr: COUNT(CASE WHEN execution_status NOT IN ('Executed', 'Completed') THEN amendment_id END)
      comment: "Number of amendments pending execution. Identifies backlog in the amendment pipeline affecting contract certainty."
    - name: "approval_required_amendment_count"
      expr: COUNT(CASE WHEN approval_required_flag = TRUE THEN amendment_id END)
      comment: "Number of amendments requiring formal approval. Governance metric for tracking compliance with amendment approval policies."
    - name: "avg_term_extension_months"
      expr: AVG(CAST(term_extension_months AS DOUBLE))
      comment: "Average term extension granted per amendment. Measures the extent to which contracts are being extended beyond original terms."
    - name: "distinct_agreements_amended"
      expr: COUNT(DISTINCT agreement_id)
      comment: "Number of distinct agreements that have been amended. Measures breadth of contract instability across the portfolio."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract obligation performance metrics tracking fulfillment rates, financial exposure from obligations, breach risk, and regulatory compliance. Used by contract managers, compliance officers, and General Counsel to monitor obligation health and prevent costly breaches."
  source: "`legal_ecm`.`contract`.`obligation`"
  dimensions:
    - name: "obligation_category"
      expr: obligation_category
      comment: "High-level category of the obligation (e.g. Payment, Delivery, Reporting, Confidentiality). Primary grouping for obligation portfolio analysis."
    - name: "subcategory"
      expr: subcategory
      comment: "Detailed sub-classification of the obligation. Enables granular obligation type analysis within categories."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current fulfillment status of the obligation (e.g. Pending, In Progress, Fulfilled, Breached). Primary KPI filter for obligation health monitoring."
    - name: "priority"
      expr: priority
      comment: "Priority level of the obligation. Used to triage high-risk obligations requiring immediate attention."
    - name: "regulatory_obligation_flag"
      expr: regulatory_obligation_flag
      comment: "Indicates whether the obligation has a regulatory basis. Separates regulatory from commercial obligations for compliance reporting."
    - name: "condition_precedent_flag"
      expr: condition_precedent_flag
      comment: "Indicates whether the obligation is a condition precedent. Critical for deal closing and transaction management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the monetary obligation value. Required for multi-currency financial exposure aggregation."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the obligation (e.g. GDPR, SOX, AML). Used for regulatory compliance portfolio reporting."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the obligation is currently active. Filters out fulfilled or cancelled obligations."
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year the obligation is due. Enables forward-looking obligation maturity and workload planning."
  measures:
    - name: "total_obligations"
      expr: COUNT(obligation_id)
      comment: "Total number of obligations tracked. Baseline measure of contractual commitment volume."
    - name: "total_monetary_obligation_value"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total monetary value of all obligations. Quantifies aggregate financial commitment exposure across the contract portfolio."
    - name: "avg_fulfillment_percentage"
      expr: AVG(CAST(fulfillment_percentage AS DOUBLE))
      comment: "Average fulfillment percentage across all obligations. Measures overall obligation performance and delivery health."
    - name: "unfulfilled_obligation_value"
      expr: SUM(CASE WHEN fulfillment_status NOT IN ('Fulfilled', 'Completed', 'Waived') THEN CAST(monetary_value AS DOUBLE) ELSE 0 END)
      comment: "Total monetary value of unfulfilled obligations. Represents outstanding financial commitment exposure requiring management attention."
    - name: "overdue_obligation_count"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE AND fulfillment_status NOT IN ('Fulfilled', 'Completed', 'Waived') THEN obligation_id END)
      comment: "Number of obligations past their due date and not yet fulfilled. Critical breach risk indicator for contract managers and legal counsel."
    - name: "overdue_obligation_value"
      expr: SUM(CASE WHEN due_date < CURRENT_DATE AND fulfillment_status NOT IN ('Fulfilled', 'Completed', 'Waived') THEN CAST(monetary_value AS DOUBLE) ELSE 0 END)
      comment: "Total monetary value of overdue unfulfilled obligations. Quantifies financial exposure from potential contract breaches."
    - name: "regulatory_obligation_count"
      expr: COUNT(CASE WHEN regulatory_obligation_flag = TRUE THEN obligation_id END)
      comment: "Number of obligations with a regulatory basis. Compliance portfolio size metric for regulatory risk management."
    - name: "regulatory_obligation_fulfillment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_obligation_flag = TRUE AND fulfillment_status IN ('Fulfilled', 'Completed') THEN obligation_id END) / NULLIF(COUNT(CASE WHEN regulatory_obligation_flag = TRUE THEN obligation_id END), 0), 2)
      comment: "Percentage of regulatory obligations fulfilled. Key compliance KPI reported to regulators and the board audit committee."
    - name: "obligation_fulfillment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fulfillment_status IN ('Fulfilled', 'Completed') THEN obligation_id END) / NULLIF(COUNT(obligation_id), 0), 2)
      comment: "Overall obligation fulfillment rate. Measures contractual performance health and identifies systemic delivery failures."
    - name: "distinct_agreements_with_obligations"
      expr: COUNT(DISTINCT agreement_id)
      comment: "Number of distinct agreements carrying active obligations. Measures breadth of contractual commitment exposure across the portfolio."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_obligation_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Obligation event and breach analytics tracking compliance incidents, financial impact of breaches, dispute rates, and resolution efficiency. Used by General Counsel, compliance officers, and risk managers to monitor contract performance failures and drive remediation."
  source: "`legal_ecm`.`contract`.`obligation_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of obligation event (e.g. Breach, Fulfillment, Waiver, Escalation). Primary classification for event portfolio analysis."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the obligation event. Identifies open incidents requiring resolution."
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity classification of the breach (e.g. Minor, Material, Critical). Used to prioritise remediation and assess legal exposure."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Level to which the event has been escalated. Measures governance response intensity for high-risk incidents."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the event is compliance-related. Separates regulatory compliance events from commercial performance events."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the event has triggered a dispute. Used to track dispute incidence rates across the obligation portfolio."
    - name: "financial_impact_currency"
      expr: financial_impact_currency
      comment: "Currency of the financial impact. Required for multi-currency breach cost aggregation."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework associated with the event. Used for regulatory breach reporting and compliance analytics."
    - name: "actor_type"
      expr: actor_type
      comment: "Type of actor responsible for the event (e.g. Firm, Counterparty, Third Party). Identifies which party is driving obligation failures."
    - name: "event_year"
      expr: YEAR(event_timestamp)
      comment: "Year the obligation event occurred. Enables trend analysis of breach and compliance event frequency over time."
  measures:
    - name: "total_obligation_events"
      expr: COUNT(obligation_event_id)
      comment: "Total number of obligation events recorded. Baseline measure of contract performance activity volume."
    - name: "total_breach_events"
      expr: COUNT(CASE WHEN event_type = 'Breach' THEN obligation_event_id END)
      comment: "Total number of breach events. Primary contract performance failure KPI for General Counsel and risk management."
    - name: "total_financial_impact_from_events"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact across all obligation events. Quantifies the aggregate cost of contract performance failures."
    - name: "breach_financial_impact"
      expr: SUM(CASE WHEN event_type = 'Breach' THEN CAST(financial_impact_amount AS DOUBLE) ELSE 0 END)
      comment: "Total financial impact attributable to breach events. Measures the direct cost of contractual non-performance for CFO reporting."
    - name: "avg_financial_impact_per_breach"
      expr: AVG(CASE WHEN event_type = 'Breach' THEN CAST(financial_impact_amount AS DOUBLE) END)
      comment: "Average financial impact per breach event. Benchmarks breach severity and informs risk provisioning decisions."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN obligation_event_id END) / NULLIF(COUNT(obligation_event_id), 0), 2)
      comment: "Percentage of obligation events that have triggered disputes. Measures contract relationship health and litigation risk exposure."
    - name: "open_breach_count"
      expr: COUNT(CASE WHEN event_type = 'Breach' AND event_status NOT IN ('Resolved', 'Closed', 'Waived') THEN obligation_event_id END)
      comment: "Number of unresolved breach events. Operational risk KPI for contract managers requiring immediate remediation action."
    - name: "avg_resolution_days"
      expr: AVG(CAST(DATEDIFF(resolution_timestamp, event_timestamp) AS DOUBLE))
      comment: "Average number of days to resolve an obligation event. Measures remediation efficiency and identifies systemic resolution bottlenecks."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average obligation completion percentage at the time of event recording. Tracks partial fulfillment progress across the obligation portfolio."
    - name: "escalated_event_count"
      expr: COUNT(CASE WHEN escalation_level IS NOT NULL AND escalation_level != '' THEN obligation_event_id END)
      comment: "Number of obligation events that have been escalated. Measures governance burden and severity of contract performance issues."
    - name: "distinct_obligations_with_breaches"
      expr: COUNT(DISTINCT CASE WHEN event_type = 'Breach' THEN obligation_id END)
      comment: "Number of distinct obligations that have experienced at least one breach. Measures breadth of contract performance failure across the portfolio."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_termination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract termination analytics covering termination rates, financial penalties, settlement outcomes, and dispute-driven exits. Used by General Counsel, CFO, and relationship managers to understand contract attrition, financial exposure from exits, and post-termination risk."
  source: "`legal_ecm`.`contract`.`termination`"
  dimensions:
    - name: "termination_type"
      expr: termination_type
      comment: "Type of termination (e.g. For Cause, For Convenience, Mutual, Regulatory). Classifies the nature of contract exits."
    - name: "termination_status"
      expr: termination_status
      comment: "Current status of the termination process. Identifies terminations in progress versus completed exits."
    - name: "grounds_for_termination"
      expr: grounds_for_termination
      comment: "Legal or contractual grounds cited for termination. Used to identify systemic causes of contract exits."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the termination is disputed. Measures contested termination rate and associated litigation risk."
    - name: "settlement_reached_flag"
      expr: settlement_reached_flag
      comment: "Indicates whether a settlement was reached. Measures out-of-court resolution success rate for terminated agreements."
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Indicates whether the termination requires regulatory reporting. Compliance KPI for identifying reportable contract exits."
    - name: "dispute_resolution_method"
      expr: dispute_resolution_method
      comment: "Method used to resolve termination disputes (e.g. Arbitration, Litigation, Mediation). Used for dispute resolution strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of financial amounts associated with the termination. Required for multi-currency financial impact aggregation."
    - name: "effective_termination_year"
      expr: YEAR(effective_termination_date)
      comment: "Year the termination became effective. Enables trend analysis of contract attrition over time."
  measures:
    - name: "total_terminations"
      expr: COUNT(termination_id)
      comment: "Total number of contract terminations. Baseline measure of contract attrition volume for portfolio health monitoring."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties incurred from contract terminations. Quantifies the direct cost of contract exits for CFO reporting."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued upon contract termination. Measures cash outflow obligations arising from contract exits."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of all terminations. Comprehensive measure of the economic cost of contract attrition."
    - name: "avg_penalty_per_termination"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per termination. Benchmarks exit cost and informs contract drafting decisions on penalty clause calibration."
    - name: "disputed_termination_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN termination_id END)
      comment: "Number of terminations that are disputed. Measures contested exit rate and associated litigation pipeline."
    - name: "disputed_termination_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN termination_id END) / NULLIF(COUNT(termination_id), 0), 2)
      comment: "Percentage of terminations that are disputed. Key relationship health and litigation risk KPI for General Counsel."
    - name: "settlement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN settlement_reached_flag = TRUE THEN termination_id END) / NULLIF(COUNT(CASE WHEN dispute_flag = TRUE THEN termination_id END), 0), 2)
      comment: "Percentage of disputed terminations resolved via settlement. Measures out-of-court resolution effectiveness and litigation avoidance rate."
    - name: "regulatory_reportable_termination_count"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN termination_id END)
      comment: "Number of terminations requiring regulatory reporting. Compliance workload metric for the regulatory affairs and legal operations teams."
    - name: "avg_wind_down_period_days"
      expr: AVG(CAST(wind_down_period_days AS DOUBLE))
      comment: "Average wind-down period in days for terminated agreements. Measures post-termination operational complexity and resource planning requirements."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract renewal pipeline metrics tracking renewal decisions, fee adjustments, auto-renewal exposure, and renewal conversion rates. Used by relationship managers, CFO, and General Counsel to manage revenue retention, renegotiation outcomes, and renewal process efficiency."
  source: "`legal_ecm`.`contract`.`renewal`"
  dimensions:
    - name: "renewal_status"
      expr: renewal_status
      comment: "Current status of the renewal (e.g. Pending, Approved, Declined, Lapsed). Primary filter for renewal pipeline management."
    - name: "renewal_type"
      expr: renewal_type
      comment: "Type of renewal (e.g. Auto, Negotiated, Early). Classifies renewal activity for pipeline and strategy analysis."
    - name: "decision"
      expr: decision
      comment: "Renewal decision outcome (e.g. Renew, Terminate, Renegotiate). Measures renewal conversion and attrition decisions."
    - name: "fee_arrangement_type"
      expr: fee_arrangement_type
      comment: "Type of fee arrangement for the renewed agreement (e.g. Fixed, Hourly, Contingency). Used for revenue mix analysis."
    - name: "fee_currency"
      expr: fee_currency
      comment: "Currency of the renewal fee. Required for multi-currency renewal revenue aggregation."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Indicates whether the renewal is automatic. Identifies auto-renewal exposure requiring proactive management."
    - name: "client_approval_required"
      expr: client_approval_required
      comment: "Indicates whether client approval is required for renewal. Tracks governance requirements in the renewal process."
    - name: "priority"
      expr: priority
      comment: "Priority level of the renewal. Used to triage high-value renewals requiring senior relationship management attention."
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year the renewal decision was made. Enables cohort analysis of renewal outcomes over time."
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the agreement expires for renewal consideration. Used for forward-looking renewal pipeline planning."
  measures:
    - name: "total_renewals"
      expr: COUNT(renewal_id)
      comment: "Total number of renewal records. Baseline measure of renewal pipeline volume."
    - name: "total_renewal_fee_value"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fee value of all renewals. Measures revenue retained through contract renewals — primary revenue retention KPI."
    - name: "avg_renewal_fee_value"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average fee value per renewal. Benchmarks renewal deal size and identifies upsell or downsell trends."
    - name: "renewal_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision = 'Renew' THEN renewal_id END) / NULLIF(COUNT(renewal_id), 0), 2)
      comment: "Percentage of renewals resulting in a positive renewal decision. Primary client retention KPI for relationship managers and the CFO."
    - name: "avg_fee_adjustment_percentage"
      expr: AVG(CAST(fee_adjustment_percentage AS DOUBLE))
      comment: "Average fee adjustment percentage applied at renewal. Measures pricing power and renegotiation outcomes across the renewal portfolio."
    - name: "total_fee_adjustment_value"
      expr: SUM(CAST(fee_adjustment_percentage AS DOUBLE) * CAST(fee_amount AS DOUBLE) / 100.0)
      comment: "Total monetary value of fee adjustments applied at renewal. Quantifies the net revenue impact of renegotiation outcomes."
    - name: "auto_renewal_count"
      expr: COUNT(CASE WHEN auto_renew_flag = TRUE THEN renewal_id END)
      comment: "Number of agreements renewing automatically. Measures auto-renewal pipeline volume requiring proactive cancellation management."
    - name: "auto_renewal_fee_value"
      expr: SUM(CASE WHEN auto_renew_flag = TRUE THEN CAST(fee_amount AS DOUBLE) ELSE 0 END)
      comment: "Total fee value of auto-renewing agreements. Quantifies revenue at risk of unintended commitment through auto-renewal."
    - name: "pending_renewal_count"
      expr: COUNT(CASE WHEN renewal_status NOT IN ('Approved', 'Completed', 'Declined', 'Lapsed') THEN renewal_id END)
      comment: "Number of renewals pending decision. Measures active renewal pipeline backlog requiring relationship manager attention."
    - name: "expiring_within_60_days_renewal_count"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 60) AND renewal_status NOT IN ('Approved', 'Completed') THEN renewal_id END)
      comment: "Number of agreements expiring within 60 days without a confirmed renewal decision. Critical pipeline urgency metric for client retention management."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_execution_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract execution analytics measuring execution velocity, electronic signature adoption, binding execution rates, and notarisation compliance. Used by legal operations, General Counsel, and compliance teams to monitor execution process efficiency and enforceability of executed agreements."
  source: "`legal_ecm`.`contract`.`execution_record`"
  dimensions:
    - name: "execution_status"
      expr: execution_status
      comment: "Current status of the execution record (e.g. Pending, Executed, Failed). Primary filter for execution pipeline monitoring."
    - name: "execution_method"
      expr: execution_method
      comment: "Method used to execute the agreement (e.g. Electronic, Wet Ink, Notarised). Used for e-signature adoption and process efficiency analysis."
    - name: "execution_type"
      expr: execution_type
      comment: "Type of execution event (e.g. Original, Counterpart, Amendment). Classifies execution activity for audit and governance reporting."
    - name: "electronic_signature_platform"
      expr: electronic_signature_platform
      comment: "Platform used for electronic signature (e.g. DocuSign, Adobe Sign). Used for vendor performance and platform adoption analysis."
    - name: "jurisdiction_of_execution"
      expr: jurisdiction_of_execution
      comment: "Jurisdiction where the agreement was executed. Used for cross-border execution compliance and enforceability analysis."
    - name: "is_binding_flag"
      expr: is_binding_flag
      comment: "Indicates whether the execution record creates a binding obligation. Filters for legally enforceable executions."
    - name: "is_original_execution_flag"
      expr: is_original_execution_flag
      comment: "Indicates whether this is the original execution. Distinguishes original executions from counterpart or duplicate records."
    - name: "notary_seal_affixed_flag"
      expr: notary_seal_affixed_flag
      comment: "Indicates whether a notary seal was affixed. Used for notarisation compliance reporting on agreements requiring notarisation."
    - name: "execution_year"
      expr: YEAR(execution_date)
      comment: "Year of execution. Enables trend analysis of execution volume and velocity over time."
  measures:
    - name: "total_execution_records"
      expr: COUNT(execution_record_id)
      comment: "Total number of execution records. Baseline measure of contract execution activity volume."
    - name: "binding_execution_count"
      expr: COUNT(CASE WHEN is_binding_flag = TRUE THEN execution_record_id END)
      comment: "Number of execution records that are legally binding. Measures the volume of enforceable contract executions."
    - name: "binding_execution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_binding_flag = TRUE THEN execution_record_id END) / NULLIF(COUNT(execution_record_id), 0), 2)
      comment: "Percentage of execution records that are binding. Measures execution quality and enforceability rate across the portfolio."
    - name: "electronic_signature_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN execution_method = 'Electronic' THEN execution_record_id END) / NULLIF(COUNT(execution_record_id), 0), 2)
      comment: "Percentage of agreements executed via electronic signature. Measures digital transformation progress in contract execution and operational efficiency gains."
    - name: "avg_days_to_counterparty_execution"
      expr: AVG(CAST(DATEDIFF(counterparty_execution_date, execution_date) AS DOUBLE))
      comment: "Average days between firm execution and counterparty execution. Measures counterparty responsiveness and identifies execution cycle bottlenecks."
    - name: "pending_execution_count"
      expr: COUNT(CASE WHEN execution_status NOT IN ('Executed', 'Completed') THEN execution_record_id END)
      comment: "Number of execution records not yet completed. Measures execution pipeline backlog and identifies agreements at risk of delayed effectiveness."
    - name: "distinct_agreements_executed"
      expr: COUNT(DISTINCT agreement_id)
      comment: "Number of distinct agreements with at least one execution record. Measures breadth of executed contract portfolio."
    - name: "notarised_execution_count"
      expr: COUNT(CASE WHEN notary_seal_affixed_flag = TRUE THEN execution_record_id END)
      comment: "Number of executions with a notary seal affixed. Compliance metric for agreements requiring notarisation under applicable law."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract milestone tracking metrics covering on-time delivery rates, critical path performance, financial impact of milestone failures, and regulatory milestone compliance. Used by contract managers, project leads, and General Counsel to monitor contractual delivery commitments."
  source: "`legal_ecm`.`contract`.`milestone`"
  dimensions:
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (e.g. Payment, Delivery, Regulatory, Review). Primary classification for milestone portfolio analysis."
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone (e.g. Pending, Completed, Overdue, Escalated). Primary filter for milestone health monitoring."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the milestone. Used to triage high-priority milestones requiring immediate attention."
    - name: "is_critical_path_flag"
      expr: is_critical_path_flag
      comment: "Indicates whether the milestone is on the critical path. Focuses management attention on milestones that directly impact agreement delivery."
    - name: "is_regulatory_milestone_flag"
      expr: is_regulatory_milestone_flag
      comment: "Indicates whether the milestone has a regulatory basis. Separates regulatory from commercial milestones for compliance reporting."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Indicates whether the milestone requires escalation. Used to track governance response to at-risk milestones."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the financial impact amount. Required for multi-currency milestone financial exposure aggregation."
    - name: "recurrence_pattern"
      expr: recurrence_pattern
      comment: "Recurrence pattern of the milestone (e.g. Monthly, Quarterly, Annual). Used for recurring obligation workload planning."
    - name: "scheduled_year"
      expr: YEAR(scheduled_date)
      comment: "Year the milestone is scheduled. Enables forward-looking milestone workload and delivery planning."
  measures:
    - name: "total_milestones"
      expr: COUNT(milestone_id)
      comment: "Total number of milestones tracked. Baseline measure of contractual delivery commitment volume."
    - name: "overdue_milestone_count"
      expr: COUNT(CASE WHEN scheduled_date < CURRENT_DATE AND milestone_status NOT IN ('Completed', 'Waived', 'Cancelled') THEN milestone_id END)
      comment: "Number of milestones past their scheduled date and not completed. Critical delivery risk KPI for contract managers and project leads."
    - name: "milestone_on_time_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN milestone_status = 'Completed' AND actual_date <= scheduled_date THEN milestone_id END) / NULLIF(COUNT(CASE WHEN milestone_status = 'Completed' THEN milestone_id END), 0), 2)
      comment: "Percentage of completed milestones delivered on or before the scheduled date. Measures contractual delivery performance and SLA adherence."
    - name: "critical_path_overdue_count"
      expr: COUNT(CASE WHEN is_critical_path_flag = TRUE AND scheduled_date < CURRENT_DATE AND milestone_status NOT IN ('Completed', 'Waived', 'Cancelled') THEN milestone_id END)
      comment: "Number of overdue milestones on the critical path. Highest-priority delivery risk metric — directly impacts agreement effectiveness and client relationships."
    - name: "total_financial_impact_at_risk"
      expr: SUM(CASE WHEN milestone_status NOT IN ('Completed', 'Waived', 'Cancelled') THEN CAST(financial_impact_amount AS DOUBLE) ELSE 0 END)
      comment: "Total financial impact associated with incomplete milestones. Quantifies financial exposure from outstanding delivery commitments."
    - name: "regulatory_milestone_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_regulatory_milestone_flag = TRUE AND milestone_status = 'Completed' THEN milestone_id END) / NULLIF(COUNT(CASE WHEN is_regulatory_milestone_flag = TRUE THEN milestone_id END), 0), 2)
      comment: "Percentage of regulatory milestones completed. Key compliance KPI for regulatory affairs and the board audit committee."
    - name: "escalated_milestone_count"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE THEN milestone_id END)
      comment: "Number of milestones flagged for escalation. Measures governance burden and severity of delivery issues requiring senior intervention."
    - name: "avg_days_overdue"
      expr: AVG(CASE WHEN scheduled_date < CURRENT_DATE AND milestone_status NOT IN ('Completed', 'Waived', 'Cancelled') THEN CAST(DATEDIFF(CURRENT_DATE, scheduled_date) AS DOUBLE) END)
      comment: "Average number of days overdue for incomplete past-due milestones. Measures severity of delivery delays and informs remediation urgency."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_clause_library`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clause library governance metrics tracking clause currency, compliance coverage, regulatory alignment, and review cycle health. Used by legal operations, knowledge management, and General Counsel to maintain a high-quality, compliant clause library that reduces drafting risk."
  source: "`legal_ecm`.`contract`.`clause_library`"
  dimensions:
    - name: "clause_type"
      expr: clause_type
      comment: "Type of clause (e.g. Indemnity, Limitation of Liability, Confidentiality, Governing Law). Primary classification for clause portfolio analysis."
    - name: "clause_category"
      expr: clause_category
      comment: "High-level category of the clause. Used for clause portfolio segmentation and governance reporting."
    - name: "clause_library_status"
      expr: clause_library_status
      comment: "Current status of the clause (e.g. Active, Deprecated, Under Review). Identifies clauses requiring review or retirement."
    - name: "usage_tier"
      expr: usage_tier
      comment: "Usage tier classification of the clause (e.g. Standard, Preferred, Fallback). Used for clause adoption and standardisation analysis."
    - name: "gdpr_compliant_flag"
      expr: gdpr_compliant_flag
      comment: "Indicates whether the clause is GDPR compliant. Used for data privacy compliance coverage analysis of the clause library."
    - name: "sox_compliant_flag"
      expr: sox_compliant_flag
      comment: "Indicates whether the clause is SOX compliant. Used for financial controls compliance coverage analysis."
    - name: "frand_applicable_flag"
      expr: frand_applicable_flag
      comment: "Indicates whether FRAND (Fair, Reasonable and Non-Discriminatory) terms apply. Used for IP licensing and standards-essential patent clause governance."
    - name: "language_code"
      expr: language_code
      comment: "Language of the clause. Used for multi-jurisdictional clause library coverage analysis."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework the clause addresses. Used for regulatory coverage gap analysis in the clause library."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the clause is currently active. Filters for live clauses available for use in drafting."
  measures:
    - name: "total_active_clauses"
      expr: COUNT(CASE WHEN is_active = TRUE THEN clause_library_id END)
      comment: "Total number of active clauses in the library. Baseline measure of clause library size and coverage."
    - name: "clauses_overdue_for_review"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE AND is_active = TRUE THEN clause_library_id END)
      comment: "Number of active clauses past their scheduled review date. Measures clause library staleness and legal risk from outdated standard language."
    - name: "clause_review_overdue_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN next_review_date < CURRENT_DATE AND is_active = TRUE THEN clause_library_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN clause_library_id END), 0), 2)
      comment: "Percentage of active clauses overdue for review. Governance KPI for legal knowledge management — high rates signal increased drafting risk."
    - name: "gdpr_compliant_clause_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gdpr_compliant_flag = TRUE AND is_active = TRUE THEN clause_library_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN clause_library_id END), 0), 2)
      comment: "Percentage of active clauses marked GDPR compliant. Data privacy compliance coverage metric for the DPO and legal operations."
    - name: "sox_compliant_clause_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sox_compliant_flag = TRUE AND is_active = TRUE THEN clause_library_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN clause_library_id END), 0), 2)
      comment: "Percentage of active clauses marked SOX compliant. Financial controls compliance coverage metric for the CFO and audit committee."
    - name: "deprecated_clause_count"
      expr: COUNT(CASE WHEN clause_library_status = 'Deprecated' THEN clause_library_id END)
      comment: "Number of deprecated clauses in the library. Measures library hygiene and the volume of legacy language requiring retirement."
    - name: "distinct_regulatory_frameworks_covered"
      expr: COUNT(DISTINCT regulatory_framework)
      comment: "Number of distinct regulatory frameworks covered by clauses in the library. Measures regulatory breadth and identifies coverage gaps."
$$;