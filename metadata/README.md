# Metadata

The metadata [schema](https://mermaid-js.github.io/mermaid/#/entityRelationshipDiagram?id=entity-relationship-diagrams) is shown below


```mermaid
erDiagram
    WELL }|--|| PLATE : ""
    WELL {
        string Metadata_Source "Data-generating center ID"
        string Metadata_Plate "Plate ID"
        string Metadata_Well "Well position"
        string Metadata_JCP2022 "Perturbation identifier"
    }
    PLATE {
        string Metadata_Source "Data-generating center ID"
        string Metadata_Batch "Batch ID"
        string Metadata_Plate "Plate ID"
        string Metadata_PlateType "One of: BORTEZOMIB, TARGET1, TARGET2, POSCON8, DMSO, ORF, COMPOUND, COMPOUND_EMPTY"
    }
    WELL }o--o| COMPOUND : ""
    COMPOUND {
        string Metadata_JCP2022 PK "Unique JUMP perturbation identifier"
        string Metadata_InChI "International Chemical Identifier"
        string Metadata_InChIKey "Hashed InChI"
    }
    WELL }o--o| ORF : ""
    ORF {
        string Metadata_JCP2022 PK "Unique JUMP perturbation identifier"
        string Metadata_NCBI_Gene_ID "NCBI unique identifier of a gene"
        string Metadata_broad_sample "Unique Broad perturbation identifier"
        string Metadata_Name "Unique internal perturbation identifier"
        string Metadata_Vector "Name of the ORF expression vector"
        float Metadata_Prot_Match "% match to protein sequence"
        int Metadata_Insert_Length "Length of the ORF sequence"
        string Metadata_pert_type "One of: trt, control"
        string Metadata_Taxon_ID "NCBI taxonomy ID"
        string Metadata_Gene_Description "NCBI gene definition"
        string Metadata_Transcript "NCBI RefSeq version"
        string Metadata_Annot_Gene_ID "NCBI RefSeq gene ID"
        string Metadata_Symbol ""
        string Metadata_Annot_Gene_Symbol ""
    }
```
