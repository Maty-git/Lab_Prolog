/* 
Predicado: piece/2
Tipo: Constructor
Dominio: Color (String) X Ficha (Carácter)
Recorrido: Ficha
Tipo de Algoritmo: Ninguno (evaluación directa con predicados auxiliares)
Descripción: Genera una ficha a partir del color especificado, 
representando la ficha como el primer carácter del color.
*/


piece(Color,C):-
    descomponer_string(Color,ListaColor),
    tomar_primer_string(ListaColor,C).

%-----------------------------------------------

descomponer_string(String, ListaCaracteres) :-
    atom_chars(String, ListaCaracteres).

tomar_primer_string([Cabeza|_],Cabeza).

