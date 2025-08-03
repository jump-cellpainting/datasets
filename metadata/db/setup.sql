-- JUMP Cell Painting Metadata Database Setup
-- Run from metadata directory: duckdb db/jump_metadata.duckdb < db/setup.sql

-- ============================================
-- 1. TABLE DEFINITIONS WITH CONSTRAINTS
-- ============================================
-- Define schema explicitly with primary and foreign keys

-- Microscopy configuration tables (no dependencies)
CREATE TABLE microscope_filter (
    Metadata_Filter_Configuration VARCHAR PRIMARY KEY,
    Metadata_Excitation_Low_DNA FLOAT,
    Metadata_Excitation_Low_ER FLOAT,
    Metadata_Excitation_Low_RNA FLOAT,
    Metadata_Excitation_Low_AGP FLOAT,
    Metadata_Excitation_Low_Mito FLOAT,
    Metadata_Excitation_High_DNA FLOAT,
    Metadata_Excitation_High_ER FLOAT,
    Metadata_Excitation_High_RNA FLOAT,
    Metadata_Excitation_High_AGP FLOAT,
    Metadata_Excitation_High_Mito FLOAT,
    Metadata_Emission_Low_DNA FLOAT,
    Metadata_Emission_Low_ER FLOAT,
    Metadata_Emission_Low_RNA FLOAT,
    Metadata_Emission_Low_AGP FLOAT,
    Metadata_Emission_Low_Mito FLOAT,
    Metadata_Emission_High_DNA FLOAT,
    Metadata_Emission_High_ER FLOAT,
    Metadata_Emission_High_RNA FLOAT,
    Metadata_Emission_High_AGP FLOAT,
    Metadata_Emission_High_Mito FLOAT,
    Metadata_FPBase_Config VARCHAR
);

COMMENT ON TABLE microscope_filter IS 'Microscope filter configurations for each fluorescence channel';
COMMENT ON COLUMN microscope_filter.Metadata_Filter_Configuration IS 'Filter configuration ID';
-- DNA Channel (Hoechst)
COMMENT ON COLUMN microscope_filter.Metadata_Excitation_Low_DNA IS 'Excitation wavelength minimum for DNA channel (nm)';
COMMENT ON COLUMN microscope_filter.Metadata_Excitation_High_DNA IS 'Excitation wavelength maximum for DNA channel (nm)';
COMMENT ON COLUMN microscope_filter.Metadata_Emission_Low_DNA IS 'Emission wavelength minimum for DNA channel (nm)';
COMMENT ON COLUMN microscope_filter.Metadata_Emission_High_DNA IS 'Emission wavelength maximum for DNA channel (nm)';
-- ER Channel (Concanavalin A)
COMMENT ON COLUMN microscope_filter.Metadata_Excitation_Low_ER IS 'Excitation wavelength minimum for ER channel (nm)';
COMMENT ON COLUMN microscope_filter.Metadata_Excitation_High_ER IS 'Excitation wavelength maximum for ER channel (nm)';
COMMENT ON COLUMN microscope_filter.Metadata_Emission_Low_ER IS 'Emission wavelength minimum for ER channel (nm)';
COMMENT ON COLUMN microscope_filter.Metadata_Emission_High_ER IS 'Emission wavelength maximum for ER channel (nm)';
-- RNA Channel (SYTO 14)
COMMENT ON COLUMN microscope_filter.Metadata_Excitation_Low_RNA IS 'Excitation wavelength minimum for RNA channel (nm)';
COMMENT ON COLUMN microscope_filter.Metadata_Excitation_High_RNA IS 'Excitation wavelength maximum for RNA channel (nm)';
COMMENT ON COLUMN microscope_filter.Metadata_Emission_Low_RNA IS 'Emission wavelength minimum for RNA channel (nm)';
COMMENT ON COLUMN microscope_filter.Metadata_Emission_High_RNA IS 'Emission wavelength maximum for RNA channel (nm)';
-- AGP Channel (Phalloidin)
COMMENT ON COLUMN microscope_filter.Metadata_Excitation_Low_AGP IS 'Excitation wavelength minimum for AGP channel (nm)';
COMMENT ON COLUMN microscope_filter.Metadata_Excitation_High_AGP IS 'Excitation wavelength maximum for AGP channel (nm)';
COMMENT ON COLUMN microscope_filter.Metadata_Emission_Low_AGP IS 'Emission wavelength minimum for AGP channel (nm)';
COMMENT ON COLUMN microscope_filter.Metadata_Emission_High_AGP IS 'Emission wavelength maximum for AGP channel (nm)';
-- Mito Channel (MitoTracker)
COMMENT ON COLUMN microscope_filter.Metadata_Excitation_Low_Mito IS 'Excitation wavelength minimum for Mito channel (nm)';
COMMENT ON COLUMN microscope_filter.Metadata_Excitation_High_Mito IS 'Excitation wavelength maximum for Mito channel (nm)';
COMMENT ON COLUMN microscope_filter.Metadata_Emission_Low_Mito IS 'Emission wavelength minimum for Mito channel (nm)';
COMMENT ON COLUMN microscope_filter.Metadata_Emission_High_Mito IS 'Emission wavelength maximum for Mito channel (nm)';
COMMENT ON COLUMN microscope_filter.Metadata_FPBase_Config IS 'FPbase.org URL for fluorescence spectra configuration';

