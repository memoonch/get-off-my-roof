# Remaining player animations

Sources: `player-swing-keyposes-v1.png`, `player-hit-keyposes-v1.png`, `player-wipe-keyposes-v1.png`, `player-death-keyposes-v1.png`. Generated with the built-in image tool from the approved master; exact prompts are in `completion-prompts.json`.

Swing correction: production now uses `player-swing-keyposes-v2.png`. The original crossed-arm pose incorrectly put hands over the visible back; v2 puts the swing on the house-facing side, with the torso occluding central hands/forearms. Only small hand portions show at the left/right silhouette edges. The third key has no hands over the back. Exact edit prompt: `swing-correction-prompt.json`. Original v1 is retained as history.

The preparation script preserves the established 76px idle-height target, keeps the same scale for every pose within an action, and retains natural crouching and falling. Death poses register to the ground as the body tips sideways. Faint source cell-edge marks and nearly transparent backdrop pixels are removed during frame export. Weapons are not painted into swing frames; the existing equipped weapon still renders separately.

The seven-row atlas now supplies all eight original player states: idle shares the first throw key; throw, walk, jump, swing, hit, wipe-face and death each have their own six illustrated keys. The keys are held on original frame counts at 30 FPS: throw 14, walk 13, jump 13, swing 12, hit 9, wipe 19, death 9. The original AnimationPlayer still controls state transitions and the death final-frame hold. Gameplay physics, damage, cooldowns, wetnap consumption and collision geometry are unchanged.

Reproduce with `./tools/prepare-player-assets.ps1`, `./tools/prepare-player-movement.ps1`, `./tools/prepare-player-completion.ps1`, then `node tools/build-remaster.cjs`. The preview page `/player-preview` shows all eight states. The HUD portrait is a separate asset and remains original for its interface batch.

Validation: prepared-frame counts match the source timeline (12 swing, 9 hit, 19 wipe, 9 death). Browser gameplay showed the equipped newspaper during W swing, natural health loss, Q restoring health while consuming one wetnap, and the illustrated prone death pose holding beneath the normal Level Failed screen. No AVM Error #, VerifyError or sprite-load failures appeared in the current load. All eight states were also reviewed in the animation gallery. Screenshots: `docs/player-swing-tested.jpg`, `docs/player-wipe-tested.jpg`, `docs/player-death-tested.jpg`, `docs/player-all-states-review.jpg`. This is validation with the starting equipment, not a full campaign or every-weapon regression.

Replay was also checked after the death: the level restarted with full health, wetnaps and the illustrated idle sprite, with no stale corpse left behind.
