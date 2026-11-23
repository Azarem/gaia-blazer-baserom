; The shared strings of the Fairy Gems of Leo's Laboratory and the common end of all laboratory dialogue (file offsets 147251-147367, SNES $04:BF33-$BFA7, bank 04): the reward text, the return question, both answers and the dialogue erase.
; asciistring_023F33: 'I am watching over the world. Please take this. <name> received EXP!' (ends [FIN][END]; the EXP itself is queued by the script, COP 38). asciistring_023F59: 'Would you like to go back to Dr-Leo's Laboratory?' (ends with [END] so that the Stay / Go back window follows). asciistring_023F7D: 'Good luck.'. asciistring_023F8B: 'Come back to me when you wish to return.'. asciistring_023FA3: the dialogue erase ([12] wait for a key, [08:408]), the target of the [JMP] that ends every NPC string of ll_laboratory_actors and of the two answers here.
; Users: the three Fairy Gems (ll_laboratory_dungeon_actors, ll_town_models_actors) and, for the common end, ll_laboratory_actors. The font prints the full stop as a dash and the apostrophe as a space: 'Dr-Leo s'.
---------------------------------------------

?BANK 04

---------------------------------------------

asciistring_023F33 |[10]I am watching over the[N]world- Please take [N]this- [FIN][02:2] received [N]EXP- [FIN][END]|

asciistring_023F59 |[10]Would you like to go [N]back to Dr-Leo s [N]Laboratory? [END]|

asciistring_023F7D |Good luck- [JMP:&asciistring_023FA3]|

asciistring_023F8B |Come back to me when [N]you wish to return- [JMP:&asciistring_023FA3]|

asciistring_023FA3 |[12][::][08:408][END]|