CREATE TABLE microscope_config (
    Metadata_Source VARCHAR PRIMARY KEY,
    Metadata_Microscope_Name VARCHAR,
    Metadata_Widefield_vs_Confocal VARCHAR,
    Metadata_Excitation_Type VARCHAR,
    Metadata_Objective_NA FLOAT,
    Metadata_N_Brightfield_Planes_Min INTEGER,
    Metadata_N_Brightfield_Planes_Max INTEGER,
    Metadata_Distance_Between_Z_Microns INTEGER,
    Metadata_Sites_Per_Well INTEGER,
    Metadata_Filter_Configuration VARCHAR,
    Metadata_Pixel_Size_Microns FLOAT,
    FOREIGN KEY (Metadata_Filter_Configuration) REFERENCES microscope_filter(Metadata_Filter_Configuration)
);

COMMENT ON TABLE microscope_config IS 'Microscope configuration and acquisition settings per imaging center';
COMMENT ON COLUMN microscope_config.Metadata_Source IS 'Data-generating center ID';
COMMENT ON COLUMN microscope_config.Metadata_Microscope_Name IS 'Microscope model name';
COMMENT ON COLUMN microscope_config.Metadata_Widefield_vs_Confocal IS 'Imaging modality. Valid values: Widefield, Confocal';
COMMENT ON COLUMN microscope_config.Metadata_Excitation_Type IS 'Light source type. Valid values: Laser, LED';
COMMENT ON COLUMN microscope_config.Metadata_Objective_NA IS 'Objective lens numerical aperture';
COMMENT ON COLUMN microscope_config.Metadata_N_Brightfield_Planes_Min IS 'Minimum number of brightfield planes acquired';
COMMENT ON COLUMN microscope_config.Metadata_N_Brightfield_Planes_Max IS 'Maximum number of brightfield planes acquired';
COMMENT ON COLUMN microscope_config.Metadata_Distance_Between_Z_Microns IS 'Distance between Z planes in microns (only if > 1μm)';
COMMENT ON COLUMN microscope_config.Metadata_Sites_Per_Well IS 'Number of imaging sites per well';
COMMENT ON COLUMN microscope_config.Metadata_Filter_Configuration IS 'Filter configuration ID';
COMMENT ON COLUMN microscope_config.Metadata_Pixel_Size_Microns IS 'Pixel size in microns';

CREATE TABLE cellprofiler_version (
    Metadata_Source VARCHAR PRIMARY KEY,
    Metadata_CellProfiler_Version VARCHAR
);

