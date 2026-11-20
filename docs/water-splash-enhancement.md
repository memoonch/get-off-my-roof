# Original water splash enhancement

The original blue vector splash is preserved. Symbol 843 and its shape 842 are byte-for-byte identical to the preserved source, as are the original feather symbols 152/153. No generated replacement, extra droplet, glow, outline or splash flash is added.

WaterExplosionEffect, its parameters and the balloon's impact/disposal trigger are unchanged. The original default burst has 20 particles; lifetime, velocity, drift, gravity, rotation, random scale and fading retain their existing code.

ParticleRenderer now renders the original water SpriteAsset at display resolution, following each particle's original matrix and color transform. It shares the direct vector layer with feathers but has its own reusable sprite pool. Unused sprites are hidden after rendering and both pools/layer are released on disposal. Other effects continue through the bitmap path. No external assets or PNG decoding are introduced.

Build: `node tools/build-remaster.cjs`.

Comparison: set `EFFECTS_QA=water` and run `node tools/make-weapons-qa.cjs`. The isolated QA movie emits original 20-particle water bursts; `/weapons-qa?weapon=1` selects original bitmap rendering and `weapon=0` selects the sharper display path. Select Day 1. QA labels show live particle count and spread; saving is disabled. Test instrumentation is excluded from the release.

Validation: release compilation and all 35 weapon symbol regression checks passed. Original water artwork was exported and inspected. The original rendering sample showed 20 live particles and 30 FPS. Screenshots are stored in docs/water-splash-original.png and docs/water-splash-enhanced.png. Randomized bursts are sampled at different times, not frame-matched.

The enhanced path also displayed 20 live particles. Successive frames showed a compact initial burst expanding into separated droplets and fading away; docs/water-splash-frames-review.png records the cycle. Gameplay samples were approximately 30 FPS, with no ActionScript errors in the inspected console. This short visual check does not resolve the earlier long-session FPS issue.
