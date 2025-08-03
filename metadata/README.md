# Metadata

This directory contains experimental metadata for the JUMP Cell Painting Consortium datasets.

## Database Setup

To create a queryable DuckDB database from these CSV files:

```bash
cd metadata
duckdb db/jump_metadata.duckdb < db/setup.sql
```

This creates a database with:

- Explicit schema with primary and foreign key constraints
- All CSV data imported as tables with data validation
- A `perturbation` union table that enables proper foreign keys from wells
- Pre-built views that handle complex joins
- Comprehensive documentation for all tables and columns embedded in the schema

## Querying the Database

```bash
# Interactive mode
duckdb db/jump_metadata.duckdb

# Example: Find all wells with TP53 perturbations
duckdb db/jump_metadata.duckdb -c "SELECT * FROM well_details WHERE orf_symbol = 'TP53' OR crispr_symbol = 'TP53'"
```

## Key Tables and Views

### Core Tables
- **`well`** - Well-level metadata with perturbation IDs
- **`plate`** - Plate information including batch and type
- **`compound`**, **`orf`**, **`crispr`** - Perturbation-specific data
- **`perturbation`** - Union table enabling foreign keys from wells (includes 'unknown' type)
- **`microscope_config`**, **`cellprofiler_version`** - Experimental configuration

### Views
- **`well_details`** - Complete well information with all perturbations pre-joined

## Schema Documentation

Full schema documentation is embedded in the database. To view:

```sql
-- List all tables with descriptions
SELECT table_name, comment FROM duckdb_tables();

-- View column descriptions
SELECT table_name, column_name, comment 
FROM duckdb_columns() 
WHERE comment IS NOT NULL;

-- View all foreign key relationships
SELECT table_name, constraint_text 
FROM duckdb_constraints() 
WHERE constraint_type = 'FOREIGN KEY';
