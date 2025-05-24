# `xmllint`

It is a command-line XML tool that is part of the
[`libxml2`](https://gitlab.gnome.org/GNOME/libxml2) library.

- Man page: <https://gnome.pages.gitlab.gnome.org/libxml2/xmllint.html>
- Source code: <https://gitlab.gnome.org/GNOME/libxml2/-/blob/master/xmllint.c>
- Docs source: <https://gitlab.gnome.org/GNOME/libxml2/-/blob/master/doc/xmllint.xml>

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
