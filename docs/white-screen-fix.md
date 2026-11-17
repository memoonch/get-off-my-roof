# Level 1 white-screen fix

Runtime diagnostics showed repeated `GameComponents: Only initialize once` errors from the sponsor preloader's `loaded` callback. Each duplicate `new GameEngine()` first invokes `Root`'s constructor, which assigns its default null stage argument to the static `Root.stage`, before the singleton rejects the duplicate engine. Subsequent `GameScreen` construction then fails when accessing `Root.stage.focus`. The screen transition has already removed the previous screen, so retries produce Error #2025 from removeChild and leave a white display.

The remaster override in `remaster/scripts/com/getoffmyroof/preloader/FogDevPreloader.as` returns from `afterPreloader` if `GameComponents.instance` already exists. This prevents the duplicate constructor and the stage reset without altering weapon or level behavior.

`tools/build-remaster.cjs` now imports this script with JPEXS after applying menu changes. Set `FFDEC_JAR` if the local installation path differs. The compiled callback was re-exported to `docs/fix-verification/` and checked for the guard. The rebuilt game was reloaded in the browser and Level 1 reached its countdown, then active pigeon waves and tutorial with Rock equipped. Screenshot: `level-one-fixed.jpg`. Browser diagnostic history retains errors from earlier loads; their presence alone does not identify a failure in the current loaded instance.
