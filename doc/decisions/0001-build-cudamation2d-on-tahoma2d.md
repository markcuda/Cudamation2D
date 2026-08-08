# ADR-0001: Build Cudamation2D as a Tahoma2D fork

## Status

Accepted

## Date

2026-08-07

## Context

The former Cudamation project proved useful automation concepts—typed
transactions, revisions, provenance, AI jobs, and MCP access—but its custom
Rust/egui desktop application did not provide the breadth or maturity of a
professional animation workstation.

Tahoma2D already provides drawing, painting, Xsheet and timeline editing,
cameras, effects, audio, rendering, stop motion, scripting, undo, and
cross-platform packaging. Rebuilding those capabilities would consume the
project while producing a weaker studio.

The product needs one coherent application, not two applications users must
understand and coordinate.

## Decision

Cudamation2D is a thin downstream fork of `tahoma2d/tahoma2d` with upstream
history preserved. It is the animation workstation and the automation product.

The implementation is extension-first. A capability belongs in a plugin,
script, or external adapter when those supported interfaces can provide the
complete feature. A downstream core patch is allowed when Tahoma exposes no
safe seam for a required capability; Cudamation2D will not drop that capability
merely to remain plugin-only.

Cudamation2D will add one typed operation layer inside the Tahoma application.
The UI, native CLI, MCP server, and AI workflows will share those operations.
Tahoma menu command identifiers are not a public API.

Internal Tahoma and Toonz names remain unless changing them creates direct user
value. User-visible branding changes are isolated from automation behavior so
upstream merges remain manageable.

Generally useful fixes and extension seams should be proposed upstream. The
remaining downstream patch is isolated, measured, and continuously tested
against `upstream/master`. Upstream candidates are never merged into the
product branch automatically.

## Alternatives considered

### Continue the custom Rust studio

Rejected because it would require recreating mature artist workflows before the
automation layer could become useful.

### Keep Cudamation as an external controller for stock Tahoma2D

Rejected as the product architecture because it creates two products and cannot
reliably expose the application state and undo semantics needed by automation.
Separate internal processes remain acceptable implementation details inside one
installed Cudamation2D product.

### Fork Pencil2D

Rejected because its intentionally lightweight feature set leaves more of the
professional animation workstation to build.

## Consequences

- The project inherits Tahoma's C++17, Qt 5, CMake, platform packaging, and
  third-party dependency surface.
- The fork must continually integrate valuable upstream Tahoma fixes.
- A scheduled candidate merge and cross-platform build reveal conflicts before
  an upstream update reaches users.
- Automation must respect Tahoma scene, threading, and undo invariants.
- Existing Rust code is ported selectively; it is not imported wholesale.
- Cudamation-specific interfaces need explicit compatibility and deprecation
  policies before protocol version 1 is published.
