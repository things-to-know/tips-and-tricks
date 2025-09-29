# tips-and-tricks

Tips and tricks

## About Jupyter Book

Jupyter Book (v2) uses [MyST](https://mystmd.org/spec), a flavor of Markdown that extends the
CommonMark specification with additional features for scientific documentation.

It is useful for creating "documents and knowledge bases that are reusable, reproducible,
and interactive".

### Features

- Interactive websites: publish websites "that allow users to interact with widgets and
  computation using JupyterHub, Binder, and even Python in the browser!"
- Reusable knowledge: "create cross-references to content from other documents and sites
  to give users a deeper, richer reading experience"
- Executable Documents: "interweave computational results with high-quality narrative using
  Jupyter Notebooks or executable MyST Markdown documents"
- Export to multiple formats: PDF, DOCX, HTML, EPUB, LaTeX, and more.

### Status

Jupyter Book v2 is, as of 2025-06-19, still in alpha stage, and the latest version is
[2.0.0a3](https://pypi.org/project/jupyter-book/2.0.0a3/).

### More information

- [Jupyter Book v2 documentation](https://next.jupyterbook.org/)
- [Jupyter Book repo](https://github.com/jupyter-book/jupyter-book)
  [v2 branch](https://github.com/jupyter-book/jupyter-book/tree/next)
- [PyPI](https://pypi.org/project/jupyter-book/)

## Development

### Dependencies

- Python 3.13
- Node.js 22.x
- Jupyter Book v2

### Development Environment Setup

Create Python virtual environment:

```sh
make create-venv
```

Install all dependencies:

```sh
make install-python-pip-tools
make compile-python-deps
make install-python-deps
make install-python-deps-dev
make install-node
```

Run [pre-commit hooks](https://pre-commit.com/) on all files:

```sh
pre-commit run --all-files
```
