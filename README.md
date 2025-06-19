# tips-and-tricks

Tips and tricks

## Development Environment Setup

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
```

Run [pre-commit hooks](https://pre-commit.com/) on all files:

```sh
pre-commit run --all-files
```
