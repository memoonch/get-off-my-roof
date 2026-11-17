# Get Off My Roof — remaster research

The original Flash game has been decompiled for asset and gameplay research. No remaster implementation has been started.

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
