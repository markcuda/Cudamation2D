# Cudamation2D automation architecture

Status: accepted foundation; implementation pending baseline build.

Decision record:
[ADR-0001](../decisions/0001-build-cudamation2d-on-tahoma2d.md).

## Product boundary

Cudamation2D is a downstream Tahoma2D distribution, not a separate animation
application. Tahoma supplies the drawing, Xsheet, scene, effects, audio,
rendering, and undo foundations. Cudamation2D adds a stable automation layer,
CLI, MCP server, AI workflows, and production provenance.

Internal `toonz` and `Tahoma2D` names remain until changing them provides user
value. This minimizes upstream merge conflicts. User-visible product identity
is Cudamation2D.

## One command path

The UI, CLI, MCP server, and AI tools must call the same typed operations.
Tahoma's `CommandManager` remains an interface adapter for menus and shortcuts;
its `MI_*` identifiers are not part of the automation API.

The in-process automation service owns validation, structured results, revision
checks, and undo boundaries. Mutations execute on the Qt application thread.

## Transport

The desktop application exposes the automation service only through a local
socket. The native CLI uses Tahoma's existing local IPC foundation and emits
newline-delimited JSON on standard output. The MCP server invokes the same CLI
contract initially; it may use the local socket directly later without changing
the operation schemas.

No network listener, remote authentication, cloud dependency, or public plugin
ABI is part of the first version.

## Protocol version 0

Every request contains:

- `protocolVersion`: `0`
- `id`: caller-supplied request identifier
- `method`: stable dotted operation name
- `params`: operation-specific object
- `ifRevision`: optional optimistic concurrency guard

Every successful response contains the same request identifier, a `result`, and
the resulting scene `revision` when a scene is active. Every failure contains a
stable error `code`, a human-readable `message`, and optional structured
`details`.

Version 0 is private and may change until the first complete vertical slice is
accepted. Version 1 becomes the compatibility boundary for external tools.

## First vertical slice

The first build adds only:

1. `system.describe` — product, protocol, and capability discovery.
2. `scene.inspect` — active scene path, dirty state, frame count, and column
   count.
3. A `cudamation2d` CLI that invokes both operations and returns JSON.
4. Contract tests for success, invalid requests, unavailable scenes, and unknown
   methods.

This slice is read-only. Scene mutation, undo, save, render, MCP, and AI are
added only after this path works identically on macOS, Windows, and Linux.

## Migration rule

Code from the former Rust studio is ported only when it provides capability
Tahoma does not already have. The old repository remains migration evidence;
it is not linked wholesale into Cudamation2D.
