# Level Up Details

> Source: KeyBlade999, *Soul Blazer – Guide and Walkthrough* (GameFAQs, SNES, final version 09/05/2013). Converted to Markdown; screenshots omitted. See [README](README.md).

## Stat Changes

We'll be covering two things when it comes to this section. First we'll deal with the actual stat changes. As you defeat enemies, you'll earn EXP., and earning enough will bring you to the next level. This act is required to use some of the more powerful weaponry in the game and, of course, to end up boosting your power to fight the stronger enemies as you proceed through the game. This game is not statistically complex, though.

- **Level:** A general ranking of your power, it maxes at 50.

- **Max HP:** How much health you have, shown at the top of the screen. There are fifty units in that bar; as it goes into newer colors, you won't see the HP go down until it returns to dark blue. However, each color adds ten more HP total, up to white. This maxes out at 100 around Level 47; growth generally follows a pattern of (Level * 2 + 6).

- **Strength:** Your offensive power, it is further augmented with good swords. The unequipped Strength maxes at 13 around Level 24 (25 with the Soul Blade and 50 with the Power Bracelet). The growth follows a pattern of (Level/2 + 1), where the division is truncated first if needed.

- **Defense:** Your resistance to damage, it is further helped with good armor. The unequipped Defense maxes at 12 around Level 25 (24 with the Soul Armor, and 48 with the Shield Bracelet). As for its growth, it follows a pattern of (Level/2 - 1), with the division being rounded up first if needed. (Defense will not go below zero for example.)

- **Experience Points:** EXP., it is earned from beating enemies. Measured are the current EXP. level and the amount to reach the next level. There is no regular growth pattern, unusually. The value maxes at 99,999,999 (Level 50). It is a four-byte stat located at `0x7E1B78` in the RAM. (That's about the only RAM address I know right now. It's a bit complicated in that each byte has to be altered to read in decimal the desired output on the screen in hexadecimal. Like if I want 99, I alter the byte to 153.)

As usual, in general, the "Now" column denotes the stat at that level and the "+/-" column denotes the change from the previous level. Note that these are slightly approximated in HP, Strength, and Defense, and averaged out from several Level-50 grinds.

