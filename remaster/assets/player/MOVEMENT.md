# Illustrated walk and jump

Build update: this script now writes `player-movement-atlas.png` as an intermediate; `prepare-player-completion.ps1` combines it with the remaining actions into the final `player-atlas.png`. All eight states now have illustrated assets.

New sources: `player-walk-keyposes-v1.png`, `player-jump-keyposes-v1.png`. Both were generated with the built-in image tool from the approved master; exact prompts are in `movement-prompts.json`.

`tools/prepare-player-movement.ps1` cuts six poses from each source, uses the same artwork scale as idle/throw, registers horizontal position from the head rather than moving feet, and uses fixed source baselines. Jump tucking/crouching is retained; the script does not stretch poses to equal height or add a second vertical jump trajectory. The game supplies all translation and physics.

The combined `player-atlas.png` contains six columns and three rows: throw/idle, walk, jump. The renderer uses thirteen frames at 30 FPS for both movement animations, matching the original timeline ranges. Walk loops; jump follows the original state's timing and transitions. Six illustrated keys are held across the thirteen timing frames; these are not thirteen unique illustrations.

Rebuild assets with `./tools/prepare-player-assets.ps1` then `./tools/prepare-player-movement.ps1`; compile with `node tools/build-remaster.cjs`. Review all four available states at `/player-preview` on the local server. Remaining original states: swing, hit, wipe-face, death.

Validation: build completed and the combined atlas was visually reviewed. In Level 1, held D input moved the illustrated player right, Space showed the illustrated airborne pose, the player landed, and held A moved left. Subsequent mouse input fired a visible stone. No AVM Error #, VerifyError or sprite-load failures appeared in the current load. Browser review shows all four available animation sets. Screenshots: `docs/player-jump-illustrated.jpg`, `docs/player-movement-tested.jpg`, `docs/player-walk-jump-review.jpg`. Full campaign regression remains pending.
