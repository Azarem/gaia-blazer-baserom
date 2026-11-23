; Ending narration, 7 pages, and 'THE END' (file offsets 82322-82863, SNES $02:C192-$C3AF, bank 02). The staff roll string StaffRollText (file offsets 90724-92320, SNES $02:E264-$E8A0) is noted in its own part (batch A8; answers OQ-I029-5).
; 
; === MODEL ===
; The ending actor (gv_obj_ending_sequence_00729D in gv_front_end, meta entry $57) prints EndingPage1Text to EndingPage7Text with a scene change between the fourth and fifth page; TheEndText is printed by gv_obj_the_end_text_01B508 (gv_up_above_trial_room_and_lisa_turbo_actors). The story: Grass Valley at sunset, the creatures looking at the sunset, a light ray that nobody notices, and Lisa alone, who now finds the sunset beautiful and believes she can be happy as her father turned the impossible into the possible.
; 
; === NOTES ===
; - The ending font prints the period as ':' and the comma as '¥' (the extract shows the glyph names).
; - The pages are not quoted by the walkthrough; Grass Valley and Lisa agree with it.
---------------------------------------------

?BANK 02

---------------------------------------------

; Ending page 1: it begins 'Grass Valley at sunset' and ends 'The restored world was beautiful'.
; 
; When: the ending actor (gv_obj_ending_sequence_00729D in gv_front_end), first page.
; Sees: four lines of narration.
; Why: the first of the seven ending pages; EndingPage2Text to EndingPage7Text follow in address order.
; In: PrintTextString with Y = this string.
; Out: [CUR:240] and the lines separated by [N][N][N].

EndingPage1Text |[CUR:240]  Grass Valley at sunset::: [N][N][N]  The glistening ocean::::::: [N][N][N]  The restored world was [N][N][N]  beautiful: |
---------------------------------------------

EndingPage2Text |[CUR:2C0][14:3]All the creatures stopped [N][N][N][14:3]and looked at the beauty [N][N][N][14:3]of the sunset:|
---------------------------------------------

EndingPage3Text |[CUR:240]  One was with his child¥ [N][N][N]  and one was with his friend¥ [N][N][N]  creatures were in awe of [N][N][N]  the scenery:|
---------------------------------------------

EndingPage4Text |[CUR:2C0]  Suddenly¥ a light ray shot [N][N][N]  into the sky:[N][N][N]  However¥ no one noticed it:|
---------------------------------------------

EndingPage5Text |[CUR:2C0][14:3]Lisa was standing all by [N][N][N][14:3]herself:|
---------------------------------------------

EndingPage6Text |[CUR:240][14:3]She used to feel lonely [N][N][N][14:3]when she saw the sunset¥ [N][N][N][14:3]but now¥ she thinks [N][N][N][14:3]it is beautiful:|
---------------------------------------------

EndingPage7Text |[CUR:240]  Just like her father changed [N][N][N]  impossible to possible¥ [N][N][N]  Lisa feels she will be happy [N][N][N]  if she believes:|
---------------------------------------------

; 'THE END'.
; 
; When: gv_obj_the_end_text_01B508 (gv_up_above_trial_room_and_lisa_turbo_actors), at the end of the game.
; Sees: the words THE END in two-row glyphs.
; Why: closes the game.
; In: PrintTextString with Y = this string.
; Out: two-row glyphs at BG3 offset $358.

TheEndText |[09][CUR:358]THE END|
---------------------------------------------

; The staff roll text: the credits scrolled up BG3 after the ending.
; 
; When: printed once by the credits actor of gv_front_end (gv_obj_staff_roll_007638, PHX, Y = this string) through ScrollStaffRollText. After the roll the actor waits $F0 frames (COP [1B]), fades the music (COP [31], track 0), waits $F0 frames again and changes scene with COP [10] to area $00, scene $0D (arrival animation 2, x = y = 0).
; Sees: the credits roll upward: the heading 'The staff of Soul Blazer', then one block per role (scenario, programming, graphics, music composed, arranged, sound, music coordinated, scenario assistant, English text, three staff groups of the Japanese and American company, special thanks, assistant producer, director, producer, publisher), the copyright lines and 'Licensed by NINTENDO' and 'Presented by'.
; Why: the roll is far longer than the 32-row BG3 page; ScrollStaffRollText prints it line by line while scrolling.
; In: n/a (data). 1597 bytes. 218 [N] line breaks (each scrolls the layer 32 pixels in 32 frames, so about 6976 frames, roughly 116 seconds at 60 frames per second, before the end delays); [14:n] indents a line (n tiles, hex) to centre it. The company-name glyph runs (5 and 6 glyphs, printed as symbols such as the run '·"▼ˮ?') are font tiles, not letters (OQ-I010-11).
; Out: n/a. 0 ends the string. Spellings are kept as printed: 'Soul Blader' (second copyright block) and 'COPORATION' (twice); the walkthrough (08-world-of-evil.md) only says 'Enjoy the credits' and does not quote the text (OQ-I010-11, OQ-I030-2).
; Clobbers: n/a.

