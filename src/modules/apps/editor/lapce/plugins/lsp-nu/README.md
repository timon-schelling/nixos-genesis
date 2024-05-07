# Nushell LSP Lapce Plugin

A language server for Nushell.

## Features

- Limited syntax highlighting, error reporting, code completion

## Configure

Configure path to LSP server in Lapce settings.toml

```toml
[nushell-lsp]
path = "/usr/bin/nu"
args = [ "--lsp" ]
```

Or use nu from `PATH` this is the default

```toml
[nushell-lsp]
path = "/usr/bin/env"
args = [ "nu", "--lsp" ]
```

## Technical

Uses [nushell's](https://github.com/nushell/nushell) [integrated lsp](https://github.com/nushell/nushell/tree/main/crates/nu-lsp) (`nu --lsp`).
