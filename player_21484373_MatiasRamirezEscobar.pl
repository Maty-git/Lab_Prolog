/* 
Predicado: player/1
Tipo: Constructor
Dominio: Id (Número) X Nombre (String) X Color (String) X Victorias (Número) X Derrotas (Número) X Empates (Número) X FichasRestantes (Número) X Jugador (Lista)
Recorrido: Jugador
Tipo de Algoritmo: Ninguno (asignación directa)
Descripción: Crea una representación de un jugador como una lista que contiene su ID,
nombre, color de ficha, estadísticas (victorias, derrotas, empates) y el número de fichas restantes.
*/


player(Id, Name, Color, Win, Losses, Draws, Piezas, [Id, Name, Color, Win, Losses, Draws, Piezas]).

%-------------------------------------------------------------
/* 
Predicado: update_stats/3
Tipo: Modificador
Dominio: EstadoJuego X Jugador1 X Jugador2 X NuevosJugadores
Recorrido: NuevosJugadores
Tipo de Algoritmo: Evaluación Condicional
Descripción: Actualiza las estadísticas de los jugadores al final de una partida,
incrementando victorias, derrotas o empates según el resultado del juego.
Determina el ganador del tablero utilizando el predicado `who_is_winner`
y actualiza las estadísticas adecuadamente.
*/


update_stats([[Id1, Name1, Color1, Win1, Losses1, Draws1, Piezas1],[Id2, Name2, Color2, Win2, Losses2, Draws2, Piezas2],Board,_,_],
[[Id1, Name1, Color1, Win1, Losses1, Draws1, Piezas1],[Id2, Name2, Color2, Win2, Losses2, Draws2, Piezas2]],
[Id1, Name1, Color1, Win1N, Losses1, Draws1, Piezas1],[Id2, Name2, Color2, Win2, Losses2N, Draws2, Piezas2]):-
	who_is_winner(Board,Ganador),
	piece(Color1,Colo1),
	Colo1 = Ganador, %significa que jugador 1 gano
	Win1N is Win1 + 1,
	Losses2N is Losses2 + 1.

update_stats([[Id1, Name1, Color1, Win1, Losses1, Draws1, Piezas1],[Id2, Name2, Color2, Win2, Losses2, Draws2, Piezas2],Board,_,_],
[[Id1, Name1, Color1, Win1, Losses1, Draws1, Piezas1],[Id2, Name2, Color2, Win2, Losses2, Draws2, Piezas2]],
[Id1, Name1, Color1, Win1, Losses1N, Draws1, Piezas1],[Id2, Name2, Color2, Win2N, Losses2, Draws2, Piezas2]):-
	who_is_winner(Board,Ganador),
	piece(Color2,Colo2),
	Colo2 = Ganador, %significa que jugador 2 gano
	Win2N is Win2 + 1,
	Losses1N is Losses1 + 1.

update_stats([[Id1, Name1, Color1, Win1, Losses1, Draws1, Piezas1],[Id2, Name2, Color2, Win2, Losses2, Draws2, Piezas2],Board,_,_],
[[Id1, Name1, Color1, Win1, Losses1, Draws1, Piezas1],[Id2, Name2, Color2, Win2, Losses2, Draws2, Piezas2]],
[Id1, Name1, Color1, Win1, Losses1, Draws1N, Piezas1],[Id2, Name2, Color2, Win2, Losses2, Draws2N, Piezas2]):-
	who_is_winner(Board,Ganador),
	Ganador = 0,
	Draws1N is Draws1 + 1,
	Draws2N is Draws2 + 1.

