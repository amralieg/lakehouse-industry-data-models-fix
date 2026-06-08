-- Metric views for domain: customs | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 19:31:38

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customs_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customs declaration metrics tracking filing volumes, declared values, duty/tax amounts, and clearance performance across trade lanes and customs authorities."
  source: "`transport_shipping_ecm`.`customs`.`declaration`"
  dimensions:
    - name: "declaration_type"
      expr: declaration_type
      comment: "Type of customs declaration (import, export, transit, etc.)"
    - name: "declaration_status"
      expr: declaration_status
      comment: "Current processing status of the declaration"
    - name: "customs_authority"
      expr: customs_authority
      comment: "Customs authority processing the declaration"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where goods originated"
    - name: "country_of_destination"
      expr: country_of_destination
      comment: "Destination country for the goods"
    - name: "customs_procedure_code"
      expr: customs_procedure_code
      comment: "Customs procedure code applied to the declaration"
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms rule governing the trade transaction"
    - name: "trade_agreement"
      expr: trade_agreement
      comment: "Trade agreement applied for preferential treatment"
    - name: "filing_year_month"
      expr: DATE_TRUNC('month', filing_date)
      comment: "Filing month for time-series analysis"
    - name: "aeo_certified"
      expr: CAST(aeo_certified AS STRING)
      comment: "Whether the declarant is AEO certified"
    - name: "inspection_required"
      expr: CAST(inspection_required AS STRING)
      comment: "Whether physical inspection was required"
    - name: "declared_value_currency"
      expr: declared_value_currency
      comment: "Currency of the declared value"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of duty/tax payment"
  measures:
    - name: "total_declarations"
      expr: COUNT(1)
      comment: "Total number of customs declarations filed"
    - name: "total_declared_value"
      expr: SUM(CAST(total_declared_value AS DOUBLE))
      comment: "Total declared customs value across all declarations"
    - name: "total_duty_amount"
      expr: SUM(CAST(total_duty_amount AS DOUBLE))
      comment: "Total duty amount assessed on declarations"
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax amount assessed on declarations"
    - name: "avg_declared_value"
      expr: AVG(CAST(total_declared_value AS DOUBLE))
      comment: "Average declared value per declaration - indicates shipment value profile"
    - name: "avg_duty_rate_effective"
      expr: AVG(CAST(total_duty_amount AS DOUBLE) / NULLIF(CAST(total_declared_value AS DOUBLE), 0))
      comment: "Average effective duty rate as ratio of duty to declared value"
    - name: "declarations_requiring_inspection"
      expr: SUM(CASE WHEN inspection_required = true THEN 1 ELSE 0 END)
      comment: "Count of declarations flagged for physical inspection"
    - name: "inspection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN inspection_required = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of declarations requiring inspection - key risk indicator"
    - name: "distinct_countries_of_origin"
      expr: COUNT(DISTINCT country_of_origin)
      comment: "Number of distinct origin countries - trade diversification indicator"
    - name: "preferential_trade_declarations"
      expr: SUM(CASE WHEN trade_agreement IS NOT NULL AND trade_agreement != '' THEN 1 ELSE 0 END)
      comment: "Declarations utilizing trade agreement preferences"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customs_declaration_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level customs metrics for detailed duty, tax, and valuation analysis by commodity, HS code, and origin."
  source: "`transport_shipping_ecm`.`customs`.`declaration_line`"
  dimensions:
    - name: "hs_code"
      expr: hs_code
      comment: "Harmonized System code classifying the commodity"
    - name: "country_of_origin_code"
      expr: country_of_origin_code
      comment: "Country of origin for the line item"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the commodity quantity"
    - name: "valuation_method_code"
      expr: valuation_method_code
      comment: "WTO valuation method applied"
    - name: "preference_indicator"
      expr: CAST(preference_indicator AS STRING)
      comment: "Whether preferential tariff treatment was claimed"
    - name: "preference_program_code"
      expr: preference_program_code
      comment: "Specific preference program code applied"
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code for the line item"
    - name: "ftz_indicator"
      expr: CAST(ftz_indicator AS STRING)
      comment: "Whether goods are in a Foreign Trade Zone"
    - name: "dangerous_goods_indicator"
      expr: CAST(dangerous_goods_indicator AS STRING)
      comment: "Whether the line contains dangerous goods"
  measures:
    - name: "total_line_items"
      expr: COUNT(1)
      comment: "Total number of declaration line items"
    - name: "total_customs_value"
      expr: SUM(CAST(customs_value_amount AS DOUBLE))
      comment: "Total customs value across all line items"
    - name: "total_duty_amount"
      expr: SUM(CAST(duty_amount AS DOUBLE))
      comment: "Total duty amount across all line items"
    - name: "total_vat_amount"
      expr: SUM(CAST(vat_amount AS DOUBLE))
      comment: "Total VAT amount across all line items"
    - name: "total_excise_tax"
      expr: SUM(CAST(excise_tax_amount AS DOUBLE))
      comment: "Total excise tax across all line items"
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total combined tax amount across all line items"
    - name: "avg_duty_rate_pct"
      expr: AVG(CAST(duty_rate_percent AS DOUBLE))
      comment: "Average duty rate percentage across line items"
    - name: "avg_vat_rate_pct"
      expr: AVG(CAST(vat_rate_percent AS DOUBLE))
      comment: "Average VAT rate percentage across line items"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of goods declared"
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight in kilograms"
    - name: "total_net_weight_kg"
      expr: SUM(CAST(net_weight_kg AS DOUBLE))
      comment: "Total net weight in kilograms"
    - name: "preferential_lines_count"
      expr: SUM(CASE WHEN preference_indicator = true THEN 1 ELSE 0 END)
      comment: "Number of lines claiming preferential tariff treatment"
    - name: "preferential_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN preference_indicator = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lines utilizing preferential tariff programs - trade agreement effectiveness"
    - name: "distinct_hs_codes"
      expr: COUNT(DISTINCT hs_code)
      comment: "Number of distinct HS codes - commodity diversity indicator"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customs_duty_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Duty and tax assessment metrics tracking total duty burden, payment performance, and preferential program utilization."
  source: "`transport_shipping_ecm`.`customs`.`duty_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the duty assessment"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the assessed duties"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the assessed goods"
    - name: "entry_type"
      expr: entry_type
      comment: "Type of customs entry (consumption, warehouse, FTZ, etc.)"
    - name: "import_export_indicator"
      expr: import_export_indicator
      comment: "Whether the assessment is for import or export"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the duty assessment"
    - name: "assessment_method"
      expr: assessment_method
      comment: "Method used for duty calculation"
    - name: "preferential_tariff_program"
      expr: preferential_tariff_program
      comment: "Preferential tariff program applied"
    - name: "port_of_entry_code"
      expr: port_of_entry_code
      comment: "Port of entry where goods were assessed"
    - name: "assessment_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Assessment month for trending"
    - name: "tariff_code"
      expr: tariff_code
      comment: "Tariff code applied to the assessment"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of duty assessments"
    - name: "total_customs_duty"
      expr: SUM(CAST(customs_duty_amount AS DOUBLE))
      comment: "Total customs duty amount assessed"
    - name: "total_vat"
      expr: SUM(CAST(vat_amount AS DOUBLE))
      comment: "Total VAT amount assessed"
    - name: "total_excise_tax"
      expr: SUM(CAST(excise_tax_amount AS DOUBLE))
      comment: "Total excise tax assessed"
    - name: "total_anti_dumping_duty"
      expr: SUM(CAST(anti_dumping_duty_amount AS DOUBLE))
      comment: "Total anti-dumping duty - trade defense measure indicator"
    - name: "total_countervailing_duty"
      expr: SUM(CAST(countervailing_duty_amount AS DOUBLE))
      comment: "Total countervailing duty assessed"
    - name: "total_duty_tax_amount"
      expr: SUM(CAST(total_duty_tax_amount AS DOUBLE))
      comment: "Total combined duty and tax amount"
    - name: "total_customs_value"
      expr: SUM(CAST(customs_value_amount AS DOUBLE))
      comment: "Total customs value of assessed goods"
    - name: "avg_effective_duty_rate"
      expr: AVG(CAST(customs_duty_amount AS DOUBLE) / NULLIF(CAST(customs_value_amount AS DOUBLE), 0))
      comment: "Average effective duty rate across assessments"
    - name: "total_harbor_maintenance_fee"
      expr: SUM(CAST(harbor_maintenance_fee AS DOUBLE))
      comment: "Total harbor maintenance fees collected"
    - name: "total_merchandise_processing_fee"
      expr: SUM(CAST(merchandise_processing_fee AS DOUBLE))
      comment: "Total merchandise processing fees"
    - name: "preferential_assessments"
      expr: SUM(CASE WHEN preferential_tariff_program IS NOT NULL AND preferential_tariff_program != '' THEN 1 ELSE 0 END)
      comment: "Number of assessments using preferential tariff programs"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customs_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customs hold metrics tracking hold volumes, durations, financial impact, and resolution performance - critical for supply chain velocity."
  source: "`transport_shipping_ecm`.`customs`.`hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the customs hold"
    - name: "type_code"
      expr: type_code
      comment: "Type of hold placed on the shipment"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the hold"
    - name: "issuing_authority_code"
      expr: issuing_authority_code
      comment: "Authority that issued the hold"
    - name: "examination_type_code"
      expr: examination_type_code
      comment: "Type of examination required"
    - name: "examination_result_code"
      expr: examination_result_code
      comment: "Result of the examination"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the hold"
    - name: "sla_breach_indicator"
      expr: CAST(sla_breach_indicator AS STRING)
      comment: "Whether the hold breached SLA targets"
    - name: "country_of_examination_code"
      expr: country_of_examination_code
      comment: "Country where examination takes place"
  measures:
    - name: "total_holds"
      expr: COUNT(1)
      comment: "Total number of customs holds placed"
    - name: "avg_hold_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average hold duration in hours - key supply chain velocity metric"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts from holds"
    - name: "total_financial_impact"
      expr: SUM(CAST(total_financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of holds including storage, demurrage, penalties"
    - name: "total_additional_duty"
      expr: SUM(CAST(additional_duty_amount AS DOUBLE))
      comment: "Total additional duty assessed during holds"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_indicator = true THEN 1 ELSE 0 END)
      comment: "Number of holds that breached SLA targets"
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_indicator = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds breaching SLA - operational performance indicator"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of held shipments"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customs_drawback_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Duty drawback claim metrics tracking claim volumes, amounts, approval rates, and recovery efficiency."
  source: "`transport_shipping_ecm`.`customs`.`drawback_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the drawback claim"
    - name: "drawback_type"
      expr: drawback_type
      comment: "Type of drawback being claimed (manufacturing, unused merchandise, etc.)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the drawback claim"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for exported goods"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of drawback payment"
    - name: "filing_month"
      expr: DATE_TRUNC('month', filing_date)
      comment: "Filing month for trending analysis"
    - name: "substitution_indicator"
      expr: CAST(substitution_indicator AS STRING)
      comment: "Whether substitution was used in the claim"
    - name: "accelerated_payment_indicator"
      expr: CAST(accelerated_payment_indicator AS STRING)
      comment: "Whether accelerated payment was requested"
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of drawback claims filed"
    - name: "total_amount_claimed"
      expr: SUM(CAST(drawback_amount_claimed AS DOUBLE))
      comment: "Total drawback amount claimed"
    - name: "total_amount_approved"
      expr: SUM(CAST(approved_drawback_amount AS DOUBLE))
      comment: "Total drawback amount approved for payment"
    - name: "total_duty_paid"
      expr: SUM(CAST(duty_paid_amount AS DOUBLE))
      comment: "Total original duty paid on imported goods"
    - name: "avg_claim_amount"
      expr: AVG(CAST(drawback_amount_claimed AS DOUBLE))
      comment: "Average drawback claim amount"
    - name: "claim_approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN claim_status = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims approved - process effectiveness indicator"
    - name: "recovery_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(approved_drawback_amount AS DOUBLE)) / NULLIF(SUM(CAST(drawback_amount_claimed AS DOUBLE)), 0), 2)
      comment: "Ratio of approved to claimed amounts - indicates claim quality"
    - name: "total_quantity_exported"
      expr: SUM(CAST(quantity_exported AS DOUBLE))
      comment: "Total quantity of goods exported for drawback"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customs_compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance audit metrics tracking audit outcomes, findings severity, compliance scores, and corrective action needs."
  source: "`transport_shipping_ecm`.`customs`.`compliance_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the compliance audit"
    - name: "audit_type"
      expr: audit_type
      comment: "Type of compliance audit conducted"
    - name: "compliance_rating"
      expr: compliance_rating
      comment: "Overall compliance rating assigned"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level identified during audit"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit being audited"
    - name: "trade_lane"
      expr: trade_lane
      comment: "Trade lane covered by the audit"
    - name: "audit_methodology"
      expr: audit_methodology
      comment: "Methodology used for the audit"
    - name: "follow_up_audit_required"
      expr: CAST(follow_up_audit_required AS STRING)
      comment: "Whether a follow-up audit is required"
    - name: "audit_month"
      expr: DATE_TRUNC('month', audit_date)
      comment: "Audit month for trending"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of compliance audits conducted"
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across audits - overall compliance health"
    - name: "total_audit_cost"
      expr: SUM(CAST(audit_cost_amount AS DOUBLE))
      comment: "Total cost of compliance audits"
    - name: "audits_requiring_followup"
      expr: SUM(CASE WHEN follow_up_audit_required = true THEN 1 ELSE 0 END)
      comment: "Number of audits requiring follow-up - indicates systemic issues"
    - name: "followup_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_audit_required = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring follow-up action"
    - name: "high_risk_audits"
      expr: SUM(CASE WHEN risk_level = 'high' OR risk_level = 'critical' THEN 1 ELSE 0 END)
      comment: "Number of audits with high or critical risk findings"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customs_trade_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade transaction metrics providing end-to-end visibility into customs clearance performance, duty burden, and compliance status."
  source: "`transport_shipping_ecm`.`customs`.`trade_transaction`"
  dimensions:
    - name: "trade_type"
      expr: trade_type
      comment: "Type of trade (import/export)"
    - name: "clearance_status"
      expr: clearance_status
      comment: "Customs clearance status of the transaction"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Overall transaction processing status"
    - name: "origin_country"
      expr: origin_country
      comment: "Country of origin"
    - name: "destination_country"
      expr: destination_country
      comment: "Destination country"
    - name: "mode_of_transport"
      expr: mode_of_transport
      comment: "Mode of transport (air, sea, road, rail)"
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterms rule applied"
    - name: "hs_code"
      expr: hs_code
      comment: "HS code of the traded goods"
    - name: "entry_port"
      expr: entry_port
      comment: "Port of entry"
    - name: "filing_type"
      expr: filing_type
      comment: "Type of customs filing"
    - name: "ftz_indicator"
      expr: CAST(ftz_indicator AS STRING)
      comment: "Whether transaction involves a Foreign Trade Zone"
    - name: "compliance_flag"
      expr: CAST(compliance_flag AS STRING)
      comment: "Whether transaction is compliance-flagged"
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency"
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of trade transactions"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross transaction value"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net transaction value"
    - name: "total_duty_amount"
      expr: SUM(CAST(duty_amount AS DOUBLE))
      comment: "Total duty amount across transactions"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across transactions"
    - name: "avg_duty_rate"
      expr: AVG(CAST(duty_rate AS DOUBLE))
      comment: "Average duty rate applied across transactions"
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of traded goods in kilograms"
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total volume of traded goods in cubic meters"
    - name: "non_compliant_transactions"
      expr: SUM(CASE WHEN compliance_flag = false THEN 1 ELSE 0 END)
      comment: "Number of non-compliant transactions"
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions that are compliant - key risk metric"
    - name: "denied_party_hits"
      expr: SUM(CASE WHEN denied_party_flag = true THEN 1 ELSE 0 END)
      comment: "Number of transactions with denied party screening hits"
    - name: "distinct_origin_countries"
      expr: COUNT(DISTINCT origin_country)
      comment: "Number of distinct origin countries - supply chain diversification"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customs_broker_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customs broker performance metrics tracking assignment volumes, filing accuracy, release times, and fee management."
  source: "`transport_shipping_ecm`.`customs`.`broker_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the broker assignment"
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of broker assignment"
    - name: "assignment_priority"
      expr: assignment_priority
      comment: "Priority level of the assignment"
    - name: "assigned_country_code"
      expr: assigned_country_code
      comment: "Country where the broker is assigned"
    - name: "brokerage_office_location"
      expr: brokerage_office_location
      comment: "Location of the brokerage office"
    - name: "service_level_agreement"
      expr: service_level_agreement
      comment: "SLA tier for the assignment"
    - name: "broker_fee_currency"
      expr: broker_fee_currency
      comment: "Currency of broker fees"
    - name: "aeo_certified_flag"
      expr: CAST(aeo_certified_flag AS STRING)
      comment: "Whether the broker is AEO certified"
    - name: "exception_flag"
      expr: CAST(exception_flag AS STRING)
      comment: "Whether an exception occurred during processing"
    - name: "assignment_month"
      expr: DATE_TRUNC('month', assignment_date)
      comment: "Assignment month for trending"
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of broker assignments"
    - name: "total_broker_fees"
      expr: SUM(CAST(broker_fee_amount AS DOUBLE))
      comment: "Total broker fees incurred"
    - name: "avg_broker_fee"
      expr: AVG(CAST(broker_fee_amount AS DOUBLE))
      comment: "Average broker fee per assignment"
    - name: "avg_filing_accuracy_rate"
      expr: AVG(CAST(filing_accuracy_rate AS DOUBLE))
      comment: "Average filing accuracy rate - broker quality indicator"
    - name: "avg_release_time_hours"
      expr: AVG(CAST(average_release_time_hours AS DOUBLE))
      comment: "Average release time in hours - clearance speed indicator"
    - name: "exception_count"
      expr: SUM(CASE WHEN exception_flag = true THEN 1 ELSE 0 END)
      comment: "Number of assignments with exceptions"
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN exception_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments with exceptions - operational risk indicator"
    - name: "active_assignments"
      expr: SUM(CASE WHEN active_flag = true THEN 1 ELSE 0 END)
      comment: "Number of currently active broker assignments"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customs_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customs valuation metrics tracking declared values, adjustments, and valuation method effectiveness for duty optimization."
  source: "`transport_shipping_ecm`.`customs`.`valuation`"
  dimensions:
    - name: "valuation_status"
      expr: valuation_status
      comment: "Status of the customs valuation"
    - name: "method_code"
      expr: method_code
      comment: "WTO valuation method applied (transaction value, deductive, computed, etc.)"
    - name: "basis"
      expr: basis
      comment: "Basis for the valuation determination"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the valuation"
    - name: "customs_authority_code"
      expr: customs_authority_code
      comment: "Customs authority reviewing the valuation"
    - name: "risk_flag"
      expr: CAST(risk_flag AS STRING)
      comment: "Whether the valuation is flagged for risk"
    - name: "customs_query_raised_indicator"
      expr: CAST(customs_query_raised_indicator AS STRING)
      comment: "Whether customs raised a query on the valuation"
    - name: "valuation_month"
      expr: DATE_TRUNC('month', valuation_date)
      comment: "Valuation month for trending"
  measures:
    - name: "total_valuations"
      expr: COUNT(1)
      comment: "Total number of customs valuations performed"
    - name: "total_declared_transaction_value"
      expr: SUM(CAST(declared_transaction_value_amount AS DOUBLE))
      comment: "Total declared transaction value"
    - name: "total_customs_value_accepted"
      expr: SUM(CAST(customs_value_accepted_amount AS DOUBLE))
      comment: "Total customs value accepted by authorities"
    - name: "total_cif_value"
      expr: SUM(CAST(cif_value_amount AS DOUBLE))
      comment: "Total CIF (Cost, Insurance, Freight) value"
    - name: "total_fob_value"
      expr: SUM(CAST(fob_value_amount AS DOUBLE))
      comment: "Total FOB (Free on Board) value"
    - name: "total_adjustments"
      expr: SUM(CAST(adjustments_amount AS DOUBLE))
      comment: "Total valuation adjustments applied"
    - name: "total_freight_charges"
      expr: SUM(CAST(freight_charges_amount AS DOUBLE))
      comment: "Total freight charges included in valuation"
    - name: "total_insurance_charges"
      expr: SUM(CAST(insurance_charges_amount AS DOUBLE))
      comment: "Total insurance charges included in valuation"
    - name: "total_royalties_fees"
      expr: SUM(CAST(royalties_license_fees_amount AS DOUBLE))
      comment: "Total royalties and license fees added to valuation"
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average valuation confidence score - data quality indicator"
    - name: "query_raised_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN customs_query_raised_indicator = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of valuations where customs raised queries - compliance risk indicator"
    - name: "risk_flagged_valuations"
      expr: SUM(CASE WHEN risk_flag = true THEN 1 ELSE 0 END)
      comment: "Number of valuations flagged for risk review"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customs_denied_party_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Denied party screening metrics tracking screening volumes, match rates, false positive rates, and compliance risk exposure."
  source: "`transport_shipping_ecm`.`customs`.`denied_party_screening`"
  dimensions:
    - name: "screening_status"
      expr: screening_status
      comment: "Current status of the screening"
    - name: "match_status"
      expr: match_status
      comment: "Match status (confirmed, potential, cleared)"
    - name: "party_type"
      expr: party_type
      comment: "Type of party screened (shipper, consignee, etc.)"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level for the screening match"
    - name: "matched_list_name"
      expr: matched_list_name
      comment: "Name of the denied party list matched against"
    - name: "compliance_program"
      expr: compliance_program
      comment: "Compliance program under which screening was conducted"
    - name: "false_positive_flag"
      expr: CAST(false_positive_flag AS STRING)
      comment: "Whether the match was determined to be a false positive"
    - name: "regulatory_hold_flag"
      expr: CAST(regulatory_hold_flag AS STRING)
      comment: "Whether a regulatory hold was placed"
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of denied party screenings performed"
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match score across screenings"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score from screenings"
    - name: "confirmed_matches"
      expr: SUM(CASE WHEN match_status = 'confirmed' THEN 1 ELSE 0 END)
      comment: "Number of confirmed denied party matches - critical compliance metric"
    - name: "false_positive_count"
      expr: SUM(CASE WHEN false_positive_flag = true THEN 1 ELSE 0 END)
      comment: "Number of false positive matches"
    - name: "false_positive_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN false_positive_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "False positive rate - screening efficiency indicator"
    - name: "regulatory_holds_placed"
      expr: SUM(CASE WHEN regulatory_hold_flag = true THEN 1 ELSE 0 END)
      comment: "Number of regulatory holds placed from screening results"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customs_trade_agreement_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade agreement utilization metrics tracking duty savings, utilization rates, and preference program effectiveness."
  source: "`transport_shipping_ecm`.`customs`.`trade_agreement_utilization`"
  dimensions:
    - name: "preference_eligibility_status"
      expr: preference_eligibility_status
      comment: "Eligibility status for preferential treatment"
    - name: "compliance_audit_status"
      expr: compliance_audit_status
      comment: "Compliance audit status for the utilization"
  measures:
    - name: "total_utilizations"
      expr: COUNT(1)
      comment: "Total number of trade agreement utilization records"
    - name: "total_annual_duty_savings"
      expr: SUM(CAST(annual_duty_savings AS DOUBLE))
      comment: "Total annual duty savings from trade agreement utilization"
    - name: "avg_utilization_rate"
      expr: AVG(CAST(utilization_rate AS DOUBLE))
      comment: "Average utilization rate of trade agreements - optimization opportunity indicator"
    - name: "total_certificate_count"
      expr: SUM(CAST(certificate_count AS BIGINT))
      comment: "Total certificates of origin issued for preference claims"
    - name: "total_shipments_claimed"
      expr: SUM(CAST(total_shipments_claimed AS BIGINT))
      comment: "Total shipments where trade agreement preferences were claimed"
    - name: "avg_annual_duty_savings"
      expr: AVG(CAST(annual_duty_savings AS DOUBLE))
      comment: "Average annual duty savings per agreement utilization"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customs_ftz_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Foreign Trade Zone inventory metrics tracking inventory value, duty deferral, and zone utilization for duty optimization strategies."
  source: "`transport_shipping_ecm`.`customs`.`ftz_inventory`"
  dimensions:
    - name: "zone_status"
      expr: zone_status
      comment: "Current status of goods in the FTZ"
    - name: "ftz_zone_number"
      expr: ftz_zone_number
      comment: "FTZ zone number"
    - name: "ftz_zone_type"
      expr: ftz_zone_type
      comment: "Type of FTZ zone (general purpose, subzone)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin of goods in the zone"
    - name: "manipulation_status"
      expr: manipulation_status
      comment: "Status of any manipulation/manufacturing in the zone"
    - name: "hs_code"
      expr: hs_code
      comment: "HS code of goods in inventory"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for inventory quantities"
    - name: "hazmat_indicator"
      expr: CAST(hazmat_indicator AS STRING)
      comment: "Whether goods are hazardous materials"
  measures:
    - name: "total_inventory_records"
      expr: COUNT(1)
      comment: "Total number of FTZ inventory records"
    - name: "total_customs_value_usd"
      expr: SUM(CAST(customs_value_usd AS DOUBLE))
      comment: "Total customs value of goods in FTZ - duty deferral exposure"
    - name: "total_estimated_duty_usd"
      expr: SUM(CAST(estimated_duty_amount_usd AS DOUBLE))
      comment: "Total estimated duty deferred by FTZ storage"
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity of goods currently in FTZ"
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of FTZ inventory in kilograms"
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total volume of FTZ inventory in cubic meters"
    - name: "total_insurance_value_usd"
      expr: SUM(CAST(insurance_value_usd AS DOUBLE))
      comment: "Total insurance value of FTZ inventory"
    - name: "avg_duty_rate_pct"
      expr: AVG(CAST(duty_rate_percent AS DOUBLE))
      comment: "Average duty rate on FTZ inventory - potential duty exposure indicator"
    - name: "total_cycle_count_variance"
      expr: SUM(CAST(cycle_count_variance_quantity AS DOUBLE))
      comment: "Total cycle count variance - inventory accuracy indicator"
$$;