; The shared strings of the fairy gems of the Lostside marsh (file offsets 125890-126027, SNES $03:EBC2-$EC4A, bank 03): the reward text with 'I am watching over the world', the return question, both answers and the common end of dialogue.
; asciistring_01EBC2: 'I am watching over the world. Please take this. <name> received EXP!' (the EXP text of the fairies; the 'Light Arrow Magic' fairy has its own text). asciistring_01EBEA: 'Would you like to return to GreenWood?' (ends with [END] so that the Stay / Go back window follows). asciistring_01EC09: 'All right, good luck.' asciistring_01EC1B: 'Come back to me whenever you feel like returning to GreenWood.' asciistring_01EC46: the dialogue box erase ([12], wait, [08:408]), jumped to by nearly every string of the Woods and of the marsh.
; The 'watching over the world' wording is also the Guardian of the Woods' (gw_woods_actors_01D045: 'I have been watching the world for a long time'); the strings print the font's hyphen as '+' and the full stop as '-'.
---------------------------------------------

?BANK 03

---------------------------------------------

asciistring_01EBC2 |[10]I am watching over [N]the world- Please take[N]this- [FIN][02:2] received [N]EXP! [JMP:&asciistring_01EC46]|

asciistring_01EBEA |[10]Would you like to [N]return to GreenWood? [END]|

asciistring_01EC09 |All right, good luck- [JMP:&asciistring_01EC46]|

asciistring_01EC1B |Come back to me [N]whenever you feel like[N]returning to [N]GreenWood- [JMP:&asciistring_01EC46]|

asciistring_01EC46 |[12][::][08:408][END]|