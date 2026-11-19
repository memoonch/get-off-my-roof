# Boss Soldier — integrated medal design

Approved idle: boss-soldier-idle-master-v2.png. The user-requested red-ribbon gold star medal replaces the original two chest bars; helmet, stern expression, gray plumage and gold epaulettes remain recognizable. Created with built-in imagegen. Prompts: concept-prompt.txt, medal-edit-prompt.txt, animation-prompts.json; falling-sheet cleanup prompts are also saved.

Original reference: symbol 933, idle frame19 exported at6× in docs/boss-soldier-original/. Visible idle bounds 295×489 sourcepixels, so target height81.5 logicalpixels (244.5px at3×). Prepared capture90×90 logicalpixels;270×270 cells. Approved neutral idle holds its original two-frame duration.

Seven animation states preserve original30FPS timings: idle2, fly9, hop9, landing21, attack12, hit13, death15. Maps in animation-manifest.json select six illustrated keys per action. Final falling sheet is v3, with transparent background and poses contained inside their cells.

Rebuild artwork: pwsh -NoProfile -File tools/prepare-boss-soldier-assets.ps1
Build game: node tools/build-remaster.cjs
Create isolated test: node tools/make-boss-soldier-qa.cjs
Run preview server: node tools/preview-server.cjs

Review: http://127.0.0.1:8123/boss-soldier-preview
Isolated test: http://127.0.0.1:8123/boss-soldier-qa

Runtime uses the original AnimationPlayer for gameplay events, with illustrated overlays from an embedded boss atlas. The existing90 Rocky/Fat keys are repacked without resampling, followed by42 Soldier keys, into3240×2970 (12columns). Regular pigeon atlas remains separate. Original entity health24, resistance18, AI, collision, projectile weapons and campaign data remain unchanged. Test movie replaces only Day1 XML in a separate SWF.

Validation: release SWF compiled successfully; JavaScript syntax checks and git diff --check passed. Browser gallery inspected all seven states on checkerboard transparency. Separate Day1 QA movie started successfully with Boss Soldier and two standard pigeons; observed medal, wing poses, rooftop/air movement, original droppings and player rock throwing. Captured console contained no AVM/VerifyError or sprite-load errors. Full boss defeat and campaign progression were not tested. Screenshots: docs/boss-soldier-animation-review.jpg and docs/boss-soldier-gameplay.jpg.
