-- Schema for Domain: fraud | Business: Banking | Version: v1_mvm
-- Generated on: 2026-05-03 02:24:56

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`fraud` COMMENT 'Operational fraud case management covering fraud detection alerts, investigation workflows, case disposition, chargeback management, loss recovery, and SAR escalation. Manages fraud typologies, rule configurations, and case outcomes for retail, card, and wire fraud. Distinct from compliance AML monitoring.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`case` (
    `case_id` BIGINT COMMENT 'Primary key for case',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to risk.assessment. Business justification: RCSA process: fraud cases are linked to the risk assessment (RCSA) that identified the control weakness enabling the fraud. Banks must trace confirmed fraud losses back to RCSA findings for remediatio',
    `atm_id` BIGINT COMMENT 'Foreign key linking to channel.atm. Business justification: ATM fraud cases (skimming operations, ATM jackpotting, cash-out fraud rings) require direct ATM device attribution for law enforcement referrals, card network dispute escalation, and ATM physical secu',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Fraud cases document the channel where fraud was perpetrated. Required for SAR filings (FinCEN requires channel context), Basel II operational risk reporting, channel security investment decisions, an',
    `capture_id` BIGINT COMMENT 'Foreign key linking to trade.capture. Business justification: Fraud cases for trading misconduct (unauthorized booking, fictitious trades) must reference the specific trade capture record. Compliance investigations and regulatory exams (SEC, FCA) require direct ',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_asset. Business justification: Collateral fraud case management: fraud cases opened for fictitious collateral, asset misrepresentation, or ownership fraud require direct linkage to the collateral_asset. Basel operational risk repor',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this case. Supports multi-currency fraud operations.',
    `custodian_account_id` BIGINT COMMENT 'Foreign key linking to wealth.custodian_account. Business justification: Fraud cases involving wealth custody (account takeover, unauthorized asset transfers, custody fraud) must reference the custodian account as the primary subject of investigation. Case management and l',
    `deal_id` BIGINT COMMENT 'Foreign key linking to investment.deal. Business justification: Fraud cases for insider trading, market manipulation, or M&A fraud are opened against specific investment deals. Regulators (SEC, FCA) require fraud cases to reference the deal under investigation. Ba',
    `deal_participant_id` BIGINT COMMENT 'Foreign key linking to investment.deal_participant. Business justification: Fraud cases in investment banking (insider trading, breach of information barriers) are opened against specific deal participants in their deal role. Compliance teams require the link to identify whic',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit or loan account involved in the fraud incident. Nullable for party-level fraud cases without specific account context.',
    `derivative_id` BIGINT COMMENT 'Foreign key linking to security.derivative. Business justification: Fraud cases involving derivative misconduct (unauthorized positions, mis-selling of structured products) require direct reference to the derivative for case quantification, regulatory reporting (EMIR/',
    `detection_rule_id` BIGINT COMMENT 'Foreign key linking to fraud.detection_rule. Business justification: A fraud case is opened based on a detection rule trigger. case.fraud_detection_method (STRING) captures the detection method name, but a FK to detection_rule provides structured access to rule configu',
    `execution_id` BIGINT COMMENT 'Foreign key linking to trade.execution. Business justification: Market abuse investigations (MAR, MiFID II) require linking a fraud case directly to the suspicious trade execution (e.g., front-running, spoofing). Compliance and surveillance teams need this link to',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Fraud cases involving fund-level manipulation (NAV fraud, front-running, unauthorized trading) must reference the specific fund. SEC/FINRA enforcement actions and regulatory reporting require fund-lev',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Fraud case SLA target close dates are calculated in business days. The sla_target_close_date field requires a holiday calendar to correctly compute deadlines, supporting SLA management, regulatory exa',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Fraud cases involving securities (insider trading, market abuse, unauthorized securities transactions) need instrument reference for case management, regulatory filings (SAR with securities context), ',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Complex fraud cases may require branch-based investigation (safe deposit box fraud, teller collusion, check fraud, cash vault discrepancies). Links case to physical location for evidence collection, s',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: Fraud cases frequently involve investor accounts (unauthorized redemptions, identity theft in fund transactions, forged instructions). Fraud operations teams need direct linkage to investigate and res',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Fraud cases are assigned to a regulatory jurisdiction determining which AML/fraud reporting obligations apply (SAR filing authority, law enforcement referral rules, regulatory examination scope). Frau',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Fraud cases are scoped to a legal entity for regulatory reporting (SAR filing jurisdiction, OCC/Fed examination responses, entity-level fraud loss disclosures). Banking compliance and finance teams re',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Fraud cases in wealth management (unauthorized trading, churning, misappropriation of client assets) must reference the managed portfolio as the primary subject. Case management, regulatory reporting,',
    `offering_id` BIGINT COMMENT 'Foreign key linking to investment.offering. Business justification: Fraud cases for securities fraud, market manipulation, or prospectus fraud are opened against specific capital markets offerings. Regulators require fraud cases to reference the offering for enforceme',
    `operational_risk_event_id` BIGINT COMMENT 'Foreign key linking to risk.operational_risk_event. Business justification: Fraud cases are operational risk events under Basel II/III event types External Fraud (ET6) and Internal Fraud (ET7). Required for regulatory capital calculation under AMA/SMA approaches and Pilla',
    `interaction_id` BIGINT COMMENT 'Foreign key linking to channel.interaction. Business justification: Fraud cases originate from specific customer interactions. Linking provides forensic detail (employee involved, transaction amount, override codes, authentication method) for investigations, employee ',
    `session_id` BIGINT COMMENT 'Foreign key linking to channel.session. Business justification: Fraud cases often originate from specific customer sessions. Session data provides forensic evidence (IP, device, geolocation, user actions, authentication method) required for investigations, SAR nar',
    `party_id` BIGINT COMMENT 'Reference to the customer or party entity that is the subject of the fraud investigation. Links to customer master data.',
    `pledge_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.pledge_agreement. Business justification: Fraudulent pledge agreement investigation: forged or fabricated pledge agreements are a named collateral fraud type. Fraud cases involving document fraud on pledge agreements require direct linkage to',
    `pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_pledge. Business justification: Double-pledging and lien fraud case management: fraud cases involving fraudulent pledge arrangements (double-pledging, unauthorized substitution) must reference the specific collateral_pledge. Require',
    `redemption_id` BIGINT COMMENT 'Foreign key linking to asset.redemption. Business justification: Fraud cases involving unauthorized redemptions require direct reference to the redemption record for case management, chargeback initiation, and regulatory reporting. Investment fraud case management ',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to asset.subscription. Business justification: Fraud cases opened around fraudulent subscription events (unauthorized fund subscriptions) require direct reference to the subscription record for case management, loss quantification, and regulatory ',
    `trading_book_id` BIGINT COMMENT 'Foreign key linking to trade.trading_book. Business justification: Fraud cases involving trading misconduct (rogue trader, unauthorized positions) must be scoped to the affected trading book for regulatory capital impact assessment, desk-level risk reporting, and FRT',
    `trust_account_id` BIGINT COMMENT 'Foreign key linking to wealth.trust_account. Business justification: Fraud cases involving trust accounts (elder financial abuse, trustee misconduct, unauthorized distributions) must reference the trust account. Regulatory reporting, law enforcement referrals, and fidu',
    `underwriting_id` BIGINT COMMENT 'Foreign key linking to investment.underwriting. Business justification: Securities fraud cases (prospectus misrepresentation, fraudulent underwriting commitments) are opened against specific underwriting records. SEC enforcement and internal compliance investigations requ',
    `assigned_timestamp` TIMESTAMP COMMENT 'Date and time when the case was assigned to an investigator. Used for SLA tracking and workload analytics.',
    `case_number` STRING COMMENT 'Externally visible unique case reference number assigned at case creation. Used for customer communication and cross-system tracking.. Valid values are `^FC-[0-9]{8,12}$`',
    `case_status` STRING COMMENT 'Current lifecycle status of the fraud case. Drives workflow routing and SLA monitoring.. Valid values are `new|assigned|under_investigation|pending_review|closed|escalated`',
    `case_type` STRING COMMENT 'Classification of fraud case by fraud typology. Determines investigation workflow and regulatory reporting requirements.. Valid values are `card_fraud|wire_fraud|ach_fraud|check_fraud|identity_theft|account_takeover`',
    `chargeback_initiated_flag` BOOLEAN COMMENT 'Indicates whether a chargeback was initiated with the card network or payment processor for loss recovery.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the case was closed. Nullable for open cases. Used for cycle time and resolution metrics.',
    `confirmed_loss_amount` DECIMAL(18,2) COMMENT 'Final confirmed financial loss amount after investigation completion. Used for regulatory reporting and loss provisioning. Expressed in base currency.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this case record was first created in the database. Used for audit trail and data lineage.',
    `customer_reimbursed_flag` BOOLEAN COMMENT 'Indicates whether the affected customer was reimbursed for their loss. Used for customer satisfaction and regulatory compliance tracking.',
    `disposition_outcome` STRING COMMENT 'Final investigation outcome classification. Determines customer remediation, regulatory reporting, and fraud analytics.. Valid values are `confirmed_fraud|false_positive|customer_error|insufficient_evidence|referred_law_enforcement`',
    `disposition_reason` STRING COMMENT 'Detailed narrative explanation of the disposition outcome. Captures investigator findings and supporting rationale.',
    `estimated_loss_amount` DECIMAL(18,2) COMMENT 'Initial estimated financial loss amount at case opening. May be revised during investigation. Expressed in base currency.',
    `fraud_detection_method` STRING COMMENT 'The method or system that initially detected the fraud. Used to measure detection effectiveness and optimize fraud controls.. Valid values are `rule_based|ml_model|customer_report|manual_review|third_party_alert`',
    `fraud_ring_indicator` BOOLEAN COMMENT 'Indicates whether this case is part of an identified organized fraud ring or syndicate. Used for pattern analysis and network investigation.',
    `insurance_claim_filed_flag` BOOLEAN COMMENT 'Indicates whether an insurance claim was filed for fraud loss recovery under the banks fraud insurance policy.',
    `investigation_notes` STRING COMMENT 'Free-text field capturing investigator observations, findings, and case narrative. Confidential investigative work product.',
    `law_enforcement_agency` STRING COMMENT 'Name of the law enforcement agency to which the case was referred. Nullable if no referral was made.',
    `law_enforcement_referral_flag` BOOLEAN COMMENT 'Indicates whether the case was referred to law enforcement agencies for criminal investigation or prosecution.',
    `opened_timestamp` TIMESTAMP COMMENT 'Date and time when the fraud case was initially opened in the case management system. Marks the start of the investigation lifecycle.',
    `priority` STRING COMMENT 'Business priority level assigned based on loss amount, customer segment, and fraud severity. Determines investigation resource allocation.. Valid values are `critical|high|medium|low`',
    `recovered_amount` DECIMAL(18,2) COMMENT 'Total amount recovered through chargeback, insurance claim, or legal action. Used to calculate net loss. Expressed in base currency.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this case requires regulatory reporting beyond SAR filing, such as Currency Transaction Report (CTR) or other jurisdiction-specific filings.',
    `reimbursement_amount` DECIMAL(18,2) COMMENT 'Total amount reimbursed to the customer. Nullable if no reimbursement was made. Expressed in base currency.',
    `reimbursement_date` DATE COMMENT 'Date when the customer reimbursement was processed. Nullable if no reimbursement was made. Used for SLA compliance tracking.',
    `sar_filed_flag` BOOLEAN COMMENT 'Indicates whether a Suspicious Activity Report was filed with FinCEN for this case. Critical for regulatory compliance tracking.',
    `sar_filing_date` DATE COMMENT 'Date when the SAR was filed with FinCEN. Nullable if no SAR was filed. Used for regulatory deadline compliance monitoring.',
    `severity` STRING COMMENT 'Risk-based severity classification reflecting potential financial and reputational impact. Level 1 is highest severity.. Valid values are `level_1|level_2|level_3|level_4`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the case exceeded defined SLA thresholds for investigation or resolution time. Used for operational performance monitoring.',
    `sla_target_close_date` DATE COMMENT 'Target date by which the case should be closed based on SLA policy and case priority. Used for workload planning and escalation.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this case record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_case PRIMARY KEY(`case_id`)
) COMMENT 'Core master entity representing an operational fraud case opened against a customer, account, or transaction. Captures the full lifecycle from initial alert escalation through investigation, disposition, and closure. Key attributes include case type (card fraud, wire fraud, identity theft, account takeover, check fraud), case status and status history, assigned investigator, priority/severity, channel of occurrence, estimated and confirmed loss amounts, recovery amount, disposition outcome, and regulatory escalation flags. Serves as the central hub linking alerts, incidents, investigations, chargebacks, claims, SARs, evidence, and loss records. Managed within NICE Actimize or Oracle Financial Crime case management platforms.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`alert` (
    `alert_id` BIGINT COMMENT 'Unique identifier for the fraud alert record. Primary key.',
    `account_transaction_id` BIGINT COMMENT 'Identifier of the triggering transaction or event that caused the fraud alert to be generated. Links to the underlying payment, transfer, or account activity.',
    `atm_id` BIGINT COMMENT 'Foreign key linking to channel.atm. Business justification: Fraud alerts for ATM transactions must link to the specific ATM for forensic analysis (camera footage retrieval, cash cassette reconciliation, skimming device inspection), ATM network fraud pattern an',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Branch-originated fraud alerts (teller-reported suspicious activity, in-branch check fraud) require branch attribution for BSA/AML branch-level reporting and FinCEN CTR/SAR filing. Fraud operations te',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_asset. Business justification: Collateral fraud detection: automated detection rules flag suspicious collateral assets (e.g., same asset pledged to multiple lenders, rapid valuation changes). The fraud_alert must reference the spec',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the transaction amount (e.g., USD, EUR, GBP).',
    `deposit_account_id` BIGINT COMMENT 'Unique identifier of the deposit account, loan account, or card account involved in the fraud alert.',
    `derivative_id` BIGINT COMMENT 'Foreign key linking to security.derivative. Business justification: Rogue trading and unauthorized derivative position detection: fraud alerts triggered by anomalous OTC/listed derivative activity (e.g., unauthorized notional exposure, margin breaches) must reference ',
    `detection_rule_id` BIGINT COMMENT 'Identifier of the specific fraud detection rule or model that triggered this alert. Used for rule performance tracking and tuning.',
    `digital_channel_id` BIGINT COMMENT 'Foreign key linking to channel.digital_channel. Business justification: When fraud occurs via digital channels (mobile app, online banking, API), linking to digital_channel enables analysis of platform-specific vulnerabilities, API abuse patterns, PSD2/open banking fraud ',
    `fund_transaction_id` BIGINT COMMENT 'Foreign key linking to asset.fund_transaction. Business justification: Fraud alerts are triggered by suspicious fund transactions (unusual redemption patterns, rapid switching, structuring). AML and fraud monitoring systems generate alerts on specific fund transactions r',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Alerts capture transaction origin country for geographic risk assessment, sanctions screening (OFAC), cross-border fraud detection, and AML risk rating. Essential for fraud and AML operations. New FK ',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Securities fraud alerts (pump-and-dump schemes, market manipulation, unauthorized trading) require direct instrument linkage for trading surveillance, regulatory reporting (MAR/MiFID II), and investig',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: AML/fraud monitoring systems generate alerts directly against investor accounts (unusual redemption patterns, suspicious subscription activity). Alert triage and investigation scoping require direct i',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Real-time fraud detection systems monitor wealth portfolios for unusual trading patterns, large withdrawals, or unauthorized access. Alerts require portfolio context for risk scoring and investigation',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: Alerts link merchant categories to industry risk profiles for fraud typology detection, high-risk MCC flagging, and rule tuning. Essential for card fraud detection. New FK replaces denormalized MCC co',
    `offering_id` BIGINT COMMENT 'Foreign key linking to investment.offering. Business justification: Capital markets offerings (IPOs, bond issuances) generate fraud alerts for wash trading, layering, or allocation manipulation. Fraud surveillance teams link alerts directly to the offering for offerin',
    `party_id` BIGINT COMMENT 'Unique identifier of the customer or party associated with the account or transaction that triggered the fraud alert.',
    `redemption_id` BIGINT COMMENT 'Foreign key linking to asset.redemption. Business justification: Fraud alerts are commonly triggered by suspicious redemption activity (large unexpected redemptions, redemptions to new bank accounts). Direct link from fraud_alert to redemption supports alert invest',
    `session_id` BIGINT COMMENT 'Foreign key linking to channel.session. Business justification: Fraud alerts triggered during active sessions need session context for investigation (page flow, transaction sequence, authentication events). Critical for real-time fraud intervention, step-up authen',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to asset.subscription. Business justification: Fraud monitoring detects suspicious subscription patterns (rapid subscription/redemption cycles, layering). Direct link from fraud_alert to subscription enables alert triage and investigation scoping ',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Fraud alerts capture the channel where suspicious transactions occurred for pattern analysis and channel-specific fraud detection tuning. Essential for fraud operations teams analyzing fraud by channe',
    `interaction_id` BIGINT COMMENT 'Foreign key linking to channel.interaction. Business justification: Fraud alerts are triggered by specific interactions (ATM withdrawal, wire transfer, mobile deposit). Linking enables interaction replay for investigations, employee review (insider fraud detection), f',
    `price_id` BIGINT COMMENT 'Foreign key linking to security.price. Business justification: Price surveillance systems generate fraud alerts when instrument prices deviate anomalously (price manipulation, spoofing, layering detection). The specific price observation that triggered the alert ',
    `trust_account_id` BIGINT COMMENT 'Foreign key linking to wealth.trust_account. Business justification: Elder financial abuse and unauthorized trust distributions are high-priority fraud alert scenarios. Fraud alerts must reference the specific trust account to support fiduciary duty investigations, reg',
    `account_number` STRING COMMENT 'The business-facing account number associated with the fraud alert. Masked or tokenized in some environments for PCI/PII compliance.',
    `alert_number` STRING COMMENT 'Business-facing unique alert reference number generated by the fraud detection system for tracking and case management purposes.. Valid values are `^FA-[0-9]{10}$`',
    `alert_status` STRING COMMENT 'Current lifecycle status of the fraud alert indicating the stage of investigation and disposition workflow.. Valid values are `new|under_review|escalated|closed|false_positive|confirmed_fraud`',
    `assigned_analyst_name` STRING COMMENT 'Full name of the fraud analyst assigned to the alert for investigation and case management.',
    `card_number_last_four` STRING COMMENT 'Last four digits of the payment card number involved in the alert, used for identification without exposing full PCI data.. Valid values are `^[0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Audit timestamp indicating when this fraud alert record was first inserted into the data warehouse or lakehouse.',
    `customer_contact_timestamp` TIMESTAMP COMMENT 'Date and time when the customer was contacted regarding the fraud alert.',
    `customer_contacted_flag` BOOLEAN COMMENT 'Boolean indicator of whether the customer was contacted during the alert investigation for verification or additional information.',
    `customer_response` STRING COMMENT 'Classification of the customers response when contacted about the alert, indicating whether they confirmed the transaction as legitimate or fraudulent.. Valid values are `confirmed_legitimate|confirmed_fraud|no_response|disputed`',
    `detection_method` STRING COMMENT 'The detection mechanism or source that generated the fraud alert, indicating whether it was triggered by automated rules, ML models, behavioral analytics, or external sources.. Valid values are `rule_based|machine_learning|behavioral_analytics|manual_referral|customer_report|third_party_alert`',
    `disposition_code` STRING COMMENT 'Final outcome classification assigned by the analyst after investigation, indicating whether the alert represents genuine fraud, a false positive, or requires further action.. Valid values are `confirmed_fraud|false_positive|suspicious_no_action|escalated_to_case|customer_verified|pending_information`',
    `disposition_reason` STRING COMMENT 'Free-text explanation or structured reason code documenting the rationale for the disposition decision, supporting audit and quality assurance.',
    `false_positive_reason` STRING COMMENT 'Structured reason or free-text explanation documenting why the alert was classified as a false positive, used for rule tuning and model retraining.',
    `generated_timestamp` TIMESTAMP COMMENT 'The date and time when the fraud alert was generated by the transaction monitoring system. This is the principal business event timestamp for the alert lifecycle.',
    `geolocation_city` STRING COMMENT 'City name derived from IP geolocation or transaction metadata, used for anomaly detection and travel pattern analysis.',
    `ip_address` STRING COMMENT 'IP address from which the transaction or session originated, used for geolocation and device fingerprinting analysis.',
    `loss_amount` DECIMAL(18,2) COMMENT 'Confirmed monetary loss amount resulting from the fraud event, if the alert was dispositioned as confirmed fraud. Used for loss reporting and recovery tracking.',
    `merchant_name` STRING COMMENT 'Name of the merchant or counterparty involved in the transaction that triggered the fraud alert, if applicable.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Amount recovered from the fraudulent transaction through chargeback, insurance claim, or other recovery mechanisms.',
    `review_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the fraud analyst completed the investigation and assigned a final disposition to the alert.',
    `review_started_timestamp` TIMESTAMP COMMENT 'Date and time when the fraud analyst began reviewing the alert, marking the transition from new to under review status.',
    `sar_filed_flag` BOOLEAN COMMENT 'Boolean indicator of whether a Suspicious Activity Report was filed with FinCEN as a result of this fraud alert.',
    `sar_filing_date` DATE COMMENT 'Date on which the SAR was filed with FinCEN, if applicable.',
    `score` DECIMAL(18,2) COMMENT 'Numeric risk score assigned by the detection engine indicating the likelihood of fraud, typically ranging from 0 to 100 or 0 to 999 depending on model configuration.',
    `severity` STRING COMMENT 'Risk severity classification assigned to the alert based on potential fraud exposure, transaction amount, and customer risk profile.. Valid values are `low|medium|high|critical`',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Monetary value of the transaction that triggered the fraud alert, in the transaction currency.',
    `transaction_channel` STRING COMMENT 'The channel or interface through which the triggering transaction was initiated (e.g., online banking, mobile app, ATM, branch, point-of-sale). [ENUM-REF-CANDIDATE: online|mobile|atm|branch|phone|mail|pos — 7 candidates stripped; promote to reference product]',
    `transaction_date` DATE COMMENT 'The business date on which the triggering transaction occurred.',
    `transaction_type` STRING COMMENT 'Classification of the transaction that triggered the alert (e.g., wire transfer, card purchase, ACH debit, ATM withdrawal).',
    `updated_timestamp` TIMESTAMP COMMENT 'Audit timestamp indicating when this fraud alert record was last modified in the data warehouse or lakehouse.',
    CONSTRAINT pk_alert PRIMARY KEY(`alert_id`)
) COMMENT 'Transactional record capturing individual fraud detection alerts generated by real-time transaction monitoring rules, machine learning models, or behavioral analytics engines. Each alert references the triggering transaction or event, the detection rule or model that fired, alert severity, alert status (new, reviewed, escalated, closed), and the disposition action taken by the analyst. Feeds the fraud case creation workflow when alerts are confirmed or escalated. Sourced from NICE Actimize transaction monitoring.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`investigation` (
    `investigation_id` BIGINT COMMENT 'Primary key for investigation',
    `alert_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_alert. Business justification: An investigation is typically triggered by one or more fraud alerts. While investigation already links to fraud_case (which links to fraud_alert), a direct FK from investigation to the triggering frau',
    `aml_case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: Fraud investigations that involve money laundering dimensions are co-managed with AML cases. Investigators need to reference the associated AML case for joint SAR filing, FinCEN reporting, and regulat',
    `capture_id` BIGINT COMMENT 'Foreign key linking to trade.capture. Business justification: Fraud investigations into trading misconduct (front-running, unauthorized trading) require direct access to the trade capture record as the primary subject of investigation. Regulatory investigators (',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Investigation tracks fraud_loss_amount with fraud_loss_currency_code as a denormalized plain text field. A proper FK to currency enforces referential integrity, enables multi-currency loss aggregation',
    `custodian_account_id` BIGINT COMMENT 'Foreign key linking to wealth.custodian_account. Business justification: Investigations into wealth custody fraud must reference the custodian account under investigation. Required for evidence gathering scope, custodian breach notifications, regulatory examination respons',
    `interaction_id` BIGINT COMMENT 'Foreign key linking to channel.interaction. Business justification: Fraud investigations collect interaction records as evidence. Linking enables audit trail reconstruction, regulatory exam support (demonstrating transaction monitoring controls), litigation evidence p',
    `session_id` BIGINT COMMENT 'Foreign key linking to channel.session. Business justification: Fraud investigations collect session data as evidence. Linking enables chain-of-custody tracking, legal hold management, courtroom evidence presentation, regulatory exam support, and forensic timeline',
    `case_id` BIGINT COMMENT 'Reference to the parent fraud case that this investigation is associated with. Links to the fraud case management entity.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Investigations into fund-level fraud (NAV manipulation, unauthorized trading, misappropriation of fund assets) must reference the specific fund. SEC/FINRA regulatory investigations require fund-level ',
    `fund_transaction_id` BIGINT COMMENT 'Foreign key linking to asset.fund_transaction. Business justification: Fraud investigations into investment fraud must examine specific fund transactions. Investigation workflow, evidence gathering, and regulatory reporting require direct fund_transaction linkage on inve',
    `incident_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_incident. Business justification: An investigation can focus on a specific fraud incident within the broader case. N:1 relationship. No bidirectional conflict (fraud_incident does not have investigation_id FK back). Investigation trac',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Securities fraud investigations (insider trading, market manipulation, unauthorized trading) are instrument-centric. Investigators need direct access to instrument master data (ISIN, asset_class, life',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: Fraud investigations examine investor account activity (transaction patterns, velocity analysis, behavioral anomalies). Investigation workflows require direct linkage to investor accounts for evidence',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Fraud investigations into wealth management misconduct (unauthorized trading, churning, misappropriation) must reference the managed portfolio under investigation. Regulatory examination responses and',
    `previous_investigation_id` BIGINT COMMENT 'Reference to the preceding investigation phase in a multi-phase investigation workflow. Null for initial investigation phase.',
    `sar_filing_id` BIGINT COMMENT 'Foreign key linking to fraud.sar_filing. Business justification: An investigation that escalates to a SAR filing should reference the resulting sar_filing record directly. investigation.sar_escalation_flag and sar_filing_date are denormalized; the FK to sar_filing ',
    `trust_account_id` BIGINT COMMENT 'Foreign key linking to wealth.trust_account. Business justification: Investigations into trust fraud (elder abuse, fiduciary misconduct, unauthorized distributions) must reference the trust account. State trust regulators and Adult Protective Services referrals require',
    `chargeback_initiated_flag` BOOLEAN COMMENT 'Indicates whether a chargeback process was initiated with card networks or payment processors based on investigation findings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the investigation record was first created in the system. Used for audit trail and data lineage.',
    `customer_notification_date` DATE COMMENT 'Date when the customer was notified of the investigation outcome. Null if customer notification has not occurred.',
    `customer_notification_flag` BOOLEAN COMMENT 'Indicates whether the customer was formally notified of the investigation outcome and any actions taken (e.g., account restrictions, fraud loss reimbursement).',
    `disposition_rationale` STRING COMMENT 'Detailed explanation of the reasoning behind the recommended disposition. Supports audit trail and regulatory review.',
    `end_date` DATE COMMENT 'Date when the investigation was formally closed or completed. Null for ongoing investigations.',
    `evidence_items_count` STRING COMMENT 'Total number of evidence items collected and catalogued during this investigation (e.g., transaction records, device logs, interview transcripts, surveillance footage).',
    `evidence_summary` STRING COMMENT 'High-level summary of key evidence gathered during the investigation. Used for case review and escalation briefings.',
    `findings_narrative` STRING COMMENT 'Detailed narrative of investigation findings, analysis, and conclusions. Forms the basis for disposition recommendations and SAR (Suspicious Activity Report) narratives.',
    `fraud_loss_amount` DECIMAL(18,2) COMMENT 'Total monetary loss attributed to the fraud as determined by the investigation. Expressed in the banks base currency.',
    `interview_conducted_flag` BOOLEAN COMMENT 'Indicates whether a formal customer or witness interview was conducted as part of this investigation.',
    `interview_date` DATE COMMENT 'Date when the customer or witness interview was conducted. Null if no interview was performed.',
    `interview_notes` STRING COMMENT 'Summary notes from customer or witness interviews conducted during the investigation. May include key statements, admissions, or denials.',
    `investigation_number` STRING COMMENT 'Business-facing unique investigation identifier used for tracking and reporting. Typically system-generated with prefix INV- followed by numeric sequence.. Valid values are `^INV-[0-9]{8,12}$`',
    `investigation_status` STRING COMMENT 'Current operational status of the investigation within its phase. Indicates whether the investigation is actively being worked, pending review, escalated, or completed.. Valid values are `open|in_progress|pending_review|escalated|completed|cancelled`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the investigation record was last updated. Tracks the most recent change to any field in the record.',
    `law_enforcement_agency` STRING COMMENT 'Name of the law enforcement agency to which the case was referred (e.g., FBI, Secret Service, local police department).',
    `law_enforcement_case_number` STRING COMMENT 'Case or incident number assigned by the law enforcement agency for tracking the criminal investigation.',
    `law_enforcement_referral_flag` BOOLEAN COMMENT 'Indicates whether the case has been referred to law enforcement agencies for criminal investigation or prosecution.',
    `methodology` STRING COMMENT 'Primary investigative approach or technique applied during this investigation phase. May include transaction pattern analysis, device fingerprinting, customer interviews, video surveillance review, or third-party data correlation.. Valid values are `transaction_analysis|device_forensics|customer_interview|surveillance_review|third_party_data|multi_method`',
    `multi_phase_investigation_flag` BOOLEAN COMMENT 'Indicates whether this investigation is part of a multi-phase investigation requiring sequential stages with different investigators or specialized skill sets.',
    `notes` STRING COMMENT 'Free-form notes and observations recorded by investigators during the investigation process. Supports case documentation and knowledge transfer.',
    `phase` STRING COMMENT 'Current phase of the investigation workflow. Tracks progression from initial review through deep investigation, potential legal referral, SAR (Suspicious Activity Report) escalation, or closure.. Valid values are `initial_review|deep_investigation|legal_referral|sar_escalation|closed|suspended`',
    `priority` STRING COMMENT 'Priority level assigned to the investigation based on loss amount, customer impact, regulatory risk, or reputational risk. Determines resource allocation and response timelines.. Valid values are `critical|high|medium|low`',
    `recommended_disposition` STRING COMMENT 'Investigators recommended outcome or disposition for the case based on investigation findings. Determines next steps including SAR filing, legal action, or case closure.. Valid values are `confirmed_fraud|no_fraud|inconclusive|referred_to_compliance|referred_to_legal|customer_error`',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Amount recovered from the fraudster, third parties, or through chargeback processes as a result of this investigation.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this investigation is subject to regulatory reporting requirements beyond SAR filing (e.g., CTR - Currency Transaction Report, OFAC reporting).',
    `sar_escalation_flag` BOOLEAN COMMENT 'Indicates whether this investigation has been escalated for SAR (Suspicious Activity Report) filing to FinCEN due to suspicious activity meeting regulatory thresholds.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the investigation exceeded its SLA (Service Level Agreement) target completion date. Used for performance monitoring and escalation.',
    `sla_target_completion_date` DATE COMMENT 'Target date by which the investigation should be completed per internal SLA (Service Level Agreement) policies. Based on case priority and regulatory requirements.',
    `source_system` STRING COMMENT 'Name of the case management platform or system where this investigation was conducted (e.g., NICE Actimize, Oracle Financial Crime, internal case management system).',
    `start_date` DATE COMMENT 'Date when the investigation was formally initiated. Used for SLA (Service Level Agreement) tracking and regulatory reporting timelines.',
    `team` STRING COMMENT 'Name or code of the specialized fraud investigation team handling this case (e.g., Card Fraud Unit, Wire Fraud Unit, AML Investigation Team).',
    CONSTRAINT pk_investigation PRIMARY KEY(`investigation_id`)
) COMMENT 'Operational entity tracking the investigation workflow associated with a fraud case within the banks case management platform (NICE Actimize, Oracle Financial Crime). Captures investigation phase (initial review, deep investigation, legal referral, SAR escalation), assigned investigator employee ID, investigation start and end dates, methodology applied (transaction analysis, device forensics, customer interview, surveillance review), evidence items gathered, interview records, findings narrative, recommended disposition (confirmed fraud, no fraud, inconclusive, referred to compliance), and escalation flags. Supports multi-phase investigations where a single case may require sequential investigation stages with different investigators or skill sets. Feeds SAR narrative generation and law enforcement referral packages.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`incident` (
    `incident_id` BIGINT COMMENT 'Unique identifier for the fraud incident record. Primary key.',
    `account_transaction_id` BIGINT COMMENT 'Reference identifier linking this fraud incident to the specific transaction or account activity that was fraudulent. May reference payment, transfer, withdrawal, or other transaction types.',
    `atm_id` BIGINT COMMENT 'Foreign key linking to channel.atm. Business justification: ATM-specific fraud incidents (card skimming, cash trapping, ATM jackpotting) require direct ATM attribution for device-level fraud analytics, ATM network reporting to Visa/MC, and physical security re',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Branch-level fraud incidents (teller fraud, in-branch identity theft, check kiting) require branch attribution for BSA/AML reporting, branch performance monitoring, and regulatory exams. fraud_inciden',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Fraud incidents track the specific channel exploited for operational fraud reviews, Basel II operational risk capital calculations, and channel security assessments. Enables channel-level fraud loss a',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_asset. Business justification: Fictitious or inflated collateral asset fraud: when a fraud incident involves a specific collateral asset (e.g., non-existent property pledged, forged ownership), the incident record must link directl',
    `collateral_valuation_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_valuation. Business justification: Valuation fraud investigation: inflated appraisal fraud is a named fraud type in banking. When a fraud incident involves a manipulated collateral valuation, investigators must link the incident to the',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the incident amount (e.g., USD, EUR, GBP).',
    `custodian_account_id` BIGINT COMMENT 'Foreign key linking to wealth.custodian_account. Business justification: Fraud incidents in wealth management (unauthorized securities transfers, custody account takeover) must reference the custodian account where the incident occurred. Required for loss quantification, B',
    `debt_issuance_id` BIGINT COMMENT 'Foreign key linking to treasury.debt_issuance. Business justification: Securities issuance fraud investigation: prospectus fraud, fictitious bond issuances, and unauthorized debt issuances are recognized securities fraud typologies. Linking fraud_incident to the specific',
    `deposit_account_id` BIGINT COMMENT 'Reference to the customer account affected by this fraud incident.',
    `derivative_id` BIGINT COMMENT 'Foreign key linking to security.derivative. Business justification: Unauthorized derivative trading incidents (rogue trader events, front-running on derivatives) require direct linkage to the derivative product for regulatory capital impact (rwa_amount, frtb_capital_c',
    `detection_rule_id` BIGINT COMMENT 'Reference to the fraud detection rule configuration that flagged this incident, if applicable.',
    `digital_channel_id` BIGINT COMMENT 'Foreign key linking to channel.digital_channel. Business justification: Digital fraud incidents (account takeover via mobile app, API abuse, open banking fraud) require specific digital channel attribution for PSD2/open banking regulatory reporting and TPP liability deter',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Fraud incidents at the fund level (unauthorized trading, NAV fraud, misappropriation) must reference the specific fund for regulatory incident reporting. Investment fraud incident management requires ',
    `interaction_id` BIGINT COMMENT 'Foreign key linking to channel.interaction. Business justification: Fraud incidents map to specific interactions for loss accounting, GL posting reconciliation, operational loss event reporting (Basel II), and transaction-level fraud analytics. Enables precise fraud l',
    `investor_order_id` BIGINT COMMENT 'Foreign key linking to investment.investment_investor_order. Business justification: Fraud incidents in capital markets (insider trading on IPO allocations, front-running) are tied to specific investor orders. Investigators require the direct link to the order record for evidence gath',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Fraud incidents on wealth accounts (unauthorized trades, account takeover, advisor fraud) require portfolio-level tracking for loss calculation, regulatory reporting, and client restitution. Operation',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: Incidents classify merchant types for fraud pattern analysis, MCC-based trend reporting, and detection rule effectiveness measurement. Standard card fraud investigation practice. New FK replaces denor',
    `nostro_account_id` BIGINT COMMENT 'Foreign key linking to treasury.nostro_account. Business justification: Nostro fraud investigation: unauthorized transfers, ghost entries, and reconciliation manipulation in nostro accounts are a significant correspondent banking fraud typology. Linking fraud_incident to ',
    `order_id` BIGINT COMMENT 'Foreign key linking to trade.order. Business justification: Market manipulation incidents (spoofing, layering) are defined by order-level behavior — placing and canceling orders to move prices. MiFID II Article 12 surveillance requires linking fraud incidents ',
    `party_id` BIGINT COMMENT 'Reference to the customer or party who is the victim of the fraud incident.',
    `pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_pledge. Business justification: Collateral fraud investigation: when double-pledging or fraudulent lien perfection is detected, the fraud_incident must reference the specific pledge. Fraud operations teams and regulatory examiners r',
    `redemption_id` BIGINT COMMENT 'Foreign key linking to asset.redemption. Business justification: Fraud incidents involving unauthorized redemptions must reference the specific redemption record for loss calculation, regulatory reporting, and recovery tracking. Direct linkage is required for inves',
    `repo_transaction_id` BIGINT COMMENT 'Foreign key linking to treasury.repo_transaction. Business justification: Repo fraud investigation: fraud teams investigate fictitious collateral, off-market repo rates, and wash trades. Linking fraud_incident directly to the specific repo_transaction is essential for the ',
    `session_id` BIGINT COMMENT 'Foreign key linking to channel.session. Business justification: Fraud incidents capture the session context where fraud occurred. Essential for chargeback defense (proving customer authentication), customer dispute resolution (session timeline evidence), fraud pat',
    `subject_id` BIGINT COMMENT 'Foreign key linking to fraud.subject. Business justification: A fraud incident involves a specific fraud subject (the perpetrator or suspected fraudster). fraud_incident already has party_id → customer.party (cross-domain), but subject is the fraud-domain entity',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to asset.subscription. Business justification: Fraud incidents tied to fraudulent subscription events (identity theft used to initiate fund subscriptions) require direct linkage to the subscription record for incident investigation, loss calculati',
    `trading_book_id` BIGINT COMMENT 'Foreign key linking to trade.trading_book. Business justification: Rogue trader and unauthorized trading incidents are scoped to a specific trading book for P&L impact attribution, risk limit breach reporting, and Volcker Rule compliance. Fraud and risk teams need to',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Incidents track transaction location for cross-border fraud pattern analysis, jurisdiction determination, and country-level risk reporting. Core fraud investigation and reporting requirement. New FK r',
    `trust_account_id` BIGINT COMMENT 'Foreign key linking to wealth.trust_account. Business justification: Trust fraud incidents (trustee misappropriation, unauthorized beneficiary changes, elder abuse) require linking the incident to the specific trust account. Regulatory reporting under state trust laws ',
    `amount` DECIMAL(18,2) COMMENT 'Monetary amount involved in the fraudulent transaction or activity. Represents the gross exposure or loss amount before any recovery.',
    `card_number_last_four` STRING COMMENT 'Last four digits of the payment card involved in the fraud incident, used for identification without exposing full card number.. Valid values are `^[0-9]{4}$`',
    `chargeback_date` DATE COMMENT 'Date when the chargeback was filed for this fraud incident, if applicable.',
    `chargeback_flag` BOOLEAN COMMENT 'Indicates whether a chargeback was initiated for this fraud incident (True) or not (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this fraud incident record was first created in the system.',
    `customer_reported_flag` BOOLEAN COMMENT 'Indicates whether the fraud incident was reported by the customer (True) or detected by internal systems (False).',
    `detection_method` STRING COMMENT 'Method by which the fraud incident was detected (e.g., system rule trigger, machine learning model alert, customer-reported, manual review, third-party alert).. Valid values are `system_rule|ml_model|customer_report|manual_review|third_party_alert`',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the fraud incident was detected by the system or reported by the customer.',
    `disposition_code` STRING COMMENT 'Final outcome or disposition of the fraud incident investigation (e.g., confirmed fraud, false positive, customer error, merchant error, unresolved, pending).. Valid values are `confirmed_fraud|false_positive|customer_error|merchant_error|unresolved|pending`',
    `incident_description` STRING COMMENT 'Detailed narrative description of the fraudulent event, including circumstances, methods used, and any relevant context for investigation.',
    `incident_status` STRING COMMENT 'Current lifecycle status of the fraud incident within the investigation workflow.. Valid values are `open|under_investigation|confirmed|dismissed|closed|escalated`',
    `incident_timestamp` TIMESTAMP COMMENT 'Date and time when the fraudulent event occurred or was first detected. Represents the real-world event time of the fraudulent act.',
    `investigation_close_date` DATE COMMENT 'Date when the investigation of this fraud incident was completed and closed.',
    `investigation_start_date` DATE COMMENT 'Date when the formal investigation of this fraud incident began.',
    `ip_address` STRING COMMENT 'IP address from which the fraudulent online or mobile transaction was initiated.',
    `law_enforcement_case_number` STRING COMMENT 'Case number assigned by law enforcement agency if the fraud incident was reported to police or other authorities.',
    `law_enforcement_notified_flag` BOOLEAN COMMENT 'Indicates whether law enforcement authorities were notified about this fraud incident (True) or not (False).',
    `loss_amount` DECIMAL(18,2) COMMENT 'Actual financial loss incurred by the bank or customer after any recoveries, chargebacks, or insurance claims. May differ from incident amount.',
    `merchant_name` STRING COMMENT 'Name of the merchant or payee involved in the fraudulent transaction, if applicable (e.g., for card fraud or unauthorized payments).',
    `recovered_amount` DECIMAL(18,2) COMMENT 'Amount recovered from the fraudulent transaction through chargeback, insurance claim, or other recovery mechanisms.',
    `reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this fraud incident for tracking and reporting purposes.',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the investigation findings, resolution actions taken, and final disposition rationale.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score assigned to this fraud incident by the fraud detection system, typically ranging from 0 to 100, with higher scores indicating higher fraud risk.',
    `sar_filed_flag` BOOLEAN COMMENT 'Indicates whether a Suspicious Activity Report was filed with regulatory authorities for this fraud incident (True) or not (False).',
    `sar_filing_date` DATE COMMENT 'Date when the SAR was filed with FinCEN or other regulatory authority for this fraud incident.',
    `transaction_location` STRING COMMENT 'Geographic location where the fraudulent transaction occurred (city, state, country) or IP address for online transactions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this fraud incident record was last modified or updated.',
    CONSTRAINT pk_incident PRIMARY KEY(`incident_id`)
) COMMENT 'Transactional record capturing a confirmed or suspected fraudulent event at the transaction or account level. Represents the specific fraudulent act (unauthorized transaction, counterfeit card use, wire fraud attempt, check fraud, identity theft event) linked to a fraud case. Captures incident date and time, incident channel (ATM, online, branch, wire, ACH), fraud typology code, transaction reference, monetary amount involved, currency, and whether the incident was customer-reported or system-detected. Multiple incidents may be linked to a single fraud case.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`chargeback` (
    `chargeback_id` BIGINT COMMENT 'Primary key for chargeback',
    `account_transaction_id` BIGINT COMMENT 'Foreign key linking to account.account_transaction. Business justification: A chargeback dispute is initiated against a specific account transaction. Reg E dispute resolution, network representment workflows, and loss accounting all require direct linkage from chargeback to t',
    `card_transaction_id` BIGINT COMMENT 'Reference to the original payment transaction that is being disputed through this chargeback.',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the disputed amount (e.g., USD, EUR, GBP).',
    `deposit_account_id` BIGINT COMMENT 'Reference to the cardholder account affected by the chargeback.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Chargebacks document the channel where the disputed transaction occurred. Required for chargeback representment (channel-specific evidence requirements), network dispute resolution, channel-specific f',
    `case_id` BIGINT COMMENT 'Reference to the fraud case that triggered or is associated with this chargeback. Links chargeback to the originating fraud investigation.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Chargebacks generate accounting entries (debit loss account, credit customer account or suspense) that must be traceable to specific journal entries for subledger reconciliation, SOX controls, and aud',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Chargeback response_deadline_date and representment_filed_date are calculated in business days per Visa/Mastercard network rules. Holiday calendars govern these deadline calculations; missing them cau',
    `incident_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_incident. Business justification: A chargeback can be linked to the underlying fraud incident that triggered it. N:1 relationship. No bidirectional conflict (fraud_incident does not have chargeback_id FK back). Chargeback has its own ',
    `investigation_id` BIGINT COMMENT 'Foreign key linking to fraud.investigation. Business justification: A chargeback dispute may be subject to a formal investigation workflow. chargeback.investigation_notes is a free-text field; linking chargeback.investigation_id → investigation provides structured acc',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: Chargebacks occur on investor account transactions when fund purchases are disputed (card-funded subscriptions, unauthorized debits). Chargeback processing requires linking to investor accounts for re',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: Chargebacks analyze merchant industry for dispute trend analysis, high-risk MCC identification, and chargeback prevention strategy. Card network and fraud operations requirement. New FK replaces denor',
    `operational_risk_event_id` BIGINT COMMENT 'Foreign key linking to risk.operational_risk_event. Business justification: Chargebacks represent operational losses (Basel event type ET6 - External Fraud) that must be captured in operational risk loss databases. Required for SMA capital calculation, CCAR/DFAST stress testi',
    `interaction_id` BIGINT COMMENT 'Foreign key linking to channel.interaction. Business justification: Chargebacks reference the original transaction interaction for representment evidence (signed receipts, authorization codes, delivery confirmation, EMV chip data). Critical for chargeback defense, net',
    `party_id` BIGINT COMMENT 'Reference to the customer or party who initiated the chargeback dispute.',
    `redemption_id` BIGINT COMMENT 'Foreign key linking to asset.redemption. Business justification: Chargebacks may be filed against fraudulent redemption proceeds sent to wrong accounts. Direct link from chargeback to redemption supports dispute resolution workflow and recovery of misdirected redem',
    `subject_id` BIGINT COMMENT 'Foreign key linking to fraud.subject. Business justification: A chargeback initiated due to fraud is associated with a fraud subject. chargeback already has party_id → customer.party (the cardholder), but subject is the fraud-domain entity for the suspected frau',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to asset.subscription. Business justification: Chargebacks can be initiated against fraudulent subscription payments (unauthorized fund subscriptions charged to a payment card or bank account). Direct link from chargeback to subscription enables d',
    `acquirer_bin` STRING COMMENT 'Bank Identification Number of the acquiring bank that processed the original transaction. Identifies the financial institution responsible for the merchant relationship.. Valid values are `^[0-9]{6,8}$`',
    `arbitration_filed_date` DATE COMMENT 'The date when either party escalated the dispute to formal arbitration with the card network.',
    `card_network` STRING COMMENT 'The payment card network that governs the chargeback dispute process (e.g., Visa, Mastercard, American Express). Each network has distinct rules and timelines.. Valid values are `visa|mastercard|amex|discover|jcb|unionpay`',
    `card_type` STRING COMMENT 'Type of payment card involved in the disputed transaction (credit, debit, prepaid, or charge card).. Valid values are `credit|debit|prepaid|charge`',
    `chargeback_status` STRING COMMENT 'Current processing status of the chargeback within the current stage. Indicates whether the chargeback is awaiting action, under investigation, or has reached a decision point.. Valid values are `pending|under_review|accepted|rejected|reversed|withdrawn`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this chargeback record was first created in the system.',
    `dispute_amount` DECIMAL(18,2) COMMENT 'The monetary amount being disputed in the chargeback, typically matching the original transaction amount or a portion thereof.',
    `fee` DECIMAL(18,2) COMMENT 'Administrative fee charged by the card network or acquiring bank for processing the chargeback. Typically ranges from $15 to $100 depending on the network and merchant agreement.',
    `fraud_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the chargeback is related to confirmed or suspected fraudulent activity. True if the chargeback reason code indicates fraud.',
    `initiated_date` DATE COMMENT 'The date when the chargeback was first initiated by the cardholder or issuing bank.',
    `investigation_notes` STRING COMMENT 'Free-text field capturing investigator notes, findings, and supporting documentation references related to the chargeback investigation and resolution process.',
    `issuer_bin` STRING COMMENT 'Bank Identification Number of the card-issuing bank. Identifies the financial institution that issued the payment card to the cardholder.. Valid values are `^[0-9]{6,8}$`',
    `loss_amount` DECIMAL(18,2) COMMENT 'The net financial loss incurred by the bank after resolution of the chargeback, accounting for any recoveries, fees, and adjustments.',
    `masked_card_number` STRING COMMENT 'Partially masked payment card number (e.g., ****1234) used to identify the card while maintaining PCI DSS compliance. Only the last four digits are visible.',
    `merchant_name` STRING COMMENT 'Name of the merchant or business where the disputed transaction took place.',
    `network_case_number` STRING COMMENT 'Unique case identifier assigned by the payment card network (Visa, Mastercard, Amex) for tracking the chargeback through the network dispute resolution process.',
    `original_transaction_amount` DECIMAL(18,2) COMMENT 'The full amount of the original transaction that is subject to the chargeback dispute.',
    `original_transaction_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the original transaction amount.. Valid values are `^[A-Z]{3}$`',
    `original_transaction_date` DATE COMMENT 'The date when the original disputed transaction was processed.',
    `reason_code` STRING COMMENT 'Standardized code indicating the reason for the chargeback as defined by the card network (e.g., Visa reason codes 10.4 for fraud, 13.1 for merchandise not received). Each network maintains its own reason code taxonomy.',
    `reason_description` STRING COMMENT 'Human-readable description of the chargeback reason, providing context for the dispute (e.g., Fraudulent Transaction - Card Not Present, Services Not Provided, Duplicate Processing).',
    `received_timestamp` TIMESTAMP COMMENT 'The precise date and time when the bank received the chargeback notification from the payment network.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'The amount recovered by the bank through the chargeback process, representment, or other loss recovery mechanisms. May differ from the original dispute amount.',
    `representment_filed_date` DATE COMMENT 'The date when the merchant or acquiring bank filed a representment (rebuttal) to challenge the chargeback.',
    `resolution_date` DATE COMMENT 'The date when the chargeback dispute reached final resolution, either through acceptance, reversal, or arbitration decision.',
    `resolution_outcome` STRING COMMENT 'Final outcome of the chargeback dispute. Cardholder favor means the chargeback stands; merchant favor means the chargeback was reversed; partial reversal indicates a compromise; withdrawn means the cardholder retracted the dispute; expired means no response was filed within the deadline.. Valid values are `cardholder_favor|merchant_favor|partial_reversal|withdrawn|expired`',
    `response_deadline_date` DATE COMMENT 'The date by which the bank or merchant must respond to the chargeback to avoid automatic acceptance. Deadlines are typically set by card network rules (e.g., 30-45 days).',
    `sar_filed_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether a Suspicious Activity Report was filed with FinCEN in connection with this chargeback due to suspected fraud or money laundering.',
    `stage` STRING COMMENT 'Current stage in the chargeback dispute lifecycle. First chargeback is the initial dispute; representment is the merchants response; pre-arbitration and arbitration are escalation stages; closed indicates final resolution.. Valid values are `first_chargeback|representment|pre_arbitration|arbitration|closed`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this chargeback record was last modified, reflecting the most recent status change or data update.',
    CONSTRAINT pk_chargeback PRIMARY KEY(`chargeback_id`)
) COMMENT 'Master entity managing the full lifecycle of payment card chargebacks initiated in response to disputed or fraudulent transactions. Captures chargeback reason code (per Visa/Mastercard/Amex network rules), dispute amount, original transaction reference, chargeback stage (first chargeback, representment, pre-arbitration, arbitration), network case number, merchant ID, acquirer BIN, response deadlines, and final resolution outcome. Includes the complete audit trail of lifecycle events: network messages, representment filings, arbitration submissions, and resolution events with timestamps and responsible parties. Supports merchant fraud risk assessment including chargeback ratios and network monitoring program enrollment. Linked to fraud cases where chargebacks arise from confirmed fraud.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`sar_filing` (
    `sar_filing_id` BIGINT COMMENT 'Primary key for sar_filing',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: SAR filings must identify the country where suspicious activity occurred for cross-border AML reporting to FinCEN/FATF. Role-prefixed activity_country_id distinguishes the activity location from the f',
    `amended_sar_sar_filing_id` BIGINT COMMENT 'Reference to the original SAR filing that this record amends, if amendment_flag is true.',
    `capture_id` BIGINT COMMENT 'Foreign key linking to trade.capture. Business justification: FinCEN/BSA SAR filings for securities-related suspicious activity must reference the specific trade capture (booked trade) that triggered the filing. Regulators expect SARs to cite the underlying tran',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the monetary amounts reported in the SAR.',
    `custodian_account_id` BIGINT COMMENT 'Foreign key linking to wealth.custodian_account. Business justification: SAR filings for wealth custody fraud must identify the custodian account involved for FinCEN BSA reporting. Examiners reviewing SARs for custody fraud expect the custodian account reference to be dire',
    `deal_id` BIGINT COMMENT 'Foreign key linking to investment.deal. Business justification: SAR filings in investment banking are triggered by suspicious activity on specific deals (e.g., unusual trading ahead of M&A announcements). FinCEN/BSA compliance requires SAR filings to reference the',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: BSA/FinCEN SAR filings must identify the specific internal deposit account(s) involved in suspicious activity. Compliance officers link SARs to account records for regulatory examination, AML case man',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: SAR filings are submitted by a specific legal entity to FinCEN under BSA obligations. Regulators and internal compliance require knowing which legal entity filed each SAR. filing_institution_name and ',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: SARs filed for fund-level suspicious activity (suspected NAV manipulation, fund-level money laundering schemes) must reference the specific fund. FinCEN BSA requirements for investment company SARs ma',
    `fund_transaction_id` BIGINT COMMENT 'Foreign key linking to asset.fund_transaction. Business justification: FinCEN SAR filing requirements mandate transaction-level detail. SARs filed for suspicious fund transactions must reference the specific fund_transaction. Currently sar_filing links to investor_accoun',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: BSA/FinCEN SAR filings for securities fraud (market manipulation, insider trading, pump-and-dump schemes) must identify the specific instrument involved. Regulators require instrument-level detail in ',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: SARs are filed on suspicious investor account activity (structuring via fund purchases, layering through switches, integration patterns). Regulatory reporting requires direct linkage to investor accou',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: SAR filings for issuer-level fraud (fraudulent bond issuance, issuer misrepresentation, sanctioned entity securities activity) must identify the issuer. FinCEN/BSA requirements for securities-related ',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: SAR filings are submitted under a specific regulatory jurisdictions AML regime (FinCEN in US, FCA in UK). Fraud compliance teams must track which jurisdictions rules govern the filing, mandatory for',
    `kyc_record_id` BIGINT COMMENT 'Foreign key linking to customer.kyc_record. Business justification: SAR preparation workflows explicitly reference the subjects KYC record for AML risk rating, EDD completion status, prior SAR dates, and sanctions screening results. FinCEN/BSA compliance requires SAR',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: SAR filings for wealth management fraud (unauthorized trading, misappropriation of AUM) must reference the managed portfolio. FinCEN BSA reporting for investment adviser fraud requires identifying the',
    `offering_id` BIGINT COMMENT 'Foreign key linking to investment.offering. Business justification: SAR filings for suspicious activity in capital markets (allocation manipulation, wash trading in IPO bookbuilds) must reference the specific offering. FinCEN BSA compliance and FINRA surveillance requ',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: BSA/FinCEN SAR filings must reference the specific suspicious payment transactions. The sar_filing product has transaction_count and total_suspicious_amount as plain attributes but no direct payment_t',
    `case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: SARs filed by fraud teams reference the originating AML case for regulatory coordination. Banks track which AML case triggered the SAR for audit trail, regulatory exams, and FinCEN reporting consisten',
    `redemption_id` BIGINT COMMENT 'Foreign key linking to asset.redemption. Business justification: SARs are filed for suspicious redemption activity (rapid in-and-out redemptions indicative of money laundering). FinCEN BSA reporting requires direct linkage from SAR filing to the specific redemption',
    `subject_id` BIGINT COMMENT 'Foreign key linking to fraud.subject. Business justification: A SAR filing is filed about a specific fraud subject. sar_filing contains heavily denormalized subject data: subject_name, subject_address, subject_email, subject_phone, subject_tin — all of which are',
    `party_id` BIGINT COMMENT 'Reference to the primary party (customer or entity) who is the subject of the suspicious activity report.',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to asset.subscription. Business justification: SARs are filed for suspicious subscription activity (structuring, layering through fund subscriptions). BSA/AML regulatory filing requirements mandate direct linkage from SAR to the specific subscript',
    `account_number` STRING COMMENT 'Primary account number involved in the suspicious activity. May be masked or tokenized depending on internal security policy.',
    `activity_description` STRING COMMENT 'Detailed narrative description of the suspicious activity, including facts, patterns, and rationale for filing the SAR. This is the core investigative summary.',
    `amendment_flag` BOOLEAN COMMENT 'Indicates whether this SAR filing is an amendment to a previously filed SAR.',
    `approval_date` DATE COMMENT 'Date when the SAR filing received final internal approval before submission to FinCEN.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SAR filing record was first created in the fraud case management system.',
    `filing_date` DATE COMMENT 'Date when the SAR was officially filed with FinCEN. This is the principal business event timestamp for the SAR filing.',
    `filing_deadline_date` DATE COMMENT 'Regulatory deadline by which the SAR must be filed with FinCEN, typically 30 days from initial detection of suspicious activity.',
    `filing_institution_contact_name` STRING COMMENT 'Name of the individual at the filing institution who can be contacted regarding this SAR.',
    `filing_institution_contact_phone` STRING COMMENT 'Phone number of the filing institution contact person for follow-up inquiries.',
    `filing_status` STRING COMMENT 'Current lifecycle status of the SAR filing within the institutions workflow and FinCEN submission process. [ENUM-REF-CANDIDATE: draft|pending_review|approved|filed|amended|withdrawn|rejected — 7 candidates stripped; promote to reference product]',
    `filing_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the SAR was submitted to FinCENs BSA E-Filing system.',
    `fincen_acknowledgment_date` DATE COMMENT 'Date when FinCEN acknowledged receipt and acceptance of the SAR filing.',
    `fincen_bsa_reference` STRING COMMENT 'Unique identifier assigned by FinCEN upon successful submission and acknowledgment of the SAR filing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SAR filing record was last updated in the fraud case management system.',
    `law_enforcement_agency_name` STRING COMMENT 'Name of the law enforcement agency contacted or involved in the investigation of this suspicious activity.',
    `law_enforcement_contact_date` DATE COMMENT 'Date when law enforcement was contacted regarding this suspicious activity, if applicable.',
    `prior_sar_reference` STRING COMMENT 'Reference to any prior SAR filings related to the same subject or activity, enabling continuity tracking.',
    `rejection_reason` STRING COMMENT 'Reason provided by FinCEN or internal compliance for rejecting the SAR filing, if applicable.',
    `sar_number` STRING COMMENT 'Business identifier for the SAR filing, typically assigned by the financial institutions SAR management system.',
    `sar_type` STRING COMMENT 'Classification of the SAR based on the primary suspicious activity driver. This entity focuses on fraud-originated SARs distinct from compliance AML SARs.. Valid values are `fraud_related|aml_related|combined`',
    `suspicious_activity_end_date` DATE COMMENT 'Date when the suspicious activity being reported ended or was last observed. Nullable for ongoing activity.',
    `suspicious_activity_start_date` DATE COMMENT 'Date when the suspicious activity being reported first began or was first detected.',
    `suspicious_activity_type_code` STRING COMMENT 'FinCEN-defined code(s) categorizing the type of suspicious activity. Multiple codes may be concatenated or stored as delimited list. [ENUM-REF-CANDIDATE: fraud_card|fraud_ach|fraud_wire|fraud_check|fraud_identity_theft|fraud_account_takeover|fraud_elder_financial_exploitation|fraud_mortgage|fraud_consumer_loan|fraud_commercial_loan|fraud_securities|fraud_insurance|fraud_other — promote to reference product]',
    `total_suspicious_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary value of all transactions or activity deemed suspicious and reported in this SAR.',
    `transaction_count` STRING COMMENT 'Number of individual transactions or events that comprise the suspicious activity being reported.',
    `withdrawal_reason` STRING COMMENT 'Explanation for why a SAR filing was withdrawn, if applicable. Populated only when filing_status is withdrawn.',
    CONSTRAINT pk_sar_filing PRIMARY KEY(`sar_filing_id`)
) COMMENT 'Master entity representing a Suspicious Activity Report (SAR) filed with FinCEN under BSA obligations arising from fraud investigations. Captures SAR type (fraud-related vs AML-related — this entity covers fraud-originated SARs distinct from compliance AML SARs), filing date, subject information, activity description, suspicious activity type codes, monetary amounts, filing status (draft, filed, amended, withdrawn), FinCEN acknowledgment reference, and the originating fraud case reference. Managed within NICE Actimize SAR filing module.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`loss_recovery` (
    `loss_recovery_id` BIGINT COMMENT 'Unique identifier for the loss recovery record. Primary key for the loss recovery entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Fraud losses must be recognized in the correct accounting period for financial close, CCAR operational loss data collection, and Basel AMA capital calculations. Banking controllers require period-leve',
    `capture_id` BIGINT COMMENT 'Foreign key linking to trade.capture. Business justification: Loss recovery for trading fraud must reference the specific trade capture that caused the loss for Basel III operational risk loss event reporting, CCAR stress testing, and insurance claim substantiat',
    `chargeback_id` BIGINT COMMENT 'Foreign key linking to fraud.chargeback. Business justification: Loss recovery records track recovery of fraud losses, which frequently originate from chargeback disputes. loss_recovery.chargeback_reference_number is a denormalized string reference to the chargebac',
    `claim_id` BIGINT COMMENT 'Foreign key linking to fraud.claim. Business justification: Loss recovery tracks the financial recovery lifecycle for fraud losses, which are often initiated by customer claims. Linking loss_recovery.claim_id → claim establishes the direct operational relation',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Fraud losses are allocated to cost centers for Basel II operational risk capital reporting, CCAR stress testing, and internal P&L attribution. The existing cost_center_code is a denormalized plain-tex',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the loss amount. Required for multi-currency operations and regulatory reporting.',
    `custodian_account_id` BIGINT COMMENT 'Foreign key linking to wealth.custodian_account. Business justification: Loss recovery efforts for wealth custody fraud trace back to the custodian account where the loss occurred. Basel operational risk loss event reporting and insurance claim processing for custody fraud',
    `deposit_account_id` BIGINT COMMENT 'Reference to the specific account (deposit, card, loan) where the fraud loss occurred, if applicable.',
    `case_id` BIGINT COMMENT 'Reference to the confirmed fraud case that generated this loss. Links to the fraud case management system.',
    `fund_transaction_id` BIGINT COMMENT 'Foreign key linking to asset.fund_transaction. Business justification: Loss recovery records must reference the specific fraudulent fund transaction to calculate gross loss and net recovery amounts. Audit trail and regulatory reporting require transaction-level linkage i',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Fraud loss recoveries (insurance claims, chargebacks, legal restitution) must be posted to GL accounts to offset original loss entries, update net loss positions for regulatory reporting, and maintain',
    `incident_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_incident. Business justification: Loss recovery can be linked to the specific fraud incident for which recovery is being pursued. N:1 relationship. No bidirectional conflict (fraud_incident does not have loss_recovery_id FK back). Rec',
    `interbank_placement_id` BIGINT COMMENT 'Foreign key linking to treasury.interbank_placement. Business justification: Interbank fraud loss recovery: losses from interbank placement fraud must reference the originating placement for Basel operational risk reporting, regulatory capital calculation, and legal recovery t',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: Loss recovery for investment fraud must reference the investor account that suffered the loss. FINRA/SEC regulatory reporting and restitution tracking require direct investor account linkage in loss r',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Fraud loss recognition requires a journal entry to book the gross loss to the GL (distinct from the chargebacks GL entry). Basel operational risk ILDC and CCAR loss data collection require tracing ea',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Loss recovery tracking for fraud events in wealth accounts requires portfolio-level attribution for insurance claims, client reimbursement, and regulatory reporting (CCAR, Basel). Operational requirem',
    `nostro_account_id` BIGINT COMMENT 'Foreign key linking to treasury.nostro_account. Business justification: Nostro fraud loss recovery: losses from nostro account fraud must reference the originating nostro_account for Basel operational risk event reporting, reconciliation, and insurance/legal recovery. Ban',
    `operational_risk_event_id` BIGINT COMMENT 'Foreign key linking to risk.operational_risk_event. Business justification: Recovery amounts offset gross operational risk losses in Basel capital calculations. Operational risk events must track both gross loss and recoveries (insurance, chargebacks, legal) to calculate net ',
    `party_id` BIGINT COMMENT 'Reference to the customer whose account or relationship was impacted by the fraud loss, if applicable.',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: Loss recovery efforts (clawbacks, reversals, insurance recoveries) must reference the original payment transaction to initiate recall requests, calculate net loss, and satisfy Basel operational risk r',
    `portfolio_transaction_id` BIGINT COMMENT 'Foreign key linking to wealth.portfolio_transaction. Business justification: Fraud loss recovery in wealth management traces back to the specific portfolio transaction that generated the loss. Basel II/III operational risk loss event reporting and CCAR stress testing require l',
    `redemption_id` BIGINT COMMENT 'Foreign key linking to asset.redemption. Business justification: Loss recovery efforts frequently target unauthorized redemptions. Direct link from loss_recovery to redemption enables tracking of recovery amounts against the specific redemption event for regulatory',
    `repo_transaction_id` BIGINT COMMENT 'Foreign key linking to treasury.repo_transaction. Business justification: Repo fraud loss recovery tracking: when fraud losses arise from repo transactions, the loss_recovery record must reference the originating repo_transaction for Basel II operational risk event reportin',
    `subject_id` BIGINT COMMENT 'Foreign key linking to fraud.subject. Business justification: Loss recovery efforts are directed against fraud subjects (perpetrators from whom recovery is sought). loss_recovery already has party_id → customer.party, but subject is the fraud-domain entity with ',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to asset.subscription. Business justification: Loss recovery efforts may target specific fraudulent subscriptions (recovering funds from fraudulently initiated subscriptions). Direct link from loss_recovery to subscription supports recovery tracki',
    `trust_account_id` BIGINT COMMENT 'Foreign key linking to wealth.trust_account. Business justification: Loss recovery for trust fraud (misappropriation, unauthorized distributions) must reference the trust account. Regulatory reporting of trust fraud losses, insurance claims, and fiduciary bond recovery',
    `basel_event_type_code` STRING COMMENT 'Basel III operational risk event type classification code. Fraud losses typically fall under Level 1 Event Type 1 (Internal Fraud) or 3 (Clients, Products & Business Practices).. Valid values are `^[1-7].[1-9]$`',
    `business_line` STRING COMMENT 'The line of business (LOB) where the fraud loss occurred. Aligns with Basel III business line segmentation for operational risk capital allocation.. Valid values are `retail_banking|corporate_banking|payment_services|trading_sales|asset_management|commercial_banking`',
    `ccar_loss_event_flag` BOOLEAN COMMENT 'Indicates whether this loss event is included in the historical loss data set used for CCAR stress testing scenarios.',
    `closed_timestamp` TIMESTAMP COMMENT 'The timestamp when the loss recovery case was closed and final disposition was recorded. Null if the case is still open.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this loss recovery record was first created in the system.',
    `gross_loss_amount` DECIMAL(18,2) COMMENT 'The total financial loss amount before any recoveries, expressed in the reporting currency. Represents the initial impact of the fraud event.',
    `insurance_claim_number` STRING COMMENT 'Reference number for the insurance claim filed for this loss, if applicable. Links to external insurance carrier systems.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `insurance_recovery_amount` DECIMAL(18,2) COMMENT 'The portion of the total recovery amount that was received from insurance. Subset of the total recovery amount.',
    `legal_case_number` STRING COMMENT 'Reference number for legal proceedings initiated to recover the loss, if applicable. Links to legal case management systems.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `loss_category` STRING COMMENT 'Classification of the fraud loss by fraud typology. Aligns with internal fraud taxonomy for retail, card, wire, and deposit fraud.. Valid values are `card_fraud|wire_fraud|ach_fraud|check_fraud|account_takeover|identity_theft`',
    `loss_date` DATE COMMENT 'The date when the fraud loss was recognized and recorded in the financial system.',
    `loss_description` STRING COMMENT 'Detailed narrative description of the fraud loss event, including circumstances, methods used, and impact. Confidential business information.',
    `loss_discovery_date` DATE COMMENT 'The date when the fraud loss was first discovered or detected by the institution.',
    `loss_event_number` STRING COMMENT 'Business-readable unique identifier for the loss event, typically formatted as business-line prefix, year, and sequence number.. Valid values are `^[A-Z]{3}-[0-9]{4}-[0-9]{6}$`',
    `loss_status` STRING COMMENT 'Current lifecycle status of the loss recovery record. Tracks the overall case from initial recognition through final disposition.. Valid values are `open|under_review|recovery_in_progress|closed_recovered|closed_written_off`',
    `net_loss_amount` DECIMAL(18,2) COMMENT 'The net financial loss after all recoveries, calculated as gross loss amount minus recovery amount. This is the final loss impact used for regulatory capital calculations.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'The total amount recovered from all recovery activities, expressed in the same currency as the gross loss. Null if no recovery has occurred.',
    `recovery_date` DATE COMMENT 'The date when the recovery amount was received or recognized. Null if no recovery has occurred.',
    `recovery_method` STRING COMMENT 'The method or channel through which loss recovery was pursued or achieved. Includes insurance claims, chargeback processes, legal action, and write-offs. [ENUM-REF-CANDIDATE: insurance|merchant_chargeback|network_recovery|legal_judgment|customer_restitution|write_off|other — 7 candidates stripped; promote to reference product]',
    `recovery_notes` STRING COMMENT 'Free-text notes documenting recovery activities, communications with recovery parties, and status updates. Confidential business information.',
    `recovery_status` STRING COMMENT 'Current status of recovery efforts for this loss event. Tracks the lifecycle from initial pursuit through final disposition.. Valid values are `pending|in_progress|partial_recovery|full_recovery|abandoned|write_off`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this loss event must be included in regulatory operational risk loss data reporting under Basel III SMA or CCAR/DFAST stress testing.',
    `sar_filed_flag` BOOLEAN COMMENT 'Indicates whether a Suspicious Activity Report was filed with FinCEN for this fraud loss event, as required under the Bank Secrecy Act.',
    `sar_filing_date` DATE COMMENT 'The date when the SAR was filed with FinCEN, if applicable. Null if no SAR was filed.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this loss recovery record was last modified. Supports audit trail and data lineage tracking.',
    `write_off_approval_authority` STRING COMMENT 'The name or role of the authority who approved the write-off decision, per internal delegation of authority policies.',
    `write_off_date` DATE COMMENT 'The date when the unrecovered loss amount was written off in the general ledger. Null if the loss has not been written off.',
    CONSTRAINT pk_loss_recovery PRIMARY KEY(`loss_recovery_id`)
) COMMENT 'Transactional entity tracking the complete fraud loss lifecycle from initial loss recognition through recovery activities for confirmed fraud cases. Captures loss event details (loss date, loss category, Basel event type code, gross loss amount, business line, GL account reference) and recovery activities (recovery method — insurance, merchant, network, legal judgment, write-off; recovery amount, recovery date, recovery status). Calculates net loss after recovery. Supports financial reconciliation against the general ledger, regulatory loss reporting under Basel III SMA framework, CCAR/DFAST stress testing loss history, operational risk loss data collection, and internal management reporting on fraud financial impact.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`detection_rule` (
    `detection_rule_id` BIGINT COMMENT 'Unique identifier for the fraud detection rule within the transaction monitoring engine.',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code applicable when threshold is monetary (e.g., USD, EUR, GBP). Null for non-monetary thresholds.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Fraud detection rules are configured and tuned per customer segment (e.g., Premier Banking, SME, Retail) with different thresholds and logic. Rule governance and model performance reporting require st',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Fraud detection rules use time-window logic (velocity checks, transaction frequency) that must account for business days vs. holidays. Rule configuration requires a holiday calendar to correctly calcu',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: Fraud detection rules target specific high-risk industries (gambling, money services businesses, cryptocurrency exchanges). Structured industry_code FK enables rule applicability reporting by industry',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Fraud detection rules are jurisdiction-specific: GDPR constrains data use in EU rules, FinCEN rules apply in the US, PSD2 governs EU payment fraud rules. Fraud rule governance and regulatory approval ',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Fraud detection rules are implemented to satisfy specific regulatory obligations (BSA, Reg E, FFIEC fraud guidance). Compliance teams must demonstrate that fraud monitoring controls satisfy named regu',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: Fraud detection rules are configured per product type (credit card velocity rules differ from wire transfer rules). The existing product_applicability is a denormalized text field; a FK to product_typ',
    `alert_priority_score` STRING COMMENT 'Numeric priority score (1-100) assigned to alerts generated by this rule, used for case queue prioritization and resource allocation. Higher scores indicate higher priority.',
    `alert_volume` BIGINT COMMENT 'Total number of alerts generated by this rule during the measurement period. Used for capacity planning and rule efficiency assessment.',
    `approval_authority` STRING COMMENT 'Name or role of the authority who approved the rule for production deployment. Required for audit trail and governance compliance.',
    `approval_date` DATE COMMENT 'Date when the rule was formally approved for production use by the designated approval authority. Part of the rule governance audit trail.',
    `case_conversion_rate` DECIMAL(18,2) COMMENT 'Proportion of alerts that resulted in formal fraud investigation cases, calculated as cases opened divided by total alerts. Indicates rule precision and investigative value.',
    `channel_applicability` STRING COMMENT 'Comma-separated list of banking channels to which this rule applies: online banking, mobile app, ATM (Automated Teller Machine), branch, call center, wire transfer, ACH (Automated Clearing House), card payment. Empty indicates all channels.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the detection rule record was first created in the system. Part of the audit trail for rule lifecycle management.',
    `detection_effectiveness_score` DECIMAL(18,2) COMMENT 'Composite metric (0-100) evaluating overall rule performance, incorporating true positive rate, false positive rate, and case conversion rate. Used for rule ranking and optimization prioritization.',
    `effective_date` DATE COMMENT 'Date when the detection rule became active in the production monitoring environment. Used for historical analysis and rule lifecycle tracking.',
    `expiration_date` DATE COMMENT 'Date when the detection rule is scheduled to be retired or reviewed. Null for rules without planned expiration. Supports rule governance and periodic review processes.',
    `false_positive_rate` DECIMAL(18,2) COMMENT 'Proportion of legitimate transactions incorrectly flagged as fraud, calculated as false positives divided by total legitimate transactions. Critical for operational efficiency and customer experience.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the detection rule record was last updated. Tracks configuration changes and parameter adjustments over time.',
    `last_tuning_date` DATE COMMENT 'Date when the rule parameters were last adjusted or optimized based on performance analysis. Critical for tracking rule maintenance and effectiveness improvement efforts.',
    `measurement_period_end_date` DATE COMMENT 'End date of the performance measurement period for the recorded metrics. Defines the temporal scope of performance statistics.',
    `measurement_period_start_date` DATE COMMENT 'Start date of the performance measurement period for the recorded metrics. Enables time-series analysis of rule effectiveness.',
    `ml_model_name` STRING COMMENT 'Name or identifier of the machine learning model used for detection, if applicable. References trained model artifacts in the fraud analytics platform.',
    `ml_model_version` STRING COMMENT 'Version identifier of the machine learning model, enabling model lineage tracking and performance comparison across model iterations.',
    `model_type` STRING COMMENT 'Detection methodology employed: rule-based (deterministic logic), machine learning (ML/AI model), hybrid (combination of rules and ML), statistical (statistical anomaly detection).. Valid values are `rule_based|machine_learning|hybrid|statistical`',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether confirmed fraud cases from this rule must be included in regulatory reports such as CTR (Currency Transaction Report) or SAR (Suspicious Activity Report) filings.',
    `rule_category` STRING COMMENT 'Classification of the detection rule by fraud detection methodology: velocity check (transaction frequency), amount threshold (monetary limits), geographic anomaly (location-based), device fingerprint (device identification), behavioral pattern (customer behavior analysis), or account takeover (credential compromise detection).. Valid values are `velocity_check|amount_threshold|geographic_anomaly|device_fingerprint|behavioral_pattern|account_takeover`',
    `rule_code` STRING COMMENT 'Unique alphanumeric code assigned to the detection rule for system integration and cross-reference with monitoring platforms such as NICE Actimize or Oracle Financial Crime.',
    `rule_description` STRING COMMENT 'Comprehensive business description of the rules purpose, detection methodology, and intended use cases. Provides context for analysts and auditors.',
    `rule_documentation_url` STRING COMMENT 'URL or file path to detailed technical documentation, configuration guides, and tuning history for the rule. Supports knowledge management and operational continuity.',
    `rule_logic` STRING COMMENT 'Detailed description of the rules detection logic, including conditions, thresholds, and decision criteria. May reference SQL-like expressions, business rules, or machine learning model invocation logic.',
    `rule_name` STRING COMMENT 'Business-friendly name of the fraud detection rule used for identification and reporting purposes.',
    `rule_owner` STRING COMMENT 'Name or identifier of the business unit, team, or individual responsible for rule governance, performance monitoring, and tuning decisions.',
    `rule_severity` STRING COMMENT 'Severity classification of alerts generated by this rule, indicating priority for investigation: critical (immediate action required), high (urgent review), medium (standard review), low (informational).. Valid values are `critical|high|medium|low`',
    `rule_status` STRING COMMENT 'Current operational status of the detection rule: active (in production), inactive (disabled), testing (pilot mode), retired (permanently decommissioned), suspended (temporarily disabled pending review).. Valid values are `active|inactive|testing|retired|suspended`',
    `sar_escalation_flag` BOOLEAN COMMENT 'Indicates whether alerts from this rule automatically trigger SAR (Suspicious Activity Report) escalation workflow for regulatory reporting to FinCEN (Financial Crimes Enforcement Network).',
    `threshold_unit` STRING COMMENT 'Unit of measurement for the threshold value: currency (monetary amount), count (transaction frequency), percentage (ratio), score (risk score), or standard deviation (statistical measure).. Valid values are `currency|count|percentage|score|standard_deviation`',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold parameter that triggers the rule when exceeded. For amount-based rules, represents monetary limit; for velocity rules, represents transaction count; for behavioral rules, represents deviation score.',
    `time_window_unit` STRING COMMENT 'Unit of time for the evaluation window: minute, hour, day, week, or month. Defines the temporal scope for transaction aggregation and pattern detection.. Valid values are `minute|hour|day|week|month`',
    `time_window_value` STRING COMMENT 'Numeric value defining the lookback or evaluation period for the rule (e.g., 24 for 24 hours, 7 for 7 days). Used in velocity checks and pattern analysis.',
    `true_positive_rate` DECIMAL(18,2) COMMENT 'Proportion of actual fraud cases correctly identified by the rule, calculated as true positives divided by total actual fraud cases. Key performance metric for detection effectiveness.',
    `tuning_frequency_days` STRING COMMENT 'Recommended number of days between rule performance reviews and parameter adjustments. Supports proactive rule maintenance scheduling.',
    CONSTRAINT pk_detection_rule PRIMARY KEY(`detection_rule_id`)
) COMMENT 'Master entity defining fraud detection rules, thresholds, and ML model configurations within the transaction monitoring engine. Captures rule name, category (velocity check, amount threshold, geographic anomaly, device fingerprint, behavioral pattern), rule logic, threshold parameters, channel and product applicability, rule status (active, inactive, testing), effective date, and last tuning date. Includes periodic performance measurement records: true positive rate, false positive rate, alert volume, case conversion rate, detection effectiveness metrics, and measurement period. Supports the complete operational rule tuning lifecycle from initial configuration through performance measurement, governance review, and retirement decisions.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`evidence` (
    `evidence_id` BIGINT COMMENT 'Unique identifier for the fraud evidence item. Primary key for the fraud evidence entity.',
    `account_transaction_id` BIGINT COMMENT 'Foreign key linking to account.account_transaction. Business justification: Fraud investigators attach specific account transactions as evidence items in investigations and court proceedings. Chain-of-custody tracking and legal discovery require direct linkage between evidenc',
    `capture_id` BIGINT COMMENT 'Foreign key linking to trade.capture. Business justification: Evidence in trading fraud investigations (rogue trader, fictitious trades) includes the actual trade capture record as a primary exhibit. Legal proceedings and regulatory exams require evidence to be ',
    `case_id` BIGINT COMMENT 'Reference to the parent fraud case or investigation to which this evidence item is attached.',
    `fund_transaction_id` BIGINT COMMENT 'Foreign key linking to asset.fund_transaction. Business justification: Evidence collection includes specific fund transaction records (confirmations, instructions, audit trails, timestamps). Chain of custody and legal admissibility requirements necessitate direct linkage',
    `incident_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_incident. Business justification: Evidence can be collected for a specific fraud incident in addition to the overall case. N:1 relationship. No bidirectional conflict (fraud_incident does not have evidence_id FK back). Evidence can re',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Evidence in securities fraud investigations (trade confirmations, prospectuses, term sheets, pricing records) must be linked to the specific instrument. Chain-of-custody and regulatory exam processes ',
    `investigation_id` BIGINT COMMENT 'Foreign key linking to fraud.investigation. Business justification: Evidence items are collected and attached to fraud investigations. investigation.evidence_items_count and evidence_summary confirm that investigations manage evidence. evidence already links to case a',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: Evidence in investment fraud investigations is directly tied to investor account records (account statements, transaction histories). Chain of custody and regulatory exam requirements mandate direct i',
    `redemption_id` BIGINT COMMENT 'Foreign key linking to asset.redemption. Business justification: Evidence tied to unauthorized redemption events (fraudulent redemption confirmations, forged instructions) requires direct linkage to the redemption record for chain of custody management and legal pr',
    `sar_filing_id` BIGINT COMMENT 'Foreign key linking to fraud.sar_filing. Business justification: Evidence items may be attached to SAR filings as supporting documentation submitted to FinCEN. evidence.sar_reference_number is a denormalized string reference to the SAR; adding evidence.sar_filing_i',
    `subject_id` BIGINT COMMENT 'Foreign key linking to fraud.subject. Business justification: Evidence items are collected about fraud subjects — documents, records, and digital artifacts that implicate or relate to a specific subject. Adding evidence.subject_id → subject links evidence direct',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to asset.subscription. Business justification: Evidence in fund fraud investigations may be specifically tied to a subscription record (forged subscription documents, fraudulent application forms). Direct link supports evidence chain of custody an',
    `admissibility_classification` STRING COMMENT 'Legal admissibility classification of the evidence item for use in legal proceedings, regulatory examinations, or law enforcement referrals. Indicates whether the evidence meets evidentiary standards and chain of custody requirements.. Valid values are `admissible|inadmissible|pending_review|conditional`',
    `archived_timestamp` TIMESTAMP COMMENT 'The date and time when the evidence item was moved to long-term archival storage.',
    `chain_of_custody_status` STRING COMMENT 'Current lifecycle status of the evidence item within the chain of custody process. Tracks whether the evidence has been collected, secured in storage, transferred to another party, archived for long-term retention, or destroyed per retention policy.. Valid values are `collected|secured|transferred|archived|destroyed`',
    `collection_timestamp` TIMESTAMP COMMENT 'The date and time when the evidence item was collected or extracted from the source system. Represents the principal business event timestamp for evidence capture.',
    `confidentiality_level` STRING COMMENT 'Data classification level of the evidence item based on its sensitivity and the presence of personally identifiable information (PII), protected health information (PHI), or other sensitive data.. Valid values are `public|internal|confidential|restricted`',
    `contains_pii_flag` BOOLEAN COMMENT 'Indicates whether the evidence item contains personally identifiable information (PII) subject to privacy regulations such as GDPR, CCPA, or GLBA.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this fraud evidence record was first created in the fraud case management system.',
    `destroyed_timestamp` TIMESTAMP COMMENT 'The date and time when the evidence item was destroyed per retention policy and legal requirements.',
    `destruction_authorized_by` BIGINT COMMENT 'Reference to the employee or manager who authorized the destruction of the evidence item after confirming retention period expiration and absence of legal holds.',
    `destruction_method` STRING COMMENT 'The method used to destroy the evidence item. Includes secure deletion (for digital files), shredding (for paper documents), degaussing (for magnetic media), or incineration.. Valid values are `secure_deletion|shredding|degaussing|incineration`',
    `evidence_description` STRING COMMENT 'Detailed textual description of the evidence item, including its content, relevance to the fraud case, and any notable characteristics or findings.',
    `evidence_type` STRING COMMENT 'Classification of the evidence item by its nature and format. Includes transaction log extract, device fingerprint record, IP geolocation data, call recording, surveillance footage, document image, network traffic log, customer correspondence, witness statement, and third-party verification response.. Valid values are `transaction_log|device_fingerprint|ip_geolocation|call_recording|surveillance_footage|document_image`',
    `file_format` STRING COMMENT 'The file format or media type of the evidence artifact. Common formats include PDF, image files (JPG, PNG), audio recordings (MP3), video files (MP4), structured data (CSV, XML, JSON), and document formats (DOC, DOCX, TXT). [ENUM-REF-CANDIDATE: pdf|jpg|png|mp3|mp4|csv|xml|json|txt|doc|docx — 11 candidates stripped; promote to reference product]',
    `file_name` STRING COMMENT 'The original or assigned file name of the evidence artifact, including file extension if applicable.',
    `file_size_bytes` BIGINT COMMENT 'The size of the evidence file or artifact in bytes. Used for storage capacity planning and transfer validation.',
    `hash_algorithm` STRING COMMENT 'The cryptographic hash algorithm used to generate the hash value for evidence integrity verification.. Valid values are `SHA-256|SHA-512|MD5`',
    `hash_value` DECIMAL(18,2) COMMENT 'Cryptographic hash (e.g., SHA-256) of the evidence file to ensure integrity and detect tampering. Used to verify that the evidence has not been altered since collection.',
    `internal_audit_reference` STRING COMMENT 'Reference identifier for the internal audit review or control testing for which this evidence item was produced or is relevant.',
    `law_enforcement_agency` STRING COMMENT 'The name or identifier of the law enforcement agency with which the evidence was shared, if applicable.',
    `law_enforcement_case_number` STRING COMMENT 'The case number or reference assigned by the law enforcement agency for tracking the evidence in their investigation.',
    `law_enforcement_shared_flag` BOOLEAN COMMENT 'Indicates whether this evidence item has been shared with law enforcement agencies as part of a criminal investigation or Suspicious Activity Report (SAR) filing.',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether the evidence item is subject to a legal hold order, preventing its destruction or alteration pending litigation, regulatory examination, or law enforcement investigation.',
    `legal_hold_reference` STRING COMMENT 'Reference identifier for the legal hold order or case that requires preservation of this evidence item.',
    `notes` STRING COMMENT 'Free-text notes or comments from investigators regarding the evidence item, its context, or its significance to the case.',
    `regulatory_exam_reference` STRING COMMENT 'Reference identifier for the regulatory examination or audit request for which this evidence item was produced or is relevant.',
    `relevance_score` DECIMAL(18,2) COMMENT 'A numerical score (0.00 to 100.00) indicating the relevance or importance of this evidence item to the fraud case investigation. Higher scores indicate more critical evidence.',
    `retention_expiration_date` DATE COMMENT 'The date on which the evidence retention period expires and the evidence item becomes eligible for destruction, unless subject to legal hold or extended retention requirements.',
    `retention_period_days` STRING COMMENT 'The number of days the evidence item must be retained per the banks evidence retention policy, regulatory requirements, and legal hold obligations. Drives evidence archival and destruction schedules.',
    `secure_storage_reference` STRING COMMENT 'Reference identifier or URI pointing to the secure storage location where the evidence file or artifact is stored. May reference document management system, secure file share, or evidence vault.',
    `source_system` STRING COMMENT 'The operational system from which the evidence was collected. Includes core banking system, card processor, digital banking platform, telephony system, physical security system, payment processing hub, and other source systems.. Valid values are `core_banking|card_processor|digital_banking|telephony|physical_security|payment_hub`',
    `transfer_method` STRING COMMENT 'The method used to transfer the evidence item to another party. Includes secure email, encrypted file transfer, physical media (USB, CD), secure portal, or in-person handoff.. Valid values are `secure_email|encrypted_file_transfer|physical_media|secure_portal|in_person`',
    `transfer_recipient` STRING COMMENT 'The name or identifier of the party to whom the evidence item was transferred.',
    `transfer_timestamp` TIMESTAMP COMMENT 'The date and time when the evidence item was transferred to another party, such as law enforcement, legal counsel, or regulatory authority.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this fraud evidence record was last modified in the fraud case management system.',
    CONSTRAINT pk_evidence PRIMARY KEY(`evidence_id`)
) COMMENT 'Operational entity capturing evidence items collected and attached to fraud investigations and cases within the banks fraud case management system. Tracks evidence type (transaction log extract, device fingerprint record, IP geolocation data, call recording, surveillance footage, document image, network traffic log, customer correspondence, witness statement, third-party verification response), evidence source system (core banking, card processor, digital banking platform, telephony, physical security), collection date and time, collecting analyst, chain of custody status (collected, secured, transferred, archived, destroyed), secure storage reference, admissibility classification, and retention period per the banks evidence retention policy. Supports legal referrals, law enforcement evidence packages, regulatory examination responses, and internal audit reviews.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`claim` (
    `claim_id` BIGINT COMMENT 'Unique identifier for the fraud claim record. Primary key.',
    `account_transaction_id` BIGINT COMMENT 'Foreign key linking to account.account_transaction. Business justification: Reg E fraud claims are filed against a specific account transaction. The claim resolution process, provisional credit issuance, and regulatory reporting all require direct reference to the disputed tr',
    `alert_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_alert. Business justification: A customer fraud claim is often initiated in response to a fraud alert generated by the detection system. Linking claim.fraud_alert_id → fraud_alert connects the customer-facing claim to the system-ge',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Customer fraud claims are received via specific channels (branch, contact center, digital). Tracking this enables claim processing workflow routing, SLA management, Reg E compliance (provisional credi',
    `deposit_account_id` BIGINT COMMENT 'Identifier of the account associated with the fraud claim.',
    `claim_provisional_credit_account_deposit_account_id` BIGINT COMMENT 'Identifier of the account to which provisional credit was posted.',
    `interaction_id` BIGINT COMMENT 'Foreign key linking to channel.interaction. Business justification: Customer fraud claims reference specific interactions. Linking enables claim validation (did transaction occur as claimed?), provisional credit calculation (Reg E 10-day rule), dispute resolution, and',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the claimed amount.',
    `case_id` BIGINT COMMENT 'Foreign key linking to fraud.case. Business justification: A customer claim can escalate to or be associated with a formal fraud case. N:1 relationship. No bidirectional conflict (case does not have claim_id FK back). No columns to remove as claim tracks its ',
    `chargeback_id` BIGINT COMMENT 'External case identifier for the chargeback filed with the card network or payment processor.',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Regulation E (12 CFR 1005) mandates provisional credit within 5 business days of error notification. The provisional_credit_issued_date deadline calculation requires a holiday calendar. This is a dire',
    `incident_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_incident. Business justification: A customer claim can be linked to a specific fraud incident. N:1 relationship. No bidirectional conflict (fraud_incident does not have claim_id FK back). Claim tracks customer-initiated dispute, incid',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Customer claims for unauthorized securities transactions (e.g., unauthorized equity purchase, bond mis-selling) must reference the specific instrument. Claim resolution, reimbursement calculation, and',
    `investigation_id` BIGINT COMMENT 'Foreign key linking to fraud.investigation. Business justification: A customer fraud claim triggers an investigation workflow. claim.investigation_start_date and investigation_completion_date are denormalized copies of investigation.start_date and end_date. Adding cla',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: Customer fraud claims involving unauthorized investment account activity must reference the investor account. Regulatory claim processing for investment accounts and restitution workflows require dire',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Customer fraud claims on wealth accounts (disputed trades, unauthorized withdrawals, advisor misconduct) require portfolio linkage for investigation, provisional credit decisions, and final resolution',
    `party_id` BIGINT COMMENT 'Identifier of the customer who submitted the fraud claim.',
    `portfolio_transaction_id` BIGINT COMMENT 'Foreign key linking to wealth.portfolio_transaction. Business justification: Client fraud claims in wealth management reference the specific portfolio transaction disputed (unauthorized redemption, misappropriated trade proceeds). Required for claim resolution, reimbursement c',
    `redemption_id` BIGINT COMMENT 'Foreign key linking to asset.redemption. Business justification: Fraud claims frequently arise from unauthorized redemptions from investor accounts. Direct link from claim to redemption enables chargeback initiation, restitution tracking, and regulatory claim resol',
    `sar_filing_id` BIGINT COMMENT 'Foreign key linking to fraud.sar_filing. Business justification: A fraud claim may result in or be associated with a SAR filing under BSA obligations. claim.sar_bsa_identifier is a denormalized reference to sar_filing.fincen_bsa_reference, and sar_filing_date is av',
    `subject_id` BIGINT COMMENT 'Foreign key linking to fraud.subject. Business justification: A fraud claim is filed against or in relation to a fraud subject. claim already has party_id → customer.party (the claimant), but subject is the fraud-domain entity for the suspected fraudster. Adding',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to asset.subscription. Business justification: Fraud claims are filed against specific fraudulent subscription transactions (unauthorized fund subscriptions via identity theft). Direct link from claim to subscription enables investigation scoping ',
    `trust_account_id` BIGINT COMMENT 'Foreign key linking to wealth.trust_account. Business justification: Fraud claims arising from trust account misappropriation or unauthorized distributions must reference the trust account. Required for fiduciary liability assessment, claim resolution, and regulatory r',
    `attestation_date` DATE COMMENT 'Date the customer attestation or affidavit was received by the bank.',
    `chargeback_initiated` BOOLEAN COMMENT 'Indicates whether a chargeback was initiated with the card network or merchant acquirer as part of the claim resolution process.',
    `claim_number` STRING COMMENT 'Externally visible unique claim reference number assigned at intake for customer and regulatory tracking.. Valid values are `^CLM[0-9]{10}$`',
    `claim_status` STRING COMMENT 'Current lifecycle status of the fraud claim in the investigation and resolution workflow. [ENUM-REF-CANDIDATE: received|under_investigation|pending_documentation|approved|denied|closed|withdrawn — 7 candidates stripped; promote to reference product]',
    `claim_type` STRING COMMENT 'Classification of the fraud claim based on the nature of the fraudulent activity reported by the customer.. Valid values are `unauthorized_transaction|identity_theft|account_takeover|card_fraud|check_fraud|wire_fraud`',
    `claimed_amount` DECIMAL(18,2) COMMENT 'Total monetary amount claimed by the customer as fraudulent or disputed, in the account currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fraud claim record was first created in the system.',
    `customer_attestation_received` BOOLEAN COMMENT 'Indicates whether the customer has provided a signed attestation or affidavit affirming the fraudulent nature of the transactions.',
    `customer_notification_date` DATE COMMENT 'Date the customer was notified of the claim resolution outcome.',
    `customer_notification_sent` BOOLEAN COMMENT 'Indicates whether the customer was notified of the claim resolution outcome as required by consumer protection regulations.',
    `final_credit_confirmation_date` DATE COMMENT 'Date the provisional credit was confirmed as permanent following successful claim resolution.',
    `final_credit_confirmed` BOOLEAN COMMENT 'Indicates whether provisional credit has been converted to permanent credit following claim approval.',
    `law_enforcement_agency` STRING COMMENT 'Name of the law enforcement agency to which the fraud claim was referred.',
    `law_enforcement_case_number` STRING COMMENT 'Case number assigned by the law enforcement agency for tracking the criminal investigation.',
    `law_enforcement_referral` BOOLEAN COMMENT 'Indicates whether the fraud claim was referred to law enforcement for criminal investigation.',
    `loss_amount` DECIMAL(18,2) COMMENT 'Actual financial loss incurred by the bank as a result of the fraud claim, net of any recoveries.',
    `provisional_credit_amount` DECIMAL(18,2) COMMENT 'Amount of provisional credit issued to the customer pending investigation outcome, as required by consumer protection regulations.',
    `provisional_credit_issued_date` DATE COMMENT 'Date provisional credit was posted to the customer account, must comply with Regulation E 10-business-day rule or Regulation Z 5-business-day rule.',
    `provisional_credit_reversal_date` DATE COMMENT 'Date provisional credit was reversed from the customer account, typically when the claim is denied or investigation concludes the transaction was authorized.',
    `provisional_credit_reversal_reason` STRING COMMENT 'Business reason for reversing provisional credit, such as claim denial, customer withdrawal, or determination that transaction was authorized.',
    `receipt_date` DATE COMMENT 'Date the fraud claim was received from the customer, marking the start of regulatory timelines for provisional credit and investigation.',
    `receipt_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the fraud claim was logged into the system, used for SLA tracking and audit trails.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Amount recovered from the fraudster, merchant, card network, or other parties through chargeback or legal action.',
    `recovery_date` DATE COMMENT 'Date recovery funds were received and posted.',
    `regulatory_basis` STRING COMMENT 'Regulatory rule under which provisional credit was issued: Regulation E 10-business-day rule for electronic fund transfers, Regulation Z 5-business-day rule for credit card disputes, or voluntary bank policy.. Valid values are `reg_e_10_day|reg_z_5_day|reg_e_45_day|voluntary|none`',
    `resolution_code` STRING COMMENT 'Final disposition code indicating the outcome of the fraud claim investigation.. Valid values are `approved_customer_favor|denied_authorized_transaction|denied_insufficient_evidence|withdrawn_by_customer|closed_duplicate`',
    `resolution_date` DATE COMMENT 'Date the fraud claim was formally resolved and closed.',
    `resolution_notes` STRING COMMENT 'Detailed narrative explanation of the investigation findings and resolution rationale, used for audit and quality assurance.',
    `sar_filed` BOOLEAN COMMENT 'Indicates whether a Suspicious Activity Report was filed with FinCEN as a result of this fraud claim, as required by the Bank Secrecy Act.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this fraud claim record was last modified.',
    CONSTRAINT pk_claim PRIMARY KEY(`claim_id`)
) COMMENT 'Master entity representing a customer-initiated fraud claim or dispute submitted through any channel (branch, contact center, digital banking, written notice). Captures claim receipt date, channel, type (unauthorized transaction, identity theft, account takeover, card fraud), claimed amount, customer attestation status, and final resolution. Includes full provisional credit lifecycle tracking: provisional credit amount, issuance date, account credited, regulatory basis (Reg E 10-day rule, Reg Z 5-day rule), reversal date, reversal reason, and final credit confirmation status. Ensures compliance with Regulation E and Regulation Z consumer protection timelines. Distinct from chargeback — a claim is the customer-facing intake record; a chargeback is the network-level dispute.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`network_link` (
    `network_link_id` BIGINT COMMENT 'Primary key for network_link',
    `incident_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_incident. Business justification: Network links between fraud subjects are often discovered through analysis of specific fraud incidents. Linking network_link.fraud_incident_id → fraud_incident connects the network analysis to the spe',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: Fraud ring network analysis maps connections between investor accounts controlled by fraud subjects. Graph-based fraud ring detection across investment accounts requires direct investor_account linkag',
    `sar_filing_id` BIGINT COMMENT 'Foreign key linking to fraud.sar_filing. Business justification: Network links between fraud subjects are frequently included in SAR filings to document the fraud ring structure. network_link.sar_included_flag and sar_filing_date indicate that network links are ass',
    `case_id` BIGINT COMMENT 'Identifier of the primary fraud case that led to the discovery of this network link. Links the relationship to the originating investigation.',
    `subject_id` BIGINT COMMENT 'Identifier of the originating fraud subject, account, device, or entity in the network relationship. References the source node in the fraud network graph.',
    `target_subject_id` BIGINT COMMENT 'Identifier of the destination fraud subject, account, device, or entity in the network relationship. References the target node in the fraud network graph.',
    `analyst_notes` STRING COMMENT 'Free-text notes and observations recorded by fraud analysts during the investigation of this network link. Contains investigative insights and follow-up actions.',
    `bidirectional_flag` BOOLEAN COMMENT 'Indicates whether the network link represents a bidirectional relationship (true) or a unidirectional relationship (false). Bidirectional links suggest mutual coordination.',
    `confirmation_date` DATE COMMENT 'Date when the network link was validated and confirmed by an analyst as a legitimate fraud relationship.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the network link record was first created in the fraud case management system. Used for audit trail and data lineage.',
    `data_source_system` STRING COMMENT 'Name of the source system or platform that provided the data leading to the discovery of this network link (e.g., NICE Actimize, internal graph analytics, external intelligence feed).',
    `discovery_date` DATE COMMENT 'Date when the network link was first identified and recorded in the fraud case management system.',
    `discovery_method` STRING COMMENT 'Method by which the network link was identified and established. Indicates whether the relationship was discovered through automated systems, manual investigation, or external sources.. Valid values are `automated_graph_analysis|manual_investigation|tip_referral|cross_case_review|pattern_matching|external_intelligence`',
    `discovery_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the network link was first identified, including time-of-day for audit trail and temporal analysis purposes.',
    `first_observed_date` DATE COMMENT 'Earliest date when the relationship between the linked subjects was first observed in transaction or behavioral data, prior to formal discovery.',
    `graph_visualization_metadata` STRING COMMENT 'JSON or XML metadata used by graph analytics platforms for network topology visualization, including node positioning, edge styling, and clustering information.',
    `investigation_priority` STRING COMMENT 'Priority level assigned to the investigation of this network link based on risk score, potential loss exposure, and regulatory urgency.. Valid values are `critical|high|medium|low`',
    `last_observed_date` DATE COMMENT 'Most recent date when the relationship between the linked subjects was observed in transaction or behavioral data, used to assess ongoing activity.',
    `law_enforcement_agency` STRING COMMENT 'Name of the law enforcement agency to which the network link evidence was referred (e.g., FBI, Secret Service, local police). Null if no referral made.',
    `law_enforcement_referral_flag` BOOLEAN COMMENT 'Indicates whether this network link was included in a referral package to law enforcement agencies for criminal investigation or prosecution.',
    `link_evidence_description` STRING COMMENT 'Detailed narrative describing the specific evidence supporting the network link, including data points, patterns, and investigative findings used for SAR narratives and law enforcement referrals.',
    `link_expiration_date` DATE COMMENT 'Date when the network link is scheduled to expire or be archived if no further activity is observed. Used for data retention and case closure workflows.',
    `link_status` STRING COMMENT 'Current lifecycle status of the network link indicating whether the relationship is actively monitored, confirmed, or has been resolved.. Valid values are `active|inactive|under_review|confirmed|disputed|archived`',
    `link_strength_score` DECIMAL(18,2) COMMENT 'Quantitative measure of the confidence and strength of the network relationship, typically ranging from 0.00 to 100.00. Higher scores indicate stronger evidence of coordinated fraud activity.',
    `link_type` STRING COMMENT 'Classification of the relationship type between fraud subjects indicating the nature of the connection. [ENUM-REF-CANDIDATE: shared_device_fingerprint|shared_ip_address|shared_physical_address|shared_phone_number|common_beneficiary_account|mule_account_network|shared_employer|velocity_pattern_match|shared_email_domain|common_transaction_pattern — promote to reference product]. Valid values are `shared_device_fingerprint|shared_ip_address|shared_physical_address|shared_phone_number|common_beneficiary_account|mule_account_network`',
    `network_depth_level` STRING COMMENT 'Degree of separation from the primary fraud subject in the network graph. Level 1 indicates direct connection, higher levels indicate indirect relationships through intermediaries.',
    `observation_frequency` STRING COMMENT 'Number of times the relationship pattern has been observed across transactions, interactions, or events. Higher frequency indicates stronger coordination.',
    `referral_date` DATE COMMENT 'Date when the network link evidence was formally referred to law enforcement. Used for tracking investigation timelines.',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk score assessing the threat level posed by this network relationship, incorporating link strength, fraud typology severity, and historical loss patterns.',
    `sar_filing_date` DATE COMMENT 'Date when the SAR containing this network link was filed with FinCEN. Null if no SAR has been filed.',
    `sar_included_flag` BOOLEAN COMMENT 'Indicates whether this network link was included in a Suspicious Activity Report (SAR) filing to FinCEN. Used for regulatory compliance tracking.',
    `shared_attribute_value` DECIMAL(18,2) COMMENT 'The specific shared data element that establishes the link (e.g., IP address, device fingerprint hash, physical address, phone number). Stored in hashed or masked format for privacy.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the network link record was last modified. Tracks changes to link status, strength score, or investigative findings.',
    CONSTRAINT pk_network_link PRIMARY KEY(`network_link_id`)
) COMMENT 'Association entity capturing identified relationships between fraud subjects, accounts, devices, and entities that indicate coordinated or organized fraud activity. Tracks link type (shared device fingerprint, shared IP address, shared physical address, shared phone number, common beneficiary account, mule account network, shared employer, velocity pattern match), link strength score, discovery method (automated graph analysis, manual investigation, tip/referral), discovery date, confirming analyst, and linkage to the fraud cases and subjects involved. Supports fraud ring detection and visualization, organized fraud investigation, Suspicious Activity Report narrative enrichment, and law enforcement referral evidence packages. Integrates with graph analytics platforms for network topology analysis.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`subject` (
    `subject_id` BIGINT COMMENT 'Unique identifier for the fraud subject entity. Primary key.',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Credit risk teams must know if a rated counterparty is a fraud subject. This link supports counterparty risk reviews triggered by fraud investigations, large exposure reporting, and regulatory require',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Fraud subjects addresses require country validation for jurisdiction determination, sanctions screening (OFAC/EU), law enforcement referral routing, and cross-border fraud ring detection. Core fraud ',
    `currency_id` BIGINT COMMENT 'Three-letter ISO currency code for loss amounts associated with the fraud subject.',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: Business fraud subjects are classified by industry for AML risk profiling and SAR filing categorization. Industry classification of subjects supports FATF risk-based approach, concentration risk repor',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Fraud subjects may be issuers themselves (shell companies, fraudulent issuers, pump-and-dump operators). Links issuer entities to fraud subject records for issuer fraud tracking, sanctions screening, ',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Fraud subjects that are legal entities (shell companies, money mules operating as businesses) must be identified via LEI for FATF-compliant AML investigations and SAR filings. LEI linkage enables sanc',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Fraud investigators must determine if a subject is an existing customer for KYC cross-referencing, AML risk assessment, and regulatory reporting. Banks operationally link fraud subjects to customer pa',
    `address_line_1` STRING COMMENT 'First line of the physical address associated with the fraud subject including street number and name.',
    `address_line_2` STRING COMMENT 'Second line of the physical address such as apartment or suite number.',
    `city` STRING COMMENT 'City or municipality of the fraud subject address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fraud subject record was first created in the system.',
    `date_of_birth` DATE COMMENT 'Date of birth of the fraud subject used for identity verification and matching.',
    `drivers_license_number` STRING COMMENT 'Drivers license number of the fraud subject used for identity verification.',
    `email_address` STRING COMMENT 'Primary email address associated with the fraud subject as identified during investigation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_identified_date` DATE COMMENT 'Date when the fraud subject was first identified in the fraud management system.',
    `first_name` STRING COMMENT 'First name or given name of the fraud subject.',
    `fraud_ring_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the fraud subject is believed to be part of an organized fraud ring or syndicate.',
    `full_name` STRING COMMENT 'Complete legal or known name of the fraud subject as identified during investigation.',
    `investigation_notes` STRING COMMENT 'Free-text notes and observations from fraud investigators regarding the fraud subject including behavioral patterns, modus operandi, and investigative findings.',
    `known_aliases` STRING COMMENT 'Comma-separated list of known aliases, alternate names, or pseudonyms used by the fraud subject.',
    `last_activity_date` DATE COMMENT 'Date of the most recent fraudulent activity or case involvement associated with the fraud subject.',
    `last_name` STRING COMMENT 'Last name or surname of the fraud subject.',
    `law_enforcement_agency` STRING COMMENT 'Name of the law enforcement agency to which the fraud subject was referred such as FBI, Secret Service, or local police department.',
    `law_enforcement_case_number` STRING COMMENT 'Case number assigned by the law enforcement agency for tracking the investigation of the fraud subject.',
    `law_enforcement_referral_date` DATE COMMENT 'Date when the fraud subject was referred to law enforcement.',
    `law_enforcement_referral_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the fraud subject has been referred to law enforcement agencies for criminal investigation.',
    `middle_name` STRING COMMENT 'Middle name or initial of the fraud subject if available.',
    `national_id_number` STRING COMMENT 'Government-issued national identification number such as Social Security Number (SSN), Tax Identification Number (TIN), or equivalent for the fraud subject.',
    `passport_number` STRING COMMENT 'Passport number of the fraud subject if available from investigation records.',
    `phone_number` STRING COMMENT 'Primary phone number associated with the fraud subject.',
    `postal_code` STRING COMMENT 'Postal code or ZIP code of the fraud subject address.',
    `prior_fraud_case_count` STRING COMMENT 'Number of prior fraud cases in which this subject has been identified or implicated.',
    `risk_score` STRING COMMENT 'Calculated risk score representing the threat level posed by the fraud subject based on historical activity, fraud typology, and loss amounts. Typically ranges from 0 to 100.',
    `risk_tier` STRING COMMENT 'Risk tier classification of the fraud subject based on risk score and threat assessment.. Valid values are `low|medium|high|critical`',
    `state_province` STRING COMMENT 'State, province, or region of the fraud subject address.',
    `subject_status` STRING COMMENT 'Current status of the fraud subject in the fraud management system indicating their investigation or monitoring state.. Valid values are `active|inactive|watchlist|law_enforcement_referred|cleared|deceased`',
    `subject_type` STRING COMMENT 'Classification of the fraud subject indicating their relationship to the bank: internal employee, external third party, customer, organized fraud ring member, mule account holder, or unknown.. Valid values are `internal_employee|external_third_party|customer|organized_fraud_ring_member|unknown|mule_account_holder`',
    `total_confirmed_loss_amount` DECIMAL(18,2) COMMENT 'Cumulative confirmed financial loss across all fraud cases involving this subject.',
    `total_estimated_loss_amount` DECIMAL(18,2) COMMENT 'Cumulative estimated financial loss across all fraud cases involving this subject.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the fraud subject record was last updated.',
    `watchlist_status` STRING COMMENT 'Indicates whether the fraud subject is on any internal or external watchlist including law enforcement, industry fraud databases, or sanctions lists.. Valid values are `not_on_watchlist|internal_watchlist|law_enforcement_watchlist|industry_watchlist|sanctions_list`',
    CONSTRAINT pk_subject PRIMARY KEY(`subject_id`)
) COMMENT 'Master entity representing individuals or entities identified as subjects of fraud investigations — including perpetrators, mule account holders, and suspected organized fraud ring members. Captures subject type (internal employee, external third party, customer, unknown), subject identification details, known aliases, associated accounts and devices, watchlist status, law enforcement referral status, and prior fraud history. Distinct from the customer master — a fraud subject may not be a bank customer and may represent an external threat actor.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_detection_rule_id` FOREIGN KEY (`detection_rule_id`) REFERENCES `banking_ecm`.`fraud`.`detection_rule`(`detection_rule_id`);
ALTER TABLE `banking_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_detection_rule_id` FOREIGN KEY (`detection_rule_id`) REFERENCES `banking_ecm`.`fraud`.`detection_rule`(`detection_rule_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `banking_ecm`.`fraud`.`alert`(`alert_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `banking_ecm`.`fraud`.`incident`(`incident_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_previous_investigation_id` FOREIGN KEY (`previous_investigation_id`) REFERENCES `banking_ecm`.`fraud`.`investigation`(`investigation_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `banking_ecm`.`fraud`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_detection_rule_id` FOREIGN KEY (`detection_rule_id`) REFERENCES `banking_ecm`.`fraud`.`detection_rule`(`detection_rule_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_subject_id` FOREIGN KEY (`subject_id`) REFERENCES `banking_ecm`.`fraud`.`subject`(`subject_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `banking_ecm`.`fraud`.`incident`(`incident_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `banking_ecm`.`fraud`.`investigation`(`investigation_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_subject_id` FOREIGN KEY (`subject_id`) REFERENCES `banking_ecm`.`fraud`.`subject`(`subject_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_amended_sar_sar_filing_id` FOREIGN KEY (`amended_sar_sar_filing_id`) REFERENCES `banking_ecm`.`fraud`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_subject_id` FOREIGN KEY (`subject_id`) REFERENCES `banking_ecm`.`fraud`.`subject`(`subject_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_chargeback_id` FOREIGN KEY (`chargeback_id`) REFERENCES `banking_ecm`.`fraud`.`chargeback`(`chargeback_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `banking_ecm`.`fraud`.`claim`(`claim_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `banking_ecm`.`fraud`.`incident`(`incident_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_subject_id` FOREIGN KEY (`subject_id`) REFERENCES `banking_ecm`.`fraud`.`subject`(`subject_id`);
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `banking_ecm`.`fraud`.`incident`(`incident_id`);
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `banking_ecm`.`fraud`.`investigation`(`investigation_id`);
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `banking_ecm`.`fraud`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_subject_id` FOREIGN KEY (`subject_id`) REFERENCES `banking_ecm`.`fraud`.`subject`(`subject_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `banking_ecm`.`fraud`.`alert`(`alert_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_chargeback_id` FOREIGN KEY (`chargeback_id`) REFERENCES `banking_ecm`.`fraud`.`chargeback`(`chargeback_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `banking_ecm`.`fraud`.`incident`(`incident_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `banking_ecm`.`fraud`.`investigation`(`investigation_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `banking_ecm`.`fraud`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_subject_id` FOREIGN KEY (`subject_id`) REFERENCES `banking_ecm`.`fraud`.`subject`(`subject_id`);
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ADD CONSTRAINT `fk_fraud_network_link_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `banking_ecm`.`fraud`.`incident`(`incident_id`);
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ADD CONSTRAINT `fk_fraud_network_link_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `banking_ecm`.`fraud`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ADD CONSTRAINT `fk_fraud_network_link_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ADD CONSTRAINT `fk_fraud_network_link_subject_id` FOREIGN KEY (`subject_id`) REFERENCES `banking_ecm`.`fraud`.`subject`(`subject_id`);
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ADD CONSTRAINT `fk_fraud_network_link_target_subject_id` FOREIGN KEY (`target_subject_id`) REFERENCES `banking_ecm`.`fraud`.`subject`(`subject_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`fraud` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `banking_ecm`.`fraud` SET TAGS ('dbx_domain' = 'fraud');
ALTER TABLE `banking_ecm`.`fraud`.`case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`fraud`.`case` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case Identifier');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `atm_id` SET TAGS ('dbx_business_glossary_term' = 'Atm Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Of Occurrence Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Capture Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `custodian_account_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `deal_participant_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Participant Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `derivative_id` SET TAGS ('dbx_business_glossary_term' = 'Derivative Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `detection_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Detection Rule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `execution_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `operational_risk_event_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Interaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Session Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `pledge_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `trust_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `underwriting_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Assigned Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^FC-[0-9]{8,12}$');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'new|assigned|under_investigation|pending_review|closed|escalated');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'card_fraud|wire_fraud|ach_fraud|check_fraud|identity_theft|account_takeover');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `chargeback_initiated_flag` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Initiated Flag');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Closed Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `confirmed_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `customer_reimbursed_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Reimbursed Flag');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `disposition_outcome` SET TAGS ('dbx_business_glossary_term' = 'Disposition Outcome');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `disposition_outcome` SET TAGS ('dbx_value_regex' = 'confirmed_fraud|false_positive|customer_error|insufficient_evidence|referred_law_enforcement');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `disposition_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposition Reason');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `estimated_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `fraud_detection_method` SET TAGS ('dbx_business_glossary_term' = 'Fraud Detection Method');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `fraud_detection_method` SET TAGS ('dbx_value_regex' = 'rule_based|ml_model|customer_report|manual_review|third_party_alert');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `fraud_ring_indicator` SET TAGS ('dbx_business_glossary_term' = 'Fraud Ring Indicator');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `insurance_claim_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Filed Flag');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `law_enforcement_agency` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Agency');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `law_enforcement_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Flag');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Opened Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Case Priority');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovered Amount');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `reimbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Amount');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `reimbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Date');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `sar_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filed Flag');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `sar_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filing Date');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Case Severity');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|level_4');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `sla_target_close_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Close Date');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`alert` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`fraud`.`alert` SET TAGS ('dbx_subdomain' = 'fraud_detection');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `account_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `atm_id` SET TAGS ('dbx_business_glossary_term' = 'Atm Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `derivative_id` SET TAGS ('dbx_business_glossary_term' = 'Derivative Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `detection_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Detection Rule Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `digital_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `fund_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `country_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `country_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Industry Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Alert Session Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Interaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `price_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Price Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `trust_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `alert_number` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Number');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `alert_number` SET TAGS ('dbx_value_regex' = '^FA-[0-9]{10}$');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `alert_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Status');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `alert_status` SET TAGS ('dbx_value_regex' = 'new|under_review|escalated|closed|false_positive|confirmed_fraud');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `assigned_analyst_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Analyst Name');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `card_number_last_four` SET TAGS ('dbx_business_glossary_term' = 'Card Number Last Four Digits');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `card_number_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `card_number_last_four` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `card_number_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `customer_contact_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `customer_contacted_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Contacted Flag');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `customer_response` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Classification');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `customer_response` SET TAGS ('dbx_value_regex' = 'confirmed_legitimate|confirmed_fraud|no_response|disputed');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Fraud Detection Method');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'rule_based|machine_learning|behavioral_analytics|manual_referral|customer_report|third_party_alert');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Alert Disposition Code');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `disposition_code` SET TAGS ('dbx_value_regex' = 'confirmed_fraud|false_positive|suspicious_no_action|escalated_to_case|customer_verified|pending_information');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `disposition_reason` SET TAGS ('dbx_business_glossary_term' = 'Alert Disposition Reason');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `false_positive_reason` SET TAGS ('dbx_business_glossary_term' = 'False Positive Reason');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Generated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `geolocation_city` SET TAGS ('dbx_business_glossary_term' = 'Geolocation City');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `geolocation_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `geolocation_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Fraud Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `merchant_name` SET TAGS ('dbx_business_glossary_term' = 'Merchant Name');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Fraud Recovery Amount');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `review_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Completed Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `review_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Started Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `sar_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filed Flag');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `sar_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filing Date');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Risk Score');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Severity Level');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `transaction_channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `banking_ecm`.`fraud`.`alert` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Identifier');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `aml_case_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Capture Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `custodian_account_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Evidence Interaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Evidence Session Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case ID');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `fund_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Incident Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `previous_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Investigation ID');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `sar_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Sar Filing Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `trust_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `chargeback_initiated_flag` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Initiated Flag');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `customer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `customer_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Flag');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `disposition_rationale` SET TAGS ('dbx_business_glossary_term' = 'Disposition Rationale');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `disposition_rationale` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation End Date');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `evidence_items_count` SET TAGS ('dbx_business_glossary_term' = 'Evidence Items Count');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `evidence_summary` SET TAGS ('dbx_business_glossary_term' = 'Evidence Summary');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `evidence_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `findings_narrative` SET TAGS ('dbx_business_glossary_term' = 'Findings Narrative');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `findings_narrative` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `fraud_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Fraud Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `fraud_loss_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `interview_conducted_flag` SET TAGS ('dbx_business_glossary_term' = 'Interview Conducted Flag');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `interview_date` SET TAGS ('dbx_business_glossary_term' = 'Interview Date');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `interview_notes` SET TAGS ('dbx_business_glossary_term' = 'Interview Notes');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `interview_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `investigation_number` SET TAGS ('dbx_business_glossary_term' = 'Investigation Number');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `investigation_number` SET TAGS ('dbx_value_regex' = '^INV-[0-9]{8,12}$');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_review|escalated|completed|cancelled');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `law_enforcement_agency` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Agency');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `law_enforcement_agency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `law_enforcement_case_number` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Case Number');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `law_enforcement_case_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `law_enforcement_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Flag');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Investigation Methodology');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `methodology` SET TAGS ('dbx_value_regex' = 'transaction_analysis|device_forensics|customer_interview|surveillance_review|third_party_data|multi_method');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `multi_phase_investigation_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Phase Investigation Flag');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `phase` SET TAGS ('dbx_business_glossary_term' = 'Investigation Phase');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `phase` SET TAGS ('dbx_value_regex' = 'initial_review|deep_investigation|legal_referral|sar_escalation|closed|suspended');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Investigation Priority');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `recommended_disposition` SET TAGS ('dbx_business_glossary_term' = 'Recommended Disposition');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `recommended_disposition` SET TAGS ('dbx_value_regex' = 'confirmed_fraud|no_fraud|inconclusive|referred_to_compliance|referred_to_legal|customer_error');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `sar_escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Escalation Flag');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `sla_target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Completion Date');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Investigation Source System');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `team` SET TAGS ('dbx_business_glossary_term' = 'Investigation Team');
ALTER TABLE `banking_ecm`.`fraud`.`incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`fraud`.`incident` SET TAGS ('dbx_subdomain' = 'fraud_detection');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Incident Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `account_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `atm_id` SET TAGS ('dbx_business_glossary_term' = 'Atm Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `collateral_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Valuation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `custodian_account_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `debt_issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Issuance Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `derivative_id` SET TAGS ('dbx_business_glossary_term' = 'Derivative Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `detection_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `digital_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Interaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `investor_order_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Investor Order Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Industry Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `repo_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Repo Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Session Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `subject_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `trust_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Incident Amount');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `card_number_last_four` SET TAGS ('dbx_business_glossary_term' = 'Card Number Last Four Digits');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `card_number_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `card_number_last_four` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `card_number_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `chargeback_date` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Date');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `chargeback_flag` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Flag');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `customer_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Reported Flag');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'system_rule|ml_model|customer_report|manual_review|third_party_alert');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Disposition Code');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `disposition_code` SET TAGS ('dbx_value_regex' = 'confirmed_fraud|false_positive|customer_error|merchant_error|unresolved|pending');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|confirmed|dismissed|closed|escalated');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `incident_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `investigation_close_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Close Date');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `law_enforcement_case_number` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Case Number');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `law_enforcement_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Notified Flag');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `loss_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `loss_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `merchant_name` SET TAGS ('dbx_business_glossary_term' = 'Merchant Name');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovered Amount');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Reference Number');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `sar_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filed Flag');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `sar_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filing Date');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `transaction_location` SET TAGS ('dbx_business_glossary_term' = 'Transaction Location');
ALTER TABLE `banking_ecm`.`fraud`.`incident` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` SET TAGS ('dbx_subdomain' = 'loss_recovery');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Identifier');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `account_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Account Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `card_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Incident Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Industry Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `operational_risk_event_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Interaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `subject_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `acquirer_bin` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Bank Identification Number (BIN)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `acquirer_bin` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `arbitration_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Filed Date');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `card_network` SET TAGS ('dbx_business_glossary_term' = 'Payment Card Network');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `card_network` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|jcb|unionpay');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'credit|debit|prepaid|charge');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `chargeback_status` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Status');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `chargeback_status` SET TAGS ('dbx_value_regex' = 'pending|under_review|accepted|rejected|reversed|withdrawn');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `dispute_amount` SET TAGS ('dbx_business_glossary_term' = 'Dispute Amount');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `fee` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Fee');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `fraud_indicator` SET TAGS ('dbx_business_glossary_term' = 'Fraud Indicator');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Initiated Date');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `issuer_bin` SET TAGS ('dbx_business_glossary_term' = 'Issuer Bank Identification Number (BIN)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `issuer_bin` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `masked_card_number` SET TAGS ('dbx_business_glossary_term' = 'Masked Card Number');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `masked_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `masked_card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `merchant_name` SET TAGS ('dbx_business_glossary_term' = 'Merchant Name');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `network_case_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Network Case Number');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `original_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Amount');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `original_transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `original_transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `original_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Date');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Reason Code');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Reason Description');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Received Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `representment_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Representment Filed Date');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'cardholder_favor|merchant_favor|partial_reversal|withdrawn|expired');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `response_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Response Deadline Date');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `sar_filed_indicator` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filed Indicator');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Lifecycle Stage');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `stage` SET TAGS ('dbx_value_regex' = 'first_chargeback|representment|pre_arbitration|arbitration|closed');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` SET TAGS ('dbx_subdomain' = 'loss_recovery');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `sar_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Sar Filing Identifier');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `amended_sar_sar_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Amended Suspicious Activity Report (SAR) ID');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Capture Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `custodian_account_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `fund_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `kyc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Record Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `subject_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Party ID');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Description');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `activity_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `amendment_flag` SET TAGS ('dbx_business_glossary_term' = 'Amendment Flag');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `filing_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Deadline Date');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `filing_institution_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Filing Institution Contact Name');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `filing_institution_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `filing_institution_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `filing_institution_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Filing Institution Contact Phone Number');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `filing_institution_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `filing_institution_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `filing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Filing Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `fincen_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Crimes Enforcement Network (FinCEN) Acknowledgment Date');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `fincen_bsa_reference` SET TAGS ('dbx_business_glossary_term' = 'Financial Crimes Enforcement Network (FinCEN) Bank Secrecy Act (BSA) Identifier');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `law_enforcement_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Agency Name');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `law_enforcement_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Contact Date');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `prior_sar_reference` SET TAGS ('dbx_business_glossary_term' = 'Prior Suspicious Activity Report (SAR) Reference');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `sar_number` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Number');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `sar_type` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Type');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `sar_type` SET TAGS ('dbx_value_regex' = 'fraud_related|aml_related|combined');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `suspicious_activity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity End Date');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `suspicious_activity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Start Date');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `suspicious_activity_type_code` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Type Code');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `total_suspicious_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Suspicious Amount');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `total_suspicious_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `total_suspicious_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` SET TAGS ('dbx_subdomain' = 'loss_recovery');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `loss_recovery_id` SET TAGS ('dbx_business_glossary_term' = 'Loss Recovery Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Capture Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Loss Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `custodian_account_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `fund_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Incident Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `interbank_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Interbank Placement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Loss Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `operational_risk_event_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `portfolio_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `repo_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Repo Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `subject_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `trust_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `basel_event_type_code` SET TAGS ('dbx_business_glossary_term' = 'Basel Event Type Code');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `basel_event_type_code` SET TAGS ('dbx_value_regex' = '^[1-7].[1-9]$');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `business_line` SET TAGS ('dbx_business_glossary_term' = 'Business Line');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `business_line` SET TAGS ('dbx_value_regex' = 'retail_banking|corporate_banking|payment_services|trading_sales|asset_management|commercial_banking');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `ccar_loss_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Comprehensive Capital Analysis and Review (CCAR) Loss Event Flag');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `gross_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Number');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `insurance_recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Recovery Amount');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `legal_case_number` SET TAGS ('dbx_business_glossary_term' = 'Legal Case Number');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `legal_case_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `loss_category` SET TAGS ('dbx_business_glossary_term' = 'Loss Category');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `loss_category` SET TAGS ('dbx_value_regex' = 'card_fraud|wire_fraud|ach_fraud|check_fraud|account_takeover|identity_theft');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `loss_date` SET TAGS ('dbx_business_glossary_term' = 'Loss Date');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `loss_description` SET TAGS ('dbx_business_glossary_term' = 'Loss Description');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `loss_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `loss_discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Loss Discovery Date');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `loss_event_number` SET TAGS ('dbx_business_glossary_term' = 'Loss Event Number');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `loss_event_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `loss_status` SET TAGS ('dbx_business_glossary_term' = 'Loss Status');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `loss_status` SET TAGS ('dbx_value_regex' = 'open|under_review|recovery_in_progress|closed_recovered|closed_written_off');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `net_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `recovery_date` SET TAGS ('dbx_business_glossary_term' = 'Recovery Date');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `recovery_method` SET TAGS ('dbx_business_glossary_term' = 'Recovery Method');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `recovery_notes` SET TAGS ('dbx_business_glossary_term' = 'Recovery Notes');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `recovery_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `recovery_status` SET TAGS ('dbx_business_glossary_term' = 'Recovery Status');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `recovery_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|partial_recovery|full_recovery|abandoned|write_off');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `sar_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filed Flag');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `sar_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filing Date');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `write_off_approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Approval Authority');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` SET TAGS ('dbx_subdomain' = 'fraud_detection');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `detection_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Detection Rule Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Threshold Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `alert_priority_score` SET TAGS ('dbx_business_glossary_term' = 'Alert Priority Score');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `alert_volume` SET TAGS ('dbx_business_glossary_term' = 'Alert Volume');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `case_conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Case Conversion Rate');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Channel Applicability');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `detection_effectiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Detection Effectiveness Score');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `false_positive_rate` SET TAGS ('dbx_business_glossary_term' = 'False Positive Rate (FPR)');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `last_tuning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Tuning Date');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `measurement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `measurement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `ml_model_name` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Model Name');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `ml_model_version` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Model Version');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Model Type');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'rule_based|machine_learning|hybrid|statistical');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Rule Category');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_value_regex' = 'velocity_check|amount_threshold|geographic_anomaly|device_fingerprint|behavioral_pattern|account_takeover');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `rule_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Rule Documentation Uniform Resource Locator (URL)');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `rule_logic` SET TAGS ('dbx_business_glossary_term' = 'Rule Logic');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `rule_owner` SET TAGS ('dbx_business_glossary_term' = 'Rule Owner');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `rule_severity` SET TAGS ('dbx_business_glossary_term' = 'Rule Severity Level');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `rule_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|testing|retired|suspended');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `sar_escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Escalation Flag');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit of Measure');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'currency|count|percentage|score|standard_deviation');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `time_window_unit` SET TAGS ('dbx_business_glossary_term' = 'Time Window Unit');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `time_window_unit` SET TAGS ('dbx_value_regex' = 'minute|hour|day|week|month');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `time_window_value` SET TAGS ('dbx_business_glossary_term' = 'Time Window Value');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `true_positive_rate` SET TAGS ('dbx_business_glossary_term' = 'True Positive Rate (TPR)');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `tuning_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Tuning Frequency in Days');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `evidence_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Evidence Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `account_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Account Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Capture Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `fund_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Incident Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `sar_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Sar Filing Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `subject_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `admissibility_classification` SET TAGS ('dbx_business_glossary_term' = 'Admissibility Classification');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `admissibility_classification` SET TAGS ('dbx_value_regex' = 'admissible|inadmissible|pending_review|conditional');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Evidence Archived Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `chain_of_custody_status` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Status');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `chain_of_custody_status` SET TAGS ('dbx_value_regex' = 'collected|secured|transferred|archived|destroyed');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Evidence Collection Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Evidence Confidentiality Level');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `contains_pii_flag` SET TAGS ('dbx_business_glossary_term' = 'Contains Personally Identifiable Information (PII) Flag');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `destroyed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Evidence Destroyed Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `destruction_authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Destruction Authorized By Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `destruction_method` SET TAGS ('dbx_business_glossary_term' = 'Evidence Destruction Method');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `destruction_method` SET TAGS ('dbx_value_regex' = 'secure_deletion|shredding|degaussing|incineration');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `evidence_description` SET TAGS ('dbx_business_glossary_term' = 'Evidence Description');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `evidence_type` SET TAGS ('dbx_business_glossary_term' = 'Evidence Type');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `evidence_type` SET TAGS ('dbx_value_regex' = 'transaction_log|device_fingerprint|ip_geolocation|call_recording|surveillance_footage|document_image');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'Evidence File Format');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'Evidence File Name');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `hash_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Hash Algorithm');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `hash_algorithm` SET TAGS ('dbx_value_regex' = 'SHA-256|SHA-512|MD5');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `hash_value` SET TAGS ('dbx_business_glossary_term' = 'Evidence Hash Value');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `internal_audit_reference` SET TAGS ('dbx_business_glossary_term' = 'Internal Audit Reference');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `law_enforcement_agency` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Agency');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `law_enforcement_case_number` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Case Number');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `law_enforcement_shared_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Shared Flag');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `legal_hold_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Reference');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Evidence Notes');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `regulatory_exam_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Examination Reference');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `relevance_score` SET TAGS ('dbx_business_glossary_term' = 'Evidence Relevance Score');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `retention_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiration Date');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period in Days');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `secure_storage_reference` SET TAGS ('dbx_business_glossary_term' = 'Secure Storage Reference');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `secure_storage_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Evidence Source System');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'core_banking|card_processor|digital_banking|telephony|physical_security|payment_hub');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `transfer_method` SET TAGS ('dbx_business_glossary_term' = 'Evidence Transfer Method');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `transfer_method` SET TAGS ('dbx_value_regex' = 'secure_email|encrypted_file_transfer|physical_media|secure_portal|in_person');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `transfer_recipient` SET TAGS ('dbx_business_glossary_term' = 'Evidence Transfer Recipient');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `transfer_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Evidence Transfer Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`claim` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`fraud`.`claim` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Claim ID');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `account_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Account Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `claim_provisional_credit_account_deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Provisional Credit Account ID');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Claimed Interaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Case ID');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Incident Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `portfolio_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `sar_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Sar Filing Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `subject_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `trust_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `attestation_date` SET TAGS ('dbx_business_glossary_term' = 'Attestation Date');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `chargeback_initiated` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Initiated');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_value_regex' = '^CLM[0-9]{10}$');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'unauthorized_transaction|identity_theft|account_takeover|card_fraud|check_fraud|wire_fraud');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `claimed_amount` SET TAGS ('dbx_business_glossary_term' = 'Claimed Amount');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `customer_attestation_received` SET TAGS ('dbx_business_glossary_term' = 'Customer Attestation Received');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `customer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `customer_notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `final_credit_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Final Credit Confirmation Date');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `final_credit_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Final Credit Confirmed');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `law_enforcement_agency` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Agency');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `law_enforcement_agency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `law_enforcement_case_number` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Case Number');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `law_enforcement_case_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `law_enforcement_referral` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `provisional_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Provisional Credit Amount');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `provisional_credit_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Provisional Credit Issued Date');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `provisional_credit_reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Provisional Credit Reversal Date');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `provisional_credit_reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Provisional Credit Reversal Reason');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Receipt Date');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Claim Receipt Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `recovery_date` SET TAGS ('dbx_business_glossary_term' = 'Recovery Date');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_value_regex' = 'reg_e_10_day|reg_z_5_day|reg_e_45_day|voluntary|none');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `resolution_code` SET TAGS ('dbx_business_glossary_term' = 'Resolution Code');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `resolution_code` SET TAGS ('dbx_value_regex' = 'approved_customer_favor|denied_authorized_transaction|denied_insufficient_evidence|withdrawn_by_customer|closed_duplicate');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `sar_filed` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filed');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` SET TAGS ('dbx_subdomain' = 'subject_network');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `network_link_id` SET TAGS ('dbx_business_glossary_term' = 'Network Link Identifier');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Incident Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `sar_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Sar Filing Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Source Fraud Case Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `subject_id` SET TAGS ('dbx_business_glossary_term' = 'Source Subject Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `target_subject_id` SET TAGS ('dbx_business_glossary_term' = 'Target Subject Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `analyst_notes` SET TAGS ('dbx_business_glossary_term' = 'Analyst Investigation Notes');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `analyst_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `bidirectional_flag` SET TAGS ('dbx_business_glossary_term' = 'Bidirectional Relationship Flag');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Date');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `discovery_method` SET TAGS ('dbx_business_glossary_term' = 'Discovery Method');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `discovery_method` SET TAGS ('dbx_value_regex' = 'automated_graph_analysis|manual_investigation|tip_referral|cross_case_review|pattern_matching|external_intelligence');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `discovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discovery Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `first_observed_date` SET TAGS ('dbx_business_glossary_term' = 'First Observed Date');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `graph_visualization_metadata` SET TAGS ('dbx_business_glossary_term' = 'Graph Visualization Metadata');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `investigation_priority` SET TAGS ('dbx_business_glossary_term' = 'Investigation Priority');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `investigation_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `last_observed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Observed Date');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `law_enforcement_agency` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Agency');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `law_enforcement_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Flag');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `link_evidence_description` SET TAGS ('dbx_business_glossary_term' = 'Link Evidence Description');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `link_evidence_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `link_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Link Expiration Date');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `link_status` SET TAGS ('dbx_business_glossary_term' = 'Link Status');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `link_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|confirmed|disputed|archived');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `link_strength_score` SET TAGS ('dbx_business_glossary_term' = 'Link Strength Score');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `link_type` SET TAGS ('dbx_business_glossary_term' = 'Network Link Type');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `link_type` SET TAGS ('dbx_value_regex' = 'shared_device_fingerprint|shared_ip_address|shared_physical_address|shared_phone_number|common_beneficiary_account|mule_account_network');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `network_depth_level` SET TAGS ('dbx_business_glossary_term' = 'Network Depth Level');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `observation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Observation Frequency');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Date');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Network Link Risk Score');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `sar_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filing Date');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `sar_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Included Flag');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `shared_attribute_value` SET TAGS ('dbx_business_glossary_term' = 'Shared Attribute Value');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `shared_attribute_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`subject` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`fraud`.`subject` SET TAGS ('dbx_subdomain' = 'subject_network');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `subject_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Lei Registry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Address Line 1');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Address Line 2');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject City');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Date of Birth (DOB)');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `drivers_license_number` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Drivers License Number');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `drivers_license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `drivers_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Email Address');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `first_identified_date` SET TAGS ('dbx_business_glossary_term' = 'First Identified Date');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject First Name');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `fraud_ring_indicator` SET TAGS ('dbx_business_glossary_term' = 'Fraud Ring Indicator');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Full Name');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `known_aliases` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Known Aliases');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `known_aliases` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `known_aliases` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Last Name');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `law_enforcement_agency` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Agency');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `law_enforcement_case_number` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Case Number');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `law_enforcement_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Date');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `law_enforcement_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Flag');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Middle Name');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `national_id_number` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject National Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `national_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `passport_number` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Passport Number');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `passport_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `passport_number` SET TAGS ('dbx_pii_passport' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Phone Number');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Postal Code');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `prior_fraud_case_count` SET TAGS ('dbx_business_glossary_term' = 'Prior Fraud Case Count');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Risk Score');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Risk Tier');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject State or Province');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `subject_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Status');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `subject_status` SET TAGS ('dbx_value_regex' = 'active|inactive|watchlist|law_enforcement_referred|cleared|deceased');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `subject_type` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Type');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `subject_type` SET TAGS ('dbx_value_regex' = 'internal_employee|external_third_party|customer|organized_fraud_ring_member|unknown|mule_account_holder');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `total_confirmed_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Confirmed Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `total_estimated_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `watchlist_status` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Status');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `watchlist_status` SET TAGS ('dbx_value_regex' = 'not_on_watchlist|internal_watchlist|law_enforcement_watchlist|industry_watchlist|sanctions_list');
