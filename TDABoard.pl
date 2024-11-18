% Constructor del tablero inicial
board([[0,0,0,0,0,0,0],
       [0,0,0,0,0,0,0],
       [0,0,0,0,0,0,0],
       [0,0,0,0,0,0,0],
       [0,0,0,0,0,0,0],
       [0,0,0,0,0,0,0]]).

% Verificar si se puede jugar (si hay algún espacio vacío)
can_play(Tablero) :-
    member(Fila, Tablero),
    member(0, Fila).

% Función para colocar una ficha en la columna asignada
play_piece(Board, Columna, Pieza, NuevoBoard) :-
    reverse(Board, RevBoard), % Invertimos el tablero para colocar la ficha desde la última posición hacia arriba
    poner_ficha_fila(RevBoard, Columna, Pieza, NuevoRevBoard), % Colocamos la ficha en el tablero invertido
    reverse(NuevoRevBoard, NuevoBoard). % Volvemos a invertir el tablero para obtener el tablero actualizado

% Función auxiliar para colocar la ficha en la columna especificada
poner_ficha_fila([Fila|Resto], Columna, Pieza, [NuevaFila|Resto]) :-
    elemento_en_columna(Columna, Fila, 0), % Verificamos si la posición está vacía
    poner_la_ficha(Fila, Columna, Pieza, NuevaFila). % Reemplazamos el 0 con la ficha
poner_ficha_fila([Fila|Resto], Columna, Pieza, [Fila|NuevoResto]) :-
    poner_ficha_fila(Resto, Columna, Pieza, NuevoResto).

% Función auxiliar para reemplazar un elemento en una lista
poner_la_ficha([_|Resto], 1, Pieza, [Pieza|Resto]). % Caso base: si la columna es 1
poner_la_ficha([Elem|Resto], Columna, Pieza, [Elem|NuevoResto]) :- % Caso recursivo: debe llegar a la posición
    ColumnaAux is Columna - 1,
    poner_la_ficha(Resto, ColumnaAux, Pieza, NuevoResto).

% Función auxiliar para obtener el elemento en una columna específica
elemento_en_columna(1, [Elem|_], Elem).
elemento_en_columna(N, [_|Tail], Elem) :-
    N1 is N - 1,
    elemento_en_columna(N1, Tail, Elem).


%--------------------------------------------
check_vertical_win(Board, Winner) :-
    vertical_win_1(1, Board, 1, r, Winner);
    vertical_win_1(1, Board, 1, y, Winner);
	vertical_win_1(1, Board, 1, 0, Winner). % Si no hay ganador, devuelve 0

vertical_win_1(_, _, _, Ficha, Ficha):-
	Ficha = 0 .

vertical_win_1(Fila, Board, Columna, Ficha, Winner) :-
    Fila =< 3, 
	Columna < 8,
    vertical_win(Board, Columna, Ficha, 0, Winner).
	
vertical_win_1(Fila, Board, Columna, Ficha, Winner) :-
    Fila =< 3,
    Columna < 8, % Columnas válidas
    ColumnaNueva is Columna + 1,
    vertical_win_1(Fila, Board, ColumnaNueva, Ficha, Winner).
	
vertical_win_1(Fila, [_|Cola], Columna, Ficha, Winner) :-
    Columna = 8,
    FilaNueva is Fila + 1,
    vertical_win_1(FilaNueva, Cola, 1, Ficha, Winner).
	

vertical_win(_,_,Ficha,Contador,Ficha):-
	Contador = 4 .

vertical_win([Head|Cola],Columna,Ficha,Contador,Winner):-
	elemento_en_columna(Columna, Head, Ficha_espacio),
	Ficha_espacio = Ficha,
	Nuevo_contador is Contador + 1,
	vertical_win(Cola,Columna,Ficha,Nuevo_contador,Winner).

