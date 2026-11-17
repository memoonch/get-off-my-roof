# Roof edge sharpness

The environment was rasterized at 854 × 480 logical pixels and copied into the actor bitmap before the 1.125 stage scaling. Diagonal roof outlines, tile seams, antenna and window reflections therefore inherited low-resolution sampling.

The environment now stays on the Flash display list as vector geometry behind the transparent actor bitmap. Only the original actors and HUD continue through their existing raster renderer. This removes the environment's intermediate low-resolution rasterization while retaining the same art geometry and collision vertices.

Browser validation: Level 1 loads with smoother roof slopes and tile seams; no AVM Error # or VerifyError entries in the current load. Screenshot: `roof-vector-fix.jpg`. Pixelation may remain in the original character sprites until their remaster batch.
