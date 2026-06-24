-- Metric views for domain: compliance | Business: Automotive | Version: 2 | Generated on: 2026-06-23 04:49:37

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_recall_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive KPI view for recall campaign management: tracks recall volume, completion rates, estimated costs, and safety risk exposure across active and historical recall campaigns. Critical for regulatory reporting, NHTSA obligations, and executive safety governance."
  source: "`vibe_automotive_v1`.`compliance`.`recall_campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the recall campaign (e.g. Open, Closed, In Progress) — primary filter for operational dashboards."
    - name: "recall_status"
      expr: recall_status
      comment: "Regulatory recall status as reported to the authority (e.g. Active, Completed, Cancelled)."
    - name: "campaign_code"
      expr: campaign_code
      comment: "Unique campaign identifier code for drill-down analysis."
    - name: "nhtsa_campaign_number"
      expr: nhtsa_campaign_number
      comment: "NHTSA-assigned campaign number for US regulatory reporting and cross-referencing."
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Indicates whether the recall has an environmental impact dimension — used for ESG reporting segmentation."
    - name: "initiation_year"
      expr: DATE_TRUNC('YEAR', initiation_date)
      comment: "Year the recall was initiated — used for trend analysis and annual regulatory reporting."
    - name: "launch_year"
      expr: DATE_TRUNC('YEAR', launch_date)
      comment: "Year the recall remedy was launched to dealers/customers."
  measures:
    - name: "total_recall_campaigns"
      expr: COUNT(1)
      comment: "Total number of recall campaigns. Executives use this to track recall volume trends and regulatory exposure."
    - name: "total_estimated_recall_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated financial exposure across all recall campaigns. Directly informs reserve provisioning and financial risk management."
    - name: "avg_estimated_recall_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per recall campaign. Benchmarks cost efficiency of recall remediation programs."
    - name: "avg_completion_rate_pct"
      expr: AVG(CAST(completion_rate_percent AS DOUBLE))
      comment: "Average recall completion rate (%) across campaigns. Regulators and executives monitor this to ensure timely remedy delivery to affected customers."
    - name: "max_completion_rate_pct"
      expr: MAX(completion_rate_percent)
      comment: "Highest completion rate achieved across campaigns — used to benchmark best-in-class recall execution."
    - name: "min_completion_rate_pct"
      expr: MIN(completion_rate_percent)
      comment: "Lowest completion rate across campaigns — flags campaigns at risk of regulatory non-compliance due to low remedy uptake."
    - name: "open_recall_campaigns"
      expr: COUNT(CASE WHEN campaign_status = 'Open' THEN 1 END)
      comment: "Number of currently open recall campaigns. A key operational risk metric for the safety and compliance leadership team."
    - name: "environmental_impact_recall_count"
      expr: COUNT(CASE WHEN environmental_impact_flag = TRUE THEN 1 END)
      comment: "Number of recalls with an environmental impact flag — critical for ESG and CSRD reporting obligations."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_cafe_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet fuel economy and CAFE compliance KPI view. Tracks achieved vs. target MPG performance, penalty exposure, and carbon credit balances by fleet type and model year. Used by regulatory affairs and sustainability leadership for CAFE obligation management."
  source: "`vibe_automotive_v1`.`compliance`.`cafe_compliance_record`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "CAFE compliance status (e.g. Compliant, Non-Compliant, Pending) — primary executive filter."
    - name: "fleet_type"
      expr: fleet_type
      comment: "Fleet type (e.g. Passenger Car, Light Truck) — CAFE standards differ by fleet type."
    - name: "model_year"
      expr: model_year
      comment: "Model year of the CAFE compliance record — enables year-over-year trend analysis."
    - name: "eu_taxonomy_activity_code"
      expr: eu_taxonomy_activity_code
      comment: "EU Taxonomy activity classification — used for ESG and sustainable finance reporting."
    - name: "csrd_disclosure_reference"
      expr: csrd_disclosure_reference
      comment: "CSRD disclosure reference — links CAFE records to corporate sustainability reporting obligations."
    - name: "record_year"
      expr: DATE_TRUNC('YEAR', created_timestamp)
      comment: "Year the CAFE record was created — used for longitudinal compliance trend analysis."
  measures:
    - name: "total_cafe_records"
      expr: COUNT(1)
      comment: "Total number of CAFE compliance records. Baseline volume metric for regulatory reporting coverage."
    - name: "avg_achieved_mpg"
      expr: AVG(CAST(achieved_mpg AS DOUBLE))
      comment: "Average achieved fleet MPG across all CAFE records. Core metric for fuel economy performance vs. regulatory targets."
    - name: "avg_target_mpg"
      expr: AVG(CAST(target_mpg AS DOUBLE))
      comment: "Average CAFE MPG target across records. Paired with avg_achieved_mpg to assess compliance gap."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total CAFE penalty exposure in dollars. Directly informs financial risk provisioning and regulatory affairs investment decisions."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per non-compliant CAFE record. Benchmarks penalty severity and guides compliance investment prioritization."
    - name: "total_credit_balance"
      expr: SUM(CAST(credit_balance AS DOUBLE))
      comment: "Total CAFE credit balance available for trading or offsetting future non-compliance. A strategic asset for regulatory planning."
    - name: "non_compliant_record_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of non-compliant CAFE records. Executives use this to assess regulatory risk exposure and prioritize remediation."
    - name: "avg_mpg_gap"
      expr: AVG(CAST(target_mpg AS DOUBLE) - CAST(achieved_mpg AS DOUBLE))
      comment: "Average gap between CAFE target and achieved MPG. Positive values indicate under-performance; drives product planning decisions on electrification and fuel economy investment."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_emissions_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle emissions certification KPI view. Tracks CO2 performance, NOx/PM emissions, certification status, and carbon credit eligibility across models, fuel types, and jurisdictions. Used by regulatory affairs, product planning, and ESG reporting teams."
  source: "`vibe_automotive_v1`.`compliance`.`compliance_emissions_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current certification status (e.g. Certified, Expired, Pending) — primary operational filter."
    - name: "emission_standard"
      expr: emission_standard
      comment: "Applicable emission standard (e.g. Euro 6, EPA Tier 3) — critical for market access and regulatory reporting segmentation."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type of the certified vehicle (e.g. BEV, PHEV, Diesel, Petrol) — key dimension for electrification strategy analysis."
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain technology type — used to segment emissions performance by technology."
    - name: "carbon_credit_eligible"
      expr: carbon_credit_eligible
      comment: "Whether the certification generates carbon credits — used for ZEV credit portfolio management."
    - name: "eu_taxonomy_eligible_flag"
      expr: eu_taxonomy_eligible_flag
      comment: "EU Taxonomy eligibility flag — critical for sustainable finance and ESG investor reporting."
    - name: "test_cycle"
      expr: test_cycle
      comment: "Test cycle used for certification (e.g. WLTP, NEDC, FTP-75) — affects comparability of emissions values."
    - name: "certification_year"
      expr: DATE_TRUNC('YEAR', certification_date)
      comment: "Year of certification — enables trend analysis of fleet emissions performance over time."
    - name: "esg_reporting_framework"
      expr: esg_reporting_framework
      comment: "ESG reporting framework under which this certification is disclosed (e.g. GRI, CSRD, CDP)."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of emissions certifications. Baseline coverage metric for regulatory affairs."
    - name: "avg_co2_g_per_km"
      expr: AVG(CAST(co2_emissions_g_per_km AS DOUBLE))
      comment: "Average certified CO2 emissions (g/km) across the fleet. Core ESG and regulatory KPI — directly tied to EU fleet CO2 targets and CSRD reporting."
    - name: "avg_certified_co2_g_per_km"
      expr: AVG(CAST(certified_co2_g_per_km AS DOUBLE))
      comment: "Average officially certified CO2 value (g/km). Used for regulatory submission and type approval reporting."
    - name: "avg_nox_mg_per_km"
      expr: AVG(CAST(nox_mg_per_km AS DOUBLE))
      comment: "Average NOx emissions (mg/km) across certified vehicles. Regulators and product teams monitor this against Euro/EPA NOx limits."
    - name: "avg_pm_mg_per_km"
      expr: AVG(CAST(pm_mg_per_km AS DOUBLE))
      comment: "Average particulate matter emissions (mg/km). Key air quality metric for urban market access and regulatory compliance."
    - name: "carbon_credit_eligible_count"
      expr: COUNT(CASE WHEN carbon_credit_eligible = TRUE THEN 1 END)
      comment: "Number of certifications eligible for carbon credits. Informs ZEV credit portfolio strategy and regulatory trading decisions."
    - name: "eu_taxonomy_eligible_count"
      expr: COUNT(CASE WHEN eu_taxonomy_eligible_flag = TRUE THEN 1 END)
      comment: "Number of certifications qualifying under EU Taxonomy — critical for green bond issuance and sustainable finance reporting."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Expired' THEN 1 END)
      comment: "Number of expired certifications. Flags vehicles at risk of losing market access due to lapsed regulatory approvals."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_homologation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle type approval and homologation KPI view. Tracks homologation status, market coverage, CO2 limit compliance, and EU Taxonomy alignment across models and jurisdictions. Used by regulatory affairs and market launch teams."
  source: "`vibe_automotive_v1`.`compliance`.`homologation_record`"
  dimensions:
    - name: "homologation_status"
      expr: homologation_status
      comment: "Current homologation status (e.g. Approved, Pending, Expired) — primary filter for market launch readiness."
    - name: "type_approval_category"
      expr: type_approval_category
      comment: "Type approval category (e.g. M1, N1, L) — determines applicable regulatory framework."
    - name: "market_code"
      expr: market_code
      comment: "Market/country code for the homologation — enables geographic coverage analysis."
    - name: "regulation_reference"
      expr: regulation_reference
      comment: "Applicable regulation reference (e.g. UN ECE R100, FMVSS) — used for regulatory framework segmentation."
    - name: "eu_taxonomy_activity_code"
      expr: eu_taxonomy_activity_code
      comment: "EU Taxonomy activity code — links homologation to sustainable finance classification."
    - name: "approval_year"
      expr: DATE_TRUNC('YEAR', approval_date)
      comment: "Year of homologation approval — used for trend analysis of market entry timelines."
    - name: "expiry_year"
      expr: DATE_TRUNC('YEAR', expiry_date)
      comment: "Year of homologation expiry — used to proactively identify renewals required."
  measures:
    - name: "total_homologation_records"
      expr: COUNT(1)
      comment: "Total number of homologation records. Baseline metric for regulatory market coverage."
    - name: "approved_homologations"
      expr: COUNT(CASE WHEN homologation_status = 'Approved' THEN 1 END)
      comment: "Number of approved homologations. Directly measures market access readiness for vehicle launches."
    - name: "pending_homologations"
      expr: COUNT(CASE WHEN homologation_status = 'Pending' THEN 1 END)
      comment: "Number of homologations pending approval. Flags potential launch delays requiring regulatory affairs intervention."
    - name: "expired_homologations"
      expr: COUNT(CASE WHEN homologation_status = 'Expired' THEN 1 END)
      comment: "Number of expired homologations. Vehicles with expired homologations cannot be legally sold — critical risk metric."
    - name: "distinct_markets_covered"
      expr: COUNT(DISTINCT market_code)
      comment: "Number of distinct markets with homologation records. Measures global regulatory coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance audit finding KPI view. Tracks finding volume, severity distribution, ESG-related findings, and resolution status. Used by compliance officers, internal audit, and ESG reporting teams to manage regulatory risk and corrective action pipelines."
  source: "`vibe_automotive_v1`.`compliance`.`compliance_audit_finding`"
  dimensions:
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the audit finding (e.g. Open, Closed, In Remediation) — primary operational filter."
    - name: "finding_type"
      expr: finding_type
      comment: "Type of audit finding (e.g. Major Non-Conformance, Minor, Observation) — used for risk prioritization."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the finding — executives use this to prioritize remediation resources."
    - name: "esg_pillar"
      expr: esg_pillar
      comment: "ESG pillar (Environmental, Social, Governance) — used for CSRD and ESG reporting segmentation."
    - name: "esg_finding_category"
      expr: esg_finding_category
      comment: "ESG-specific finding category — enables granular ESG risk reporting."
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for resolving the finding — used for accountability tracking."
    - name: "identified_year"
      expr: DATE_TRUNC('YEAR', identified_date)
      comment: "Year the finding was identified — enables trend analysis of audit finding rates."
    - name: "due_year"
      expr: DATE_TRUNC('YEAR', due_date)
      comment: "Year the finding remediation is due — used for workload planning and overdue risk identification."
  measures:
    - name: "total_audit_findings"
      expr: COUNT(1)
      comment: "Total number of compliance audit findings. Baseline metric for regulatory risk exposure volume."
    - name: "open_findings"
      expr: COUNT(CASE WHEN finding_status = 'Open' THEN 1 END)
      comment: "Number of open audit findings. Executives use this to assess unresolved compliance risk requiring immediate action."
    - name: "esg_related_findings"
      expr: COUNT(CASE WHEN esg_pillar IS NOT NULL THEN 1 END)
      comment: "Number of findings with an ESG pillar classification. Measures ESG compliance risk exposure for CSRD and investor reporting."
    - name: "distinct_responsible_parties"
      expr: COUNT(DISTINCT responsible_party)
      comment: "Number of distinct parties with open compliance findings. Measures breadth of organizational compliance risk."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance corrective action KPI view. Tracks action volume, completion rates, ESG impact, and effectiveness verification. Used by compliance officers and ESG teams to manage remediation pipelines and demonstrate regulatory responsiveness."
  source: "`vibe_automotive_v1`.`compliance`.`compliance_corrective_action`"
  dimensions:
    - name: "action_status"
      expr: action_status
      comment: "Current status of the corrective action (e.g. Open, Completed, Overdue) — primary operational filter."
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action (e.g. Process Change, Training, System Fix) — used for root cause pattern analysis."
    - name: "esg_related_flag"
      expr: esg_related_flag
      comment: "Whether the corrective action is ESG-related — used for ESG remediation reporting."
    - name: "esg_impact_area"
      expr: esg_impact_area
      comment: "ESG impact area addressed by the action (e.g. Emissions, Labor, Governance) — enables ESG pillar-level remediation tracking."
    - name: "effectiveness_verified"
      expr: effectiveness_verified
      comment: "Whether the corrective action effectiveness has been verified — key quality gate for audit closure."
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for executing the corrective action — used for accountability and workload analysis."
    - name: "completion_year"
      expr: DATE_TRUNC('YEAR', completion_date)
      comment: "Year the corrective action was completed — used for trend analysis of remediation velocity."
    - name: "due_year"
      expr: DATE_TRUNC('YEAR', due_date)
      comment: "Year the corrective action is due — used to identify overdue actions requiring escalation."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of compliance corrective actions. Baseline metric for remediation pipeline volume."
    - name: "open_corrective_actions"
      expr: COUNT(CASE WHEN action_status = 'Open' THEN 1 END)
      comment: "Number of open corrective actions. Executives use this to assess unresolved compliance remediation backlog."
    - name: "completed_corrective_actions"
      expr: COUNT(CASE WHEN action_status = 'Completed' THEN 1 END)
      comment: "Number of completed corrective actions. Measures remediation throughput and regulatory responsiveness."
    - name: "effectiveness_verified_count"
      expr: COUNT(CASE WHEN effectiveness_verified = TRUE THEN 1 END)
      comment: "Number of corrective actions with verified effectiveness. Regulators and auditors require this as evidence of sustainable compliance improvement."
    - name: "esg_corrective_action_count"
      expr: COUNT(CASE WHEN esg_related_flag = TRUE THEN 1 END)
      comment: "Number of ESG-related corrective actions. Used for CSRD and ESG reporting to demonstrate active sustainability governance."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_emissions_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plant-level emissions monitoring KPI view. Tracks measured vs. limit values, exceedance rates, and ESG scope classification for environmental permit compliance. Used by environmental compliance, plant management, and ESG reporting teams."
  source: "`vibe_automotive_v1`.`compliance`.`emissions_monitoring_reading`"
  dimensions:
    - name: "parameter_name"
      expr: parameter_name
      comment: "Emissions parameter being monitored (e.g. CO2, NOx, VOC, PM) — primary dimension for environmental compliance analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the emissions reading — ensures correct interpretation of measured values."
    - name: "esg_scope_category"
      expr: esg_scope_category
      comment: "GHG Protocol scope classification (Scope 1, 2, 3) — critical for CSRD and CDP emissions reporting."
    - name: "esg_reporting_category"
      expr: esg_reporting_category
      comment: "ESG reporting category for the reading — used for structured ESG disclosure."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality flag for the reading — used to filter out unreliable readings from compliance calculations."
    - name: "reading_month"
      expr: DATE_TRUNC('MONTH', reading_timestamp)
      comment: "Month of the emissions reading — enables monthly trend analysis for permit compliance reporting."
    - name: "reading_year"
      expr: DATE_TRUNC('YEAR', reading_timestamp)
      comment: "Year of the emissions reading — used for annual environmental permit compliance reporting."
  measures:
    - name: "total_readings"
      expr: COUNT(1)
      comment: "Total number of emissions monitoring readings. Baseline metric for monitoring program coverage and data completeness."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured emissions value across readings. Core metric for environmental performance trending and permit compliance assessment."
    - name: "avg_limit_value"
      expr: AVG(CAST(limit_value AS DOUBLE))
      comment: "Average permitted limit value across readings. Paired with avg_measured_value to assess compliance headroom."
    - name: "max_measured_value"
      expr: MAX(measured_value)
      comment: "Maximum measured emissions value — identifies peak exceedance events requiring regulatory notification."
    - name: "exceedance_reading_count"
      expr: COUNT(CASE WHEN measured_value > limit_value THEN 1 END)
      comment: "Number of readings where measured value exceeded the permitted limit. Directly triggers regulatory reporting obligations and environmental enforcement risk."
    - name: "poor_data_quality_reading_count"
      expr: COUNT(CASE WHEN data_quality_flag = TRUE THEN 1 END)
      comment: "Number of readings flagged for poor data quality. Used to assess monitoring system reliability and data governance compliance."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory submission KPI view. Tracks submission volumes, on-time performance, and ESG submission types across regulatory bodies and jurisdictions. Used by regulatory affairs leadership to manage submission calendars and compliance obligations."
  source: "`vibe_automotive_v1`.`compliance`.`regulatory_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current submission status (e.g. Submitted, Pending, Overdue) — primary operational filter."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (e.g. Annual Report, Type Approval, Emissions Declaration) — used for workload categorization."
    - name: "esg_submission_type"
      expr: esg_submission_type
      comment: "ESG-specific submission type (e.g. CSRD, CDP, EU Taxonomy) — used for sustainability reporting pipeline management."
    - name: "submission_year"
      expr: DATE_TRUNC('YEAR', submission_date)
      comment: "Year of submission — enables annual submission volume trend analysis."
    - name: "due_year"
      expr: DATE_TRUNC('YEAR', due_date)
      comment: "Year the submission was due — used to identify late submissions and regulatory risk."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions. Baseline metric for regulatory affairs workload and coverage."
    - name: "submitted_on_time_count"
      expr: COUNT(CASE WHEN submission_status = 'Submitted' AND submission_date <= due_date THEN 1 END)
      comment: "Number of submissions filed on or before the due date. Measures regulatory compliance timeliness — late submissions trigger penalties and enforcement actions."
    - name: "overdue_submission_count"
      expr: COUNT(CASE WHEN submission_status = 'Overdue' THEN 1 END)
      comment: "Number of overdue regulatory submissions. Executives use this to assess regulatory penalty risk and prioritize compliance resources."
    - name: "esg_submission_count"
      expr: COUNT(CASE WHEN esg_submission_type IS NOT NULL THEN 1 END)
      comment: "Number of ESG-specific regulatory submissions. Tracks ESG disclosure obligation fulfillment for CSRD, CDP, and EU Taxonomy reporting."
    - name: "distinct_submission_types"
      expr: COUNT(DISTINCT submission_type)
      comment: "Number of distinct submission types managed. Measures breadth of regulatory reporting obligations."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_zev_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Zero Emission Vehicle (ZEV) credit portfolio KPI view. Tracks credit values, transaction types, EU Taxonomy alignment, and credit status by model year and jurisdiction. Used by regulatory affairs and sustainability leadership for ZEV mandate compliance and credit trading strategy."
  source: "`vibe_automotive_v1`.`compliance`.`zev_credit`"
  dimensions:
    - name: "credit_status"
      expr: credit_status
      comment: "Current ZEV credit status (e.g. Active, Retired, Transferred) — primary filter for portfolio management."
    - name: "credit_type"
      expr: credit_type
      comment: "Type of ZEV credit (e.g. BEV, PHEV, FCEV) — used for technology-level credit portfolio analysis."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Transaction type (e.g. Earned, Traded, Banked, Deficit) — used for credit flow analysis."
    - name: "model_year"
      expr: model_year
      comment: "Model year associated with the ZEV credit — enables vintage analysis of credit portfolio."
    - name: "eu_taxonomy_aligned_flag"
      expr: eu_taxonomy_aligned_flag
      comment: "Whether the ZEV credit is EU Taxonomy aligned — used for sustainable finance and green bond reporting."
    - name: "credit_year"
      expr: DATE_TRUNC('YEAR', created_timestamp)
      comment: "Year the ZEV credit record was created — used for annual credit generation trend analysis."
  measures:
    - name: "total_zev_credit_records"
      expr: COUNT(1)
      comment: "Total number of ZEV credit records. Baseline metric for credit portfolio size."
    - name: "total_credit_value"
      expr: SUM(CAST(credit_value AS DOUBLE))
      comment: "Total ZEV credit value in the portfolio. Core strategic metric — ZEV credits have direct monetary value through trading and mandate compliance."
    - name: "avg_credit_value"
      expr: AVG(CAST(credit_value AS DOUBLE))
      comment: "Average ZEV credit value per record. Used to benchmark credit generation efficiency by model and technology type."
    - name: "active_credit_value"
      expr: SUM(CASE WHEN credit_status = 'Active' THEN credit_value ELSE 0 END)
      comment: "Total value of active (usable) ZEV credits. Directly informs ZEV mandate compliance position and trading strategy."
    - name: "eu_taxonomy_aligned_credit_value"
      expr: SUM(CASE WHEN eu_taxonomy_aligned_flag = TRUE THEN credit_value ELSE 0 END)
      comment: "Total ZEV credit value that is EU Taxonomy aligned. Used for sustainable finance reporting and green bond eligibility calculations."
    - name: "distinct_credit_types"
      expr: COUNT(DISTINCT credit_type)
      comment: "Number of distinct ZEV credit types in the portfolio. Measures technology diversification of the ZEV compliance strategy."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_ncap_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NCAP safety rating KPI view. Tracks safety scores across occupant, pedestrian, and safety assist categories, plus environmental ratings. Used by product safety leadership and marketing to manage safety brand positioning and regulatory star rating targets."
  source: "`vibe_automotive_v1`.`compliance`.`ncap_submission`"
  dimensions:
    - name: "ncap_program"
      expr: ncap_program
      comment: "NCAP program (e.g. Euro NCAP, NHTSA, ANCAP) — primary dimension for regional safety rating analysis."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall NCAP star rating — the primary consumer-facing safety metric used in marketing and product positioning."
    - name: "submission_status"
      expr: submission_status
      comment: "Status of the NCAP submission (e.g. Submitted, Rated, Pending) — used for submission pipeline management."
    - name: "test_year"
      expr: test_year
      comment: "Year of the NCAP test — enables trend analysis of safety rating performance over model generations."
  measures:
    - name: "total_ncap_submissions"
      expr: COUNT(1)
      comment: "Total number of NCAP submissions. Baseline metric for safety testing program coverage."
    - name: "avg_adult_occupant_score"
      expr: AVG(CAST(adult_occupant_score AS DOUBLE))
      comment: "Average adult occupant protection score. Core safety KPI — directly impacts NCAP star rating and consumer purchase decisions."
    - name: "avg_child_occupant_score"
      expr: AVG(CAST(child_occupant_score AS DOUBLE))
      comment: "Average child occupant protection score. Regulatory and consumer safety metric for family vehicle positioning."
    - name: "avg_pedestrian_score"
      expr: AVG(CAST(pedestrian_score AS DOUBLE))
      comment: "Average pedestrian protection score. Increasingly important for urban market access and regulatory requirements."
    - name: "avg_safety_assist_score"
      expr: AVG(CAST(safety_assist_score AS DOUBLE))
      comment: "Average safety assist (ADAS) score. Measures active safety technology performance — key differentiator in premium segments."
    - name: "avg_environmental_rating_score"
      expr: AVG(CAST(environmental_rating_score AS DOUBLE))
      comment: "Average environmental rating score from NCAP. Tracks sustainability performance in safety testing — increasingly weighted in overall ratings."
    - name: "five_star_submission_count"
      expr: COUNT(CASE WHEN overall_rating = '5' THEN 1 END)
      comment: "Number of NCAP submissions achieving 5-star rating. Executives use this to track safety brand leadership and product quality targets."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_environmental_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental permit KPI view. Tracks permit status, ESG materiality, and expiry risk across plants and jurisdictions. Used by environmental compliance and plant management to ensure continuous permit validity and ESG reporting."
  source: "`vibe_automotive_v1`.`compliance`.`environmental_permit`"
  dimensions:
    - name: "permit_status"
      expr: permit_status
      comment: "Current permit status (e.g. Active, Expired, Under Review) — primary operational filter for compliance risk."
    - name: "permit_type"
      expr: permit_type
      comment: "Type of environmental permit (e.g. Air Emission, Water Discharge, Waste) — used for environmental compliance categorization."
    - name: "esg_category"
      expr: esg_category
      comment: "ESG category of the permit (e.g. Environmental, Climate) — used for ESG reporting segmentation."
    - name: "esg_materiality_flag"
      expr: esg_materiality_flag
      comment: "Whether the permit is ESG-material — used to prioritize permits for CSRD double materiality assessment."
    - name: "expiry_year"
      expr: DATE_TRUNC('YEAR', expiry_date)
      comment: "Year the permit expires — used for renewal pipeline planning and risk management."
    - name: "issue_year"
      expr: DATE_TRUNC('YEAR', issue_date)
      comment: "Year the permit was issued — used for permit vintage analysis."
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of environmental permits. Baseline metric for environmental compliance portfolio size."
    - name: "active_permits"
      expr: COUNT(CASE WHEN permit_status = 'Active' THEN 1 END)
      comment: "Number of currently active environmental permits. Plants cannot operate legally without valid permits — critical operational risk metric."
    - name: "expired_permits"
      expr: COUNT(CASE WHEN permit_status = 'Expired' THEN 1 END)
      comment: "Number of expired environmental permits. Expired permits represent immediate regulatory enforcement risk and potential plant shutdown exposure."
    - name: "esg_material_permit_count"
      expr: COUNT(CASE WHEN esg_materiality_flag = TRUE THEN 1 END)
      comment: "Number of ESG-material permits. Used for CSRD double materiality assessment and ESG investor reporting."
    - name: "distinct_permit_types"
      expr: COUNT(DISTINCT permit_type)
      comment: "Number of distinct environmental permit types managed. Measures breadth of environmental compliance obligations."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory compliance test result KPI view. Tracks pass/fail rates, measured vs. limit values, and ESG test categories. Used by regulatory affairs and engineering teams to manage type approval test performance and identify compliance gaps."
  source: "`vibe_automotive_v1`.`compliance`.`compliance_test_result`"
  dimensions:
    - name: "pass_fail_flag"
      expr: pass_fail_flag
      comment: "Whether the test result passed or failed — primary dimension for compliance test performance analysis."
    - name: "parameter_name"
      expr: parameter_name
      comment: "Test parameter name (e.g. CO2, NOx, Brake Performance) — used for parameter-level compliance analysis."
    - name: "test_condition"
      expr: test_condition
      comment: "Test condition under which the measurement was taken — used for test reproducibility and comparability analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the test result — ensures correct interpretation of measured vs. limit values."
    - name: "esg_test_category"
      expr: esg_test_category
      comment: "ESG test category — used to segment test results for environmental and sustainability reporting."
    - name: "result_year"
      expr: DATE_TRUNC('YEAR', created_timestamp)
      comment: "Year the test result was recorded — used for trend analysis of compliance test performance."
  measures:
    - name: "total_test_results"
      expr: COUNT(1)
      comment: "Total number of compliance test results. Baseline metric for regulatory testing program coverage."
    - name: "pass_count"
      expr: COUNT(CASE WHEN pass_fail_flag = TRUE THEN 1 END)
      comment: "Number of passing test results. Core metric for regulatory type approval readiness."
    - name: "fail_count"
      expr: COUNT(CASE WHEN pass_fail_flag = FALSE THEN 1 END)
      comment: "Number of failing test results. Executives use this to assess regulatory approval risk and prioritize engineering remediation."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured test value. Used to assess fleet-level compliance performance against regulatory limits."
    - name: "avg_limit_value"
      expr: AVG(CAST(limit_value AS DOUBLE))
      comment: "Average regulatory limit value across test results. Paired with avg_measured_value to assess compliance headroom."
    - name: "avg_compliance_margin"
      expr: AVG(CAST(limit_value AS DOUBLE) - CAST(measured_value AS DOUBLE))
      comment: "Average margin between regulatory limit and measured value. Positive values indicate compliance headroom; negative values indicate exceedances requiring immediate action."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_recall_defect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recall defect reporting metrics that drive safety and compliance actions."
  source: "`vibe_automotive_v1`.`compliance`.`recall_defect_report`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "recall_report_count"
      expr: COUNT(1)
      comment: "Number of recall defect reports filed"
$$;