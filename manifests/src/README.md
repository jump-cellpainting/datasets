# Automated versioning with Zenodo

The scripts in this folder are used for automated versioning by uploading the manifest file (`profile_index.json`, currently the only one in the root folder) to Zenodo.
In the future, additional manifest files will be added and updated in this repository, triggering the same automated versioning process.

## Updating new versions

To release a new set of assembled JUMP profiles, manually update the URLs in `profile_index.json` to point to the new location.
If necessary, update the associated names for new dataset types and (optionally) the permanent link to the version of the recipe that produced them.

## Update ETags to reflect new URLs

After updating a URL, the ETag (provided by S3) will no longer match. To update the ETags, run the following command from the home folder:

```bash
bash manifests/src/update_etags.sh manifests/profile_index.json > manifests/profile_index.json.tmp && mv manifests/profile_index.json.tmp manifests/profile_index.json
```

Note: If using Nix, all dependencies are already included in the flake at the root folder. Simply run `nix develop --extra-experimental-features nix-command --extra-experimental-features flakes` before the above command.

## Commit changes

Add and commit the updated `profile_index.json`. This should trigger an update on Zenodo. Once the update is complete, the json files in the repository and on Zenodo should match.
