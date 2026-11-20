# Weapon art integration

The 18 approved shop designs replace 35 native SWF symbols: 18 icons, nine melee sprites and eight projectile sprites. Handful of Rocks reuses RockProjectile. The SWF patch retains symbol IDs, original registration bounds, frame counts, frame labels and linkage. Melee sprites are aligned grip-left/head-right within the original bounds. Nunchucks use a separate extended pose generated with built-in imagegen; its exact prompt is in gameplay/nunchucks-prompt.txt.

Transparent gameplay PNGs and premultiplied ARGB buffers are prepared in runtime/. integration-manifest.json maps each replacement to its original SWF symbol. Lossless bitmap-backed shapes use smooth clipped fills. Three renderer patches display the equipped weapons and projectiles directly on GameScreen, following original transforms and visibility, to avoid the old low-resolution world capture. Original animation players, weapon timing, projectile rotation and yo-yo tether code remain active. Native overlays are removed on disposal; renderer-owned temporary bitmap buffers are released.

Rebuild from the repository root:

```powershell
node tools/weapon-swf-assets.cjs
pwsh -NoProfile -File tools/prepare-weapon-integration.ps1
node tools/build-remaster.cjs
node tools/check-weapon-assets.cjs
```

The structural check reads the compiled release SWF and compares all 35 symbols against the preserved source. It verifies exact original local bounds, frame counts and labels.

For isolated gameplay checks, run `node tools/make-weapons-qa.cjs`, then visit http://127.0.0.1:8123/weapons-qa through the preview server. Select an equipment pair and Day 1. This separate SWF equips that pair, attacks automatically and disables saving; its invulnerability and test wave are not included in the release.

Extra source art (WhipIcon, SlingshotIcon, BigRockIcon and the non-shop RockSlingshot registration) is outside this approved shop batch.
