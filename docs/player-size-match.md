# Illustrated player size correction

Measured the original SWF's idle pose (symbol 778, frame 2) and the prepared illustrated idle using alpha > 32 visible bounds. The original is 50 × 76 logical pixels; the prepared image contains 126 × 205 visible source pixels. At the previous one-third scale that was 42 × 68⅓ logical pixels.

The renderer now uses a uniform scale of 76/205 = 0.3707317, an 11.22% increase. The new visible size is approximately 46.7 × 76. It matches the original height while preserving the approved character's proportions. Its slight width difference reflects the illustration's silhouette; the art is not stretched horizontally.

Idle and every throw pose use the same scale. The source foot anchor (135,240) maps to logical y=20, so enlarging the character does not sink its feet into the ground. Colliders, weapon logic and animation timing are unchanged. Comparison: `player-size-comparison.png`.
