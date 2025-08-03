# Metadata

This directory contains experimental metadata for the JUMP Cell Painting Consortium datasets.

## Database Setup

To create a queryable DuckDB database from these CSV files:

```bash
rm -rf db/jump_metadata.duckdb && duckdb db/jump_metadata.duckdb < db/setup.sql
```

This creates a database with:

- Explicit schema with primary and foreign key constraints
- All CSV data imported as tables with data validation
- Documentation for all tables and columns embedded in the schema

## Querying the Database

```bash
# Interactive mode
duckdb db/jump_metadata.duckdb

# UI
duckdb -ui db/jump_metadata.duckdb
```

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
