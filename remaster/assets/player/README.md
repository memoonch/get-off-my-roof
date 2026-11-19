# Illustrated player assets

Current status: all eight player states are integrated using separate illustrated PNG frames. The seven-row combined atlas supplies idle, throw, walk, jump, swing, hit, wipe-face and death. See `COMPLETION.md` for the latest build workflow. Historical trial notes follow.

Movement update: illustrated walk and jump are integrated. Sources, individual prepared PNGs, the combined atlas and timing/registration metadata are included. See `MOVEMENT.md`. Hit/swing/wipe/death still use original sprites.

Status: design approved. Aligned idle and throw assets are integrated in the current build. See `INTEGRATION.md`; `frames/` includes the idle, six keys and fourteen timed throw-frame PNGs. Use `/player-preview` on the local preview server to review the animation at a larger size. The original source-draft notes follow.

The code-drawn idle/throw trial was rejected. Its PlayerRenderer override has been restored to the original implementation while separate illustrated assets are developed.

`player-idle-master-v1.png`: transparent illustrated back-view master sprite, generated with the built-in image tool using the approved scene concept as a style and identity reference. This is a candidate production source, not yet installed in the game.

Workflow: lock the master character design, create matching animation poses, verify size/pivots/silhouette consistency, then export individual animation frames and integrate them into the original animation timings. Required sets: idle, walk, jump, throw, melee swing, hit, wipe-face, and death. The existing timing/label map is in `remaster/design/asset-map.md`.

The next throw sheet is a six-key-pose source. It must be checked and prepared into the original fourteen-frame sequence before being called a game-ready animation. No frames have been silently substituted into the playable SWF.

`player-throw-keyposes-v1.png` and `player-throw-keyposes-v2.png` contain the initial six-pose throw source and a cleanup iteration. Both are drafts: normalize registration, check silhouette/scale consistency, and inspect semi-transparent edge haze before frame export. Alpha checks confirmed transparent corner/gap pixels, but that is not proof of clean cutouts across the whole sheet. The exact initial generation prompts and built-in tool mode are recorded in `prompts.json`.
