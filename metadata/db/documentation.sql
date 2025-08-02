-- JUMP Cell Painting Metadata Documentation
-- ==========================================
-- This file serves as both documentation and executable SQL to add descriptions to the database
-- Run: duckdb jump_metadata.duckdb < add_descriptions.sql
--
-- To view documentation in the database:
--   Tables:  SELECT table_name, comment FROM duckdb_tables();
--   Columns: SELECT table_name, column_name, comment FROM duckdb_columns() WHERE comment IS NOT NULL;

-- ============================================
-- CORE TABLES
-- ============================================

-- WELL: Central table linking wells to perturbations
-- Relationships: well -> plate (many-to-one), well -> compound/orf/crispr (many-to-many via JCP2022)
COMMENT ON TABLE well IS 'Well-level metadata with perturbation IDs. Central table that links plates to perturbations.';
COMMENT ON COLUMN well.Metadata_Source IS 'Data-generating center ID';
COMMENT ON COLUMN well.Metadata_Plate IS 'Plate ID - foreign key to plate table';
COMMENT ON COLUMN well.Metadata_Well IS 'Well position (e.g., A01, B12, P24)';
COMMENT ON COLUMN well.Metadata_JCP2022 IS 'JUMP Perturbation ID - links to compound, orf, or crispr tables';

-- PLATE: Experimental plate information
COMMENT ON TABLE plate IS 'Plate metadata including batch, type, and experimental context';
COMMENT ON COLUMN plate.Metadata_Source IS 'Data-generating center ID';
COMMENT ON COLUMN plate.Metadata_Batch IS 'Batch ID - experimental batch identifier';
COMMENT ON COLUMN plate.Metadata_Plate IS 'Plate ID - primary key';
COMMENT ON COLUMN plate.Metadata_PlateType IS 'Plate type. Valid values: TARGET1, TARGET2, POSCON8, DMSO, ORF, COMPOUND, COMPOUND_EMPTY';

-- ============================================
-- PERTURBATION TABLES
-- ============================================

-- COMPOUND: Chemical compound information
COMMENT ON TABLE compound IS 'Chemical compound metadata including structures';
COMMENT ON COLUMN compound.Metadata_JCP2022 IS 'JUMP Perturbation ID - primary key';
COMMENT ON COLUMN compound.Metadata_InChI IS 'International Chemical Identifier - full structure representation';
COMMENT ON COLUMN compound.Metadata_InChIKey IS 'Hashed InChI - for quick structure lookups';
COMMENT ON COLUMN compound.Metadata_SMILES IS 'SMILES notation - simplified molecular structure';

-- COMPOUND_SOURCE: Source/provider information for compounds
COMMENT ON TABLE compound_source IS 'Compound source/provider information';
COMMENT ON COLUMN compound_source.Metadata_JCP2022 IS 'JUMP Perturbation ID - foreign key to compound';
COMMENT ON COLUMN compound_source.Metadata_Compound_Source IS 'Compound-nominating center ID';

-- ORF: Overexpression constructs
COMMENT ON TABLE orf IS 'ORF (Open Reading Frame) overexpression construct metadata';
COMMENT ON COLUMN orf.Metadata_JCP2022 IS 'JUMP Perturbation ID - primary key';
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

-- CRISPR: CRISPR gene knockout information
COMMENT ON TABLE crispr IS 'CRISPR perturbation metadata for gene knockouts';
COMMENT ON COLUMN crispr.Metadata_JCP2022 IS 'JUMP Perturbation ID - primary key';
COMMENT ON COLUMN crispr.Metadata_Symbol IS 'NCBI gene symbol targeted';
COMMENT ON COLUMN crispr.Metadata_NCBI_Gene_ID IS 'NCBI gene ID targeted';

-- ============================================
-- MICROSCOPY CONFIGURATION TABLES
-- ============================================

-- MICROSCOPE_CONFIG: Microscope hardware and settings
COMMENT ON TABLE microscope_config IS 'Microscope configuration and acquisition settings per imaging center';
COMMENT ON COLUMN microscope_config.Metadata_Source IS 'Data-generating center ID';
COMMENT ON COLUMN microscope_config.Metadata_Microscope_Name IS 'Microscope model name';
COMMENT ON COLUMN microscope_config.Metadata_Widefield_vs_Confocal IS 'Imaging modality. Valid values: Widefield, Confocal';
COMMENT ON COLUMN microscope_config.Metadata_Excitation_Type IS 'Light source type. Valid values: Laser, LED';
COMMENT ON COLUMN microscope_config.Metadata_Objective_NA IS 'Objective lens numerical aperture';
COMMENT ON COLUMN microscope_config.Metadata_N_Brightfield_Planes_Min IS 'Minimum number of brightfield planes acquired';
COMMENT ON COLUMN microscope_config.Metadata_N_Brightfield_Planes_Max IS 'Maximum number of brightfield planes acquired';
COMMENT ON COLUMN microscope_config.Metadata_Distance_Between_Z_Microns IS 'Distance between Z planes in micrometers (only if > 1μm)';
COMMENT ON COLUMN microscope_config.Metadata_Sites_Per_Well IS 'Number of imaging sites per well';
COMMENT ON COLUMN microscope_config.Metadata_Filter_Configuration IS 'Filter configuration ID - foreign key to microscope_filter';
COMMENT ON COLUMN microscope_config.Metadata_Pixel_Size_Microns IS 'Pixel size in micrometers';

-- MICROSCOPE_FILTER: Filter/channel wavelength information
COMMENT ON TABLE microscope_filter IS 'Microscope filter configurations for each fluorescence channel';
COMMENT ON COLUMN microscope_filter.Metadata_Filter_Configuration IS 'Filter configuration ID - primary key';
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
-- Additional metadata
COMMENT ON COLUMN microscope_filter.Metadata_FPBase_Config IS 'FPbase.org URL for fluorescence spectra configuration';

-- CELLPROFILER_VERSION: Software version information
COMMENT ON TABLE cellprofiler_version IS 'CellProfiler software version used for image analysis';
COMMENT ON COLUMN cellprofiler_version.Metadata_Source IS 'Data-generating center ID';
COMMENT ON COLUMN cellprofiler_version.Metadata_CellProfiler_Version IS 'CellProfiler version number';

-- ============================================
-- RELATIONSHIPS SUMMARY
-- ============================================
-- well -> plate: Many wells belong to one plate (via Metadata_Plate)
-- well -> compound: Many-to-many via Metadata_JCP2022
-- well -> orf: Many-to-many via Metadata_JCP2022  
-- well -> crispr: Many-to-many via Metadata_JCP2022
-- compound -> compound_source: One-to-one mapping
-- plate -> microscope_config: Many plates to one config (via Metadata_Source)
-- microscope_config -> microscope_filter: Many configs to one filter set
-- plate -> cellprofiler_version: Many plates to one version (via Metadata_Source)