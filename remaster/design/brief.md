# Asset remaster — baseline and first concept

## Selected direction

Polished cartoon, retaining the original humor and character identities (selected by the user). Keep the bald, stocky homeowner in a green top and brown trousers, expressive gray pigeons, rooftop-defense premise, newspaper melee, and thrown rocks. Improve silhouette clarity, linework, shading, scenery depth, and UI readability.

## Existing reference baseline

- Original: `source/get-my-roof.swf`, immutable reference copy.
- Current playable layout: `build/get-my-roof-remaster.swf`, 960 × 540, 30 FPS.
- Scene reference: `docs/widescreen-gameplay.jpg`.
- Player/pigeon first-frame references: `docs/visuals/`.
- Code and reconstructed animation symbols: `decompiled/`.
- Initial resource inventory: `docs/asset-audit.md` and `docs/asset-manifest.json`.
- Current adaptations: direct-to-menu startup, unwanted buttons hidden, extended scenery, right-aligned HUD, original simulation coordinates.

## Visual concept scope

One coherent 16:9 gameplay scene: homeowner at ground level below the house, pigeons on/above the roof, sky and garden across the full width, status panel on the right. Preserve the current scene composition and playfield readability. Do not reinterpret this as a game where the player stands on the roof. Avoid extra gameplay features or sponsor branding.

Use a warm terracotta house, cool blue sky, muted green lawn, clean dark outlines, restrained soft cel shading, readable silhouettes, and a simple charcoal HUD. Preserve the green/brown player identity and gray pigeon identity. The concept is a static visual target, not an implemented replacement or a sprite sheet.

## First replacement trial

Player idle/walk/jump/throw/swing plus other shared states required by its symbol; basic pigeon states; house and sky; newspaper and rock artwork. Preserve existing symbol linkage, frame labels and ranges, animation capture bounds, pivots and attack alignment. Player animation captures are 90 × 100 logical pixels with the existing (1, -20) import offsets; basic pigeon captures are 70 × 58. Full mappings are in `asset-map.md`.

## Behavior checklist

- A/D movement, jumping, melee activation and thrown rocks.
- Feet, hand, weapon and hit-effect alignment throughout animations.
- Pigeon flying, hopping, landing, attacks, damage and death.
- Original collision/spawn boundaries and weapon timing.
- HUD state, health, wetnaps, equipment icons and tutorial overlays.
- Menu navigation, save/load and Level 1 start/restart.
- Full 960 × 540 scene coverage without black bars.

## Milestones

1. Baseline references and first-slice asset map: organized. Full animation motion capture and campaign baseline remain to be checked before their production batches.
2. Scene art direction: polished cartoon selected; `polished-cartoon-concept-v1.png` generated for review using the built-in image tool. Exact prompt: `concept-prompt.txt`.
3. Asset replacement proof: environment pass validated. All eight illustrated player animation states are integrated on their original frame timings, with the corrected original-size target. See `remaster/assets/player/INTEGRATION.md`, `MOVEMENT.md` and `COMPLETION.md`.
4. All five regular pigeon families and all five bosses are integrated (20 of 20 pigeon types). Regular families have seven states and gray/black/brown variants; Rocky has eight states including rock throw; Boss Fat and Boss Soldier each have seven states. Rocky, Fat and Soldier share a separate boss atlas; Crazy and Bomber share a second atlas with padded cells. Test movies exercise locked characters without changing release campaign data. See asset-folder README/integration notes for verification coverage. All 18 shop weapons are integrated with original registrations and attack behavior. Effects remain pending.
5. Interface visual refresh: pending core art direction.
6. Regression checks and packaging: pending implementation. Custom loader and Play More Games return at the end.

## Concept v1 review

The concept shows the intended cleaner cartoon linework, warm house, expressive pigeons, preserved green/brown homeowner identity, and coherent charcoal HUD. It is not installed in the SWF. Production must fit the original collision geometry, character capture bounds, and weapon timing rather than copying the concept's roof/character dimensions literally. Detailed textures should be simplified where necessary for readability at 960 × 540. The first production trial should start with static house/sky artwork before moving to animated characters.
