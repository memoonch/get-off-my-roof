# Standard pigeon animation integration

Approved identity: `pigeon-idle-master-v2.png`, based directly on original symbol 852 frame 18. Seven sheets were generated with built-in imagegen; exact prompts are in `animation-prompts.json`. Death v1 contained a partially opaque background; production uses v2, with its edit prompt in `death-transparency-prompt.txt`.

`tools/prepare-pigeon-assets.ps1` creates 42 registered keys in `frames/` and `pigeon-atlas.png` (1260 × 1218). Each cell is 210 × 174, rendered at one-third scale on the original 70 × 58 logical capture canvas. Original idle alpha bounds measured from a 6× export: 179 × 318, or approximately 29.8 × 53 logical pixels. New idle matches the 53px height with uniform scaling, retaining the approved narrower silhouette. Foot anchor is local y=27. Artwork controls poses; physics supplies movement and jump height.

State timing stays at 30 FPS: idle 33 frames, flight 8, hop 9, landing 21, attack 12, hit 13, death 10. Six illustrated keys are held across each original frame range. Original AnimationPlayer remains active for transitions and events. Its sprite hides only when replacement frames are loaded; special pigeon types and bosses retain their existing artwork. Standard gray, black and brown use the new sprite, with the original variant color offsets. Wet/dry filters and renderer disposal are preserved.

`tools/build-remaster.cjs` embeds the PNG in the PigeonRenderer override; no external asset requests are needed. The `/pigeon-preview` route offers all seven animations plus pause/frame-step controls.

Validation: atlas inspected against checkerboard; original idle height measured; SWF compilation passed; Level 1 started and continued into wave 2 with new perched and flying pigeons, hits and scoring visible. Roof foot contact checked. Current-load browser logs contained no `Error #`, `VerifyError`, or sprite load failures. Gallery review covers all seven states; not every short reaction was individually captured during gameplay. Brown/black transformations and wet effects are preserved in code but were not separately exercised in this pass. Evidence: `docs/pigeon-animation-review.jpg` and `docs/pigeon-remaster-gameplay.jpg`.

Rebuild: run `tools/prepare-pigeon-assets.ps1`, then `node tools/build-remaster.cjs`. Originals and rejected concepts remain available for comparison.
