-- Metric views for domain: customer | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 18:41:06

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the customer account master — tracks portfolio health, credit exposure, revenue potential, and segment distribution to steer customer acquisition, retention, and risk management decisions."
  source: "`agriculture_ecm`.`customer`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Lifecycle status of the account (e.g. Active, Inactive, Suspended) — primary filter for active-portfolio analysis."
    - name: "account_tier"
      expr: account_tier
      comment: "Commercial tier assigned to the account (e.g. Platinum, Gold, Silver) — used to stratify revenue and credit metrics by customer value band."
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account (e.g. Distributor, Retailer, Grower) — enables channel-level performance analysis."
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "ISO country code of the billing address — supports geographic segmentation of the customer portfolio."
    - name: "billing_state_province"
      expr: billing_state_province
      comment: "State or province of the billing address — enables sub-national geographic drill-down."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating assigned to the account — used to segment credit-risk exposure across the portfolio."
    - name: "currency_code"
      expr: currency_code
      comment: "Transactional currency of the account — required for multi-currency revenue and credit analysis."
    - name: "gmo_preference"
      expr: gmo_preference
      comment: "GMO preference declared by the account (e.g. GMO-Free, Conventional) — drives product assortment and compliance segmentation."
    - name: "organic_certification_required"
      expr: organic_certification_required
      comment: "Flag indicating whether the account requires organic-certified supply — used to size the organic-compliant customer base."
    - name: "fsma_registered_facility_flag"
      expr: fsma_registered_facility_flag
      comment: "Indicates whether the account operates an FSMA-registered facility — critical for regulatory compliance segmentation."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Position of the account in the customer hierarchy (e.g. Parent, Child) — supports consolidated vs. subsidiary analysis."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the account became effective — used to track new-account cohort trends over time."
  measures:
    - name: "total_active_accounts"
      expr: COUNT(CASE WHEN account_status = 'Active' THEN account_id END)
      comment: "Count of accounts currently in Active status — the primary portfolio-size KPI used in executive dashboards and territory planning."
    - name: "total_annual_revenue_usd"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Sum of declared annual revenue across all accounts — proxy for total addressable wallet and used to size the commercial opportunity by segment or geography."
    - name: "avg_annual_revenue_per_account"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per account — benchmarks account value across tiers and geographies; a drop signals portfolio mix shift toward lower-value customers."
    - name: "total_credit_limit_usd"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts — measures aggregate credit exposure; monitored by Finance and Risk to ensure limits align with portfolio risk appetite."
    - name: "avg_credit_limit_per_account"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account — used to benchmark credit generosity across tiers and identify outliers requiring review."
    - name: "accounts_on_credit_hold"
      expr: COUNT(CASE WHEN account_status = 'Credit Hold' THEN account_id END)
      comment: "Number of accounts currently on credit hold — a leading risk indicator; spikes trigger collections and credit-review interventions."
    - name: "organic_certified_account_count"
      expr: COUNT(CASE WHEN organic_certification_required = TRUE THEN account_id END)
      comment: "Count of accounts requiring organic certification — quantifies the organic-compliant customer base to guide procurement and product strategy."
    - name: "fsma_registered_account_count"
      expr: COUNT(CASE WHEN fsma_registered_facility_flag = TRUE THEN account_id END)
      comment: "Count of accounts with FSMA-registered facilities — used by Regulatory Affairs to track compliance coverage and prioritise audit scheduling."
    - name: "distinct_billing_countries"
      expr: COUNT(DISTINCT billing_country_code)
      comment: "Number of distinct countries in the billing address portfolio — measures geographic reach and international market penetration."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`customer_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and receivables health KPIs derived from customer credit profiles — supports Finance, Credit Risk, and Collections teams in monitoring exposure, overdue balances, and payment behaviour across the customer portfolio."
  source: "`agriculture_ecm`.`customer`.`credit_profile`"
  dimensions:
    - name: "credit_risk_category"
      expr: credit_risk_category
      comment: "Internal risk category assigned to the credit profile (e.g. Low, Medium, High) — primary dimension for risk-stratified exposure analysis."
    - name: "internal_credit_rating"
      expr: internal_credit_rating
      comment: "Internally assigned credit rating — used alongside external ratings to segment portfolio credit quality."
    - name: "external_credit_rating"
      expr: external_credit_rating
      comment: "Credit rating from an external agency — enables benchmarking of internal ratings against market assessments."
    - name: "external_rating_agency"
      expr: external_rating_agency
      comment: "Name of the external rating agency (e.g. Dun & Bradstreet, Moody's) — used to compare rating sources."
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Boolean indicating whether the profile is currently on credit hold — key operational flag for order-release decisions."
    - name: "overdue_days_bucket"
      expr: overdue_days_bucket
      comment: "Ageing bucket for overdue balances (e.g. 1-30, 31-60, 61-90, 90+) — standard AR ageing dimension for collections prioritisation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit profile — required for multi-currency exposure aggregation."
    - name: "profile_status"
      expr: profile_status
      comment: "Status of the credit profile (e.g. Active, Closed, Suspended) — filters analysis to live profiles."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms assigned to the profile (e.g. Net30, Net60) — used to segment DSO and overdue analysis by terms bucket."
    - name: "credit_review_date"
      expr: DATE_TRUNC('month', credit_review_date)
      comment: "Month of the scheduled credit review — used to track review cadence and identify overdue reviews."
  measures:
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding receivables balance across all credit profiles — the primary AR exposure KPI monitored by Finance and the CFO."
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue receivables — measures collections risk; a rising trend triggers escalation to the collections team and credit review."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Aggregate credit limit extended across all profiles — used to measure total credit exposure approved by the business."
    - name: "total_available_credit"
      expr: SUM(CAST(available_credit AS DOUBLE))
      comment: "Total unused credit capacity across all profiles — indicates headroom for incremental sales without increasing credit risk."
    - name: "total_open_sales_order_exposure"
      expr: SUM(CAST(open_sales_order_exposure AS DOUBLE))
      comment: "Total value of open sales orders not yet invoiced — forward-looking credit exposure used in credit-limit utilisation calculations."
    - name: "avg_dso_days"
      expr: AVG(CAST(dso_days AS DOUBLE))
      comment: "Average Days Sales Outstanding across credit profiles — a core working-capital efficiency KPI; increases signal deteriorating payment behaviour or collections effectiveness."
    - name: "profiles_on_credit_hold"
      expr: COUNT(CASE WHEN credit_hold_flag = TRUE THEN credit_profile_id END)
      comment: "Number of credit profiles currently on hold — operational KPI for the Order-to-Cash team; spikes indicate systemic payment issues requiring management attention."
    - name: "avg_last_payment_amount"
      expr: AVG(CAST(last_payment_amount AS DOUBLE))
      comment: "Average value of the most recent payment received per profile — tracks payment size trends and early signals of customer financial stress."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`customer_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer service and quality-incident KPIs derived from the case management system — tracks case volume, resolution efficiency, SLA compliance, regulatory notifications, and food-safety flags to steer service quality and compliance posture."
  source: "`agriculture_ecm`.`customer`.`case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of case (e.g. Quality Complaint, Regulatory, Logistics, Billing) — primary dimension for case-mix analysis and resource allocation."
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case (e.g. Open, In Progress, Closed) — used to track workload and backlog."
    - name: "priority"
      expr: priority
      comment: "Priority level of the case (e.g. Critical, High, Medium, Low) — used to assess urgency distribution and SLA risk."
    - name: "origin_channel"
      expr: origin_channel
      comment: "Channel through which the case was raised (e.g. Email, Phone, Portal) — informs channel strategy and self-service investment decisions."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level root cause category (e.g. Product Quality, Logistics, Documentation) — drives corrective action prioritisation."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the case was resolved (e.g. Replacement, Refund, Advisory) — used to analyse resolution cost and customer satisfaction patterns."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether the case breached its SLA target — key service-quality flag for executive reporting."
    - name: "regulatory_notification_flag"
      expr: regulatory_notification_flag
      comment: "Indicates whether a regulatory body was notified — critical compliance dimension for food-safety and FSMA reporting."
    - name: "mrl_exceedance_flag"
      expr: mrl_exceedance_flag
      comment: "Indicates whether the case involved an MRL (Maximum Residue Level) exceedance — food-safety risk dimension requiring executive visibility."
    - name: "fsma_traceability_flag"
      expr: fsma_traceability_flag
      comment: "Indicates whether FSMA traceability requirements were triggered — regulatory compliance dimension."
    - name: "opened_month"
      expr: DATE_TRUNC('month', opened_timestamp)
      comment: "Month the case was opened — used to track case volume trends and seasonal quality patterns."
  measures:
    - name: "total_open_cases"
      expr: COUNT(CASE WHEN case_status != 'Closed' THEN case_id END)
      comment: "Total number of currently open cases — primary workload KPI for the customer service team; a rising backlog triggers staffing or process interventions."
    - name: "total_cases"
      expr: COUNT(case_id)
      comment: "Total case volume across all statuses — baseline volume metric used to normalise rates and track overall incident frequency."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN case_id END)
      comment: "Number of cases that breached their SLA target — a direct service-quality KPI; increases trigger process reviews and resource reallocation."
    - name: "regulatory_notification_case_count"
      expr: COUNT(CASE WHEN regulatory_notification_flag = TRUE THEN case_id END)
      comment: "Number of cases requiring regulatory body notification — a critical compliance KPI monitored by Legal and Regulatory Affairs."
    - name: "mrl_exceedance_case_count"
      expr: COUNT(CASE WHEN mrl_exceedance_flag = TRUE THEN case_id END)
      comment: "Number of cases involving MRL exceedances — a food-safety risk KPI; any increase demands immediate investigation and potential product recall assessment."
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total quantity of product affected across all cases — measures the physical scale of quality incidents; used to assess recall scope and financial exposure."
    - name: "avg_affected_quantity_per_case"
      expr: AVG(CAST(affected_quantity AS DOUBLE))
      comment: "Average affected quantity per case — benchmarks incident severity; rising averages indicate larger-scale quality failures."
    - name: "distinct_accounts_with_cases"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customer accounts that have raised cases — measures breadth of service issues across the customer base; high counts signal systemic product or logistics problems."
    - name: "haccp_corrective_action_case_count"
      expr: COUNT(CASE WHEN haccp_corrective_action_flag = TRUE THEN case_id END)
      comment: "Number of cases requiring a HACCP corrective action — a food-safety compliance KPI tracked by Quality Assurance and reported to regulatory bodies."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`customer_certification_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance and certification health KPIs for customer accounts — tracks certification coverage, audit scores, expiry risk, and non-conformance rates to steer supplier qualification, regulatory compliance, and preferential-pricing eligibility decisions."
  source: "`agriculture_ecm`.`customer`.`certification_record`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g. Organic, GlobalG.A.P., SQF, FSMA) — primary dimension for compliance coverage analysis by standard."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (e.g. Active, Expired, Suspended, Pending) — used to track compliance posture across the customer base."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit conducted (e.g. Initial, Surveillance, Re-certification) — used to analyse audit programme composition."
    - name: "audit_grade"
      expr: audit_grade
      comment: "Grade awarded at the most recent audit (e.g. A, B, C, Fail) — used to segment customers by compliance quality."
    - name: "certified_site_country_code"
      expr: certified_site_country_code
      comment: "Country of the certified site — enables geographic compliance coverage analysis."
    - name: "gmo_status"
      expr: gmo_status
      comment: "GMO status declared in the certification (e.g. GMO-Free, Conventional) — used to track GMO-free supply chain compliance."
    - name: "cool_eligible_flag"
      expr: cool_eligible_flag
      comment: "Indicates whether the certification makes the account eligible for Country of Origin Labelling — used to manage COOL compliance across the supply base."
    - name: "mrl_compliance_verified_flag"
      expr: mrl_compliance_verified_flag
      comment: "Indicates whether MRL compliance has been verified in this certification — food-safety compliance dimension."
    - name: "preferential_pricing_eligible_flag"
      expr: preferential_pricing_eligible_flag
      comment: "Indicates whether the certification qualifies the account for preferential pricing — links compliance to commercial benefit."
    - name: "expiry_month"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month the certification expires — used to build expiry-risk calendars and trigger renewal workflows."
    - name: "issue_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month the certification was issued — used to track certification issuance trends and renewal cycles."
  measures:
    - name: "total_active_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN certification_record_id END)
      comment: "Total number of currently active certifications across all accounts — primary compliance coverage KPI; a decline signals certification lapses requiring urgent renewal action."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score across all certification records — a composite quality indicator; declining scores signal deteriorating supplier compliance and trigger corrective action programmes."
    - name: "distinct_certified_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customer accounts holding at least one certification — measures the breadth of the certified customer base; used to track compliance programme reach."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Expired' THEN certification_record_id END)
      comment: "Number of expired certifications — a compliance risk KPI; high counts indicate renewal process failures and potential regulatory exposure."
    - name: "suspended_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Suspended' THEN certification_record_id END)
      comment: "Number of suspended certifications — a critical compliance alert; suspended certifications may block shipments and trigger regulatory scrutiny."
    - name: "mrl_compliant_certification_count"
      expr: COUNT(CASE WHEN mrl_compliance_verified_flag = TRUE THEN certification_record_id END)
      comment: "Number of certifications with verified MRL compliance — measures food-safety compliance coverage; used by Quality and Regulatory teams to assess supply chain risk."
    - name: "preferential_pricing_eligible_count"
      expr: COUNT(CASE WHEN preferential_pricing_eligible_flag = TRUE THEN certification_record_id END)
      comment: "Number of certifications qualifying accounts for preferential pricing — links compliance achievement to commercial incentive; used by Sales to identify pricing-eligible customers."
    - name: "certifications_expiring_next_90_days"
      expr: COUNT(CASE WHEN certification_status = 'Active' AND expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN certification_record_id END)
      comment: "Number of active certifications expiring within the next 90 days — a forward-looking compliance risk KPI; drives renewal prioritisation and customer outreach campaigns."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`customer_account_relationship`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner and channel relationship KPIs derived from account-to-account relationships — tracks relationship portfolio health, volume commitments, credit exposure, and compliance flags across distributors, co-packers, brokers, and cooperative members."
  source: "`agriculture_ecm`.`customer`.`account_relationship`"
  dimensions:
    - name: "relationship_type"
      expr: relationship_type
      comment: "Type of inter-account relationship (e.g. Distributor, Co-Packer, Broker, Cooperative) — primary dimension for channel and partner analysis."
    - name: "relationship_status"
      expr: relationship_status
      comment: "Current status of the relationship (e.g. Active, Expired, Suspended) — used to filter to live partnerships."
    - name: "pricing_arrangement_type"
      expr: pricing_arrangement_type
      comment: "Type of pricing arrangement governing the relationship (e.g. Fixed, Index-Linked, Spot) — used to analyse pricing strategy across the partner network."
    - name: "geographic_scope_code"
      expr: geographic_scope_code
      comment: "Geographic scope of the relationship (e.g. National, Regional, Global) — used to segment partner coverage by territory."
    - name: "gmo_preference"
      expr: gmo_preference
      comment: "GMO preference agreed in the relationship — used to segment the partner network by GMO compliance requirements."
    - name: "organic_certified_flag"
      expr: organic_certified_flag
      comment: "Indicates whether the relationship involves an organically certified partner — used to size the organic supply network."
    - name: "preferred_partner_flag"
      expr: preferred_partner_flag
      comment: "Indicates whether the partner is designated as preferred — used to stratify KPIs by strategic partner tier."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Indicates whether the relationship is exclusive — used to track exclusivity commitments and assess competitive exposure."
    - name: "co_packer_flag"
      expr: co_packer_flag
      comment: "Indicates whether the partner is a co-packer — used to segment manufacturing partnership metrics."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the relationship agreement — required for multi-currency volume and exposure analysis."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the relationship became effective — used to track new partnership formation trends."
  measures:
    - name: "total_active_relationships"
      expr: COUNT(CASE WHEN relationship_status = 'Active' THEN account_relationship_id END)
      comment: "Total number of active inter-account relationships — measures the breadth of the partner and channel network; a key input to channel strategy reviews."
    - name: "total_annual_volume_commitment_mt"
      expr: SUM(CAST(annual_volume_commitment_mt AS DOUBLE))
      comment: "Total annual volume committed across all active relationships in metric tonnes — a strategic supply planning KPI; used to align procurement and production capacity with contracted demand."
    - name: "avg_annual_volume_commitment_mt"
      expr: AVG(CAST(annual_volume_commitment_mt AS DOUBLE))
      comment: "Average annual volume commitment per relationship in metric tonnes — benchmarks partner scale; used to identify under-committed relationships for renegotiation."
    - name: "total_credit_exposure_limit"
      expr: SUM(CAST(credit_exposure_limit AS DOUBLE))
      comment: "Total credit exposure limit extended across all relationships — measures aggregate financial risk in the partner network; monitored by Finance and Risk Management."
    - name: "preferred_partner_count"
      expr: COUNT(CASE WHEN preferred_partner_flag = TRUE THEN account_relationship_id END)
      comment: "Number of relationships designated as preferred partnerships — tracks the size of the strategic partner tier; used in partner programme management and incentive allocation."
    - name: "organic_certified_relationship_count"
      expr: COUNT(CASE WHEN organic_certified_flag = TRUE THEN account_relationship_id END)
      comment: "Number of relationships with organically certified partners — measures organic supply network capacity; used to assess ability to fulfil organic demand commitments."
    - name: "fsma_verified_supplier_count"
      expr: COUNT(CASE WHEN fsma_verified_supplier_flag = TRUE THEN account_relationship_id END)
      comment: "Number of relationships with FSMA-verified suppliers — a regulatory compliance KPI; used by Food Safety teams to track verified supply chain coverage."
    - name: "globalg_ap_certified_relationship_count"
      expr: COUNT(CASE WHEN globalg_ap_certified_flag = TRUE THEN account_relationship_id END)
      comment: "Number of relationships with GlobalG.A.P.-certified partners — measures good agricultural practice compliance across the partner network."
    - name: "distinct_partner_accounts"
      expr: COUNT(DISTINCT target_account_id)
      comment: "Number of distinct partner accounts engaged in relationships — measures the unique breadth of the partner network, excluding duplicates from multiple relationship types."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`customer_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer contact engagement and data quality KPIs — tracks decision-maker coverage, marketing opt-in rates, FSMA point-of-contact designation, and contact data health to steer CRM hygiene, marketing effectiveness, and regulatory contact management."
  source: "`agriculture_ecm`.`customer`.`contact`"
  dimensions:
    - name: "contact_type"
      expr: contact_type
      comment: "Type of contact (e.g. Primary, Technical, Billing, Regulatory) — used to segment engagement metrics by contact role."
    - name: "contact_status"
      expr: contact_status
      comment: "Current status of the contact record (e.g. Active, Inactive) — used to filter to reachable contacts."
    - name: "department"
      expr: department
      comment: "Department of the contact within their organisation — used to analyse stakeholder coverage by function."
    - name: "country_code"
      expr: country_code
      comment: "Country of the contact — enables geographic segmentation of the contact base."
    - name: "lead_source"
      expr: lead_source
      comment: "Source through which the contact was acquired (e.g. Trade Show, Referral, Web) — used to evaluate lead generation channel effectiveness."
    - name: "preferred_communication_channel"
      expr: preferred_communication_channel
      comment: "Contact's preferred communication channel (e.g. Email, Phone, Portal) — used to optimise outreach strategy."
    - name: "is_decision_maker"
      expr: is_decision_maker
      comment: "Indicates whether the contact is a decision-maker — used to measure decision-maker coverage across the account portfolio."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Indicates whether the contact has opted into marketing communications — primary dimension for addressable marketing audience analysis."
    - name: "gdpr_consent_basis"
      expr: gdpr_consent_basis
      comment: "Legal basis for GDPR consent (e.g. Legitimate Interest, Explicit Consent) — required for GDPR compliance reporting."
    - name: "last_activity_month"
      expr: DATE_TRUNC('month', last_activity_date)
      comment: "Month of the contact's last recorded activity — used to track engagement recency and identify dormant contacts."
  measures:
    - name: "total_active_contacts"
      expr: COUNT(CASE WHEN contact_status = 'Active' THEN contact_id END)
      comment: "Total number of active contacts in the CRM — baseline measure of reachable stakeholder coverage across the customer portfolio."
    - name: "marketing_opt_in_contacts"
      expr: COUNT(CASE WHEN marketing_opt_in = TRUE THEN contact_id END)
      comment: "Number of contacts opted into marketing communications — defines the addressable marketing audience; directly impacts campaign reach and revenue pipeline."
    - name: "decision_maker_contact_count"
      expr: COUNT(CASE WHEN is_decision_maker = TRUE THEN contact_id END)
      comment: "Number of contacts identified as decision-makers — measures executive stakeholder coverage; low counts signal relationship risk and prompt account development actions."
    - name: "fsma_point_of_contact_count"
      expr: COUNT(CASE WHEN is_fsma_point_of_contact = TRUE THEN contact_id END)
      comment: "Number of contacts designated as FSMA points of contact — a regulatory compliance KPI; ensures every FSMA-regulated account has a designated contact for traceability and recall communications."
    - name: "email_bounced_contact_count"
      expr: COUNT(CASE WHEN email_bounced = TRUE THEN contact_id END)
      comment: "Number of contacts with bounced email addresses — a CRM data quality KPI; high counts reduce marketing deliverability and signal the need for data cleansing campaigns."
    - name: "distinct_accounts_with_contacts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct accounts with at least one contact record — measures CRM coverage of the account portfolio; gaps indicate accounts at risk of poor relationship management."
    - name: "haccp_coordinator_count"
      expr: COUNT(CASE WHEN is_haccp_coordinator = TRUE THEN contact_id END)
      comment: "Number of contacts designated as HACCP coordinators — a food-safety compliance KPI; ensures adequate HACCP oversight coverage across the customer base."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segmentation strategy KPIs — tracks segment portfolio composition, revenue band coverage, volume commitments, and compliance requirements to steer go-to-market strategy, pricing tier design, and customer programme investments."
  source: "`agriculture_ecm`.`customer`.`segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of segment (e.g. Behavioural, Geographic, Value-Based) — primary dimension for segmentation strategy analysis."
    - name: "segment_tier"
      expr: segment_tier
      comment: "Tier of the segment (e.g. Strategic, Core, Transactional) — used to stratify investment and service levels by customer value."
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment (e.g. Active, Archived) — used to filter to live segments in go-to-market analysis."
    - name: "pricing_tier_code"
      expr: pricing_tier_code
      comment: "Pricing tier associated with the segment — links segmentation to commercial pricing strategy."
    - name: "geography_scope"
      expr: geography_scope
      comment: "Geographic scope of the segment (e.g. Global, Regional, National) — used to analyse segment coverage by market."
    - name: "gmo_preference"
      expr: gmo_preference
      comment: "GMO preference of the segment — used to size GMO-free vs. conventional customer segments."
    - name: "organic_cert_required"
      expr: organic_cert_required
      comment: "Indicates whether organic certification is required for accounts in this segment — used to quantify the organic-compliant segment base."
    - name: "fsma_compliance_required"
      expr: fsma_compliance_required
      comment: "Indicates whether FSMA compliance is required for this segment — used to track regulatory compliance requirements across the segment portfolio."
    - name: "agronomic_service_tier"
      expr: agronomic_service_tier
      comment: "Level of agronomic service provided to the segment (e.g. Full Service, Self-Serve) — used to align service cost with segment value."
    - name: "effective_from"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the segment became effective — used to track segment creation and refresh cadence."
  measures:
    - name: "total_active_segments"
      expr: COUNT(CASE WHEN segment_status = 'Active' THEN segment_id END)
      comment: "Total number of active customer segments — measures the granularity and coverage of the segmentation model; used in go-to-market strategy reviews."
    - name: "total_volume_commitment_mt"
      expr: SUM(CAST(volume_commitment_mt AS DOUBLE))
      comment: "Total volume commitment in metric tonnes across all segments — aggregates contracted demand by segment; used to align supply planning with segmented customer commitments."
    - name: "total_credit_limit_usd"
      expr: SUM(CAST(credit_limit_usd AS DOUBLE))
      comment: "Total credit limit allocated across all segments — measures aggregate credit exposure by segment design; used by Finance to validate segment-level credit policies."
    - name: "avg_max_segment_score"
      expr: AVG(CAST(max_segment_score AS DOUBLE))
      comment: "Average maximum segment score across all segments — benchmarks the scoring ceiling of the segmentation model; used to calibrate ML model versions and scoring thresholds."
    - name: "total_revenue_band_max_usd"
      expr: SUM(CAST(revenue_band_max_usd AS DOUBLE))
      comment: "Sum of the upper revenue band limits across all segments — measures the total addressable revenue ceiling defined by the segmentation model; used to validate revenue band design against actual portfolio revenue."
    - name: "organic_required_segment_count"
      expr: COUNT(CASE WHEN organic_cert_required = TRUE THEN segment_id END)
      comment: "Number of segments requiring organic certification — quantifies the organic-compliant segment base; used to size procurement requirements for certified organic supply."
    - name: "fsma_required_segment_count"
      expr: COUNT(CASE WHEN fsma_compliance_required = TRUE THEN segment_id END)
      comment: "Number of segments with mandatory FSMA compliance — measures regulatory compliance scope across the segmentation model; used by Regulatory Affairs to prioritise compliance programme investments."
$$;