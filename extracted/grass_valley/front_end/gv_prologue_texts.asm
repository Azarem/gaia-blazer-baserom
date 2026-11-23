; Story narration of the intro, 14 pages (file offsets 80773-82293, SNES $02:BB85-$C175, bank 02).
; 
; === MODEL ===
; The intro actor (code_0066FC in gv_front_end, meta entry $56) prints the pages one after the other in address order, each on its own BG3 position (the [CUR:o] at the start of the page; $240, $280 or $300 depending on the line count). After the last page it warps to scene $0A of area 0, the Mode 7 scene (OQ-I011-4). The story: the Freil Empire under King Magridd, the inventor Dr. Leo, the deal with the king of evil Deathtoll that empties the world, and the Master sending the player to revive it as a Soul Blazer.
; 
; === NOTES ===
; - The text is printed with the intro font: the period prints as '-' and the apostrophe as a blank (the extract shows 'Dr-Leo-'). Line breaks are [N][N][N].
; - The walkthrough does not quote the story; names it shares (Magridd, Leo, Deathtoll, the Master) agree. 'Freil Empire' occurs nowhere else in the project.
---------------------------------------------

?BANK 02

---------------------------------------------

; Intro page 1: 'Wise men tell a tale late at night of a great King destroyed by the temptation of evil.'
; 
; When: the intro actor, first page after the title.
; Sees: four lines of narration.
; Why: sets up the story before the first scene.
; In: PrintTextString with Y = this string; pages 2-14 (IntroPage02Text-IntroPage14Text) follow in address order and are printed in turn.
; Out: [CUR:280] and four lines separated by [N][N][N].

IntroPage01Text |[CUR:280]  Wise men tell a tale late [N][N][N]  at night of a great King [N][N][N]  destroyed by the temptation [N][N][N]  of evil- |
---------------------------------------------

IntroPage02Text |[CUR:280]  The Freil Empire, as it was [N][N][N]  called in those days, [N][N][N]  was ruled by a powerful man, [N][N][N]  King Magridd- |
---------------------------------------------

IntroPage03Text |[CUR:240]  It seems most people thought [N][N][N]  the King was a fair and kind [N][N][N]  ruler- There were some, [N][N][N]  however, who felt the King [N][N][N]  himself was ruled by greed- |
---------------------------------------------

IntroPage04Text |[CUR:240]  One day the King happened to [N][N][N]  overhear two guards talking [N][N][N]  about a man named Dr-Leo- [N][N][N]  Now Dr-Leo was considered [N][N][N]  by all to be a great inventor [N][N][N]  and a genius- |
---------------------------------------------

IntroPage05Text |[CUR:240][14:3]The King stayed up many [N][N][N][14:3]nights wondering how he [N][N][N][14:3]could use this great [N][N][N][14:3]inventor to make him even [N][N][N][14:3]more wealthy-|
---------------------------------------------

IntroPage06Text |[CUR:240]  All of the sudden the King [N][N][N]  had an idea- [N][N][N]  He ordered his guards to [N][N][N]  capture Dr-Leo and bring him [N][N][N]  to the castle at once!|
---------------------------------------------

IntroPage07Text |[CUR:300]  Soon Dr-Leo was brought to [N][N][N]  the castle- |
---------------------------------------------

IntroPage08Text |[CUR:240]  The King confined him in a [N][N][N]  small room and ordered him [N][N][N]  to invent a machine that [N][N][N]  would summon the King of [N][N][N]  evil, Deathtoll-|
---------------------------------------------

IntroPage09Text |[CUR:240]  Dr-Leo finally completed [N][N][N]  the machine- [N][N][N]  The King instantly called [N][N][N]  upon Deathtoll, hoping they [N][N][N]  might strike a deal-|
---------------------------------------------

IntroPage10Text |[CUR:240]  After many days the deal was [N][N][N]  complete- The King would [N][N][N]  bring Deathtoll all living [N][N][N]  creatures, and in return, [N][N][N]  Deathtoll would give him a [N][N][N]  gold piece for each-|
---------------------------------------------

IntroPage11Text |[CUR:280]  One by one, all living [N][N][N]  creatures began to disappear- [N][N][N]  Soon the world was completely [N][N][N]  empty- |
---------------------------------------------

IntroPage12Text |[CUR:280][14:3]Two people were watching [N][N][N][14:3]this catastrophe, [N][N][N][14:3]the Master, and you, [N][N][N][14:3]his follower- |
---------------------------------------------

IntroPage13Text |[CUR:240]  "The King was very foolish [N][N][N]  to be tempted by evil, [N][N][N]  however I will give him [N][N][N]  another chance- You must go [N][N][N]  down to Earth and revive the [N][N][N]  World!ˮ the Master said- |
---------------------------------------------

IntroPage14Text |[CUR:240]  On a ray of light you [N][N][N]  descended to Earth----- [N][N][N]  --A warrior sent to revive [N][N][N]  the living and punish evil- [N][N][N]  A SOUL BLAZER!!|