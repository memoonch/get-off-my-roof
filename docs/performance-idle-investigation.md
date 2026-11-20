# Idle FPS investigation

User report: FPS can drop below 10 after leaving the game open. Foreground vs background was uncertain. At first inspection the existing visible tab was about 29.6 FPS, with no captured AVM errors. A persistent foreground slowdown was not reproduced, so these findings are confirmed code defects/contributors rather than proof of the sole cause of the report.

## Changes

- Original Ticker accumulated wall-clock time and ran an unbounded while loop. A 60-second gap could demand about 1,818 simulation updates before the next render. The remaster caps pending time to five original fixed steps (165 ms at 33 ms/step). Normal timing and the ordinary fractional remainder are retained; excess stale time is dropped after a stall.
- ParticleEffect.dispose previously nulled the emitter list without stopping the emitters or removing their listeners. Cleanup now detaches effect listeners and calls emitter.stop(), which unregisters the global Flint frame-update listener and kills remaining particles. It is safe to call twice.
- ParticleEffectDisplay.dispose now disposes active effects and the particle renderer. The renderer releases both its bitmap buffers and render listener. Its removeEmitter implementation also checked the old list length instead of the new length, so its empty-renderer cleanup never ran when the last emitter was removed; corrected.
- Preview explicitly sets Ruffle backgroundExecutionMode to none, pausing hidden tabs instead of spending background CPU. This is not a browser-throttling bypass. Browser power saving can still reduce hidden-tab frame rates.

References: https://ruffle.rs/js-docs/master/enums/Config.BackgroundExecutionMode.html and https://developer.chrome.com/blog/timer-throttling-in-chrome-88

## Verification

Release rebuilt with JPEXS. Separate /performance-qa page supplies documented Ruffle suspend/resume controls. Extended suspension recovered to about 30 FPS; observed gameplay timer exceeded five minutes while displaying 30 FPS. A first FPS sample after suspension can include the inactive time and temporarily read low; subsequent one-second windows recover.

node tools/make-performance-stall-qa.cjs creates a separate QA movie from the complete compiled release script set. It injects one minute of clock debt into Ticker.start and counts actual dispatched updates. Observed result: 60s stall: 5 updates (limit 5), with the menu at about 30 FPS. Release clock is never altered by this QA script. The same test movie checks ten particle-display/effect lifecycles for released bitmap buffers and no remaining global update listener. Observed result: PASS, with no runtime errors in that run. An initial 100-lifecycle startup stress experiment hit Ruffle’s execution watchdog; isolated single- and ten-lifecycle checks passed, so the larger startup experiment is not claimed as passing. Checkpoints remain in the QA script for investigation. Evidence: docs/performance-regression-check.jpg and docs/performance-idle-check.jpg.

This was a short local verification, not an hours-long benchmark or a heap/CPU profile. A persistent drop while the game is visibly active still needs measurements on the affected level/device. No claim is made that every possible slowdown is resolved.
