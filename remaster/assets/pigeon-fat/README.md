# Fat pigeon — integrated animation assets

`fat-pigeon-idle-master-v1.png` is a built-in imagegen remaster of original symbol 831 idle frame 18. Exact prompt: `concept-prompt.txt`. Reference 1 was the original export in `docs/fat-pigeon-original/`; reference 2 was the approved standard pigeon v2, for rendering style only.

The design was approved. Seven animation states are integrated for gray, black and brown fat pigeons. The standing master supplies the two-frame idle; six generated sheets supply flight, hop, landing, attack, hit and death. Exact built-in imagegen prompts are in `animation-prompts.json`.

Original symbol 831 timing at 30 FPS: idle 2 frames, fly 8, hop 9, landing 21, attack 12, hit 14, death 10. Original idle visible bounds measured at 6×: 304 × 358, approximately 50.7 × 59.7 logical pixels. Prepared cells are 270 × 240, displayed at one-third scale on the original 90 × 80 logical canvas, matching the 59.7px height. The approved art retains its own aspect ratio. Foot anchor local y=30. Six illustrated keys are held across each action's original timing; idle holds the approved neutral art.

Run `tools/prepare-fat-pigeon-assets.ps1`, then `node tools/build-remaster.cjs`. Preparation writes `pigeon-atlas.png` for review and `combined-pigeon-atlas.png` for embedding. Standard pigeon frames are padded without moving their original registration. PigeonRenderer selects fat rows only for FatPigeon, BlackFatPigeon and BrownFatPigeon. Existing AI, health, damage, event transitions, wet effects and variant color offsets remain in use; bosses and other families use their existing art.

Review all states at `/fat-pigeon-preview` with pause/frame-step. Evidence: `docs/fat-pigeon-animation-review.jpg`, `docs/fat-pigeon-gameplay.jpg` and `docs/black-fat-pigeon-gameplay.jpg`. Day 6 confirmed gray fat and standard pigeons together with correct roof contact; projectile scoring, incoming damage, level failure and replay were exercised. The final build was also checked on Day 7 with black fat pigeons and progressed into wave 2 with scoring. Current-load logs had no AVM or sprite load errors. Short hit/death frames were reviewed in the gallery rather than individually captured in gameplay; brown selection is implemented but was not separately exercised in this pass.

Replay testing exposed an original particle callback arriving after its display renderer was disposed. The ParticleEffectDisplay override now guards the absent renderer while still disposing the completed effect.
