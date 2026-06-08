-- Metric views for domain: clinical_ai_governance | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_ai_governance_bias_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for monitoring AI model bias across clinical AI deployments, tracking fairness and equity in algorithmic decision-making for healthcare AI governance and FDA compliance."
  source: "`healthcare_ecm_v1`.`clinical_ai_governance`.`clinical_ai_governance_bias_monitoring`"
  dimensions:
    - name: "model_version_id"
      expr: model_version_id
      comment: "The specific AI model version being monitored for bias, enabling drill-down into which model releases exhibit fairness concerns."
  measures:
    - name: "total_bias_assessments"
      expr: COUNT(1)
      comment: "Total number of bias monitoring assessments conducted across all clinical AI models. Tracks organizational commitment to algorithmic fairness and regulatory compliance with FDA SaMD guidance on bias detection."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_ai_governance_fda_samd`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for FDA Software as a Medical Device (SaMD) regulatory tracking, monitoring compliance status of clinical AI models requiring FDA clearance or approval."
  source: "`healthcare_ecm_v1`.`clinical_ai_governance`.`clinical_ai_governance_fda_samd`"
  dimensions:
    - name: "model_version_id"
      expr: model_version_id
      comment: "The AI model version subject to FDA SaMD regulatory oversight, enabling tracking of clearance status per model release."
  measures:
    - name: "total_fda_samd_submissions"
      expr: COUNT(1)
      comment: "Total number of FDA SaMD regulatory submissions tracked. Critical for ensuring all clinical AI models requiring FDA oversight have proper regulatory documentation and clearance tracking."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_ai_governance_model_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for AI model card documentation completeness, tracking transparency and governance documentation across clinical AI deployments per responsible AI frameworks."
  source: "`healthcare_ecm_v1`.`clinical_ai_governance`.`clinical_ai_governance_model_card`"
  dimensions:
    - name: "model_version_id"
      expr: model_version_id
      comment: "The AI model version for which a model card has been created, enabling governance completeness tracking per model release."
  measures:
    - name: "total_model_cards"
      expr: COUNT(1)
      comment: "Total number of model cards documented across clinical AI models. Measures organizational adherence to responsible AI practices and transparency requirements for healthcare AI governance."
$$;