COMMENT ON TABLE cellprofiler_version IS 'CellProfiler software version used for image analysis';
COMMENT ON COLUMN cellprofiler_version.Metadata_Source IS 'Data-generating center ID';
COMMENT ON COLUMN cellprofiler_version.Metadata_CellProfiler_Version IS 'CellProfiler version number';

-- Perturbation tables (no dependencies)
CREATE TABLE compound (
    Metadata_JCP2022 VARCHAR PRIMARY KEY,
    Metadata_InChIKey VARCHAR,
    Metadata_InChI VARCHAR,
    Metadata_SMILES VARCHAR
);

COMMENT ON TABLE compound IS 'Chemical compound metadata including structures';
COMMENT ON COLUMN compound.Metadata_JCP2022 IS 'JUMP Perturbation ID';
COMMENT ON COLUMN compound.Metadata_InChI IS 'International Chemical Identifier';
COMMENT ON COLUMN compound.Metadata_InChIKey IS 'Hashed InChI';
COMMENT ON COLUMN compound.Metadata_SMILES IS 'SMILES notation';

CREATE TABLE orf (
    Metadata_JCP2022 VARCHAR PRIMARY KEY,
    Metadata_broad_sample VARCHAR,
    Metadata_Name VARCHAR,
    Metadata_Vector VARCHAR,
    Metadata_Transcript VARCHAR,
    Metadata_Symbol VARCHAR,
    Metadata_NCBI_Gene_ID VARCHAR,
    Metadata_Taxon_ID VARCHAR,
    Metadata_Gene_Description VARCHAR,
    Metadata_Prot_Match FLOAT,
    Metadata_Insert_Length INTEGER,
    Metadata_pert_type VARCHAR
);

COMMENT ON TABLE orf IS 'ORF (Open Reading Frame) overexpression construct metadata';
COMMENT ON COLUMN orf.Metadata_JCP2022 IS 'JUMP Perturbation ID';
COMMENT ON COLUMN orf.Metadata_broad_sample IS 'Broad Institute perturbation ID';
COMMENT ON COLUMN orf.Metadata_Name IS 'Internal perturbation ID';
COMMENT ON COLUMN orf.Metadata_Vector IS 'ORF expression vector used';
COMMENT ON COLUMN orf.Metadata_Prot_Match IS 'Percentage match to protein sequence';
COMMENT ON COLUMN orf.Metadata_Insert_Length IS 'ORF sequence length in base pairs';
COMMENT ON COLUMN orf.Metadata_Taxon_ID IS 'NCBI taxonomy ID';
COMMENT ON COLUMN orf.Metadata_Symbol IS 'NCBI gene symbol';
COMMENT ON COLUMN orf.Metadata_NCBI_Gene_ID IS 'NCBI gene ID';
COMMENT ON COLUMN orf.Metadata_Transcript IS 'NCBI reference sequence';
COMMENT ON COLUMN orf.Metadata_Gene_Description IS 'NCBI gene definition/description';
COMMENT ON COLUMN orf.Metadata_pert_type IS 'Perturbation type. Valid values: trt (treatment), poscon (positive control), negcon (negative control)';

CREATE TABLE crispr (
    Metadata_JCP2022 VARCHAR PRIMARY KEY,
    Metadata_NCBI_Gene_ID VARCHAR,
    Metadata_Symbol VARCHAR
);

COMMENT ON TABLE crispr IS 'CRISPR perturbation metadata for gene knockouts';
COMMENT ON COLUMN crispr.Metadata_JCP2022 IS 'JUMP Perturbation ID';
COMMENT ON COLUMN crispr.Metadata_Symbol IS 'NCBI gene symbol';
COMMENT ON COLUMN crispr.Metadata_NCBI_Gene_ID IS 'NCBI gene ID';

