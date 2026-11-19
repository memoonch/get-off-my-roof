# Player trial: idle and throw

Status: rejected by the user. The PlayerRenderer override has been restored to the original implementation; the rebuilt SWF uses original player art while separate illustrated sprites are developed under `remaster/assets/player/`. The description below documents the abandoned trial.

First playable trial of the approved polished-cartoon homeowner: bald back-view head with ears and neck folds, outlined green sweater with collar/seam/hem, brown trousers, and boots. The feet remain at the existing ground anchor and the head stays near the original hit target.

`PlayerRenderer` draws a vector overlay for `PlayerIdle` and `PlayerThrow`. The original AnimationPlayer continues to run; it still determines state duration, transitions and events. The throwing arm uses the existing fourteen-frame/30 FPS window, with wind-up, overhead extension and follow-through. Weapon firing, cooldown, physics and colliders are untouched.

The new artwork stays on the display list to avoid the low-resolution raster aliasing previously seen on the environment. It follows the renderer's position, scale, visibility and invincibility alpha. Walk, jump, hit, swing, wipe and death still use original sprites in this deliberately limited trial; therefore visual switches between old/new art are expected until the remaining states are remastered. HUD portrait is also still original.

Source: `remaster/scripts/com/getoffmyroof/rendering/PlayerRenderer.as`. Build: `build/get-my-roof-remaster.swf`. Prior build retained at `build/get-my-roof-before-player-trial.swf`.

Validation: build completed; Level 1 displayed the new idle artwork with feet at the ground anchor. Throw input showed the new arm motion and visible rocks; scoring reached 10 points during the trial. No AVM Error # or VerifyError entries were recorded in the current load. Reference screenshots: `docs/player-idle-trial.jpg` and `docs/player-throw-trial.jpg`. This proves the limited visual overlay approach, not completion of the full character animation set.
