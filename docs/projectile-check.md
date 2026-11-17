# Empty projectile slot check

The running preview had Rock in inventory but no projectile equipped. In Player Setup, dragging Rock onto the number/upper portion of projectile slot 1 equipped it; returning through Main Menu saved the loadout. Starting Day 1 then displayed the Rock icon in slot 1, and mouse input threw visible stones. Evidence: `projectile-fixed.jpg`.

No weapon code changes were needed. An empty slot was already visible in the original preview before the menu patch. The reason the earlier loadout was empty has not been established. The existing Player Setup supports unequipping projectiles by clicking their equipped slot. The original new-player initialization explicitly equips Rock in projectile_1.

If a separate browser profile has an empty loadout, use Player Setup → drag Rock from inventory onto projectile slot 1 → Main Menu to save. Browser profiles have separate local saves.
