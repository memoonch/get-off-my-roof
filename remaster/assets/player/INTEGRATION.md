# Illustrated idle and throw integration

Completion update: all eight player states now use illustrated assets. The combined atlas has seven rows (42 poses); run all three preparation scripts, including `prepare-player-completion.ps1`, before building. Details and validation are in `COMPLETION.md`. Earlier trial descriptions below are historical.

Update: walk and jump now use illustrated sprites too. The embedded atlas has expanded to `player-atlas.png` (six columns, three rows); the idle/throw row remains unchanged. Run both asset preparation scripts before compiling. See `MOVEMENT.md`.

Prepared assets are derived from the approved `player-throw-keyposes-v1.png` sheet. `tools/prepare-player-assets.ps1` exports six PNG key poses and an idle PNG, normalizes feet to `(135,240)` in a 270 × 300 canvas, and uses a single scale across all throw poses. The idle uses the first key pose so the transition starts from exactly matching artwork. The larger master idle remains the design reference.

`animation-manifest.json` records source crops, source bounds, scale and anchors. The fourteen-frame/30 FPS throw maps six illustrated keys with held poses; it is not fourteen independently drawn images. Remaining player animation states retain original sprites for the next batch.

The renderer uses the existing animation state machine and timing, with high-resolution PNGs displayed at scale 76/205 (about 0.3707), matching the original visible idle height. It follows world position, scale, visibility and invincibility alpha. Weapon firing, cooldowns and collision data remain unchanged. Sprite graphics are not drawn procedurally.

The build copies script sources into `build/import-scripts`, injects the prepared PNG atlas as base64 into PlayerRenderer, and compiles it into the SWF. PNG decoding is local through Loader.loadBytes; no external sprite request is needed. Until decoding completes the renderer retains the original player artwork. Base64 payloads are generated build output, not hand-maintained source.

Commands: `./tools/prepare-player-assets.ps1`, then `node tools/build-remaster.cjs`. Visual review: `http://127.0.0.1:8123/player-preview`. Game: `http://127.0.0.1:8123/`.

Validation: reviewed normalized transparent atlas and browser animation preview; Level 1 loads the illustrated player and visible stones without AVM Error #, VerifyError or sprite-load failures in the current load. Scoring advanced during play. Screenshots: `docs/illustrated-player-gameplay.jpg`, `docs/illustrated-player-review.jpg`. The original walk/jump/hit/swing/wipe/death art remains a visible temporary fallback, not a completed full animation remaster.
