%constructor
board([[0,0,0,0,0,0,0],
       [0,0,0,0,0,0,0],
       [0,0,0,0,0,0,0],
       [0,0,0,0,0,0,0],
       [0,0,0,0,0,0,0],
       [0,0,0,0,0,0,0]]).
%

can_play(Tablero):-
    member(Fila,Tablero),
    member(0,Fila).

play_piece(Board, Columna, Pieza, NuevoBoard) :-
    reverse(Board, RevBoard),
    revisar_fila(RevBoard, Columna, Pieza, NuevoRevBoard),
    reverse(NuevoRevBoard, NuevoBoard).

revisar_fila([Fila|Resto], Columna, Pieza, [NuevaFila|Resto]) :-
    elemento_en_columna(Columna, Fila, 0),
    poner_la_ficha(Fila, Columna, Pieza, NuevaFila).
revisar_fila([Fila|Resto], Columna, Pieza, [Fila|NuevoResto]) :-
    revisar_fila(Resto, Columna, Pieza, NuevoResto).

poner_la_ficha([_|Resto], 1, Pieza, [Pieza|Resto]).
poner_la_ficha([Elem|Resto], Columna, Pieza, [Elem|NuevoResto]) :-
    ColumnaAux is Columna - 1,
    poner_la_ficha(Resto, ColumnaAux, Pieza, NuevoResto).

elemento_en_columna(1, [Elem|_], Elem).
elemento_en_columna(N, [_|Tail], Elem) :-
    N1 is N - 1,
    nth1(N1, Tail, Elem).











