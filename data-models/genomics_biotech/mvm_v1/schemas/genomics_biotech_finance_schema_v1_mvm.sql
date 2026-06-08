-- Schema for Domain: finance | Business: Genomics Biotech | Version: v1_mvm
-- Generated on: 2026-05-06 15:33:26

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `genomics_biotech_ecm`.`finance` COMMENT 'Owns enterprise financial management — general ledger, cost centers, accounts payable/receivable, revenue recognition, budgeting, R&D capitalization, COGS allocation, financial consolidation, and SOX-compliant reporting. Manages EBITDA tracking, ROI analysis, multi-entity P&L, and capital expenditures. Integrates SAP FI/CO as the primary ERP financial system of record.';

-- ========= TAGS =========
ALTER SCHEMA `genomics_biotech_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `genomics_biotech_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
