# Bomber pigeon — integrated animations

`bomber-pigeon-idle-master-v1.png` is the initial design candidate, created with built-in imagegen. Reference: original symbol 814 frame 18, exported at 6× under `docs/bomber-pigeon-original/`. Approved standard pigeon v2 supplied rendering style only. Exact prompt: `concept-prompt.txt`.

The design was accepted for animation. Seven illustrated states are integrated for BomberPigeon, BlackBomberPigeon and BrownBomberPigeon. Original aviator cap, pale blue goggles, gray vest, gold badge and pink feet are retained. Boss bomber remains separate. Seven sheets were created with built-in imagegen; exact prompts: `animation-prompts.json`.

Original symbol 814 timing at 30 FPS: idle 34 frames, flight 8, hop 9, landing 21, attack 12, hit 14, death 13. Six keys are held across these original frame counts. AnimationPlayer remains active for original transitions/events; bombing logic, projectiles, collision, damage and effects are unchanged. Color variants use original offsets and wet/dry filters remain in place.

Original idle alpha bounds at 6×: 211 × 306, approximately 35.2 × 51 logical pixels. New art matches 51px height uniformly and retains its approved aspect ratio. The original 65 × 60 capture is padded into 90 × 80 shared cells at 3× (270 × 240), with foot anchor local y=26. `tools/prepare-bomber-pigeon-assets.ps1` writes 42 keys and `pigeon-atlas.png`, then combines all five regular families into `combined-pigeon-atlas.png` (3780 × 3600, 14 columns, 210 keys). Previous family art retains its registration.

Rebuild: prepare the bomber atlas (requires the prepared crazy combined atlas), then run `node tools/build-remaster.cjs`. Review `/bomber-pigeon-preview` with pause/frame-step. `node tools/make-bomber-pigeon-qa.cjs` makes a separate `/bomber-pigeon-qa` movie whose Day 1 XML spawns two each of gray, black and brown bombers. Release movie and campaign data remain intact; select Day 1 to run the test wave.

Validation: SWF compilation and `git diff --check` passed. All seven states were inspected in the checkerboard animation preview. The isolated test wave visibly showed gray/black/brown bombers together, roof contact, attacks/projectiles, incoming damage and the level-failure flow. Current-load logs contained no AVM or sprite-loading errors. Individual short hit/death reactions, scoring and full campaign progression were not separately confirmed in live combat; the animation poses were reviewed in the gallery. Evidence: `docs/bomber-pigeon-animation-review.jpg` and `docs/bomber-pigeon-gameplay.jpg`.
