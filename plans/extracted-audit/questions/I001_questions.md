# I001 open questions (Pass 4, COP system)

IDs are scoped to this iteration. Nothing here is written into notes as fact.

| ID | Question | Evidence so far | How to settle |
|---|---|---|---|
| OQ-I001-1 | `Cop8D_JumpIfBit15Clear` / `Cop8E_JumpIfBit15Set` read a word operand only on the taken path; on the other path they `BRL loc_0064BF` without skipping it. Intended, or a defect that the game never reaches? | Both handlers (`code_005FF7`, `code_00600C`) read as stated; the commands are unused in all 704 extracted blocks, so the game never runs them. `copdef.json` was corrected from size 0 to `&Code` (size 2). | Nothing to settle for gameplay; only matters if a patch uses them. |
| OQ-I001-2 | R-2 (Pass 3 item 3.9): bank-base idioms that depend on the movable block `meta_tables_008000` are still unchecked. | Plan §8c. | Trace the idioms with the emulator and decide whether `meta_tables_008000` must stay `movable: false`. |
| OQ-I001-3 | What do the `$1B1E` entries mean in the game (commands `0A`, `0B`, `18`, `19`)? What do `Cop25_CallLib0276A5`, `Cop26_JumpIfLib0276C9` and `Cop3A_CallLib0124EE` do? | The handlers read as documented in `docs/cop/index.md`; entry numbers are only known by value (e.g. `$38` in `code_0120F9`). | Use the walkthrough item list against the scripts that use `0A`/`0B` (47 and 27 uses), then step the three library routines in Mesen2. |
| OQ-I001-4 | Meaning of actor fields `$16` (other than bit 15, `$0800`, `$2000`, `$0010`, bit 2), `$1A` (`$0080`, `$2000`, `$4000`, `$8000`), `$22`, `$24`, `$2C`, `$34`, `$14`, `$30`. | Only set/test patterns are known. | Needs the actor update loop; do together with the struct inventory (item 2.8). |
| OQ-I001-5 | What is the fixed string `asciistring_014F02` used by `Cop02_PromptFixedString`, and what do the menu-type bytes of `Cop1A_ChoiceMenu` select? | Handlers call `lib_012281` with a menu id; unused (`02`) or not decoded (`1A`). | Read the string; trace `lib_012281`. |
| OQ-I001-6 | Up Above (area 0) scenes `unnamed_0f` .. `unnamed_13` have no name string. What are they? | Names come from `lib_014536_part2.asciistring_list_0147C2`; these location ids have no entry. | Visit them in the emulator, then rename the scene keys. |
| OQ-I001-7 | The handler names are readings of the code, checked by reading, not by a runtime trace. Which names are wrong? | No emulator trace of the COP handlers was done in Pass 4. | Break on the COP dispatcher in Mesen2 for one scene, compare the ids hit with the names. |