| Level | Max HP (Now) | Max HP (+/-) | Strength (Now) | Strength (+/-) | Defense (Now) | Defense (+/-) | EXP. (Current) | EXP. (Next Level) |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Level 1 | 8 | - | 1 | - | 0 | - | 0 | +100 |
| Level 2 | 10 | +2 | 2 | +1 | 0 | ±0 | 100 | +180 |
| Level 3 | 12 | +2 | 2 | ±0 | 1 | +1 | 280 | +300 |
| Level 4 | 14 | +2 | 3 | +1 | 1 | ±0 | 580 | +420 |
| Level 5 | 16 | +2 | 3 | ±0 | 2 | +1 | 1,000 | +1,000 |
| Level 6 | 18 | +2 | 4 | +1 | 2 | ±0 | 2,000 | +1,200 |
| Level 7 | 20 | +2 | 4 | ±0 | 3 | +1 | 3,200 | +1,300 |
| Level 8 | 22 | +2 | 5 | +1 | 3 | ±0 | 4,500 | +1,300 |
| Level 9 | 24 | +2 | 5 | ±0 | 4 | +1 | 5,800 | +1,800 |
| Level 10 | 26 | +2 | 6 | +1 | 4 | ±0 | 7,600 | +2,000 |
| Level 11 | 28 | +2 | 6 | ±0 | 5 | +1 | 9,600 | +2,800 |
| Level 12 | 30 | +2 | 7 | +1 | 5 | ±0 | 12,400 | +2,600 |
| Level 13 | 32 | +2 | 7 | ±0 | 6 | +1 | 15,000 | +4,000 |
| Level 14 | 34 | +2 | 8 | +1 | 6 | ±0 | 19,000 | +6,000 |
| Level 15 | 36 | +2 | 8 | ±0 | 7 | +1 | 25,000 | +7,000 |
| Level 16 | 38 | +2 | 9 | +1 | 7 | ±0 | 32,000 | +10,000 |
| Level 17 | 40 | +2 | 9 | ±0 | 8 | +1 | 42,000 | +17,000 |
| Level 18 | 42 | +2 | 10 | +1 | 8 | ±0 | 59,000 | +24,000 |
| Level 19 | 44 | +2 | 10 | ±0 | 9 | +1 | 83,000 | +32,000 |
| Level 20 | 46 | +2 | 11 | +1 | 9 | ±0 | 115,000 | +45,000 |
| Level 21 | 48 | +2 | 11 | ±0 | 10 | +1 | 160,000 | +60,000 |
| Level 22 | 50 | +2 | 12 | +1 | 10 | ±0 | 220,000 | +80,000 |
| Level 23 | 52 | +2 | 12 | ±0 | 11 | +1 | 300,000 | +120,000 |
| Level 24 | 54 | +2 | 13 | +1 | 11 | ±0 | 420,000 | +150,000 |
| Level 25 | 56 | +2 | 13 | ±0 | 12 | +1 | 570,000 | +190,000 |
| Level 26 | 58 | +2 | 13 | ±0 | 12 | ±0 | 760,000 | +190,000 |
| Level 27 | 60 | +2 | 13 | ±0 | 12 | ±0 | 950,000 | +250,000 |
| Level 28 | 62 | +2 | 13 | ±0 | 12 | ±0 | 1,200,000 | +300,000 |
| Level 29 | 64 | +2 | 13 | ±0 | 12 | ±0 | 1,500,000 | +350,000 |
| Level 30 | 66 | +2 | 13 | ±0 | 12 | ±0 | 1,850,000 | +400,000 |
| Level 31 | 68 | +2 | 13 | ±0 | 12 | ±0 | 2,250,000 | +450,000 |
| Level 32 | 70 | +2 | 13 | ±0 | 12 | ±0 | 2,700,000 | +500,000 |
| Level 33 | 72 | +2 | 13 | ±0 | 12 | ±0 | 3,200,000 | +550,000 |
| Level 34 | 74 | +2 | 13 | ±0 | 12 | ±0 | 3,750,000 | +650,000 |
| Level 35 | 76 | +2 | 13 | ±0 | 12 | ±0 | 4,400,000 | +600,000 |
| Level 36 | 78 | +2 | 13 | ±0 | 12 | ±0 | 5,000,000 | +1,000,000 |
| Level 37 | 80 | +2 | 13 | ±0 | 12 | ±0 | 6,000,000 | +1,200,000 |
| Level 38 | 82 | +2 | 13 | ±0 | 12 | ±0 | 7,200,000 | +1,300,000 |
| Level 39 | 84 | +2 | 13 | ±0 | 12 | ±0 | 8,500,000 | +1,500,000 |
| Level 40 | 86 | +2 | 13 | ±0 | 12 | ±0 | 10,000,000 | +2,500,000 |
| Level 41 | 88 | +2 | 13 | ±0 | 12 | ±0 | 12,500,000 | +3,300,000 |
| Level 42 | 90 | +2 | 13 | ±0 | 12 | ±0 | 15,800,000 | +3,700,000 |
| Level 43 | 92 | +2 | 13 | ±0 | 12 | ±0 | 19,500,000 | +5,500,000 |
| Level 44 | 94 | +2 | 13 | ±0 | 12 | ±0 | 25,000,000 | +9,000,000 |
| Level 45 | 96 | +2 | 13 | ±0 | 12 | ±0 | 34,000,000 | +12,000,000 |
| Level 46 | 98 | +2 | 13 | ±0 | 12 | ±0 | 46,000,000 | +13,000,000 |
| Level 47 | 100 | +2 | 13 | ±0 | 12 | ±0 | 59,000,000 | +13,000,000 |
| Level 48 | 100 | +2 | 13 | ±0 | 12 | ±0 | 72,000,000 | +13,000,000 |
| Level 49 | 100 | +2 | 13 | ±0 | 12 | ±0 | 85,000,000 | +14,999,999 |
| Level 50 | 100 | +2 | 13 | ±0 | 12 | ±0 | 99,999,999 | - |

## Level Grinding