StaffRollText |[14:3]The staff of Soul Blazer[N][N][N][N][N][N][N][14:4]Scenario written by[N][14:9]Tomoyoshi Miyazaki[N][N][N][N][N][N][N][14:4]Programmed by[N][14:9]Masaya Hashimoto[N][N][N][N][N][N][N][14:4]Graphics designed by[N][14:9]Kouji Yokota[N][14:9]Masahiko Takai[N][14:9]Takeshi Matsumuro[N][14:9]Shintaro Majima[N][N][N][N][N][N][N][14:4]Music composed by[N][14:9]Yukihide Takekawa[N][N][N][N][N][N][N][14:4]Music arranged by[N][14:9]KAZZ TOYAMA[N][N][N][N][N][N][N][14:4]Sound created by[N][14:9]You Himeno[N][N][N][N][N][N][N][14:4]Music coordinated by[N][14:9]AMENITY Co:[N][N][N][N][N][N][N][14:4]Scenario assistant[N][14:9]Tatsuo Hashimoto[N][N][N][N][N][N][N][N][14:4]English Text by[N][14:9]Robert L:Jerauld[N][N][N][N][N][N][N][N][14:4]*►,+-/ staff[N][14:9]Reiko Takebayashi[N][14:9]Akira Kitanohara[N][N][N][N][N][N][N][14:4]·"▼ˮ? staff[N][14:9]Takao Kawaguchi[N][14:9]Keizo Mochizuki[N][14:9]Teruhiko Hanawa[N][14:9]Tetsuro Shimoda[N][14:9]Masahiro Hirasawa[N][14:9]Kenjiro Kano[N][14:9]Yasuko Sekiguchi[N][14:9]Miwako Matsumoto[N][14:9]Keiko Taga[N][N][14:9]Hajime Kanie[N][14:9]Eiichi Hirasawa[N][14:9]Shinji Futami[N][N][N][N][N][N][N][14:4]·"▼ˮ? America staff[N][14:9]Keiji Honda[N][14:9]Tsuneo Morita[N][14:9]Paul Bowler[N][14:9]Paul Handelman[N][14:9]Cherie Hasson[N][N][N][N][N][N][N][N][14:4]Special thanks to[N][14:9]Ryuichi Moriya[N][14:9]Naoki Yasuda[N][14:9]Yoshiaki Ujiie[N][14:9]Shinichi Kouda[N][14:9]Taiki Mochida[N][14:9]Masahiro Endo[N][14:9]Azumi Izumi[N][14:9]Dai Yamamoto[N][14:9]Keiko Hattori[N][14:9]Nobuyoshi Yoshii[N][14:9]Miki Watanabe[N][14:9]Hirotomo Morisada[N][N][N][N][N][N][N][14:4]Assistant producer[N][14:9]Kazunori Takado[N][N][N][N][N][N][N][14:4]Directed by[N][14:9]Masaya Hashimoto[N][N][N][N][N][N][N][14:4]Produced by[N][14:9]Yasuyuki Sone[N][N][N][N][N][N][N][14:4]Published by[N][14:9]Yasuhiro Fukushima[N][N][N][N][N][N][N][14:9]Soul Blazer[N][14:6]Copyright -' 1992[N][14:3]-' 1992 ·"▼ˮ? COPORATION[N][14:3]-' 1992 *►,+-/[N][N][N][N][N][N][N][14:4]Based Upon Soul Blader[N][14:6]Copyright -' 1992[N][14:3]-' 1992 ·"▼ˮ? COPORATION[N][14:3]-' 1992 *►,+-/[N][N][N][N][N][N][N][14:4]Music Copyright -' 1992[N][14:3]-' 1992 Yukihide Takekawa[N][14:3]-' 1992 KAZZ TOYAMA[N][14:3]-' 1992 AMENITY Co:[N][N][N][N][N][N][N][14:5]Licensed by NINTENDO[N][N][N][N][N][N][N][14:6]Presented by ·"▼ˮ?[N][N][N][N]|