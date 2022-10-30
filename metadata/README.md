```mermaid
erDiagram
    WELL }|--|| PLATE : ""
    WELL {
        string Metadata_Source FK "Source"
        string Metadata_Plate FK "Plate ID"
        string Metadata_Well "Well position"
        string Metadata_JCP2022 FK "Perturbation identifier"
    }
    PLATE {
        string Metadata_Source PK "Source"
        string Metadata_PlateType
        string Metadata_Batch "Batch ID"
        string Metadata_Plate PK "Plate ID"
    }
    WELL }|--|| COMPOUND : ""
    COMPOUND {
        string Metadata_JCP2022 PK "Perturbation identifier"
        string Metadata_InChIKey
        string Metadata_InChI
    }
```
