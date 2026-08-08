# Cudamation2D

Cudamation2D is an AI-assisted professional 2D animation studio built directly
on [Tahoma2D](https://github.com/tahoma2d/tahoma2d).

The fork keeps Tahoma's mature drawing, painting, Xsheet, scene, effects, audio,
rendering, and stop-motion workflows. Cudamation2D adds a stable automation
layer, command-line tools, an MCP server, AI-assisted production workflows, and
auditable revisions.

## Status

The repository is in its bootstrap phase. It currently tracks the Tahoma2D 1.6
codebase; the Cudamation2D automation API and user-visible branding are being
introduced incrementally. Do not expect CLI, MCP, or AI functionality yet.

The first automation milestone is documented in
[doc/cudamation2d/automation-architecture.md](./doc/cudamation2d/automation-architecture.md).
The downstream maintenance contract is documented in
[doc/cudamation2d/upstream-sync.md](./doc/cudamation2d/upstream-sync.md).

## Development

Tahoma's existing platform build documentation remains authoritative:

- [macOS](./doc/how_to_build_macosx.md)
- [Windows](./doc/how_to_build_win.md)
- [Linux](./doc/how_to_build_linux.md)

The current CI workflows build macOS on both Apple Silicon and Intel, plus
Windows and Linux.

## Upstream

`upstream` points to `tahoma2d/tahoma2d`. Cudamation2D is extension-first: use
Tahoma's supported interfaces when they preserve the full product, and patch
the application only where a required automation seam does not exist. Upstream
updates are tested on a candidate branch before a human-controlled merge.

## Licensing

Tahoma2D-derived source remains under its BSD 3-Clause license and original
copyright notices. Third-party code and bundled assets retain their respective
licenses. See [LICENSE.txt](./LICENSE.txt), `thirdparty`, and
`stuff/doc/LICENSE` for details.
