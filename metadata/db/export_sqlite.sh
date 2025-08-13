#!/bin/bash
# Export DuckDB database to SQLite format
# Usage: bash db/export_sqlite.sh
#
# This script exports the DuckDB database to SQLite format rather than maintaining
# a separate SQLite setup script. DuckDB is the primary interaction mode, and this
# export approach ensures schema consistency between formats while avoiding dual
# maintenance of separate setup scripts.

set -euo pipefail

DUCKDB_FILE="db/jump_metadata.duckdb"
SQLITE_FILE="db/jump_metadata.sqlite"

if [[ ! -f "$DUCKDB_FILE" ]]; then
    echo "Error: DuckDB file $DUCKDB_FILE not found. Run setup first:"
    echo "  duckdb $DUCKDB_FILE < db/setup.sql"
    exit 1
fi

echo "Exporting DuckDB to SQLite..."

duckdb "$DUCKDB_FILE" -c "
ATTACH '$SQLITE_FILE' AS sqlite_db (TYPE SQLITE);
CREATE TABLE sqlite_db.microscope_filter AS SELECT * FROM microscope_filter;
CREATE TABLE sqlite_db.microscope_config AS SELECT * FROM microscope_config;
CREATE TABLE sqlite_db.cellprofiler_version AS SELECT * FROM cellprofiler_version;
CREATE TABLE sqlite_db.compound AS SELECT * FROM compound;
CREATE TABLE sqlite_db.orf AS SELECT * FROM orf;
CREATE TABLE sqlite_db.crispr AS SELECT * FROM crispr;
CREATE TABLE sqlite_db.perturbation AS SELECT * FROM perturbation;
CREATE TABLE sqlite_db.perturbation_control AS SELECT * FROM perturbation_control;
CREATE TABLE sqlite_db.plate AS SELECT * FROM plate;
CREATE TABLE sqlite_db.well AS SELECT * FROM well;
CREATE TABLE sqlite_db.compound_source AS SELECT * FROM compound_source;
"

echo "SQLite database created: $SQLITE_FILE"
