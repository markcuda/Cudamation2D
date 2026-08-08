# Upstream maintenance contract

Status: accepted.

## Goal

Cudamation2D keeps every required product capability while continuing to
receive Tahoma2D development. The fork is a compatibility layer around Tahoma,
not an independent rewrite.

## Extension order

For each Cudamation2D capability:

1. Use an existing Tahoma plugin, script, command, or file interface when it
   provides the complete feature safely.
2. Add a small, generally useful extension seam and propose it upstream.
3. Keep a focused Cudamation-only core patch when upstream cannot yet support
   the requirement.

Plugin-only is not a goal. A user-visible feature must not be weakened or
abandoned solely to avoid maintaining a downstream patch.

## Patch discipline

- Keep Cudamation code in dedicated modules wherever Tahoma's build and runtime
  boundaries allow it.
- Avoid broad renames, source moves, formatting churn, and unrelated cleanup.
- Keep UI, CLI, MCP, and AI behavior behind one typed operation layer.
- Submit generally useful fixes and extension points to Tahoma2D.
- Review the diff against `upstream/master` before each release. Every core
  patch must still correspond to a documented product requirement.

The long-term ideal is that upstream accepts every generic seam and the
remaining Cudamation layer could become an ordinary extension suite. The
architecture must permit that outcome without requiring it.

## Integration flow

`upstream` is fetch-only and points to `tahoma2d/tahoma2d`. `origin/master` is
the product line.

The scheduled upstream compatibility workflow merges both lines into the
machine-owned `codex/upstream-candidate` branch and dispatches the inherited
macOS, Linux, and Windows builds. A conflict stops the workflow. A passing
candidate still requires review and a human-controlled merge into `master`.

Use merge commits for accepted upstream updates so their provenance remains
obvious. Never rewrite public product history to make an upstream update fit.

## Cadence

- Run the compatibility workflow weekly and before starting a release.
- Review successful candidates promptly instead of accumulating a large merge.
- Reassess the downstream core patch after each Tahoma release.
- Stop and redesign any Cudamation change that repeatedly conflicts across
  unrelated upstream areas.
