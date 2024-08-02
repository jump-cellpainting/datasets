# Automated versioning with Zenodo

The scripts in this folder enable automated versioning by uploading the `profile_index.csv` file to Zenodo when it is updated in this repository.

## Updating new versions

To release a new set of assembled JUMP profiles, manually update the URLs in `profile_index.csv` to point to the new location.
If necessary, update the associated names for new dataset types.

## Update ETags to Reflect New URLs

After updating a URL, the ETag (provided by S3) will no longer match. To update the ETags, run the following command from the home folder:

```bash
bash src/update_etags.sh | sponge > profile_index.csv
```

Note: If using Nix, all dependencies are already included in the flake at the root folder. Simply run `nix develop` before the above command.

## Commit changes

Add and commit the updated `profile_index.csv`. This  should trigger an update on Zenodo. Once the update is complete, the csv files in the repository and on Zenodo should match.
