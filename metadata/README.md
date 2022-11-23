# Metadata

The metadata [schema](https://mermaid-js.github.io/mermaid/#/entityRelationshipDiagram?id=entity-relationship-diagrams) is shown below


```mermaid
erDiagram
    WELL }|--|| PLATE : ""
    WELL {
        string Metadata_Source "Data-generating center ID"
        string Metadata_Plate "Plate ID"
        string Metadata_Well "Well position"
        string Metadata_JCP2022 "JUMP Perturbation ID"
    }
    PLATE {
        string Metadata_Source "Data-generating center ID"
        string Metadata_Batch "Batch ID"
        string Metadata_Plate "Plate ID"
        string Metadata_PlateType "One of: BORTEZOMIB, TARGET1, TARGET2, POSCON8, DMSO, ORF, COMPOUND, COMPOUND_EMPTY"
    }
    WELL }o--o| COMPOUND : ""
    COMPOUND {
        string Metadata_JCP2022 PK "JUMP perturbation ID"
        string Metadata_InChI "International Chemical ID"
        string Metadata_InChIKey "Hashed InChI"
    }
    WELL }o--o| ORF : ""
    ORF {
        string Metadata_JCP2022 PK "JUMP perturbation ID"
        string Metadata_broad_sample "Broad perturbation ID"
        string Metadata_Name "Internal perturbation ID"
        string Metadata_Vector "ORF expression vector"
        float Metadata_Prot_Match "% match to protein sequence"
        int Metadata_Insert_Length "ORF sequence length"
        string Metadata_Taxon_ID "NCBI taxonomy ID"
        string Metadata_Symbol "NCBI gene symbol"
        string Metadata_NCBI_Gene_ID "NCBI gene ID"
        string Metadata_Transcript "NCBI reference sequence"
        string Metadata_Gene_Description "NCBI gene definition"
        string Metadata_pert_type "One of: trt, control"
    }
```
