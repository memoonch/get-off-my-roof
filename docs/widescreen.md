# 960 × 540 presentation

The SWF stage is now 960 × 540 at 30 FPS. The browser preview uses a responsive 16:9 player, up to its native 960-pixel width.

The original coordinate system remains 640 × 480 for physics, collision, spawn data, weapon parameters, and level scripts. A uniform 1.125 display scale preserves character proportions. The wider logical presentation is 853⅓ × 480. The original playfield is shifted right by 106⅔ logical units (120 physical pixels), and the player information sidebar is moved to the far right. The scene renderer fills the side extensions with background-only sky and environment pixels; actors and projectiles are never mirrored. Static menu backgrounds extend using reflected outer artwork, with controls retained at their original proportions. This is a layout adaptation using existing artwork; these extensions can be replaced by custom art during the visual remaster.

The screen framework positions primary screens and game overlays in the widened presentation. Transparent dimmers and hit areas retain their alpha and behavior. Persistent mute and tutorial controls are scaled/repositioned. Mouse coordinates convert back to simulation coordinates.

Build: `node tools/build-remaster.cjs`. Output: `build/get-my-roof-remaster.swf`. Original SWF and reference exports remain intact. JPEXS header verification is recorded in `widescreen-header.txt`.

Validation: the build completed; JPEXS reported widthPx=960, heightPx=540, frameRate=30. Browser checks covered the main menu, Options overlay, Player Setup, level selection, Level 1 countdown, tutorial transparency, active pigeon waves, and visible rock firing. The current load's runtime log had no AVM Error # or VerifyError entries. Screenshot: `widescreen-gameplay.jpg`. Full campaign progression and every boss/ending screen have not been play-tested.
