# `xmllint`

TODO:

- convert file to "linting", instead of specific to xmllint
- reference `src/sw/libxml2/README.md#xmllint`

## How to

### Validate against XSD schema

DTD: Document Type Definition

WARNING: don't use the option `--valid`. Per Gemini:

> This option tells `xmllint` to check the XML document for validity based on its DTD.
  `xmllint` looks for a `<!DOCTYPE ...>` declaration within the XML file itself.
  This declaration points to the DTD that defines the document's structure.

```bash
xmllint --noout \
    --schema 'my-schema.xsd' \
    'my-file.xml'
```

```text
./my-file.xml validates
```
