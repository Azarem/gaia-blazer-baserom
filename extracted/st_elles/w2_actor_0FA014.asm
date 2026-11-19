?BANK 1F

?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0FA014 {
    COP [14] ( #$00B6, &code_0FA02E )
    COP [14] ( #$009D, &code_0FA027 )
    COP [17] ( &code_0FA031 )
    COP [91]
    RTL 
}

code_0FA027 {
    COP [17] ( &code_0FA03A )
    COP [91]
    RTL 
}

code_0FA02E {
    COP [86]
    RTL 
}

code_0FA031 {
    COP [01] ( &asciistring_0FA03F )
    COP [09] ( #$8502 )
    RTL 
}

code_0FA03A {
    COP [01] ( &asciistring_0FA0D3 )
    RTL 
}

asciistring_0FA03F |[10][02:2] heard [N]a small voice- [FIN]This is St-Elles [N]Palace in the ocean- [FIN]No human can live [N]under the sea- [FIN]Go to the island, [N]Southerta, through the[N]shrine and look for [N]the Bubble Clothing- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0FA0D3 |[10]Listen closely to the [N]advice of the 4 [N]mermaid statues- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|