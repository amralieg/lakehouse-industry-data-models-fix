-- Metric views for domain: laboratory | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 14:47:42

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_lab_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lab order volume, turnaround, send-out and cancellation KPIs used by lab operations leadership to steer throughput, vendor send-out strategy, and order-quality."
  source: "`vibe_healthcare_v1`.`laboratory`.`lab_order`"
  dimensions:
    - name: "order_date"
      expr: DATE_TRUNC('DAY', order_timestamp)
      comment: "Day the lab order was placed, for daily/weekly throughput trending."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_timestamp)
      comment: "Month bucket of the lab order for monthly volume trending."
    - name: "order_priority"
      expr: order_priority
      comment: "Order priority (e.g. STAT vs routine) for STAT mix and SLA analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order for backlog and completion analysis."
    - name: "performing_lab_location"
      expr: performing_lab_location
      comment: "Lab location performing the test for site-level capacity and routing decisions."
    - name: "specimen_type"
      expr: specimen_type
      comment: "Specimen type ordered, used for collection-mix and workload analysis."
  measures:
    - name: "Order Count"
      expr: COUNT(1)
      comment: "Total number of lab orders; baseline volume KPI for capacity and staffing planning."
    - name: "Distinct Patients Ordered"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Unique patients with lab orders; measures testing reach and patient panel size."
    - name: "Send Out Order Count"
      expr: COUNT(CASE WHEN is_send_out = TRUE THEN 1 END)
      comment: "Orders sent to reference labs; informs reference-lab cost and insourcing decisions."
    - name: "Send Out Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_send_out = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of orders sent out; high values flag insourcing/cost-reduction opportunities."
    - name: "Cancelled Order Count"
      expr: COUNT(CASE WHEN cancelled_timestamp IS NOT NULL THEN 1 END)
      comment: "Orders cancelled; tracks rework and ordering-quality issues."
    - name: "Cancellation Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cancelled_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of orders cancelled; elevated rates signal ordering or workflow problems."
    - name: "Point Of Care Order Count"
      expr: COUNT(CASE WHEN point_of_care_test = TRUE THEN 1 END)
      comment: "Point-of-care orders; supports decentralization and POC governance decisions."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test result quality and safety KPIs (critical value handling, abnormal rate, amendments) used by lab quality leaders and patient safety committees."
  source: "`vibe_healthcare_v1`.`laboratory`.`test_result`"
  dimensions:
    - name: "result_date"
      expr: DATE_TRUNC('DAY', result_datetime)
      comment: "Day the result was finalized, for turnaround and volume trending."
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_datetime)
      comment: "Month bucket of the result for monthly quality trending."
    - name: "result_status"
      expr: result_status
      comment: "Result lifecycle status for completion and pending-result monitoring."
    - name: "performing_lab_section"
      expr: performing_lab_section
      comment: "Lab section performing the test for section-level quality benchmarking."
    - name: "result_interpretation"
      expr: result_interpretation
      comment: "Clinical interpretation of the result for abnormal/critical pattern analysis."
  measures:
    - name: "Result Count"
      expr: COUNT(1)
      comment: "Total finalized results; baseline lab productivity KPI."
    - name: "Critical Value Count"
      expr: COUNT(CASE WHEN is_critical_value = TRUE THEN 1 END)
      comment: "Number of critical-value results; drives patient-safety escalation monitoring."
    - name: "Critical Value Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical_value = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of results flagged critical; informs notification-process resourcing."
    - name: "Abnormal Result Count"
      expr: COUNT(CASE WHEN abnormal_flag = TRUE THEN 1 END)
      comment: "Abnormal results count; supports clinical follow-up and population-health insight."
    - name: "Amended Result Count"
      expr: COUNT(CASE WHEN is_amended = TRUE THEN 1 END)
      comment: "Amended results; tracks result-accuracy and post-release correction risk."
    - name: "Amendment Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_amended = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of results amended; a key result-integrity quality metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_lab_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory revenue and charge KPIs used by finance and revenue-cycle leadership to monitor lab billing volume, STAT surcharge revenue, and reference-lab charge mix."
  source: "`vibe_healthcare_v1`.`laboratory`.`lab_charge`"
  dimensions:
    - name: "charge_date"
      expr: DATE_TRUNC('DAY', charge_created_timestamp)
      comment: "Day the charge was created, for daily revenue trending."
    - name: "charge_month"
      expr: DATE_TRUNC('MONTH', charge_created_timestamp)
      comment: "Month bucket of charges for monthly revenue reporting."
    - name: "performing_lab_section"
      expr: performing_lab_section
      comment: "Lab section performing the billed test for service-line revenue analysis."
    - name: "charge_entry_method"
      expr: charge_entry_method
      comment: "How the charge was entered for charge-capture process analysis."
    - name: "reference_lab_indicator"
      expr: reference_lab_indicator
      comment: "Whether the charge is for a reference (send-out) lab test, for outsourcing cost review."
  measures:
    - name: "Charge Count"
      expr: COUNT(1)
      comment: "Total lab charges; baseline billing-volume KPI for revenue-cycle steering."
    - name: "STAT Surcharge Revenue"
      expr: SUM(CAST(stat_surcharge_amount AS DOUBLE))
      comment: "Total STAT surcharge revenue; informs STAT pricing and demand decisions."
    - name: "Avg STAT Surcharge"
      expr: ROUND(AVG(CAST(stat_surcharge_amount AS DOUBLE)), 2)
      comment: "Average STAT surcharge per charge; monitors STAT premium per test."
    - name: "Voided Charge Count"
      expr: COUNT(CASE WHEN charge_voided_timestamp IS NOT NULL THEN 1 END)
      comment: "Voided charges; tracks revenue leakage and charge-capture rework."
    - name: "Reference Lab Charge Count"
      expr: COUNT(CASE WHEN reference_lab_indicator = TRUE THEN 1 END)
      comment: "Charges for reference-lab tests; supports outsourcing cost-management decisions."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_specimen`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Specimen pre-analytic quality KPIs (rejection rate, transport conditions) used by lab quality leadership to reduce redraws and pre-analytic error."
  source: "`vibe_healthcare_v1`.`laboratory`.`specimen`"
  dimensions:
    - name: "collection_date"
      expr: DATE_TRUNC('DAY', collection_datetime)
      comment: "Day the specimen was collected, for daily pre-analytic trending."
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_datetime)
      comment: "Month bucket of specimen collection for monthly quality reporting."
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of specimen, for collection-mix and rejection-pattern analysis."
    - name: "accession_status"
      expr: accession_status
      comment: "Accessioning status for backlog and processing analysis."
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason a specimen was rejected, for root-cause pre-analytic improvement."
    - name: "receiving_lab_location"
      expr: receiving_lab_location
      comment: "Receiving lab location for site-level pre-analytic benchmarking."
  measures:
    - name: "Specimen Count"
      expr: COUNT(1)
      comment: "Total specimens processed; baseline lab workload KPI."
    - name: "Rejected Specimen Count"
      expr: COUNT(CASE WHEN rejection_reason IS NOT NULL THEN 1 END)
      comment: "Specimens rejected; drives redraw cost and pre-analytic quality action."
    - name: "Specimen Rejection Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rejection_reason IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of specimens rejected; a core pre-analytic quality KPI tied to patient delay and cost."
    - name: "Avg Transport Duration Minutes"
      expr: ROUND(AVG(CAST(transport_duration_minutes AS DOUBLE)), 2)
      comment: "Average specimen transport time; long transit risks integrity and turnaround."
    - name: "Avg Volume Collected ML"
      expr: ROUND(AVG(CAST(volume_collected_ml AS DOUBLE)), 2)
      comment: "Average collected volume; under-fill drives recollection and QNS rejections."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_microbiology_culture`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Microbiology and infection-prevention KPIs (MDRO rate, HAI association, turnaround) used by infection-control and antimicrobial-stewardship leadership."
  source: "`vibe_healthcare_v1`.`laboratory`.`microbiology_culture`"
  dimensions:
    - name: "result_date"
      expr: DATE_TRUNC('DAY', result_datetime)
      comment: "Day the culture result was reported, for daily surveillance trending."
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_datetime)
      comment: "Month bucket of culture results for monthly infection-control reporting."
    - name: "culture_type"
      expr: culture_type
      comment: "Type of culture, for surveillance and workload segmentation."
    - name: "growth_result"
      expr: growth_result
      comment: "Growth outcome of the culture, for positivity-rate analysis."
    - name: "specimen_source_code"
      expr: specimen_source_code
      comment: "Specimen source for site-of-infection surveillance."
    - name: "mdro_type"
      expr: mdro_type
      comment: "Multidrug-resistant organism type for resistance-trend monitoring."
  measures:
    - name: "Culture Count"
      expr: COUNT(1)
      comment: "Total microbiology cultures; baseline micro workload KPI."
    - name: "MDRO Positive Count"
      expr: COUNT(CASE WHEN mdro_flag = TRUE THEN 1 END)
      comment: "Cultures positive for MDRO; central infection-prevention surveillance metric."
    - name: "MDRO Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mdro_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of cultures positive for MDRO; drives isolation and stewardship action."
    - name: "HAI Associated Count"
      expr: COUNT(CASE WHEN hai_associated_flag = TRUE THEN 1 END)
      comment: "Cultures associated with healthcare-acquired infection; key safety/quality metric."
    - name: "Public Health Reportable Count"
      expr: COUNT(CASE WHEN public_health_reportable_flag = TRUE THEN 1 END)
      comment: "Reportable organism cultures; ensures regulatory reporting compliance."
    - name: "Avg Turnaround Hours"
      expr: ROUND(AVG(CAST(turnaround_time_hours AS DOUBLE)), 2)
      comment: "Average culture turnaround; faster results enable timely antimicrobial decisions."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_qc_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality control and proficiency-testing KPIs (QC pass rate, PT z-score) used by lab directors to ensure CLIA compliance and analytic accuracy."
  source: "`vibe_healthcare_v1`.`laboratory`.`qc_run`"
  dimensions:
    - name: "qc_run_date"
      expr: DATE_TRUNC('DAY', qc_run_timestamp)
      comment: "Day of the QC run, for daily QC monitoring."
    - name: "qc_run_month"
      expr: DATE_TRUNC('MONTH', qc_run_timestamp)
      comment: "Month bucket of QC runs for monthly compliance reporting."
    - name: "qc_type"
      expr: qc_type
      comment: "Type of QC run for QC-program segmentation."
    - name: "qc_level"
      expr: qc_level
      comment: "QC material level for level-specific control analysis."
    - name: "qc_run_status"
      expr: qc_run_status
      comment: "Status of the QC run for review and exception tracking."
  measures:
    - name: "QC Run Count"
      expr: COUNT(1)
      comment: "Total QC runs; baseline QC-program volume KPI."
    - name: "QC Pass Count"
      expr: COUNT(CASE WHEN pass_fail_indicator = TRUE THEN 1 END)
      comment: "Passing QC runs; foundation for analytic-reliability monitoring."
    - name: "QC Pass Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of QC runs passing; core CLIA-compliance and accuracy KPI."
    - name: "Avg PT Z Score"
      expr: ROUND(AVG(CAST(pt_z_score AS DOUBLE)), 2)
      comment: "Average proficiency-testing z-score; measures peer-comparative analytic accuracy."
    - name: "Avg Observed Result"
      expr: ROUND(AVG(CAST(observed_result AS DOUBLE)), 4)
      comment: "Average observed QC result; supports bias/drift detection against expected mean."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_blood_bank_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blood bank inventory KPIs (wastage, cost, expiration) used by transfusion-service and supply-chain leadership to manage blood product utilization."
  source: "`vibe_healthcare_v1`.`laboratory`.`blood_bank_unit`"
  dimensions:
    - name: "donation_month"
      expr: DATE_TRUNC('MONTH', donation_date)
      comment: "Month bucket of donation for inventory aging analysis."
    - name: "product_type"
      expr: product_type
      comment: "Blood product type for product-mix and demand analysis."
    - name: "abo_blood_group"
      expr: abo_blood_group
      comment: "ABO blood group for inventory balance by blood type."
    - name: "rh_type"
      expr: rh_type
      comment: "Rh type for inventory balance and matching analysis."
    - name: "unit_status"
      expr: unit_status
      comment: "Current status of the blood unit for inventory and disposition analysis."
  measures:
    - name: "Blood Unit Count"
      expr: COUNT(1)
      comment: "Total blood units; baseline transfusion-service inventory KPI."
    - name: "Discarded Unit Count"
      expr: COUNT(CASE WHEN discard_timestamp IS NOT NULL THEN 1 END)
      comment: "Units discarded; tracks blood-product wastage and cost leakage."
    - name: "Wastage Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN discard_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of units discarded; a key cost and stewardship KPI for blood bank."
    - name: "Total Unit Cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total acquisition cost of blood units; informs blood-product budget management."
    - name: "Transfused Unit Count"
      expr: COUNT(CASE WHEN transfusion_timestamp IS NOT NULL THEN 1 END)
      comment: "Units transfused; supports utilization-rate and demand-planning decisions."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_transfusion_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transfusion safety KPIs (reaction rate, consent, hemovigilance) used by transfusion committee and patient-safety leadership."
  source: "`vibe_healthcare_v1`.`laboratory`.`transfusion_event`"
  dimensions:
    - name: "transfusion_date"
      expr: DATE_TRUNC('DAY', transfusion_start_datetime)
      comment: "Day the transfusion started, for daily safety trending."
    - name: "transfusion_month"
      expr: DATE_TRUNC('MONTH', transfusion_start_datetime)
      comment: "Month bucket of transfusions for monthly safety reporting."
    - name: "transfusion_status"
      expr: transfusion_status
      comment: "Status of the transfusion event for completion and disposition analysis."
    - name: "reaction_severity"
      expr: reaction_severity
      comment: "Severity of any transfusion reaction for safety-risk stratification."
    - name: "transfusion_reaction_type"
      expr: transfusion_reaction_type
      comment: "Type of transfusion reaction for reaction-pattern analysis."
  measures:
    - name: "Transfusion Event Count"
      expr: COUNT(1)
      comment: "Total transfusion events; baseline transfusion-service activity KPI."
    - name: "Reaction Count"
      expr: COUNT(CASE WHEN transfusion_reaction_occurred = TRUE THEN 1 END)
      comment: "Transfusions with a reaction; core transfusion-safety surveillance metric."
    - name: "Reaction Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN transfusion_reaction_occurred = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of transfusions with reaction; a key patient-safety KPI driving review action."
    - name: "Consent Obtained Count"
      expr: COUNT(CASE WHEN consent_obtained = TRUE THEN 1 END)
      comment: "Transfusions with documented consent; compliance KPI for informed-consent process."
    - name: "Hemovigilance Reported Count"
      expr: COUNT(CASE WHEN hemovigilance_reported = TRUE THEN 1 END)
      comment: "Events reported to hemovigilance; ensures regulatory reporting compliance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_susceptibility_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Antimicrobial susceptibility KPIs (resistance rate, stewardship flags) used by antimicrobial-stewardship and infection-control leadership."
  source: "`vibe_healthcare_v1`.`laboratory`.`susceptibility_result`"
  dimensions:
    - name: "result_date"
      expr: DATE_TRUNC('DAY', result_timestamp)
      comment: "Day the susceptibility result was reported, for resistance trending."
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_timestamp)
      comment: "Month bucket of susceptibility results for antibiogram reporting."
    - name: "antibiotic_agent_name"
      expr: antibiotic_agent_name
      comment: "Antibiotic agent tested, for agent-level resistance analysis."
    - name: "antibiotic_class"
      expr: antibiotic_class
      comment: "Antibiotic class for class-level resistance trending."
    - name: "susceptibility_interpretation"
      expr: susceptibility_interpretation
      comment: "Interpretation (S/I/R) for resistance-rate calculation and antibiogram."
  measures:
    - name: "Susceptibility Result Count"
      expr: COUNT(1)
      comment: "Total susceptibility results; baseline antibiogram volume KPI."
    - name: "Resistant Result Count"
      expr: COUNT(CASE WHEN susceptibility_interpretation = 'R' THEN 1 END)
      comment: "Resistant results; central antimicrobial-resistance surveillance metric."
    - name: "Resistance Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN susceptibility_interpretation = 'R' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of results resistant; drives stewardship policy and empiric-therapy decisions."
    - name: "Stewardship Flagged Count"
      expr: COUNT(CASE WHEN antibiotic_stewardship_flag = TRUE THEN 1 END)
      comment: "Results flagged for stewardship review; tracks stewardship-intervention workload."
    - name: "Avg MIC Value"
      expr: ROUND(AVG(CAST(mic_value AS DOUBLE)), 2)
      comment: "Average minimum inhibitory concentration; monitors MIC creep over time."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_molecular_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Molecular and genomic testing KPIs (variant detection, companion diagnostics, turnaround) used by precision-medicine and lab leadership."
  source: "`vibe_healthcare_v1`.`laboratory`.`molecular_test`"
  dimensions:
    - name: "result_date"
      expr: DATE_TRUNC('DAY', result_datetime)
      comment: "Day the molecular result was reported, for volume trending."
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_datetime)
      comment: "Month bucket of molecular results for monthly reporting."
    - name: "test_category"
      expr: test_category
      comment: "Molecular test category for service-line segmentation."
    - name: "test_type"
      expr: test_type
      comment: "Molecular test type for test-mix and demand analysis."
    - name: "clinical_significance"
      expr: clinical_significance
      comment: "Clinical significance of the result for actionable-result analysis."
    - name: "result_status"
      expr: result_status
      comment: "Result lifecycle status for completion and pending analysis."
  measures:
    - name: "Molecular Test Count"
      expr: COUNT(1)
      comment: "Total molecular tests; baseline precision-medicine volume KPI."
    - name: "Variant Detected Count"
      expr: COUNT(CASE WHEN variant_detected = TRUE THEN 1 END)
      comment: "Tests with a detected variant; supports precision-therapy decision insight."
    - name: "Variant Detection Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN variant_detected = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of tests detecting a variant; informs test-yield and utilization decisions."
    - name: "Companion Diagnostic Count"
      expr: COUNT(CASE WHEN companion_diagnostic = TRUE THEN 1 END)
      comment: "Companion-diagnostic tests; tracks therapy-linked test demand for pharma alignment."
    - name: "Critical Value Count"
      expr: COUNT(CASE WHEN critical_value = TRUE THEN 1 END)
      comment: "Molecular results flagged critical; drives clinical-notification process monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_instrument`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lab instrument asset and downtime KPIs used by lab operations and biomed leadership to manage uptime, maintenance, and capital decisions."
  source: "`vibe_healthcare_v1`.`laboratory`.`instrument`"
  dimensions:
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of lab instrument for asset-class segmentation."
    - name: "lab_section"
      expr: lab_section
      comment: "Lab section housing the instrument for section-level uptime analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status for availability and downtime analysis."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Instrument manufacturer for vendor-performance and service decisions."
    - name: "installation_month"
      expr: DATE_TRUNC('MONTH', installation_date)
      comment: "Month of installation for asset-age and replacement planning."
  measures:
    - name: "Instrument Count"
      expr: COUNT(1)
      comment: "Total instruments; baseline asset-inventory KPI for capacity planning."
    - name: "Total Downtime Hours"
      expr: SUM(CAST(total_downtime_hours AS DOUBLE))
      comment: "Total instrument downtime; drives maintenance and capital-replacement decisions."
    - name: "Avg Downtime Hours"
      expr: ROUND(AVG(CAST(total_downtime_hours AS DOUBLE)), 2)
      comment: "Average downtime per instrument; benchmarks reliability across the fleet."
    - name: "Total Acquisition Cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total instrument acquisition cost; informs lab capital-investment analysis."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_pathology_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Anatomic pathology KPIs (amendment rate, critical values, cancer registry reporting) used by pathology and quality leadership."
  source: "`vibe_healthcare_v1`.`laboratory`.`pathology_report`"
  dimensions:
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month the specimen was received in pathology, for volume trending."
    - name: "report_type"
      expr: report_type
      comment: "Type of pathology report for case-mix analysis."
    - name: "report_status"
      expr: report_status
      comment: "Report lifecycle status for turnaround and backlog analysis."
    - name: "histologic_grade"
      expr: histologic_grade
      comment: "Histologic grade for tumor-grade distribution analysis."
    - name: "tumor_site"
      expr: tumor_site
      comment: "Tumor site for oncology case-mix and registry analysis."
  measures:
    - name: "Pathology Report Count"
      expr: COUNT(1)
      comment: "Total pathology reports; baseline AP workload KPI."
    - name: "Amended Report Count"
      expr: COUNT(CASE WHEN is_amended = TRUE THEN 1 END)
      comment: "Amended pathology reports; key diagnostic-accuracy quality metric."
    - name: "Amendment Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_amended = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reports amended; tracks AP report-integrity for quality review."
    - name: "Cancer Registry Reportable Count"
      expr: COUNT(CASE WHEN cancer_registry_reportable_flag = TRUE THEN 1 END)
      comment: "Reportable cancer cases; ensures registry-reporting compliance and oncology insight."
    - name: "Critical Value Count"
      expr: COUNT(CASE WHEN critical_value_flag = TRUE THEN 1 END)
      comment: "Pathology critical values; drives notification-process safety monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_point_of_care_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point-of-care testing KPIs (QC compliance, EHR transmission, critical values) used by POCT coordinators and lab governance."
  source: "`vibe_healthcare_v1`.`laboratory`.`point_of_care_test`"
  dimensions:
    - name: "test_date"
      expr: DATE_TRUNC('DAY', test_datetime)
      comment: "Day the POC test was performed, for daily POCT trending."
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_datetime)
      comment: "Month bucket of POC tests for monthly governance reporting."
    - name: "device_type"
      expr: device_type
      comment: "POC device type for device-fleet and QC analysis."
    - name: "test_category"
      expr: test_category
      comment: "POC test category for test-mix analysis."
    - name: "performing_location_name"
      expr: performing_location_name
      comment: "Location performing POC testing for site-level compliance analysis."
    - name: "qc_status"
      expr: qc_status
      comment: "QC status of the POC test for quality-compliance monitoring."
  measures:
    - name: "POC Test Count"
      expr: COUNT(1)
      comment: "Total point-of-care tests; baseline POCT volume KPI."
    - name: "Abnormal Result Count"
      expr: COUNT(CASE WHEN abnormal_flag = TRUE THEN 1 END)
      comment: "Abnormal POC results; supports clinical follow-up and POCT value analysis."
    - name: "Critical Value Count"
      expr: COUNT(CASE WHEN critical_value_flag = TRUE THEN 1 END)
      comment: "Critical POC values; drives bedside escalation-process monitoring."
    - name: "Corrected Result Count"
      expr: COUNT(CASE WHEN corrected_result_flag = TRUE THEN 1 END)
      comment: "Corrected POC results; tracks POCT accuracy and operator-competency risk."
    - name: "EHR Transmission Failure Count"
      expr: COUNT(CASE WHEN ehr_transmission_status <> 'SUCCESS' THEN 1 END)
      comment: "POC results that failed EHR transmission; flags interface and documentation gaps."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_reagent_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reagent inventory and cost KPIs (recall exposure, validation, value on hand) used by lab supply-chain and quality leadership."
  source: "`vibe_healthcare_v1`.`laboratory`.`reagent_lot`"
  dimensions:
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month the reagent lot was received, for inventory aging analysis."
    - name: "reagent_type"
      expr: reagent_type
      comment: "Type of reagent for inventory-mix and cost analysis."
    - name: "lot_status"
      expr: lot_status
      comment: "Lot status for inventory disposition and quarantine analysis."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Reagent manufacturer for vendor-quality and sourcing decisions."
    - name: "qc_validation_status"
      expr: qc_validation_status
      comment: "QC validation status for lot-release compliance analysis."
  measures:
    - name: "Reagent Lot Count"
      expr: COUNT(1)
      comment: "Total reagent lots; baseline reagent-inventory KPI."
    - name: "Recalled Lot Count"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Reagent lots under recall; quantifies recall-exposure and safety risk."
    - name: "Total Lot Cost"
      expr: SUM(CAST(total_lot_cost AS DOUBLE))
      comment: "Total cost of reagent lots; informs lab reagent-budget management."
    - name: "Total Quantity On Hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total reagent quantity on hand; supports stock-out prevention and reorder decisions."
    - name: "Avg Cost Per Unit"
      expr: ROUND(AVG(CAST(cost_per_unit AS DOUBLE)), 2)
      comment: "Average reagent cost per unit; monitors reagent price trends for sourcing."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_test_coverage_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test payer-coverage KPIs (prior-auth burden, coverage mix, copay) used by revenue-cycle and managed-care leadership to manage reimbursement risk."
  source: "`vibe_healthcare_v1`.`laboratory`.`test_coverage_policy`"
  dimensions:
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the coverage policy became effective, for policy-change trending."
    - name: "coverage_status"
      expr: coverage_status
      comment: "Coverage status of the test policy for covered/non-covered analysis."
    - name: "coverage_determination"
      expr: coverage_determination
      comment: "Coverage determination outcome for reimbursement-risk analysis."
    - name: "policy_type"
      expr: policy_type
      comment: "Type of coverage policy for policy-mix analysis."
  measures:
    - name: "Coverage Policy Count"
      expr: COUNT(1)
      comment: "Total test coverage policies; baseline managed-care policy KPI."
    - name: "Prior Auth Required Count"
      expr: COUNT(CASE WHEN prior_authorization_required = TRUE THEN 1 END)
      comment: "Policies requiring prior auth; quantifies administrative-burden and denial risk."
    - name: "Prior Auth Required Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN prior_authorization_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of policies requiring prior auth; drives staffing for auth workflows."
    - name: "Avg Copay Amount"
      expr: ROUND(AVG(CAST(copay_amount AS DOUBLE)), 2)
      comment: "Average patient copay across policies; informs patient-financial-experience decisions."
    - name: "Avg Coverage Percentage"
      expr: ROUND(AVG(CAST(coverage_percentage AS DOUBLE)), 2)
      comment: "Average coverage percent; benchmarks reimbursement generosity across payers."
$$;