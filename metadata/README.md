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
        string Metadata_JCP2022 PK "Perturbation identifier"
        string Metadata_InChI "International Chemical Identifier"
        string Metadata_InChIKey "Hashed InChI"
    }
    WELL }o--o| ORF : ""
    ORF {
        string Metadata_JCP2022 PK "Unique JUMP perturbation identifier"
        string Metadata_NCBI_Gene_ID "NCBI unique identifier of a gene"
        string Metadata_broad_sample ""
        string Metadata_Name ""
        string Metadata_Vector "Name of the ORF expression vector"
        string Metadata_Transcript ""
        string Metadata_Symbol ""
        string Metadata_Taxon_ID ""
        string Metadata_Gene_Description ""
        string Metadata_Annot_Gene_Symbol ""
        string Metadata_Annot_Gene_ID ""
        string Metadata_Prot_Match ""
        string Metadata_Insert_Length ""
        string Metadata_pert_type "One of: trt, control"
    }
```
