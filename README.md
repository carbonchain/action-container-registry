# GitHub Action for Container Registry

A GitHub action that builds your docker image and pushes it to Container Registry.

## Usage

```bash
- name: Build and publish image to GCR
  uses: carbonchain/action-container-registry@v1.0
  with:
    project: [your-project]
    dockerfile: [path-to-your-dockerfile]
    image: gcr.io/[your-project]/[image-name]
    service_account_key: ${{ secrets.GCLOUD_AUTH }}
```

Your `GCLOUD_AUTH` secret (or whatever you name it) must be a base64 encoded gcloud JSON service key with the Storage
Admin permissions.

The image must be "pushable" to one of Google's container registries, i.e. it should be in the
`gcr.io/[project]/[image]` or `eu.gcr.io/[project]/[image]` format.

**Don't forget to enable Container Registry in your GCP project!**
