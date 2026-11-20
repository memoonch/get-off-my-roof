# Weapon integration verification

Release: build/get-my-roof-remaster.swf. All 18 shop designs replace their icons and gameplay graphics (35 SWF symbols). The build and JavaScript syntax checks passed. `node tools/check-weapon-assets.cjs` passes against the compiled release, confirming exact original local bounds, frame counts and labels for every replacement.

Browser checks use a separate weapons-qa.swf, with selected equipment, automatic attacks and saving disabled. All nine equipment pairs were loaded into gameplay. Observed projectile art includes faceted rocks/multi-rock spread, tennis ball, water balloon, yo-yo, vinyl record, firecracker, baseball and boomerang. The original yo-yo tether remains attached; the native melee overlay follows the swing transform. Rake and bat swing screenshots showed grip alignment. Native exported symbol previews were also inspected for newspaper/rock icons, broom and extended nunchucks.

These are rendering smoke checks, not an exhaustive balance or campaign playthrough. The release weapon definitions and attack/physics classes are unchanged. Some later preview runs showed low FPS, including on the main menu; this batch does not establish that the previously reported idle-performance issue is fully resolved. Early gameplay runs showed approximately 30 FPS; the crowded yo-yo test showed 23.6 FPS in one sample. No ActionScript runtime errors appeared in the inspected console logs.

The release Item Shop was opened directly and showed redesigned broom, golf-club and mop icons with the original prices and item descriptions. No purchases were made. The final boomerang gameplay sample returned to 30 FPS and showed differently rotated boomerangs in flight.

Proof images: weapons-broom-gameplay.png, weapons-rake-yoyo-gameplay.png and weapons-boomerang-gameplay.png. Test routes and build instructions are documented in remaster/assets/weapons/INTEGRATION.md. Test-only automatic attacks and invulnerability are excluded from the release.
