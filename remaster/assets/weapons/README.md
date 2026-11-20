# Weapon redesign — integrated

Built-in imagegen created a matching set of the 18 weapons listed in the original shop data: nine melee and nine throwable weapons. Original references were exported from preserved source SWF icons into docs/weapons-original/. The approved player supplies the cartoon rendering style.

Melee: newspaper, broom, golf club, mop, fan rake, baseball bat, pool cue, nunchucks, shovel.

Throwables: rock, handful of five rocks, tennis ball, water balloon, gold star yo-yo, vinyl record, firecracker, baseball, boomerang.

Each design is saved as a separate transparent 512 × 512 PNG in icons/. Full generated sheets are melee-design-sheet-v1.png and projectile-design-sheet-v1.png. Exact prompts: melee-prompt.txt and projectile-prompt.txt. Mapping and status: manifest.json. Recreate individual crops with pwsh -NoProfile -File tools/prepare-weapon-designs.ps1.

Preview: http://127.0.0.1:8123/weapons-preview. Cards show both a large design and a 48-pixel inventory-sized preview.

The approved designs are integrated into the release SWF: 18 inventory/shop icons, nine melee sprites and eight projectile sprites (the handful of rocks shares the rock). Original local bounds, grip positions, frame counts and labels are preserved. Collision, range, damage, projectile speed, rotation and abilities retain their original code. Generated sheet sizes are normalized during preparation; they are not gameplay dimensions. See INTEGRATION.md for preparation and verification details.

The source also contains unused/extra art such as WhipIcon, SlingshotIcon and BigRockIcon. The active projectile registration includes RockSlingshot, but it is absent from the shop list. These are outside this 18-item shop batch and must be audited before declaring all weapon-related resources finished.
