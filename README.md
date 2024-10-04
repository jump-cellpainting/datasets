# JUMP Cell Painting Datasets

[![DOI](https://zenodo.org/badge/552371375.svg)](https://zenodo.org/badge/latestdoi/552371375)

This is a collection of [Cell Painting](https://jump-cellpainting.broadinstitute.org/cell-painting) image datasets generated by the [JUMP-Cell Painting Consortium](https://jump-cellpainting.broadinstitute.org/), funded in part by a grant from the Massachusetts Life Sciences Center.

This repository contains notebooks and instructions to work with the datasets.

All the data is hosted on the Cell Painting Gallery on the Registry of Open Data on AWS ([https://registry.opendata.aws/cellpainting-gallery/](https://registry.opendata.aws/cellpainting-gallery/)). If you'd like to take a look at (a subset of) the data interactively, the [JUMP-CP Data Explorer](https://phenaid.ardigen.com/jumpcpexplorer/) by Ardigen and the [JUMP-CP Data Portal](https://www.springdiscovery.com/jump-cp) by Spring Discovery provide portals to do so.

## Details about the data

This collection comprises 4 datasets:

- The principal dataset of 116k chemical and >15k genetic perturbations the partners created in tandem (`cpg0016`), split across 12 data-generating centers. Human U2OS osteosarcoma cells are used.
- 3 pilot datasets created to test: different perturbation conditions (`cpg0000`, including different cell types), staining conditions (`cpg0001`), and microscopes (`cpg0002`).

### What’s available now

- All data [components](https://github.com/broadinstitute/cellpainting-gallery/blob/main/documentation/data_structure.md) of the three pilots.
- Most data components (images, raw CellProfiler output, single-cell profiles, aggregated CellProfiler profiles) from 12 sources for the principal dataset. Each source corresponds to a unique data generating center (except `source_7` and `source_13`, which were from the same center).
- All key [metadata](metadata/README.md) files.
- A [notebook](https://github.com/jump-cellpainting/datasets/blob/main/sample_notebook.ipynb) to load and inspect the data currently available in the principal dataset.
- Different subsets of data in the principal dataset, assembled into single parquet files. The URLs to the subsets are [here](https://github.com/jump-cellpainting/datasets/blob/main/manifests/profile_index.csv). The corresponding folders for each contain all the data levels (e.g. this [folder](https://cellpainting-gallery.s3.amazonaws.com/index.html#cpg0016-jump-assembled/source_all/workspace/profiles/jump-profiling-recipe_2024_a917fa7/ORF/profiles_wellpos_cc_var_mad_outlier_featselect_sphering_harmony/)). Snakemake workflows for producing these assembled profiles are available [here](https://github.com/broadinstitute/jump-profiling-recipe/releases/tag/v0.1.0). We recommend working with the the `all` or `all_interpretable` subsets -- they contain all three data modalities in single dataframe. Note that cross-modality matching is still poor (ORF-CRISPR, COMPOUND-CRISPR, COMPOUND-ORF), but within modality generally works well. 
- A [tutorial](https://broadinstitute.github.io/2023_12_JUMP_data_only_vignettes/howto/1_retrieve_profiles.html) to load these subsets of data.
- Other [tutorials](https://broadinstitute.github.io/2023_12_JUMP_data_only_vignettes/) to work with `cpg0016`.

### What’s coming up

- Extending the metadata and notebooks to the three pilots so that all these datasets can be quickly loaded together ([issue](https://github.com/jump-cellpainting/datasets-private/issues/93)).
- Curated annotations for the compounds, obtained from [ChEMBL](https://www.ebi.ac.uk/chembl/) and other sources ([issue](https://github.com/jump-cellpainting/datasets-private/issues/78)).
- Deep learning [embeddings](https://tfhub.dev/google/imagenet/efficientnet_v2_imagenet1k_s/feature_vector/2) using a pre-trained neural network for all 4 datasets ([issue](https://github.com/jump-cellpainting/datasets-private/issues/50)).
- Methods and tools to simplify access to the data/metadata ([`cpgdata`](https://github.com/broadinstitute/cpg/tree/main/cpgdata), [`jump-portraits`](https://github.com/broadinstitute/monorepo/tree/main/libs/jump_portrait), [`jump-babel`](https://github.com/broadinstitute/monorepo/tree/main/libs/jump_babel)).

## How to load the data: notebooks and folder structure

*Note:* This new resource <https://broad.io/jump> include vignettes demonstrating how to work with JUMP data, and we recommend using those to get started.

See the [sample notebook](sample_notebook.ipynb) to learn more about how to load the data in the principal dataset.

To get set up to run the notebook, first install the python dependencies and activate the virtual environment

   ```bash
   # install pipenv if you don't have it already https://pipenv.pypa.io/en/latest/#install-pipenv-today
   pipenv install
   pipenv shell
   ```

See the typical [folder structure](https://github.com/broadinstitute/cellpainting-gallery/blob/main/documentation/data_structure.md) for datasets in the Cell Painting Gallery.


## Citation/license

### Citing the JUMP resource as a whole

All the data is released with CC0 1.0 Universal (CC0 1.0).
Still, professional ethics require that you cite the associated publication.
Please use the following format to cite this resource as a whole:

> _We used the JUMP Cell Painting datasets (Chandrasekaran et al., 2023), available from the Cell Painting Gallery on the Registry of Open Data on AWS ([https://registry.opendata.aws/cellpainting-gallery/](https://registry.opendata.aws/cellpainting-gallery/))._
>
> _Chandrasekaran et al., 2023: doi:10.1101/2023.03.23.534023_

### Citing individual JUMP datasets

To cite individual JUMP Cell Painting datasets, please follow the guidelines in the Cell Painting Gallery citation [guide](https://github.com/broadinstitute/cellpainting-gallery/#citationlicense).
Examples are as follows:

> _We used the dataset cpg0001 (Cimini et al., 2022), available from the Cell Painting Gallery on the Registry of Open Data on AWS (<https://registry.opendata.aws/cellpainting-gallery/>)._
>
> _We used the dataset cpg0000 (Chandrasekaran et al., 2022), available from the Cell Painting Gallery on the Registry of Open Data on AWS (<https://registry.opendata.aws/cellpainting-gallery/>)._

## Gratitude

Thanks to Consortium Partner scientists for creating this data, from Ksilink, Amgen, AstraZeneca, Bayer, Biogen, the Broad Institute, Eisai, Janssen Pharmaceutica NV, Merck KGaA Darmstadt Germany, Pfizer, Servier, and Takeda.

Supporting Partners include Ardigen, Google Research, Nomic Bio, PerkinElmer, and Verily. Collaborators include the Pistoia Alliance, Umeå University, and the Stanford Machine Learning Group. The AWS Open Data Sponsorship Program is sponsoring data storage.

This work was funded by a major grant from the Massachusetts Life Sciences Center and the National Institutes of Health through MIRA R35 GM122547 to Anne Carpenter.

## Questions?

Please ask your questions via issues [https://github.com/jump-cellpainting/datasets/issues](https://github.com/jump-cellpainting/dataset/issues).

Keep posted on future data updates by subscribing to our email list, see the button here: <https://jump-cellpainting.broadinstitute.org/more-info>
