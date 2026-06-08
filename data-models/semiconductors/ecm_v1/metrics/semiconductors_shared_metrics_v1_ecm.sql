-- Metric views for domain: shared | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 18:21:54

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`shared_fab`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for semiconductor fabs focusing on energy, footprint, and criticality."
  source: "`semiconductors_ecm`.`shared`.`fab`"
  dimensions:
    - name: "fab_location_id"
      expr: fab_location_id
      comment: "Foreign key to location where the fab resides"
  measures:
    - name: "fab_count"
      expr: COUNT(1)
      comment: "Number of fab records (facilities)"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`shared_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level location inventory metrics."
  source: "`semiconductors_ecm`.`shared`.`location`"
  dimensions:
    - name: "region"
      expr: region
      comment: "Geographic region of the location"
  measures:
    - name: "location_count"
      expr: COUNT(1)
      comment: "Number of location records"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`shared_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site‑level inventory and capacity metrics."
  source: "`semiconductors_ecm`.`shared`.`site`"
  dimensions:
    - name: "region"
      expr: region
      comment: "Geographic region of the site"
  measures:
    - name: "site_count"
      expr: COUNT(1)
      comment: "Number of site records"
$$;