# Standard pigeon concept

V2 was approved and the standard pigeon is now integrated with all seven animation states. See `INTEGRATION.md` for preparation, timing, coverage and verification. V1 remains rejected history. Later paragraphs describe the earlier concept review stage.

Revision v2: `pigeon-idle-master-v2.png` is the current review candidate. The user rejected v1 as too far from the original. V2 uses original symbol 852 frame 18 directly as the imagegen edit reference, preserving the front-facing pose, wide eyes, open beak and striped wings. Exact built-in imagegen prompt: `concept-v2-prompt.txt`. Original animation frames were exported at 6× into `docs/pigeon-original/` for reference. V2 is not installed in the game yet.

`pigeon-idle-master-v1.png` is the first design for review, generated with the built-in imagegen tool. It is not installed in the game yet. References: current gameplay (`docs/player-swing-corrected.jpg`) for identity and the approved player master for illustration style.

Keep the gray upright silhouette, mischievous eyes, folded wings and pink feet. Production sprites must be registered and measured against the original visible bounds; the 70 × 58 logical capture canvas is not the visible bird size.

Original symbol 852 has seven states at 30 FPS: hop 9 frames, flight 8, idle 33, landing 21, attack 12, death 10, hit 13. Flight, idle, landing and death loop. Retain original animation events, collision geometry, variant color transforms and wet effects when integrating. Bosses and special pigeon types stay separate.

Next after design review: create consistent key poses for these seven states, prepare timed sprite atlas, then integrate and verify the standard pigeon before expanding variants.
