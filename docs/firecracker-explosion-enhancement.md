# Original firecracker explosion enhancement

The original explosion sprite 747 and shape 746 are preserved, including their cream/yellow/orange/red gradients and pointed silhouette. The release retains these resources byte-for-byte. The explosion effect, its parameters, firecracker trigger and damage code are unchanged; the original burst emits 20 particles with its existing randomized positions, velocity, rotation, scale, gravity and fade.

ParticleRenderer now renders these original SpriteAssets directly at display resolution. Explosion particles have a separate reusable pool alongside the feather and water pools. Every clip follows its particle matrix and color transform. Unused clips are hidden, and the pool is released with the renderer. No new particle artwork, counts, effects or textures are introduced.

Build: `node tools/build-remaster.cjs`.

Comparison QA: set `EFFECTS_QA=explosion`, then run `node tools/make-weapons-qa.cjs`. Select Day 1 at `/weapons-qa?weapon=1` for the original bitmap path or `/weapons-qa?weapon=0` for display-resolution vectors. This separate movie emits original 20-particle explosions at intervals. QA instrumentation and automatic bursts are excluded from the release; saving is disabled.

Checks: release compilation passed. All 35 weapon symbol registration checks pass. Feather, water and explosion art remains byte-for-byte identical to the original source.

Browser comparison captured both complete burst-to-fade sequences in docs/explosion-original-cycle.png and docs/explosion-enhanced-cycle.png. The original sample ran at 30 FPS; the enhanced samples were in the high twenties to around 30 FPS, with no ActionScript errors in the inspected console. Randomized bursts were sampled at different times, not frame-matched. These are short visual smoke checks, not a resolution of the previously reported long-session performance issue. Representative full screenshots: docs/explosion-original.png and docs/explosion-enhanced.png.

Run `node tools/check-effect-assets.cjs` to protect the original feather, water and explosion artwork during future builds.
