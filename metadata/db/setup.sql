-- JUMP Cell Painting Metadata Database Setup
-- Run from metadata directory: duckdb db/jump_metadata.duckdb < db/setup_jump_db.sql

-- Import compressed CSV files directly (DuckDB handles .gz automatically)
-- Note: When running from db/ subdirectory, use ../ prefix for CSV files
CREATE TABLE well AS SELECT * FROM read_csv_auto('../well.csv.gz');
CREATE TABLE plate AS SELECT * FROM read_csv_auto('../plate.csv.gz');
CREATE TABLE compound AS SELECT * FROM read_csv_auto('../compound.csv.gz');
CREATE TABLE compound_source AS SELECT * FROM read_csv_auto('../compound_source.csv.gz');
CREATE TABLE orf AS SELECT * FROM read_csv_auto('../orf.csv.gz');
CREATE TABLE crispr AS SELECT * FROM read_csv_auto('../crispr.csv.gz');
-- Cast Metadata_Source to VARCHAR for consistency across all tables
CREATE TABLE microscope_config AS 
SELECT 
    Metadata_Source::VARCHAR as Metadata_Source,
    Metadata_Microscope_Name,
    Metadata_Widefield_vs_Confocal,
    Metadata_Excitation_Type,
    Metadata_Objective_NA,
    Metadata_N_Brightfield_Planes_Min,
    Metadata_N_Brightfield_Planes_Max,
    Metadata_Distance_Between_Z_Microns,
    Metadata_Sites_Per_Well,
    Metadata_Filter_Configuration,
    Metadata_Pixel_Size_Microns
FROM read_csv_auto('../microscope_config.csv');

CREATE TABLE microscope_filter AS SELECT * FROM read_csv_auto('../microscope_filter.csv');

-- Cast Metadata_Source to VARCHAR for consistency
CREATE TABLE cellprofiler_version AS 
SELECT 
    Metadata_Source::VARCHAR as Metadata_Source,
    Metadata_CellProfiler_Version
FROM read_csv_auto('../cellprofiler_version.csv');

-- Create indexes for faster joins
CREATE INDEX idx_well_plate ON well(Metadata_Plate);
CREATE INDEX idx_well_jcp ON well(Metadata_JCP2022);
CREATE INDEX idx_plate_id ON plate(Metadata_Plate);
CREATE INDEX idx_compound_jcp ON compound(Metadata_JCP2022);
CREATE INDEX idx_orf_jcp ON orf(Metadata_JCP2022);
CREATE INDEX idx_crispr_jcp ON crispr(Metadata_JCP2022);

-- Main view: Complete well information with all perturbations
CREATE VIEW well_details AS
SELECT 
    w.*,
    p.Metadata_Batch,
    p.Metadata_PlateType,
    -- Compound info
    c.Metadata_InChI,
    c.Metadata_InChIKey,
    c.Metadata_SMILES,
    cs.Metadata_Compound_Source,
    -- ORF info
    o.Metadata_Symbol as orf_symbol,
    o.Metadata_NCBI_Gene_ID as orf_gene_id,
    o.Metadata_Gene_Description as orf_description,
    o.Metadata_pert_type as orf_pert_type,
    -- CRISPR info
    cr.Metadata_Symbol as crispr_symbol,
    cr.Metadata_NCBI_Gene_ID as crispr_gene_id,
    -- What type of perturbation
    CASE 
        WHEN c.Metadata_JCP2022 IS NOT NULL THEN 'compound'
        WHEN o.Metadata_JCP2022 IS NOT NULL THEN 'orf'
        WHEN cr.Metadata_JCP2022 IS NOT NULL THEN 'crispr'
        ELSE 'control'
    END as perturbation_type
FROM well w
JOIN plate p ON w.Metadata_Plate = p.Metadata_Plate
LEFT JOIN compound c ON w.Metadata_JCP2022 = c.Metadata_JCP2022
LEFT JOIN compound_source cs ON c.Metadata_JCP2022 = cs.Metadata_JCP2022
LEFT JOIN orf o ON w.Metadata_JCP2022 = o.Metadata_JCP2022
LEFT JOIN crispr cr ON w.Metadata_JCP2022 = cr.Metadata_JCP2022;

-- Plate summary with counts
CREATE VIEW plate_summary AS
SELECT 
    p.*,
    COUNT(DISTINCT w.Metadata_Well) as well_count,
    COUNT(DISTINCT CASE WHEN c.Metadata_JCP2022 IS NOT NULL THEN w.Metadata_JCP2022 END) as compound_count,
    COUNT(DISTINCT CASE WHEN o.Metadata_JCP2022 IS NOT NULL THEN w.Metadata_JCP2022 END) as orf_count,
    COUNT(DISTINCT CASE WHEN cr.Metadata_JCP2022 IS NOT NULL THEN w.Metadata_JCP2022 END) as crispr_count
FROM plate p
LEFT JOIN well w ON p.Metadata_Plate = w.Metadata_Plate
LEFT JOIN compound c ON w.Metadata_JCP2022 = c.Metadata_JCP2022
LEFT JOIN orf o ON w.Metadata_JCP2022 = o.Metadata_JCP2022
LEFT JOIN crispr cr ON w.Metadata_JCP2022 = cr.Metadata_JCP2022
GROUP BY ALL;

-- All perturbations in one view
CREATE VIEW perturbations AS
SELECT 
    Metadata_JCP2022,
    'compound' as type,
    Metadata_InChIKey as identifier,
    Metadata_SMILES as details,
    NULL as gene_symbol
FROM compound
UNION ALL
SELECT 
    Metadata_JCP2022,
    'orf' as type,
    Metadata_broad_sample as identifier,
    Metadata_Gene_Description as details,
    Metadata_Symbol as gene_symbol
FROM orf
UNION ALL
SELECT 
    Metadata_JCP2022,
    'crispr' as type,
    Metadata_NCBI_Gene_ID as identifier,
    NULL as details,
    Metadata_Symbol as gene_symbol
FROM crispr;

-- Gene-centric view (both ORF and CRISPR)
CREATE VIEW gene_perturbations AS
SELECT 
    COALESCE(o.Metadata_Symbol, c.Metadata_Symbol) as gene_symbol,
    COALESCE(o.Metadata_NCBI_Gene_ID::VARCHAR, c.Metadata_NCBI_Gene_ID::VARCHAR) as gene_id,
    w.Metadata_Plate,
    w.Metadata_Well,
    w.Metadata_JCP2022,
    CASE 
        WHEN o.Metadata_JCP2022 IS NOT NULL THEN 'orf'
        WHEN c.Metadata_JCP2022 IS NOT NULL THEN 'crispr'
    END as perturbation_method
FROM well w
LEFT JOIN orf o ON w.Metadata_JCP2022 = o.Metadata_JCP2022
LEFT JOIN crispr c ON w.Metadata_JCP2022 = c.Metadata_JCP2022
WHERE o.Metadata_JCP2022 IS NOT NULL OR c.Metadata_JCP2022 IS NOT NULL;