The scripts in this folder are used for automated versioning by uploading the "manifest-esque" file (`profile_index.csv`, on the root folder) to Zenodo when the csv is updated in this repository.


# Updating new versions

The JUMP profiles that are most up-to-date are indicated on `profile_index.csv`. To release a new set you need only manually update the urls to point to the new location, and potentially change their associated names if it is a new kind of dataset.


# Update hashes

After updating an url it will not match the ETag (provided by S3). This


# Upload new version

From the home folder you can run this to update the . It requires sponge

```bash
bash src/update_etags.sh | sponge > profile_index.csv
```

Note: (if using Nix, all dependencies are already included in the flake at the root folder, just run `nix develop` before the last command)


# Commit changes

Add and commit the updated csv, this should trigger an update on Zenodo and, once that is up, the csv files should match.
