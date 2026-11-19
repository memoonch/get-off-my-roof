# Boss Bomber — integrated animations

Approved concept: boss-bomber-idle-master-v1.png. Preserves stern exposed eyes, blue goggles raised above the forehead, olive cap and vest, white fleece trim, two flap pockets, central zipper and gray wings. Built-in imagegen supplied six action sheets; the approved idle is held. Prompts: concept-prompt.txt, animation-prompts.json and death-spacing-prompt.txt. Falling uses the v2 sheet to keep poses inside their cells.

Reference: original symbol 902, idle frame 19 exported at 6× in docs/boss-bomber-original/. Original visible height 541 pixels gives 90⅙ logical pixels, matched with 270.5 pixels at 3×. Original nominal capture is 90 × 90; the new art uses transparent padding to 110 × 100 (330 × 300 pixel cells) to preserve full goggles and feet without clipping. Registration anchor is (165,285) in prepared pixels.

Original 30 FPS durations: idle 2, fly 9, hop 9, landing 21, attack 12, hit 13, death 17 frames. Maps in animation-manifest.json retain these durations. Original AnimationPlayer still supplies events. Entity health 30, resistance 10, AI, collision, attacks and campaign data remain unchanged. FPS counter is retained.

Rebuild art: pwsh -NoProfile -File tools/prepare-boss-bomber-assets.ps1
Build game: node tools/build-remaster.cjs
Create isolated test: node tools/make-boss-bomber-qa.cjs
Run preview: node tools/preview-server.cjs

Review: http://127.0.0.1:8123/boss-bomber-preview
Isolated test: http://127.0.0.1:8123/boss-bomber-qa

The standalone atlas is 1980 × 2100. Production packs the unchanged 42 Crazy cells followed by 42 Bomber cells into combined-wide-boss-atlas.png, 2310 × 3600 (7 columns). Both use the shared wide-boss loader. Rocky/Fat/Soldier and regular pigeon atlases remain separate. The QA movie replaces only Day 1 XML in its own SWF; the release campaign stays intact.

Validation: release compile, JavaScript syntax checks and git diff --check passed. All seven states inspected on checkerboard transparency. Separate Day 1 QA movie started with Boss Bomber and two standard pigeons. Observed flight, rooftop movement, original attack effects, player rock throwing and successful replay after player defeat. FPS counter remained visible and returned to 30 FPS after loading. No captured AVM or sprite-load errors (see final browser check). Full boss defeat and release campaign progression were not tested. Screenshots: docs/boss-bomber-animation-review.jpg and docs/boss-bomber-gameplay.jpg.
