# Boss Fat — integrated animations

Approved original-style design from symbol 985, preserving the enormous round belly, stern eyes, short legs and two wing bars. Source concept: boss-fat-idle-master-v1.png. Generation prompts: concept-prompt.txt and animation-prompts.json.

Seven states use the original 30 FPS durations: idle 2, fly 9, hop 9, landing 19, attack 12, hit 13, death 15 frames. Six keys per action are held according to animation-manifest.json; idle retains the approved neutral pose. Visible idle height matches the original 460 pixels at 6×: 76⅔ logical pixels. Prepared cells are 270 × 270 at 3× resolution.

Rebuild artwork with pwsh -NoProfile -File tools/prepare-boss-fat-assets.ps1, then node tools/build-remaster.cjs. The preparation script combines the unchanged Rocky atlas with Fat into a 1620 × 4050 boss atlas. PigeonRenderer loads this independently from the regular pigeon atlas. Original AnimationPlayer continues to supply timing and events. Health (22), resistance (22), AI, collision, spawning and projectile logic remain unchanged.

Review: http://127.0.0.1:8123/boss-fat-preview
Isolated test: node tools/make-boss-fat-qa.cjs, then http://127.0.0.1:8123/boss-fat-qa. This replaces only Day 1 XML in a separate test movie; release campaign data remains intact.

Verification: release compiled successfully; all seven states inspected on checkerboard transparency; isolated Day 1 started with Boss Fat and two standard pigeons. Observed roof movement, wing animation and original droppings, with no captured AVM/sprite-load errors. Full boss defeat and campaign progression were not tested. Screenshots: docs/boss-fat-animation-review.jpg and docs/boss-fat-gameplay.jpg.
