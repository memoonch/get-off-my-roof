# Original feather enhancement

The generated feather and comic flash were rejected. They remain archived and are not loaded by the release. No PNG atlas is embedded or decoded for this effect.

FeatherBlastEffect.as is restored verbatim from the decompiled original. Original vector symbol 153 (shape 152) is unchanged, including fine shaft lines, fills, bounds, tint, particle count, motion, scale, rotation, fade and hit behavior. The extra stationary flash is removed.

The enhancement is limited to rendering. ParticleRenderer draws original feather MovieClips directly on GameScreen at display resolution instead of flattening them into the low-resolution world bitmap. Each live particle gets an independent pooled clip following its original matrix and color transform. Camera offset and world clipping are preserved. Unused clips are hidden each frame; the pool and layer are released on disposal. Other particle types retain their existing rendering path.

Build: node tools/build-remaster.cjs. The previous hit atlas is not required.

Comparison QA: set EFFECTS_QA=1 and run node tools/make-weapons-qa.cjs. Select Day 1 at /weapons-qa?weapon=1 for the original bitmap path, or /weapons-qa?weapon=0 for native vectors. This isolated movie emits default feather bursts every 2.5 seconds instead of attacking. Its label reports live particle counts. Test controls and labels are excluded from the release; saving is disabled.
