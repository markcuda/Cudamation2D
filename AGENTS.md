# Cudamation2D agent instructions

## Repository identity

This checkout is locked to `markcuda/Cudamation2D` using the `markcuda` GitHub
account. Verify `.codex/repo-lock.json`, remotes, and `gh auth status` before
pushes, pull requests, or GitHub API mutations.

`origin` is the Cudamation2D fork. `upstream` is
`https://github.com/tahoma2d/tahoma2d.git` and is fetch-only.

## Product

Cudamation2D is a true Tahoma2D fork. Tahoma supplies the animation workstation;
Cudamation2D adds one typed automation path shared by UI, CLI, MCP, and AI.

Do not expose Tahoma `MI_*` menu identifiers as the automation API. Menu actions
are UI adapters, not stable domain commands. Validate external input at the
automation boundary, return structured errors, and run scene mutations on the
Qt application thread with explicit undo boundaries.

See `doc/cudamation2d/automation-architecture.md` for the active boundary and
first vertical slice.

## Change discipline

- Keep upstream history and license notices intact.
- Prefer additive, focused changes that remain easy to rebase.
- Do not globally rename internal `toonz` or `Tahoma2D` symbols.
- Make user-visible Cudamation2D identity changes separately from automation
  behavior changes.
- Build and verify each increment before starting the next.

## Build

Follow the platform instructions under `doc/` and the matching official CI
script under `ci-scripts/`. The macOS workflow builds both Apple Silicon and
Intel packages.
