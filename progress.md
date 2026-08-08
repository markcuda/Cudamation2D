# Cudamation2D progress

Updated: 2026-08-08

## Current direction

Cudamation2D is a thin downstream Tahoma2D distribution. We use supported
plugins, scripts, and adapters whenever they preserve the complete feature, and
patch Tahoma only where a required automation seam is missing. We do not give
up product capability merely to remain plugin-only.

The fork must stay easy to update from Tahoma. Generic fixes and extension
seams should be offered upstream; Cudamation-specific code stays isolated.

## Repository state

- Repository: `markcuda/Cudamation2D`
- Checkout: `/Users/markcuda/Cudamation2D`
- Active branch: `codex/cudamation2d-bootstrap`
- Latest implementation commit: `c4f14e2e9`
- Branch is clean and pushed to origin.
- `upstream` is fetch-only and points to `tahoma2d/tahoma2d`.
- Product code is still inherited Tahoma2D; CLI, MCP, AI, and the typed
  automation host have not been implemented yet.

The retired custom Rust studio remains at `/Users/markcuda/cudamation-pro` on
branch `codex/tahoma-transition`, commit `59d97ca`. It is migration evidence,
not part of the new application.

## Completed

- Created and locked the public Cudamation2D fork.
- Preserved Tahoma history, licensing, internal names, and platform workflows.
- Ratified the extension-first thin-fork decision in ADR-0001.
- Defined the first read-only automation slice: `system.describe`,
  `scene.inspect`, and a JSON CLI.
- Added `doc/cudamation2d/upstream-sync.md`.
- Added a weekly/manual upstream compatibility workflow. It merges
  `origin/master` and `upstream/master` into the machine-owned
  `codex/upstream-candidate` branch, dispatches macOS/Linux/Windows builds, and
  never merges into the product branch automatically.
- Diagnosed an inherited macOS build defect: libgphoto2 camera modules failed
  to link gettext, the shell script ignored the failure, and Tahoma later
  failed because `gphoto2/gphoto2.h` was never installed.
- Fixed the macOS libgphoto2 build with direct gettext linkage, fail-fast shell
  behavior, and an installed-header guard in commit `c4f14e2e9`.

## Verification

Passed:

- Windows build, packaging, and artifacts: run `31236074511`.
- Linux GCC and Clang builds, packaging, and artifacts: run `31236074510`.
- Apple Silicon build, packaging, and artifacts after the repair: run
  `31238462778`.
- The repaired libgphoto2 step passed on both Apple Silicon and Intel.

Still running when work paused:

- Intel macOS is compiling Tahoma in run `31238462778`:
  https://github.com/markcuda/Cudamation2D/actions/runs/31238462778

The earlier macOS run `31236074506` failed on both architectures at the same
inherited libgphoto2 defect and is superseded by the repaired run.

## Next session

1. Check the Intel job in run `31238462778` and record its final result.
2. If Intel passes, merge `codex/cudamation2d-bootstrap` into `master` without
   rewriting history.
3. Manually run `Cudamation2D Upstream Compatibility` once from `master` and
   confirm that it creates `codex/upstream-candidate` and dispatches all three
   platform workflows.
4. Offer the generic libgphoto2 macOS repair upstream to Tahoma2D.
5. Begin only the first read-only automation vertical slice. Do not start scene
   mutation, MCP, or AI work until the typed in-process operation path and CLI
   work on all three platforms.
