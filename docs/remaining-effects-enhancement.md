# Record fragments, splatters and face-wiping sparkles

This batch preserves the original artwork and effect logic. VinylRecordExplosionEffect retains its four default fragments, PooSplatterEffect retains its five default gradient dots, and WipeFaceEffect retains its timed sparkle emission, tint, size variation and fading. Hit triggers, character animation, damage and wetnap behavior are unchanged.

The native vector renderer now also handles the original record particle (symbol 962 / shape 961), sparkle (symbol 606 / shape 605), and Flint RadialDot. The SWF artwork is unchanged. RadialDot copies use the original radius, color and blend mode. Every live particle has an independent clip/shape with its original transform and color transform.

Pools are keyed by image class, and by radius/color/blend for gradient dots. Existing feather, water and explosion rendering shares this reusable layer. Unused objects are hidden each frame, and all pools are released on renderer disposal. Other particle types keep their bitmap rendering path. No replacement artwork, additional particles or external texture requests are introduced.

Build: `node tools/build-remaster.cjs`. Regression checks: `node tools/check-effect-assets.cjs` and `node tools/check-weapon-assets.cjs`.

Comparison QA: set `EFFECTS_QA=remaining`, then run `node tools/make-weapons-qa.cjs`. Select Day 1 at `/weapons-qa?weapon=1` for original bitmap rendering, or `weapon=0` for sharper vectors. The separate test movie displays record fragments on the left, splatters in the center, and wiping sparkles on the right. Test emission and labels are excluded from the release; saving is disabled. Individual modes `vinyl`, `splat`, `wipe`, `water`, `explosion` and `feather` are also supported.

Verification: release compilation, JavaScript syntax checks, original effect artwork checks and all 35 weapon registration checks passed. The original and sharper paths were inspected in motion. The enhanced sample showed four record fragments and simultaneous splatter/wipe particles, at approximately 30 FPS, with no ActionScript errors in the inspected console. Captured cycles show fragments and sparkles appearing, moving/fading and clearing between bursts. Natural pigeon splatters can add to the test label's live count. Randomized bursts were sampled at different times, not frame-matched. The earlier long-session FPS issue is not resolved by these short smoke checks.

Proof: docs/remaining-effects-original.png, docs/remaining-effects-enhanced.png, and the corresponding remaining-original-cycle.png / remaining-enhanced-cycle.png contact sheets.