-- Union table for all perturbations (enables proper FK from well)
-- This lightweight index table allows wells to reference any perturbation type
-- while keeping type-specific data (SMILES, gene info, etc.) in separate tables
CREATE TABLE perturbation (
    Metadata_JCP2022 VARCHAR PRIMARY KEY,
    Metadata_perturbation_modality VARCHAR CHECK (Metadata_perturbation_modality IN ('compound', 'orf', 'crispr', 'unknown'))
);

COMMENT ON TABLE perturbation IS 'Union of all perturbation types (compound, orf, crispr, unknown). Enables foreign key from well table.';
COMMENT ON COLUMN perturbation.Metadata_JCP2022 IS 'JUMP Perturbation ID';
COMMENT ON COLUMN perturbation.Metadata_perturbation_modality IS 'Type of perturbation: compound, orf, crispr, or unknown';

-- Control designation table (provides human-readable names and control types)
CREATE TABLE perturbation_control (
    Metadata_JCP2022 VARCHAR PRIMARY KEY,
    Metadata_pert_type VARCHAR CHECK (Metadata_pert_type IN ('trt', 'poscon', 'negcon', 'empty')),
    Metadata_Name VARCHAR,
    FOREIGN KEY (Metadata_JCP2022) REFERENCES perturbation(Metadata_JCP2022)
);

COMMENT ON TABLE perturbation_control IS 'Control type and human-readable names for special perturbations. Note: The orf table already contains a Metadata_pert_type column which is redundant with this table and may be deprecated in future versions';
COMMENT ON COLUMN perturbation_control.Metadata_JCP2022 IS 'JUMP Perturbation ID';
COMMENT ON COLUMN perturbation_control.Metadata_pert_type IS 'Perturbation type: trt (treatment), poscon (positive control), negcon (negative control), empty (empty well)';
COMMENT ON COLUMN perturbation_control.Metadata_Name IS 'Human-readable name for the perturbation (e.g., "DMSO" instead of "JCP2022_033924"). This column provides friendly names for commonly used controls and does not map to any existing table columns';

-- Core experimental tables (depend on microscope_config and cellprofiler_version)
CREATE TABLE plate (
    Metadata_Source VARCHAR,
    Metadata_Batch VARCHAR,
    Metadata_Plate VARCHAR PRIMARY KEY,
    Metadata_PlateType VARCHAR,
    FOREIGN KEY (Metadata_Source) REFERENCES microscope_config(Metadata_Source),
    FOREIGN KEY (Metadata_Source) REFERENCES cellprofiler_version(Metadata_Source)
);

COMMENT ON TABLE plate IS 'Plate metadata including batch, type, and experimental context';
COMMENT ON COLUMN plate.Metadata_Source IS 'Data-generating center ID';
COMMENT ON COLUMN plate.Metadata_Batch IS 'Batch ID - experimental batch identifier';
COMMENT ON COLUMN plate.Metadata_Plate IS 'Plate ID';
COMMENT ON COLUMN plate.Metadata_PlateType IS 'Plate type. Valid values: TARGET1, TARGET2, POSCON8, DMSO, ORF, COMPOUND, COMPOUND_EMPTY';

CREATE TABLE well (
    Metadata_Source VARCHAR,
    Metadata_Plate VARCHAR,
    Metadata_Well VARCHAR,
    Metadata_JCP2022 VARCHAR,
    PRIMARY KEY (Metadata_Plate, Metadata_Well),
    FOREIGN KEY (Metadata_Plate) REFERENCES plate(Metadata_Plate),
    FOREIGN KEY (Metadata_JCP2022) REFERENCES perturbation(Metadata_JCP2022)
);

COMMENT ON TABLE well IS 'Well-level metadata with perturbation IDs. Central table that links plates to perturbations.';
COMMENT ON COLUMN well.Metadata_Source IS 'Data-generating center ID';
COMMENT ON COLUMN well.Metadata_Plate IS 'Plate ID';
COMMENT ON COLUMN well.Metadata_Well IS 'Well position (e.g., A01, B12, P24)';
COMMENT ON COLUMN well.Metadata_JCP2022 IS 'JUMP Perturbation ID';

