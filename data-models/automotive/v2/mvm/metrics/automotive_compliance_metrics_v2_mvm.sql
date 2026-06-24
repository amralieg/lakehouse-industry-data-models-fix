-- Metric views for domain: compliance | Business: Automotive | Version: 2 | Generated on: 2026-06-23 05:54:22

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_emissions_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for vehicle emissions certification performance. Tracks CO2 and pollutant levels against certified thresholds, certification status distribution, and carbon credit eligibility — enabling regulatory compliance officers and sustainability executives to monitor fleet-wide emissions posture and ESG reporting readiness."
  source: "`vibe_automotive_v1`.`compliance`.`emissions_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the emissions certification (e.g., Active, Expired, Pending) — primary grouping for compliance health dashboards."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type of the certified vehicle (e.g., BEV, PHEV, ICE, Hydrogen) — critical for ESG and powertrain transition analysis."
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain classification of the certified vehicle — used to segment emissions performance by technology type."
    - name: "emission_standard"
      expr: emission_standard
      comment: "Regulatory emission standard the vehicle was certified against (e.g., Euro 6, CARB LEV III) — essential for multi-jurisdiction compliance tracking."
    - name: "test_cycle"
      expr: test_cycle
      comment: "Test cycle used for certification (e.g., WLTP, NEDC, FTP-75) — affects comparability of emissions figures across markets."
    - name: "esg_reporting_framework"
      expr: esg_reporting_framework
      comment: "ESG framework under which this certification is reported (e.g., GRI, TCFD) — supports sustainability disclosure alignment."
    - name: "carbon_credit_eligible"
      expr: carbon_credit_eligible
      comment: "Whether the certified vehicle qualifies for carbon credits — used to quantify regulatory credit portfolio value."
    - name: "eu_taxonomy_eligible_flag"
      expr: eu_taxonomy_eligible_flag
      comment: "Whether the certification qualifies under EU Taxonomy for sustainable activities — critical for green finance and ESG reporting."
    - name: "certification_year"
      expr: DATE_TRUNC('YEAR', certification_date)
      comment: "Year of certification — enables year-over-year trend analysis of emissions performance."
    - name: "expiry_year"
      expr: DATE_TRUNC('YEAR', expiry_date)
      comment: "Year the certification expires — used to forecast upcoming re-certification workload and compliance risk."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of emissions certification records — baseline volume metric for compliance portfolio sizing."
    - name: "avg_co2_g_per_km"
      expr: AVG(CAST(co2_g_per_km AS DOUBLE))
      comment: "Average CO2 emissions (g/km) across certified vehicles — primary fleet-level emissions KPI for regulatory and ESG reporting."
    - name: "avg_certified_co2_g_per_km"
      expr: AVG(CAST(certified_co2_g_per_km AS DOUBLE))
      comment: "Average certified CO2 limit (g/km) — represents the regulatory threshold the fleet must meet; compare against avg_co2_g_per_km to assess headroom."
    - name: "avg_nox_mg_per_km"
      expr: AVG(CAST(nox_mg_per_km AS DOUBLE))
      comment: "Average NOx emissions (mg/km) across certified vehicles — key air quality pollutant metric tracked by regulators globally."
    - name: "avg_pm_mg_per_km"
      expr: AVG(CAST(pm_mg_per_km AS DOUBLE))
      comment: "Average particulate matter emissions (mg/km) — critical health-impact pollutant metric for urban compliance and ESG reporting."
    - name: "carbon_credit_eligible_count"
      expr: COUNT(CASE WHEN carbon_credit_eligible = TRUE THEN 1 END)
      comment: "Number of certifications eligible for carbon credits — quantifies the regulatory credit portfolio available for trading or offset."
    - name: "eu_taxonomy_eligible_count"
      expr: COUNT(CASE WHEN eu_taxonomy_eligible_flag = TRUE THEN 1 END)
      comment: "Number of certifications qualifying under EU Taxonomy — directly supports green finance disclosures and sustainable investment reporting."
    - name: "active_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN 1 END)
      comment: "Count of currently active emissions certifications — operational compliance health indicator; a drop signals regulatory exposure."
    - name: "co2_compliance_gap_avg"
      expr: AVG(CAST(co2_emissions_g_per_km AS DOUBLE) - CAST(certified_co2_g_per_km AS DOUBLE))
      comment: "Average difference between actual CO2 emissions and the certified CO2 limit (g/km). Positive values indicate vehicles exceeding their certified threshold — a direct regulatory risk signal."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_recall_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive-level KPIs for vehicle recall campaign management. Tracks recall volume, financial exposure, completion rates, and safety risk — enabling product safety officers, legal, and C-suite to monitor recall performance, cost liability, and regulatory compliance posture."
  source: "`vibe_automotive_v1`.`compliance`.`recall_campaign`"
  dimensions:
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall campaign (e.g., Open, Closed, In Progress) — primary filter for active safety risk monitoring."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Operational status of the recall campaign execution — used to track campaign lifecycle stage."
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Whether the recall has an environmental impact component — used to segment recalls with ESG and regulatory reporting implications."
    - name: "initiation_year"
      expr: DATE_TRUNC('YEAR', initiation_date)
      comment: "Year the recall was initiated — enables year-over-year recall trend analysis for product safety governance."
    - name: "launch_year"
      expr: DATE_TRUNC('YEAR', launch_date)
      comment: "Year the recall campaign was launched to the market — used to measure time-to-launch from initiation."
    - name: "completion_target_year"
      expr: DATE_TRUNC('YEAR', completion_target_date)
      comment: "Target year for recall completion — used to forecast workload and identify campaigns at risk of missing deadlines."
  measures:
    - name: "total_recall_campaigns"
      expr: COUNT(1)
      comment: "Total number of recall campaigns — baseline volume metric for product safety portfolio sizing and regulatory reporting."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated financial cost across all recall campaigns — primary financial liability metric for CFO and legal risk management."
    - name: "avg_estimated_cost_per_campaign"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per recall campaign — benchmarking metric for recall cost efficiency and budget planning."
    - name: "avg_completion_rate_pct"
      expr: AVG(CAST(completion_rate_percent AS DOUBLE))
      comment: "Average recall completion rate (%) across campaigns — key operational KPI; low rates signal unresolved safety risks and potential regulatory penalties."
    - name: "open_recall_campaigns"
      expr: COUNT(CASE WHEN recall_status = 'Open' THEN 1 END)
      comment: "Number of currently open recall campaigns — direct measure of unresolved safety exposure; tracked by regulators and executives."
    - name: "environmental_impact_recall_count"
      expr: COUNT(CASE WHEN environmental_impact_flag = TRUE THEN 1 END)
      comment: "Number of recall campaigns with environmental impact — supports ESG risk reporting and environmental liability quantification."
    - name: "total_completion_rate"
      expr: SUM(CAST(completion_rate AS DOUBLE))
      comment: "Sum of completion rates across campaigns — used as numerator when computing weighted average completion rates in BI tools."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_homologation_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market access and type-approval KPIs for vehicle homologation. Tracks approval status, market coverage, EU taxonomy alignment, and expiry risk — enabling regulatory affairs teams and executives to manage market entry compliance and anticipate re-approval workload."
  source: "`vibe_automotive_v1`.`compliance`.`homologation_record`"
  dimensions:
    - name: "homologation_status"
      expr: homologation_status
      comment: "Current status of the homologation record (e.g., Approved, Pending, Expired) — primary compliance health indicator for market access."
    - name: "market_code"
      expr: market_code
      comment: "Market or country code for which homologation was granted — enables geographic compliance coverage analysis."
    - name: "type_approval_category"
      expr: type_approval_category
      comment: "Vehicle type approval category (e.g., M1, N1, L-category) — used to segment homologation portfolio by vehicle class."
    - name: "eu_taxonomy_activity_code"
      expr: eu_taxonomy_activity_code
      comment: "EU Taxonomy activity code associated with the homologation — supports green finance and sustainable investment reporting."
    - name: "approval_year"
      expr: DATE_TRUNC('YEAR', approval_date)
      comment: "Year of homologation approval — enables year-over-year market entry trend analysis."
    - name: "expiry_year"
      expr: DATE_TRUNC('YEAR', expiry_date)
      comment: "Year the homologation expires — critical for proactive re-approval planning and market access risk management."
  measures:
    - name: "total_homologation_records"
      expr: COUNT(1)
      comment: "Total number of homologation records — baseline metric for market access portfolio size."
    - name: "approved_homologations"
      expr: COUNT(CASE WHEN homologation_status = 'Approved' THEN 1 END)
      comment: "Number of currently approved homologations — direct measure of active market access; a decline signals market entry risk."
    - name: "pending_homologations"
      expr: COUNT(CASE WHEN homologation_status = 'Pending' THEN 1 END)
      comment: "Number of homologations awaiting approval — pipeline metric for regulatory affairs workload and launch readiness."
    - name: "expired_homologations"
      expr: COUNT(CASE WHEN homologation_status = 'Expired' THEN 1 END)
      comment: "Number of expired homologations — risk metric indicating vehicles that may no longer be legally sold in their target markets."
    - name: "distinct_markets_covered"
      expr: COUNT(DISTINCT market_code)
      comment: "Number of distinct markets with at least one homologation record — measures geographic compliance coverage breadth."
    - name: "eu_taxonomy_aligned_count"
      expr: COUNT(CASE WHEN eu_taxonomy_activity_code IS NOT NULL THEN 1 END)
      comment: "Number of homologations with an EU Taxonomy activity code — quantifies the sustainable vehicle portfolio eligible for green finance instruments."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory submission timeliness and pipeline KPIs. Tracks submission volumes, on-time delivery rates, and ESG submission types — enabling compliance officers and executives to monitor regulatory filing health, identify overdue submissions, and manage regulatory relationship risk."
  source: "`vibe_automotive_v1`.`compliance`.`regulatory_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the regulatory submission (e.g., Submitted, Pending, Overdue, Accepted) — primary compliance health dimension."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (e.g., Type Approval, Recall Notification, Emissions Report) — used to segment submission workload by category."
    - name: "esg_submission_type"
      expr: esg_submission_type
      comment: "ESG-specific submission classification — enables tracking of sustainability-related regulatory filings separately from standard compliance submissions."
    - name: "submission_year"
      expr: DATE_TRUNC('YEAR', submission_date)
      comment: "Year the submission was filed — enables year-over-year regulatory filing volume trend analysis."
    - name: "due_year"
      expr: DATE_TRUNC('YEAR', due_date)
      comment: "Year the submission was due — used to identify cohorts of submissions by deadline year for timeliness analysis."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions — baseline volume metric for compliance filing workload and regulatory relationship management."
    - name: "submitted_on_time_count"
      expr: COUNT(CASE WHEN submission_date <= due_date THEN 1 END)
      comment: "Number of submissions filed on or before their due date — numerator for on-time submission rate; a key regulatory relationship health indicator."
    - name: "overdue_submissions"
      expr: COUNT(CASE WHEN submission_status = 'Overdue' THEN 1 END)
      comment: "Number of submissions currently overdue — direct regulatory risk metric; overdue filings can trigger penalties, audits, or market access suspension."
    - name: "esg_submissions_count"
      expr: COUNT(CASE WHEN esg_submission_type IS NOT NULL THEN 1 END)
      comment: "Number of ESG-related regulatory submissions — tracks sustainability disclosure filing volume for ESG governance reporting."
    - name: "distinct_regulatory_bodies_filed"
      expr: COUNT(DISTINCT regulatory_body_id)
      comment: "Number of distinct regulatory bodies to which submissions have been made — measures regulatory engagement breadth and multi-jurisdiction compliance complexity."
    - name: "distinct_jurisdictions_filed"
      expr: COUNT(DISTINCT jurisdiction_id)
      comment: "Number of distinct jurisdictions covered by submissions — quantifies geographic regulatory footprint and compliance complexity."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_recall_defect_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product safety defect reporting KPIs. Tracks defect report volumes, environmental hazard exposure, and defect category distribution — enabling product safety, legal, and executive teams to monitor safety incident trends and prioritize recall remediation efforts."
  source: "`vibe_automotive_v1`.`compliance`.`recall_defect_report`"
  dimensions:
    - name: "defect_category"
      expr: defect_category
      comment: "Category of the reported defect (e.g., Electrical, Structural, Software) — primary dimension for root-cause analysis and safety risk prioritization."
    - name: "environmental_hazard_flag"
      expr: environmental_hazard_flag
      comment: "Whether the defect poses an environmental hazard — used to segment reports with ESG and environmental liability implications."
    - name: "report_year"
      expr: DATE_TRUNC('YEAR', report_date)
      comment: "Year the defect report was filed — enables year-over-year safety incident trend analysis."
  measures:
    - name: "total_defect_reports"
      expr: COUNT(1)
      comment: "Total number of recall defect reports — baseline safety incident volume metric for product safety governance and regulatory reporting."
    - name: "environmental_hazard_report_count"
      expr: COUNT(CASE WHEN environmental_hazard_flag = TRUE THEN 1 END)
      comment: "Number of defect reports flagged as environmental hazards — quantifies environmental liability exposure from product defects."
    - name: "distinct_recall_campaigns_with_defects"
      expr: COUNT(DISTINCT recall_campaign_id)
      comment: "Number of distinct recall campaigns with at least one defect report — measures breadth of active safety issues across the recall portfolio."
    - name: "distinct_defect_categories"
      expr: COUNT(DISTINCT defect_category)
      comment: "Number of distinct defect categories reported — measures diversity of safety failure modes; high values indicate systemic quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`compliance_regulatory_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory requirement portfolio KPIs. Tracks the volume, status, and sustainability relevance of regulatory requirements — enabling compliance strategy teams to monitor the regulatory landscape, prioritize compliance investments, and assess sustainability-driven regulatory exposure."
  source: "`vibe_automotive_v1`.`compliance`.`regulatory_requirement`"
  dimensions:
    - name: "requirement_status"
      expr: requirement_status
      comment: "Current status of the regulatory requirement (e.g., Active, Sunset, Proposed) — primary dimension for compliance landscape monitoring."
    - name: "requirement_category"
      expr: requirement_category
      comment: "Category of the regulatory requirement (e.g., Emissions, Safety, Labeling) — used to segment compliance obligations by domain."
    - name: "sustainability_relevance_flag"
      expr: sustainability_relevance_flag
      comment: "Whether the requirement has sustainability relevance — used to quantify the ESG-driven regulatory burden on the business."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the requirement becomes effective — used to forecast upcoming compliance obligations and resource planning."
    - name: "sunset_year"
      expr: DATE_TRUNC('YEAR', sunset_date)
      comment: "Year the requirement is sunset — used to identify expiring obligations and plan compliance wind-down activities."
  measures:
    - name: "total_requirements"
      expr: COUNT(1)
      comment: "Total number of regulatory requirements in scope — baseline metric for compliance obligation portfolio size."
    - name: "active_requirements"
      expr: COUNT(CASE WHEN requirement_status = 'Active' THEN 1 END)
      comment: "Number of currently active regulatory requirements — measures the live compliance obligation burden on the organization."
    - name: "sustainability_relevant_requirements"
      expr: COUNT(CASE WHEN sustainability_relevance_flag = TRUE THEN 1 END)
      comment: "Number of requirements with sustainability relevance — quantifies the ESG-driven regulatory compliance workload; rising counts signal increasing sustainability regulation pressure."
    - name: "distinct_jurisdictions_with_requirements"
      expr: COUNT(DISTINCT jurisdiction_id)
      comment: "Number of distinct jurisdictions imposing regulatory requirements — measures multi-jurisdiction compliance complexity and geographic regulatory footprint."
    - name: "distinct_regulatory_bodies"
      expr: COUNT(DISTINCT regulatory_body_id)
      comment: "Number of distinct regulatory bodies issuing requirements — quantifies the breadth of regulatory relationships the organization must manage."
$$;