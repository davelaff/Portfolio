# Bonk!

A neon-arcade whack-a-mole game built for mobile — clear endless levels by filling the score bar before the timer runs out.

Open `bonk/index.html` in any browser. Single self-contained file: HTML/CSS/Canvas + synthesized WebAudio, no dependencies, no build step.

## How to play
- **Fill the progress bar** to the quota before time runs out to clear the level
- **Bonk any colored critter** for points — every color except purple is safe
- **Grab the golden star critters** for +5 (rare and quick — from level 2 on)
- **Avoid the purple bombs** — each one costs a life, knocks back your progress, and breaks your streak
- **Chain safe bonks** to build a score multiplier (x2 at 5, up to x5); it multiplies your score and carries across levels
- You have **3 lives** (❤︎ in the HUD); lose them all and it is game over. Clearing a level refills one

## Level progression (endless)
- **More holes each level:** 5 → 6 → 7 → 9 → 12
- **New colors unlock** as you climb (green, cyan, gold, orange, pink, blue) — all harmless, so purple is harder to spot in the crowd
- **Multi-ball holes** from level 4: a single hole pops two, then three at higher levels
- **Color-shifting critters** from level 6: some critters cycle through the palette while up — and purple is in the rotation. The rule never changes: don't tap purple. Shifters wear a spinning dashed ring; static bombs get rarer to compensate
- Bombs get more frequent and critters faster the higher you go — the ramp continues past level 6 forever
- Best score is saved locally on your device

## Notes
- Appending `?debug` to the URL exposes a small `window.__bonk` test hook; it has no effect on normal play.