-- Dependent tables
CREATE TABLE compound_source (
    Metadata_Compound_Source VARCHAR,
    Metadata_JCP2022 VARCHAR,
    PRIMARY KEY (Metadata_JCP2022, Metadata_Compound_Source),
    FOREIGN KEY (Metadata_JCP2022) REFERENCES compound(Metadata_JCP2022)
);

COMMENT ON TABLE compound_source IS 'Compound source/provider information';
COMMENT ON COLUMN compound_source.Metadata_JCP2022 IS 'JUMP Perturbation ID';
COMMENT ON COLUMN compound_source.Metadata_Compound_Source IS 'Compound-nominating center ID';


-- ============================================
-- 2. DATA IMPORT
-- ============================================
-- Import data in correct order to respect foreign key constraints

-- First load tables with no dependencies
INSERT INTO microscope_filter SELECT * FROM read_csv_auto('microscope_filter.csv');
INSERT INTO microscope_config SELECT * FROM read_csv_auto('microscope_config.csv');
INSERT INTO cellprofiler_version SELECT * FROM read_csv_auto('cellprofiler_version.csv');
INSERT INTO compound SELECT * FROM read_csv_auto('compound.csv.gz');
INSERT INTO orf SELECT * FROM read_csv_auto('orf.csv.gz');
INSERT INTO crispr SELECT * FROM read_csv_auto('crispr.csv.gz');

-- Populate the perturbation union table
INSERT INTO perturbation 
SELECT Metadata_JCP2022, 'compound' FROM compound
UNION ALL
SELECT Metadata_JCP2022, 'orf' FROM orf
UNION ALL
SELECT Metadata_JCP2022, 'crispr' FROM crispr;

-- Add the special unknown entry
INSERT INTO perturbation VALUES ('JCP2022_UNKNOWN', 'unknown');

-- Load perturbation control information
INSERT INTO perturbation_control (Metadata_JCP2022, Metadata_pert_type, Metadata_Name)
SELECT Metadata_JCP2022, Metadata_pert_type, Metadata_Name 
FROM read_csv_auto('perturbation_control.csv');

-- Then load tables with foreign keys
INSERT INTO plate SELECT * FROM read_csv_auto('plate.csv.gz');

-- Only insert compound_source records that have matching compounds (deduplicated)
INSERT INTO compound_source 
SELECT DISTINCT cs.* FROM read_csv_auto('compound_source.csv.gz') cs
WHERE cs.Metadata_JCP2022 IN (SELECT Metadata_JCP2022 FROM compound);

INSERT INTO well SELECT * FROM read_csv_auto('well.csv.gz');

-- ============================================
-- 3. INDEXES
-- ============================================
-- Create additional indexes for query performance
-- (Primary keys already create indexes automatically)

CREATE INDEX idx_well_jcp ON well(Metadata_JCP2022);

-- ============================================
-- RELATIONSHIPS SUMMARY
-- ============================================
-- well -> plate: Many wells belong to one plate (via Metadata_Plate)
-- well -> perturbation: Many wells to one perturbation (via Metadata_JCP2022)
-- perturbation -> compound/orf/crispr: Logical relationship based on Metadata_perturbation_modality
-- compound <-> compound_source: Many-to-many mapping (compounds can have multiple sources, sources can provide multiple compounds)
-- plate -> microscope_config: Many plates to one config (via Metadata_Source)
-- plate -> cellprofiler_version: Many plates to one version (via Metadata_Source)
-- microscope_config -> microscope_filter: Many configs to one filter set
--
-- To view documentation in the database:
--   Tables:  SELECT table_name, comment FROM duckdb_tables();
--   Columns: SELECT table_name, column_name, comment FROM duckdb_columns() WHERE comment IS NOT NULL;
--   Foreign Keys: SELECT table_name, constraint_text FROM duckdb_constraints() WHERE constraint_type = 'FOREIGN KEY';