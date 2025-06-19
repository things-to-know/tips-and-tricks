# Vendor services / Google Cloud Platform (GCP) / Billing

## Overview

TODO

## How-to

### Get all billing accounts

Retrieve all the billing accounts the user has access to:

```sh
gcloud billing accounts list
```

For example:

```text
ACCOUNT_ID            NAME                                    OPEN  MASTER_ACCOUNT_ID
016965-50AF66-E9C818  Foo default billing account             True
```

### Get billing account information

Retrieve the following details of a billing account :

- currency
- display name
- master billing account
- state: open or closed
- parent: an organization

```sh
gcloud billing accounts describe \
    ${gcp_billing_account_id}
```

For example:

```yaml
currencyCode: USD
displayName: Foo default billing account
masterBillingAccount: ''
name: billingAccounts/016965-50AF66-E9C818
open: true
parent: organizations/990990633258
```

### Get a billing account's associated projects

Retrieve all the active projects associated with a billing account:

```sh
gcloud billing projects list \
    --billing-account=${gcp_billing_account_id}
```

```text
PROJECT_ID                      BILLING_ACCOUNT_ID    BILLING_ENABLED
my-gcp-project-id               016965-50AF66-E9C818  True
```

### Get an invoice costs details

Warning: if you're using credits, remember to filter out the credits from the invoice to see the
actual costs.

The information can't be retrieved with the CLI, so you have to use the GCP web console.
The costs are returned in a tabular format, grouped by project, service and SKU.

#### Grouped hierarchically by project, service and SKU

Grouped (but expandable) by GCP project, service and then by SKU.

Parameters:

```sh
gcp_billing_account_id='016965-50AF66-E9C818'
gcp_invoice_number='5249602153'
```

GCP web console URL:

```sh
xdg-open "https://console.cloud.google.com/billing/${gcp_billing_account_id}/reports/tabular;
invoiceNumber=${gcp_invoice_number};
credits=NONE;"
```

#### Filtered by project grouped hierarchically by service and SKU

Filtered for a given project, grouped (but expandable) by GCP service, and then by SKU.

Parameters:

```sh
gcp_billing_account_id='016965-50AF66-E9C818'
gcp_invoice_number='5249602153'
gcp_project_id='my-gcp-project-id'
```

GCP web console URL:

```sh
xdg-open "https://console.cloud.google.com/billing/${gcp_billing_account_id}/reports/tabular;
invoiceNumber=${gcp_invoice_number};
projects=${gcp_project_id};
credits=NONE"
```
