```mermaid
erDiagram
    WELL }|--|| PLATE : ""
    WELL {
        string Metadata_Source "Source"
        string Metadata_Plate "Plate ID"
        string Metadata_Well "Well position"
        string Metadata_JCP2022 "Perturbation identifier"
    }
    PLATE {
        string Metadata_Source "Source"
        string Metadata_Batch "Batch ID"
        string Metadata_Plate "Plate ID"
        string Metadata_PlateType
    }
    WELL }|--|| COMPOUND : ""
    COMPOUND {
        string Metadata_JCP2022 PK "Perturbation identifier"
        string Metadata_InChIKey
        string Metadata_InChI
    }
```
