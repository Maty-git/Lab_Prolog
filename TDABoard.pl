% Constructor del tablero inicial
board([[0,0,0,0,0,0,0],
       [0,0,0,0,0,0,0],
       [0,0,0,0,0,0,0],
       [0,0,0,0,0,0,0],
       [0,0,0,0,0,0,0],
       [0,0,0,0,0,0,0]]).
%------------------------------------------------------------
% Verificar si se puede jugar (si hay algún espacio vacío)
can_play(Tablero) :-
    member(Fila, Tablero),
    member(0, Fila).


%------------------------------------------------------------
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
    vertical_win_1(1, Board, 1, y, Winner).
	%vertical_win_1(1, Board, 1, 0, Winner).

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

%--------------------------------------------------------------
check_horizontal_win(Board,Winner):-
	horizontal_win_1(1,Board,1,r,Winner);
	horizontal_win_1(1,Board,1,y,Winner).
	%horizontal_win_1(1,Board,1,0,Winner).

horizontal_win_1(_,_,_,Ficha,Ficha):-
	Ficha = 0 .

horizontal_win_1(Fila,Board,Columna,Ficha,Winner):-
	Fila =< 6,
	Columna =< 4,
	horizontal_win(Fila,Board,Columna,Ficha,0,Winner).

horizontal_win_1(Fila,Board,Columna,Ficha,Winner):-
	Fila =< 6,
	Columna =< 4,
	ColumnaNueva is Columna + 1,
	horizontal_win_1(Fila,Board,ColumnaNueva,Ficha,Winner).

horizontal_win_1(Fila,[_|Cola],Columna,Ficha,Winner):-
	Fila =< 6,
	Columna = 5,
	FilaNueva is Fila + 1,
	horizontal_win_1(FilaNueva,Cola,1,Ficha,Winner).


horizontal_win(_,_,_,Ficha,Contador,Ficha):-
	Contador = 4 .

horizontal_win(Fila,[Head|Cola],Columna,Ficha,Contador,Winner):-
	elemento_en_columna(Columna, Head, Ficha_espacio),
	Ficha_espacio = Ficha,
	ColumnaNueva is Columna + 1 ,
	ContadorNuevo is Contador + 1 ,
	horizontal_win(Fila,[Head|Cola],ColumnaNueva,Ficha,ContadorNuevo,Winner).

%-------------------------------------------------------------
check_diagonal_win(Board,Winner):-
	diagonal_win_1(1,Board,1,r,Winner);
	diagonal_win_2(1,Board,7,r,Winner);
	diagonal_win_1(1,Board,1,y,Winner);
	diagonal_win_2(1,Board,7,y,Winner).
	%diagonal_win_1(1,Board,1,0,Winner).

diagonal_win_1(_,_,_,Ficha,Ficha):-
	Ficha = 0 .

diagonal_win_1(Fila,Board,Columna,Ficha,Winner):-
	Fila =< 3 ,
	Columna =< 4 ,
	diagonal_win(Fila,Board,Columna,Ficha,0,Winner).

diagonal_win_1(Fila,Board,Columna,Ficha,Winner):-
	Fila =< 3 ,
	Columna =< 4 ,
	ColumnaNueva is Columna + 1 ,
	diagonal_win_1(Fila,Board,ColumnaNueva,Ficha,Winner).

diagonal_win_1(Fila,[_|Cola],Columna,Ficha,Winner):-
	Fila < 4 ,
	Columna = 5 ,
	FilaNueva is Fila + 1 ,
	diagonal_win_1(FilaNueva,Cola,1,Ficha,Winner).

diagonal_win(_,_,_,Ficha,Contador,Ficha):-
	Contador = 4.

diagonal_win(Fila,[Head|Cola],Columna,Ficha,Contador,Winner):-
	elemento_en_columna(Columna, Head, Ficha_espacio),
	Ficha_espacio = Ficha,
	ColumnaN is Columna + 1,
	ContadorN is Contador + 1,
	diagonal_win(Fila,Cola,ColumnaN,Ficha,ContadorN,Winner).


diagonal_win_2(Fila,Board,Columna,Ficha,Winner):-
	Fila =< 3 ,
	Columna > 3 ,
	diagonal_win3(Fila,Board,Columna,Ficha,0,Winner).

diagonal_win_2(Fila,Board,Columna,Ficha,Winner):-
	Fila =< 3 ,
	Columna > 3 ,
	ColumnaNueva is Columna - 1 ,
	diagonal_win_2(Fila,Board,ColumnaNueva,Ficha,Winner).

diagonal_win_2(Fila,[_|Cola],Columna,Ficha,Winner):-
	Fila < 4 ,
	Columna = 3 ,
	FilaNueva is Fila + 1 ,
	diagonal_win_2(FilaNueva,Cola,7,Ficha,Winner).

diagonal_win3(_,_,_,Ficha,Contador,Ficha):-
	Contador = 4.

diagonal_win3(Fila,[Head|Cola],Columna,Ficha,Contador,Winner):-
	elemento_en_columna(Columna, Head, Ficha_espacio),
	Ficha_espacio = Ficha,
	ColumnaN is Columna - 1,
	ContadorN is Contador + 1,
	diagonal_win3(Fila,Cola,ColumnaN,Ficha,ContadorN,Winner).

%-------------------------------------------------------------
who_is_winner(Board,Winner):-
	check_vertical_win(Board,Winner);
	check_horizontal_win(Board,Winner);
	check_diagonal_win(Board,Winner);
	win(0,Winner).
	
win(Ficha,Ficha):-
	Ficha = 0.

%--------------------------------------------

imprimir_tablero([]).  % Caso base: si la lista está vacía, no hacemos nada

imprimir_tablero([Fila|Resto_tablero]):-
    imprimir_fila(Fila),
    nl,
    imprimir_tablero(Resto_tablero).

imprimir_fila([]).  % Caso base: si la fila está vacía, no hacemos nada

imprimir_fila([X|Resto_fila]):-
    write(X),
    write(' '),
    imprimir_fila(Resto_fila).
	
	