# Metadata

This directory contains experimental metadata for the JUMP Cell Painting Consortium datasets.

## Database Setup

To create a queryable DuckDB database from these CSV files:

```bash
cd metadata/db
duckdb jump_metadata.duckdb < setup.sql
duckdb jump_metadata.duckdb < documentation.sql
```

This creates a database with:
- All CSV data imported as tables
- Pre-built views that handle complex joins
- Comprehensive documentation for all tables and columns

## Querying the Database

```bash
# Interactive mode
duckdb db/jump_metadata.duckdb

# Example: Find all wells with TP53 perturbations
duckdb db/jump_metadata.duckdb -c "SELECT * FROM well_details WHERE orf_symbol = 'TP53' OR crispr_symbol = 'TP53'"

# See more examples
cat db/example_queries.sql
```

## Key Views

- **`well_details`** - Complete well information with all perturbations pre-joined
- **`plate_summary`** - Plate-level statistics
- **`gene_perturbations`** - Gene-centric view combining ORF and CRISPR
- **`perturbations`** - Union of all perturbation types

## Schema Documentation

Full schema documentation is embedded in the database. To view:

```sql
-- List all tables with descriptions
SELECT table_name, comment FROM duckdb_tables();

-- View column descriptions
SELECT table_name, column_name, comment 
FROM duckdb_columns() 
WHERE comment IS NOT NULL;
