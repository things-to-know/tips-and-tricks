# Vendor services / Google Cloud Platform (GCP) / Services / Dataplex

## Overview

## Billing SKUs

Service "Dataplex" (ID: `51C6-B3F5-9B38`).
The full list of SKUs under this service can be found in:
[SKU Group Data Analytics](https://cloud.google.com/skus/sku-groups/data-analytics).

## How-to

### Get all lakes

Retrieve the list of all the lakes in a project and region:

```sh
gcloud dataplex lakes list \
    --project=${gcp_project_id} \
    --location=${gcp_region}
```

### Get all zones in a lake

Retrieve the list of all the zones in a given _Dataplex lake_:

```sh
gcloud dataplex zones list \
    --lake=${gcp_lake_id} \
    --project=${gcp_project_id} \
    --location=${gcp_region}
```

### Get all assets in a zone

Retrieve the list of all the assets in a given _Dataplex zone_:

```sh
gcloud dataplex assets list \
    --zone=${gcp_zone_id} \
    --lake=${gcp_lake_id} \
    --project=${gcp_project_id} \
    --location=${gcp_region}
```

### Get all data scans

```sh
gcp_project_id='my-gcp-project-id'
gcp_region='us-central1'
```

```sh
gcloud dataplex datascans list \
    --project=${gcp_project_id} \
    --location=${gcp_region}
```

```text
NAME                                                                                              DISPLAY_NAME                                                 DATASCAN_STATUS  SCAN_TYPE     LOCATION
projects/my-gcp-project-id/locations/us-central1/dataScans/a5fdcf5a1-ffc7-4d1a-abaa-50d9a631255d  my-gcp-project-id:my-bq-dataset.my-bq-table-default-profile  ACTIVE           DATA_PROFILE  us-central1
```

### Find billable resources

The simple way is to retrieve the list of _Dataplex asset resources_.
However, **the result is not exhaustive**, as it doesn't include all types of resources that can be
billed in Dataplex.

Also, the request must be made for each _Dataplex zone_, which, if fully qualified, determines
a specific GCP project, GCP region, and _Dataplex lake_.

#### Get billed SKUs

See [billing](../billing.md#get-an-invoice-costs-details) for details on how to retrieve the
relevant SKUs, which are grouped under the service "Dataplex".

For example, the SKU "Dataplex Metadata Storage Iowa" (Iowa is the GCP region `us-central1`)
with ID `51C6-B3F5-9B38` is used by Dataplex in that region to store metadata.

#### Dataplex assets

For each _Dataplex zone_, retrieve the list of _Dataplex assets_.
See the [Get all assets in a zone](#get-all-assets-in-a-zone) section for details.

#### Dataplex data scans

Dataplex data scans aren't _Dataplex assets_, but **they're billed resources**
(as of 2025-06-18, under the SKU named "Dataplex Metadata Storage <gcp-region-name>", that belongs
to service "Dataplex", with each region having its own SKU).

**Warning**: Even if a data scan was created/executed a long time ago, it is billed nonetheless.
To avoid being charged for data scans that are no longer needed, you have to delete them.
