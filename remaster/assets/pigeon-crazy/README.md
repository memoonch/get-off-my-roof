# Crazy pigeon — integrated animations

`crazy-pigeon-idle-master-v1.png` is the first design candidate, generated using built-in imagegen. Reference 1: original symbol 923 frame 18 in `docs/crazy-pigeon-original/`. Reference 2: approved standard pigeon v2 for remaster linework/shading only. Exact prompt: `concept-prompt.txt`.

The design was accepted for animation. All seven states are now integrated for CrazyPigeon, BlackCrazyPigeon and BrownCrazyPigeon, preserving spiral eyes, blue drool, scruffy feathers and pink feet. Boss crazy pigeon remains separate. Seven sheets were generated with built-in imagegen; exact prompt set: `animation-prompts.json`.

Original symbol 923 timings at 30 FPS: idle 30 frames, flight 8, hop 9, landing 21, attack 12, hit 13, death 11. Six illustrated keys are held across each original frame range. The original animation player continues updating transitions/events; physics supplies movement and jump height. Existing color offsets and wet/dry effects are preserved.

Original idle alpha bounds measured at 6×: 370 × 343, approximately 61.7 × 57.2 logical pixels. Prepared art matches height uniformly, retaining its own aspect ratio. Original 70 × 65 capture is padded to shared 90 × 80 cells, exported at 3× (270 × 240). Foot anchor: local y=27.5. All sheets have transparent corners and were inspected on checkerboard.

Rebuild: run `tools/prepare-crazy-pigeon-assets.ps1`, then `node tools/build-remaster.cjs`. Prerequisite: soldier combined atlas, which includes standard and fat. Outputs: `frames/`, `pigeon-atlas.png`, `animation-manifest.json`, and `combined-pigeon-atlas.png`. The combined atlas is 3240 × 3360, 12 columns with 168 keys across four families. Prior art retains its registration.

Review `/crazy-pigeon-preview`. `node tools/make-crazy-pigeon-qa.cjs` creates a separate `/crazy-pigeon-qa` movie that replaces only Day 1's XML with two each of gray, black and brown crazy pigeons. The release movie and campaign level data are unchanged; select Day 1 in the test movie to exercise this wave.

Validation: compilation and `git diff --check` passed. All seven states inspected in the animation gallery on checkerboard. The test wave showed gray, black and brown variants together, with hopping/flight, roof contact, projectile throwing and incoming player damage visible. Scoring and individual short hit/death reactions were not separately confirmed in live combat; those poses were reviewed in the gallery. Current-load logs contained no AVM or sprite load errors. Evidence: `docs/crazy-pigeon-animation-review.jpg` and `docs/crazy-pigeon-gameplay.jpg`. Full campaign progression and wet effects were not exercised in this pass.
