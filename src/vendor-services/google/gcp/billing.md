# Vendor services / Google Cloud Platform (GCP) / Billing

## Overview

TODO

## Glossary

- _Google Cloud Organization_
- [Cloud Billing account](#cloud-billing-account)
- [Payments Account](#payments-account)
- [Google Payments Profile](#google-payments-profile)
- _Payment method_
- Billing service
- Billing SKU
- Billing SKU group
- Billing project

A _Google Cloud Account_ isn't a defined term, and it is best to avoid using it.

## Cloud Billing Account

(aka _Billing Account_)

A (Google) Cloud Billing account establishes a billing relationship between Google (as the vendor)
and a customer in the context of Google Cloud (or similar) services.
It is at a Google Cloud level, not Google (higher-level entity) nor _Google Payments_.

Properties:

- customer: defined by one, and only one, [Google Payments Profile](#google-payments-profile),
  and is the entity responsible for the payments of the services consumed
  i.e. who pays for Google Cloud resources that are consumed
- organization: belongs to a single _Google Cloud Organization_, but it can be changed,
  and **may or may not be the same as the organization that owns the Google Payments Profile**
- [type](https://cloud.google.com/billing/docs/concepts#billing_account_types):
  - "Self-serve" (or "Online"):
    - available payment instruments/methods: credit card, debit card, or ACH direct debit
      (depending on the country)
    - costs are charged automatically to the configured payment instrument/method
    - customers con sign up for the account online by themselves
  - "Invoiced" (or "Offline")
    - available payment instruments/methods: check, wire transfer, and those available for
      self-serve accounts
    - customers must be [eligible](https://cloud.google.com/billing/docs/how-to/invoiced-billing)
      and approved by Google
- billable status:
  - "Paid account": i.e. not a free trial account
  - "Free trial account": available only for self-serve accounts, and it is temporary
- charging cycle:
  - "Monthly billing": the default, and the most common
  - "Threshold billing"
- billing contacts: one or more contacts that are defined on the associated
  _Google Payments Profile_
- subaccounts: used by resellers

One or more _Google Cloud Projects_ can be linked to a billing account.
A _Google Cloud Project_ can't be linked to multiple billing accounts.

### Cloud Billing Account Type

There are two types of Cloud Billing accounts:

- self-serve (or "online")
- invoiced (or "offline")

More info:
[Google Cloud / Cloud Billing overview](https://cloud.google.com/billing/docs/concepts#billing_account_types)

### Permissions

It is not straightforward to manage
[permissions](https://cloud.google.com/billing/docs/how-to/billing-access) in a billing account.

> The permissions needed to manage a Google payments profile are separate from the permissions
  needed to access and manage a Cloud Billing account.
> Payments-related actions for your Google Cloud account require both Cloud Billing account
  permissions as well as Google payments profile permissions.

\[Source: in-app tutorial in the GCP web console\]

### Configuration

- Google Cloud Billing accounts: use the
  [Cloud Billing](https://console.cloud.google.com/billing) app in the GCP web console.
- Google Payments Profiles: use the
  [Google Payments Center](https://payments.google.com/) system, although there is a degree of
  **overlap with the Cloud Billing web app**.

## Cloud Billing Document

A Cloud Billing Document can be:

- Statement: a "summary of monthly billing activity". It contains
  "your legally registered business address, tax IDs, any payments made during the month, any
  taxes paid for the month, and a summary of your usage costs for the month"
  [[source](https://cloud.google.com/billing/docs/how-to/get-invoice#statements)].
- Invoice
- Payment receipt

## Payments account

Note: don't confuse it with a [Google Payments Profile](#google-payments-profile),
nor a [Cloud Billing Account](#cloud-billing-account).

- payments account ID: e.g. `4381-2930-5001-3842`
- nickname
- payment terms: e.g. "Net 30", "Due on receipt"

> Contains info about how you pay as well as your document delivery addresses.

## Google Payments Profile

Note: sometimes referred to as _payment account_ but that is a
[different thing](#payments-account).

Used for billing and payments in Google Cloud Platform (GCP) and other Google products,
to manage billing and payments information, and designate who is responsible for the payments.

Note: unlike a Cloud Billing account, a [Google Payments Profile](#google-payments-profile)
is "Google-level resource".

Its ID is the _payments profile ID_ (fka "Billing ID") and is used to identify the profile.
Example value: `9712-6488-0246`.

It can only be one of two kinds, and it is permanent:

- _Individual_: for personal use
- _Business_ (in some products/apps, _Organization_ is used instead):
  for a business, organization, partnership, or educational institution

More info:
[Google payments center help / Account settings for payments profile](https://support.google.com/paymentscenter/topic/9017383?hl=en)

### For organizations

An organization can have multiple payments profiles,
e.g. an agency with clients paying for the account.

### Information stored in a payments profile

- (payment) account type (sic): individual or organization
- legal entity: information of whom (individual or organization) is responsible for the profile:
  - name: of an individual, even if it is a business profile
    ("the name appears on invoices so that invoices are routed appropriately")
  - organization name: if applicable
  - tax information:
    - tax ID
    - tax status
    - tax exemption status
  - address: may or may not be the same as the mailing address
- payment methods: credit cards, debit cards, bank accounts, other
- subscriptions and recurring payments configuration
- access control and contact information: who can access the profile, what they can do,
  and how to contact them
- preferences: language, notification settings

Records of transactions aren't usually stored in the _payments profile_
(e.g. GCP _Billing Account_) but are linked to it.

## Billing services and SKUs

All the existing billing services and SKUs can be found in:

- [GCP SKUs list and prices](https://cloud.google.com/skus)
- [GCP SKU Groups list](https://cloud.google.com/skus/sku-groups)

The [Cloud Billing API](https://cloud.google.com/billing/docs/reference/rest)
(`cloudbilling.googleapis.com`) is useful for, among other things:

- listing all billing services: method
  [`services.list`](https://cloud.google.com/billing/docs/reference/rest/v1/services/list)
- listing all SKUs under a given billing service: method
  [`services.skus.list`](https://cloud.google.com/billing/docs/reference/rest/v1/services.skus/list)
- get more details about a billing SKU: apparently coming in HTTP API v2
  - TODO: check out the RPC API:
    [`google.cloud.billing.v1.Sku`](https://cloud.google.com/billing/docs/reference/rpc/google.cloud.billing.v1#google.cloud.billing.v1.Sku)

### Billing services

A _billing service_ has a name and an ID. It can correspond to:

- a regular GCP service e.g. "Big Query" (`24E6-581D-38E5`)
- a subservice e.g. "BigQuery Reservation API" (`16B8-3DDA-9F10`)
- licensing fees for third-party software e.g. "VMware Engine" (`C079-64FE-9109`)

### Billing SKUs

A _billing SKU_ is a more granular product or service billed to customers, and belongs to a
_billing service_. It has a name and ID, and there are many thousands of them, with more
being added all the time.

They can correspond to:

- something simple e.g. "API Gateway GOOGLE-API Egress" (`3F66-E308-4A92`),
  under "API Gateway" (`36A9-155B-23F0`)
- something very specific like a certain feature, in a certain region e.g.
  "API Gateway Network Egress via Carrier Peering Network - Asia Pacific Based" (`1AD1-5B57-590A`)
  under "API Gateway" (`36A9-155B-23F0`)
- a purchase commitment like
  [Committed Use Discounts](https://cloud.google.com/compute/docs/instances/committed-use-discounts-overview)
  (CUDs) e.g. "Committed Use Discount Premium for E2 Custom Instance Ram running in Toronto"
  (`ECA4-1159-9E65`) (3-year CUD for E2 VMs)
  under "Compute Engine" (`6F81-5844-456A`)

Billing SKUs are used:

- by Google to bill its customers
- by Google to restrict credit usage: some credits can only be used for specific SKUs
- by Google and customers for procurement: referenced in GCP services purchase orders and contracts
- by customers for cost management: track the costs of GCP services

Billing SKUs are organized by _SKU groups_ although the grouping is not always intuitive,
and _perhaps_ they're of no use beyond documentation, and they might even be subject to change
over time (we just don't know).

_SKU groups_ don't necessarily correspond 1:1 to a service or group of services. They can be:

- a group of SKUs that belong to a single service e.g.
  [App Engine](https://cloud.google.com/skus/sku-groups/app-engine)
- a group of SKUs that belong to several services, e.g.
  [Data Analytics](https://cloud.google.com/skus/sku-groups/data-analytics)
- a subset of the SKUs that belong to one or several services,
  e.g. "Compute Engine" SKUs are organized in several SKU groups
- a group of SKUs that belong to a specific offer, e.g.
  [Vertex GenAI Offer 2025](https://cloud.google.com/skus/sku-groups/vertex-genai-offer-2025)
- something else we don't know about yet

## Pricing

TODO

## Discounts

Note: don't confuse discounts with [credits](#credits).

### Committed Use Discounts (CUDs)

Committed Use Discounts (CUD) are a way to save on GCP costs by committing to use a service for a
specific period of time, typically one year or three years. CUDs provide significant discounts
compared to on-demand pricing.

For some resources/services, there are types of CUDs. For example, in GCE (Google Compute Engine)
there are
[Resource-based CUDs](https://cloud.google.com/compute/docs/instances/committed-use-discounts-overview#resource_based)
and
[Compute flexible CUDs](https://cloud.google.com/compute/docs/instances/committed-use-discounts-overview#spend_based).

## Credits

TODO

Note: don't confuse discounts with [discounts](#discounts).

## Tax

TODO

### Sustained Use Discounts (SUDs)

Apparently, there are SUDs only in GCE (Google Compute Engine).
They're applied automatically, although there are several restrictions and conditions.

> Compute Engine offers sustained use discounts (SUDs) on resources that are used for more than
  25% of a billing month and are not receiving any other discounts.
  Whenever you use an applicable resource for more than a fourth of a billing month,
  you automatically receive a discount for every incremental hour that you continue to use
  that resource.
  The discount increases incrementally with usage and you can get up to a 30% net discount off
  of the resource cost for virtual machine (VM) instances that run the entire month.

More information: <https://cloud.google.com/compute/docs/sustained-use-discounts>

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
