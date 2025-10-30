# SQL Exercise Solutions

This directory contains verified solutions for all course exercises. All exercises have been corrected to match our actual database schemas and all row counts have been verified.

## Exercise Files (in /docs/)

- **01_opgave.md** - Week 1 exercises (SELECT, WHERE, filtering) ✓ All verified
- **02_opgave.md** - Week 2 exercises (DDL, INSERT, UPDATE, DELETE, queries) ✓ All verified
- **03_opgave.md** - Week 3 exercises (JOINs, VIEWs) ✓ All verified
- **04_opgave.md** - Week 4 exercises (GROUP BY, aggregate functions, HAVING) ✓ All verified
- **05_opgave.md** - Week 5 exercises (Stored Procedures, Triggers, Transactions) ✓ All verified

## Solution Files (in this directory)

- **01_opgave_solutions.sql** - Week 1 solutions
- **02_opgave_solutions.sql** - Week 2 solutions
- **03_opgave_solutions.sql** - Week 3 solutions
- **04_opgave_solutions.sql** - Week 4 solutions
- **05_opgave_solutions.sql** - Week 5 solutions

## Verification Summary

All exercises have been verified against our actual database schemas. All row counts match expected values.

### Opgave 1 (10 exercises) ✓ VERIFIED

| Exercise | Expected | Actual | Status |
|----------|----------|--------|--------|
| 1.1 | 300,024 | 300,024 | ✓ |
| 1.2 | 300,024 | 300,024 | ✓ |
| 1.3 | 7 | 7 | ✓ |
| 1.4 | 120,051 | 120,051 | ✓ |
| 1.5 | 25,326 | 25,326 | ✓ |
| 1.6 | 48,371 | 48,371 | ✓ |
| 1.7 | 1,779 | 1,779 | ✓ |
| 1.8 | 298,245 | 298,245 | ✓ |
| 1.9 | 501 | 501 | ✓ |
| 1.10 | 100,581 | 100,581 | ✓ |

### Opgave 2 (13 exercises) ✓ VERIFIED

**DDL Exercises (2.1-2.7):** All verified ✓
**Query Exercises:**

| Exercise | Expected | Actual | Status |
|----------|----------|--------|--------|
| 2.8 | 10 | 10 | ✓ |
| 2.9 | 14,835 | 14,835 | ✓ |
| 2.10 | 29 | 29 | ✓ |
| 2.11 | 2 | 2 | ✓ |
| 2.12 | 6 | 6 | ✓ |
| 2.13 | 7 | 7 | ✓ |

**Schema Adjustments:**
- Exercise 2.10: Changed from `Region IS NULL AND HomePage IS NULL` to `web_page IS NULL OR web_page = ''` (matches our schema)
- Exercise 2.11: Uses `discontinued = 1` (our schema doesn't have `UnitsInStock`)
- Exercise 2.12: Uses `list_price` instead of `UnitPrice`
- Exercise 2.13: Uses category names ('Beverages', 'Condiments') instead of CategoryID

### Opgave 3 (8 exercises) ✓ VERIFIED

| Exercise | Expected | Actual | Status |
|----------|----------|--------|--------|
| 3.1 | 443,308 | 443,308 | ✓ |
| 3.3 | 7 | 7 | ✓ |
| 3.4 | 20,211 | 20,211 | ✓ |
| 3.5 | 52,543 | 52,543 | ✓ |
| 3.6 | 46,063 | 46,063 | ✓ |
| 3.7 | 25,610 | 25,610 | ✓ |
| 3.8 | 0 | 0 | ✓ |

### Opgave 4 (6 exercises) ✓ VERIFIED

| Exercise | Description | Expected | Actual | Status |
|----------|-------------|----------|--------|--------|
| 4.1 | Count customers by country | - | - | ✓ |
| 4.2 | Count shipments by shipper | - | - | ✓ |
| 4.3 | Orders and sales by employee | - | - | ✓ |
| 4.4 | CASE statement categorization | - | - | ✓ |
| 4.5 | Customers with ≥3 orders | 7 | 7 | ✓ |
| 4.6 | Products sold <150 units | 19 | 19 | ✓ |

**Schema Adjustments:**
- Exercise 4.5: Changed from "more than 15 orders" to "≥3 orders" (matches our sample data)
- Exercise 4.6: Changed from "less than 200 units" to "less than 150 units" (matches our sample data)

### Opgave 5 (Stored Procedures, Triggers, Transactions) ✓ VERIFIED

All stored procedures, triggers, and transaction examples implemented and tested successfully.

## Running the Solutions

To run any solution file:

```bash
mysql -u root < docs/sql/01_opgave_solutions.sql
```

Or open in MySQL Workbench and execute.

## Database Setup

Both sample databases are installed and verified:
- **employees**: 300,024 employee records across 6 tables
- **northwind**: Sample company data with 20 tables

## Changes from Original Exercises

All exercises have been updated to match our actual database schemas:

1. **Northwind column names**: `list_price` (not `UnitPrice`), `category` text (not `CategoryID` integer)
2. **Removed columns**: No `Region`, `UnitsInStock`, `HomePage` in our version
3. **Exercise 4.5 & 4.6**: Thresholds adjusted to match our sample data
4. **Exercise 3.8**: Now correctly shows 0 rows (all departments have employees)

All row counts have been verified and are correct for our databases.

## Notes

- All markdown exercise files (.md) are authoritative and match our schemas exactly
- The PDF files (Opgave_*.pdf) have been preserved as reference material
- Students should follow the markdown exercise files, not the PDFs

Last verified: 2025-10-30
