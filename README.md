# Cell Painting Gallery

This page provides a guide to the datasets that are available in the Cell Painting Gallery, hosted by the AWS Registry of Open Data (RODA): <https://registry.opendata.aws/cellpainting-gallery>

## Citation/license

All the data is released with CC0 1.0 Universal (CC0 1.0).
Still, professional ethics require that you cite the appropriate resources/publications, [listed below](#available-datasets), when using individual datasets.
For example,

> We used the dataset `cpg0000` ([Chandrasekaran et al., 2022](https://doi.org/10.1101/2022.01.05.475090)), available from the Cell Painting Gallery on the Registry of Open Data on AWS (<https://registry.opendata.aws/cellpainting-gallery/>).

## Available datasets

All datasets are generated using the Cell Painting assay unless indicated otherwise. Several updates to that protocol exist ([Cell Painting wiki](https://github.com/carpenterlab/2022_Cimini_NatureProtocols/wiki)).

The datasets are stored with the prefix indicated by the dataset name.
E.g. the first dataset is located at `s3://cellpainting-gallery/cpg0000-jump-pilot` and can be listed using `aws s3 ls --no-sign-request s3://cellpainting-gallery/cpg0000-jump-pilot/` (note the `/` at the end).

The datasets' accession numbers are the first seven characters of the dataset name.
E.g. the accession number of the first dataset is `cpg0000`.

| Dataset name                             | Description                                                                                                                     | Publication to cite | IDR accession number     |
|------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------|---------------------|--------------------------|
| cpg0000-jump-pilot                       | 300+ compounds and 160+ genes (CRISPR knockout and overexpression) profiled in A549 and U2OS cells, at two timepoints           | 3                   |                          |
| cpg0001-cellpainting-protocol            | 300+ compounds profiled in U2OS cells using several different modifications of the Cell Painting protocol                       | 6                   |                          |
| cpg0002-jump-scope                       | 300+ compounds profiled in U2OS using different microscopes and settings                                                        | 7                   |                          |
| cpg0003-rosetta                          | 28,000+ genes and compounds profiled in Cell Painting and [L1000](https://doi.org/10.1016%2Fj.cell.2017.10.049) gene expression | 5                   |                          |
| cpg0004-lincs                            | 1,571 compounds across 6 doses in A549 cells                                                                                    | 4                   | idr0125                  |
| cpg0012-wawer-bioactivecompoundprofiling | 30,000 compound dataset in U2OS cells                                                                                           | 1,2                 | idr0016                  |
| cpg0015-heterogeneity                    | 2,200+ compounds and 200+ genes profiles in U2OS cells                                                                          | 8                   | idr0016,idr0036, idr0033 |
| cpg0016-jump                             | 116,000+ compounds and 16+ genes (CRISPR knockout and overexpression) profiled in U2OS cells                                    | 9                   |                          |
| cpg0017-rohban-pathways                  | 323 genes overexpressed in U2OS cells. Original images re-profiled in 2023                                                      | 11                  |                          |
| cpg0019-moshkov-deepprofiler             | 8.3 million single cells from 232 plates, across 488 treatments from 5 public datasets, used for learning representations       | 10                  |                          |

## Downloading from Cell Painting Gallery

See [Folder Structure](folder_structure.md) for a complete description of data organization in Cell Painting gallery.
Note that for each dataset you can download just images, just extracted features and metadata, or both.
Note also that many datasets contain separate batches and you may want a subset of available batches.

If you'd like to just browse the data, it's a lot easier [to do so using a storage browser](https://stackoverflow.com/a/72143198/1094109).

## Publications using datasets in Cell Painting Gallery

|    | First Author   | <div style="width:350px">Title</div>                                                                                                 | Year | <div style="width:150px">Publication URL</div> | Dataset Name in Gallery                  |
|----|----------------|--------------------------------------------------------------------------------------------------------------------------------------|------|------------------------------------------------|------------------------------------------|
| 1  | Wawer          | Toward performance-diverse small-molecule libraries for cell-based phenotypic screening using multiplexed high-dimensional profiling | 2014 | <https://doi.org/10.1073/pnas.1410933111>      | cpg0012-wawer-bioactivecompoundprofiling |
| 2  | Bray           | A dataset of images and morphological profiles of 30 000 small-molecule treatments using the Cell Painting assay                     | 2017 | <https://doi.org/10.1093/gigascience/giw014>   | cpg0012-wawer-bioactivecompoundprofiling |
| 3  | Chandrasekaran | Three million images and morphological profiles of cells treated with matched chemical and genetic perturbations                     | 2022 | <https://doi.org/10.1101/2022.01.05.475090>    | cpg0000-jump-pilot                       |
| 4  | Way            | Morphology and gene expression profiling provide complementary information for mapping cell state                                    | 2022 | <https://doi.org/10.1101/2021.10.21.465335>    | cpg0004-lincs                            |
| 5  | Haghighi       | High-Dimensional Gene Expression and Morphology Profiles of Cells across 28,000 Genetic and Chemical Perturbations                   | 2022 | <https://doi.org/10.1101/2021.09.08.459417>    | cpg0003-rosetta                          |
| 6  | Cimini         | Optimizing the Cell Painting assay for image-based profiling                                                                         | 2022 | <https://doi.org/10.1101/2022.07.13.499171>    | cpg0001-cellpainting-protocol            |
| 7  | Jamali         | Assessing the performance of the Cell Painting assay across different imaging systems                                                | 2023 | <https://doi.org/10.1101/2023.02.15.528711>    | cpg0002-jump-scope                       |
| 8  | Rohban         | Capturing single-cell heterogeneity via data fusion improves image-based profiling                                                   | 2019 | <https://doi.org/10.1038/s41467-019-10154-8>   | cpg0015-heterogeneity                    |
| 9  | Chandrasekaran | JUMP Cell Painting dataset: morphological impact of 136,000 chemical and genetic perturbations                                       | 2023 | <https://doi.org/10.1101/2023.03.23.534023>    | cpg0016-jump                             |
| 10 | Moshkov        | Learning representations for image-based profiling of perturbations                                                                  | 2022 | <https://doi.org/10.1101/2022.08.12.503783>    | cpg0019-moshkov-deepprofiler             |
| 11 | Rohban         | Systematic morphological profiling of human gene and allele function via Cell Painting                                               | 2017 | <https://doi.org/10.7554/eLife.24060>          | cpg0017-rohban-pathways                  |

## Contributing to Cell Painting Gallery

See [Folder Structure](folder_structure.md) for the required folder structure of your data.
See [Upload](upload.md) for a complete description of how to upload to the Cell Painting gallery bucket.

Any data contributions to Cell Painting Gallery must be accompanied by a pull request to this repository with updates to this README to add your dataset to [Available datasets](#available-datasets) and [Publications](#publications-using-datasets-in-cell-painting-gallery).

## Complementary Datasets

For other sources of publicly available Cell Painting datasets we encourage you to explore:

- [Recursion](https://www.rxrx.ai)
- [Broad Bioimage Benchmark Collection (BBBC)](https://bbbc.broadinstitute.org)
- [Image Data Resource](https://idr.openmicroscopy.org)
