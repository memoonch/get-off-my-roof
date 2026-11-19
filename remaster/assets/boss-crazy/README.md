# Boss Crazy — integrated animations

Approved design: boss-crazy-idle-master-v1.png. Preserves spiral eyes, scruffy head, white foam, pale yellow jacket, loose straps and crooked stance. Built-in imagegen supplied seven six-key sheets. Original prompts are in concept-prompt.txt and animation-prompts.json; transparency cleanup prompt is in transparency-edit-prompt.txt. Landing, hit and death use cleaned v2 sheets.

Original reference is symbol 994, idle frame 19, exported at 6× in docs/boss-crazy-original/. Original visible bounds are 582 × 499 pixels: 83⅙ logical pixels tall, matched with 249.5-pixel height at 3×. Frames use the original 110 × 100 logical capture, prepared as 330 × 300 cells. The atlas is 1980 × 2100, retained for review. Production now repacks Crazy and Bomber cells without resampling into boss-bomber/combined-wide-boss-atlas.png (2310 × 3600, 7 columns), loaded separately from the other boss and regular pigeon atlases.

Original 30 FPS durations: idle 21, fly 9, hop 9, landing 19, attack 12, hit 13, death 18 frames. The manifest maps each original frame to an illustrated key; original AnimationPlayer still controls events. Entity health 28, resistance 12, AI, collision, movement and projectile logic remain unchanged.

Rebuild art with pwsh -NoProfile -File tools/prepare-boss-crazy-assets.ps1, then node tools/build-remaster.cjs. Create a separate test movie using node tools/make-boss-crazy-qa.cjs; only this QA movie's Day 1 XML is replaced, leaving release campaign data intact.

Review: http://127.0.0.1:8123/boss-crazy-preview
Isolated QA: http://127.0.0.1:8123/boss-crazy-qa

Validation: release compiled, JavaScript syntax checks and git diff --check passed. Seven-state gallery inspected for transparency and alignment. Separate Day 1 QA movie launched with Boss Crazy and two standard pigeons; observed animated character, costume, rooftop movement, original droppings and player rock throwing. No captured AVM/VerifyError or sprite-load errors. Full boss defeat and campaign progression were not tested. Screenshots: docs/boss-crazy-animation-review.jpg and docs/boss-crazy-gameplay.jpg.
