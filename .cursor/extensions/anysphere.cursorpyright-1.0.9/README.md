# Cursor Pyright

Cursor Pyright is a fork of [Basedpyright](https://github.com/DetachHead/basedpyright) which is a fork of [pyright](https://github.com/microsoft/pyright) with various type checking improvements, pylance features and more.

See [the original documentation](https://detachhead.github.io/basedpyright) for a comprehensive list of features and improvements.


## Differences between Cursor Pyright and Basedpyright

* The default analysis level (`cursorpyright.analysis.typeCheckMode`) is `off`, with warnings for import errors to more closely match the Pylance defaults. The default for basedpyright is `recommended`, which shows many more errors.
* By default, the amount of memory for the language server is dynamically set to be ~half of the physical RAM available, capped at 16GB. This can be customized via the `cursorpyright.nodeMaxOldSpaceSize` setting.
* The options for the node interpreter running the LSP can be customized via the `cursorpyright.nodeEnvVars`, `cursorpyright.nodeExecutable`, and `cursorpyright.nodeArguments` settings.
* On first use, we offer to import settings from Pylance, and copy them over to the Cursor Pyright equivalents.
* It is possible to disable the workspace symbol provider with the setting `cursorpyright.analysis.disableWorkspaceSymbol`.
* Inlay type hints are disabled by default, as they conflict with Cursor Tab. They can be enabled via the `cursorpyright.analysis.inlayHints.*` settings.
* Formatting on rename is disabled to improve performance.
