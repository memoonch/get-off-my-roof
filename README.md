# Get Off My Roof — remaster research

The playable art batches update the house, sky and garden, all eight illustrated player states, all five regular pigeon families (gray/black/brown), Boss Rocky with eight states including rock throw, Boss Fat with seven states, Boss Soldier with the approved medal design, Boss Crazy and Boss Bomber; each has seven states. All 20 pigeon types now have remastered animation art. See the README/integration notes in each asset folder. All 18 shop weapons now have redesigned icons and gameplay art. Effects, HUD and menus remain pending.

The current remaster presentation is **960 × 540 (16:9)**, with extended scenery, a right-aligned HUD, proportionally scaled artwork, and original gameplay coordinates. See `docs/widescreen.md` for implementation details.

The original Flash game has been decompiled for asset and gameplay research. The first remaster build removes unwanted menu buttons while preserving the original gameplay code.

Build with `node tools/build-remaster.cjs`, then preview with `node tools/preview-server.cjs` at `http://127.0.0.1:8123/`. The output is `build/get-my-roof-remaster.swf`. Credits, Add This Game to Your Website, and Play More Games placements are collapsed to zero scale, preserving linked objects required by existing scripts. Play More Games is also hidden on pause/results screens and can be restored later. Original source and decompiled reference exports remain intact.

- `source/get-my-roof.swf`: preserved input SWF.
- `decompiled/scripts`: 702 recovered ActionScript 3 files.
- `decompiled/shapes`: 371 vector SVG shapes.
- `decompiled/images`: 24 bitmap images.
- `decompiled/sounds`: 94 exported audio resources.
- `decompiled/fonts`: 10 exported fonts.
- `decompiled/texts`: 240 text resources.
- `decompiled/symbolClass/symbols.csv`: symbol IDs and ActionScript linkage names.
- `decompiled/binaryData`: 30 original embedded data resources.
- `decompiled/timeline/get-my-roof/get-my-roof.xfl`: reconstructed editable Flash timeline project.
- `docs/data`: readable XML copies of all 30 embedded data resources.
- `docs/asset-audit.md`: findings and remaster considerations.
- `docs/asset-manifest.json`: file inventory and SWF metadata.
- `docs/bitmap-contact-sheet.png`: visual overview of the bitmap assets.

Regenerate the inventory with `node tools/inspect-swf.cjs` from this directory. See the audit for decompiler commands and limitations.

The remaster opens directly to the main menu once the SWF is loaded, skipping the FOG sponsor preloader, logos, audio and Continue screen. The legacy API remains available for existing score/results code, but its preloader is never started. A custom loader can be added later. Startup also retains the duplicate-initialization guard that fixes the level white screen; see `docs/white-screen-fix.md`. Building requires Java and JPEXS; `FFDEC_JAR` can override the default installation path.

A small top-left FPS counter is embedded in the remaster SWF. It samples actual stage ENTER_FRAME events over one-second windows and displays current FPS / 30 (the original target). It stays visible across menus, gameplay and pause screens and does not intercept input.

Idle performance investigation and validation: see docs/performance-idle-investigation.md. The release now bounds delayed simulation catch-up and explicitly stops/disposes completed particle effects and render buffers.
