piece(Color,C):-
    descomponer_string(Color,ListaColor),
    tomar_primer_string(ListaColor,C).


descomponer_string(String, ListaCaracteres) :-
    atom_chars(String, ListaCaracteres).

tomar_primer_string([Cabeza|_],Cabeza).