Okay, so this is one of the few games I've played - perhaps the only as of this date? - that requires you to have a certain level by the game's end. In this case, you must be at least Level 24 because you need to wield the Soul Blade so you can use the Phoenix spell. That is normally attainable by game's end. However, that also means beating every enemy in the game usually at least once, not necessarily something everyone wants to do. Thusly, there are two main methods I'll mention for how to grind for EXP.

As a note, this has a lot of math. To help you out, the "Quick Method" is about 24,000 times faster than the "Slow Method". No joke.

### Slow Method

This method is the one in which you are not obligated to do anything beyond taping down a turbo controller button, but the amount of EXP. earned per unit of time is rather minimal. There is a monster lair in the Lostside Fire Shrine that can be beaten to reveal a Fairy Gem that gives 1 EXP. per time spoken to - do note that you need the Zantetsu Sword to beat the lair. In the end, it takes about ten seconds to get 1 EXP. Here's the math on the matter...

| Unit of Time | Amount in Seconds | Average EXP. Earnings | % of Level 50 EXP. (99,999,999) |
| --- | --- | --- | --- |
| 1 second | 1 second | 0.1 EXP. | 0.000000100000001% |
| 10 seconds | 10 seconds | 1 EXP. | 0.000001000000010% |
| 1 minute | 60 seconds | 6 EXP. | 0.000006000000060% |
| 5 minutes | 300 seconds | 30 EXP. | 0.000030000000300% |
| 10 minutes | 600 seconds | 60 EXP. | 0.000060000000600% |
| 30 minutes | 1,800 seconds | 180 EXP. | 0.000180000001800% |
| 1 hour | 3,600 seconds | 360 EXP. | 0.000360000003600% |
| 2 hours | 7,200 seconds | 720 EXP. | 0.000720000007200% |
| 4 hours | 14,400 seconds | 1,440 EXP. | 0.001440000014400% |
| 6 hours | 21,600 seconds | 2,160 EXP. | 0.002160000021600% |
| 12 hours | 43,200 seconds | 4,320 EXP. | 0.004320000043200% |
| 1 day | 86,400 seconds | 8,640 EXP. | 0.008640000086400% |
| 1 week | 604,800 seconds | 60,480 EXP. | 0.060480000604800% |
| 1 30-day month | 2,592,000 seconds | 259,200 EXP. | 0.259200002592000% |
| 6 30-day months | 15,552,000 seconds | 1,555,200 EXP. | 1.555200015552000% |
| 1 year | 31,104,000 seconds | 3,110,400 EXP. | 3.110400031104000% |
| 31.70979166... years | 999,999,990 seconds | 99,999,999 EXP. | 100.000000000000000% |

### Quick Method

This method is not available until late in the game. It requires the use of the Soul Blade and preferably the Soul Armor and Phoenix spell. In the World of Evil, head to the Dazzling Space area on foot - not through the Master's Shrine. As you enter, there are two Wall Tile enemies nearby, plus one further north. You can defeat them all in about five seconds, warp out, and come. They're worth 4,000 EXP. each, making each five-second trip worth 12,000 EXP. The math on this matter...

| Unit of Time | EXP. Earned (Constant Gameplay) | Notes |
| --- | --- | --- |
| 1 second | 2,400 EXP. | |
| 5 seconds | 12,000 EXP. | |
| 10 seconds | 24,000 EXP. | |
| 30 seconds | 72,000 EXP. | |
| 1 minute | 144,000 EXP. | |
| 2.92 minutes | 420,000 EXP. | EXP. for boss minimum (Level 24) |
| 5 minutes | 720,000 EXP. | |
| 10 minutes | 1,440,000 EXP. | |
| 30 minutes | 4,320,000 EXP. | |
| 1 hour | 8,640,000 EXP. | |
| 2 hours | 17,280,000 EXP. | |
| 3 hours | 25,920,000 EXP. | |
| 6 hours | 51,840,000 EXP. | |
| 6.83 hours | 59,000,000 EXP. | Max level-up-based stats (Level 47) |
| 11.57 hours | 99,999,999 EXP. | Maximum level (Level 50) |
| 12 hours | 103,680,000 EXP. | EXP. maxes at 99,999,999 EXP. |
