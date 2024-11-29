/* 
Predicado: piece/2
Tipo: Constructor
Dominio: Color (String) X Ficha (Carácter)
Recorrido: Ficha
Descripción: Genera una ficha a partir del color especificado, representando la ficha como el primer carácter del color. Utiliza predicados auxiliares para descomponer el string y extraer su primer carácter.
*/

piece(Color,C):-
    descomponer_string(Color,ListaColor),
    tomar_primer_string(ListaColor,C).

%-----------------------------------------------

descomponer_string(String, ListaCaracteres) :-
    atom_chars(String, ListaCaracteres).

tomar_primer_string([Cabeza|_],Cabeza).

