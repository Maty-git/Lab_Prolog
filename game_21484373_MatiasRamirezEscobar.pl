
/* 
Predicado: game/5
Tipo: Constructor
Dominio: Jugador1 X Jugador2 X Tablero X TurnoActual X Historial X Juego
Recorrido: Juego
Tipo de Algoritmo: Ninguno (definición estática)
Descripción: Construye el estado inicial o un nuevo estado del juego Conecta (4).
*/


game(Player1,Player2,Board,Turnoactual,[Player1,Player2,Board,Turnoactual,[]]).
game(Player1,Player2,Board,Turnoactual,Historial,[Player1,Player2,Board,Turnoactual,Historial]).

%----------------------------------
/* 
Predicado: game_history/2
Tipo: Consultor
Dominio: Juego X Historial
Recorrido: Historial
Tipo de Algoritmo: Recursión Natural
Descripción: Obtiene el historial de movimientos realizados durante el juego en orden inverso,
usando el predicado `reverse` para mostrar la secuencia desde el primer movimiento hasta el último.
*/


game_history([_,_,_,_,Historial],H):-
	reverse(Historial,H).

%-----------------------------------
/* 
Predicado: is_draw/1
Tipo: Consultor
Dominio: Juego
Recorrido: Booleano
Tipo de Algoritmo: Fuerza Bruta
Descripción: Determina si el juego ha terminado en empate.
Esto ocurre si no se puede jugar más (tablero lleno) o si ambos jugadores se han quedado sin fichas.
*/


is_draw([Player1,Player2,Board,_,_]):-
	not(can_play(Board));
	(no_tienen_fichas(Player1),
	no_tienen_fichas(Player2)).

no_tienen_fichas([_,_,_,_,_,_,0]).

%------------------------------------------------------------
/* 
Predicado: get_current_player/2
Tipo: Selector
Dominio: Juego X JugadorActual
Recorrido: JugadorActual
Tipo de Algoritmo: Ninguno (evaluación directa)
Descripción: Obtiene el jugador cuyo turno está activo.
*/


get_current_player([Player1,_,_,Turnoactual,_],Player1):-
	1 is Turnoactual mod 2.
get_current_player([_,Player2,_,Turnoactual,_],Player2):-
	0 is Turnoactual mod 2.


%-------------------------------------------------------------
/* 
Predicado: game_get_board/2
Tipo: Selector
Dominio: Juego X Tablero
Recorrido: Tablero
Tipo de Algoritmo: Ninguno (acceso directo)
Descripción: Recupera el tablero actual del estado del juego.
*/


game_get_board([_,_,Board,_,_],Board).

%------------------------------------------------------------
/* 
Predicado: end_game/2
Tipo: Modificador
Dominio: Juego X NuevoEstado
Recorrido: NuevoEstado
Tipo de Algoritmo: Ninguno (evaluación secuencial)
Descripción: Finaliza el juego actual, 
actualizando las estadísticas de los jugadores con el predicado `update_stats` 
y mostrando la información de los jugadores.
*/


end_game([Player1,Player2,Board,Turnoactual,Historial],[P1,P2,Board,Turnoactual,Historial]):-
	update_stats([Player1,Player2,Board,Turnoactual,Historial],
				[Player1,Player2],
				P1,P2),
	write(P1),nl,
	write(P2),nl.
%--------------------------------------------------------------
/* 
Predicado: player_play/4
Tipo: Modificador
Dominio: Juego X Jugador X Columna X NuevoEstadoJuego
Recorrido: NuevoEstadoJuego
Tipo de Algoritmo: Backtracking
Descripción: Realiza un movimiento de un jugador en una columna específica del tablero,
actualiza el historial, verifica si hay empate o un ganador, y actualiza el estado del juego.
Utiliza backtracking.
*/
%caso de si juega el player 1 y resulta en empate
player_play([Player1,Player2,Board,Turnoactual,Historial],Player,Column,Newgame2):-
	corresponde_player(Player1,Player),
	not(no_tienen_fichas(Player1)),
	get_current_player([Player1,Player2,Board,Turnoactual,Historial],Cp),
	corresponde_player(Cp,Player),
	saber_color(Player,Color),
	piece(Color,Ficha),
	play_piece(Board,Column,Ficha,Newboard),
	actualizar_historial(Column,Color,Historial,Newhistorial),
	Newturno is Turnoactual + 1,
	restar_fichas(Player1,NP1),
	game(NP1,Player2,Newboard,Newturno,Newhistorial,Newgame),
	is_draw(Newgame),
	end_game(Newgame,Newgame2),
	imprimir_tablero(Newboard), nl.
%caso de si juega el player 2 y resulta en empate
player_play([Player1,Player2,Board,Turnoactual,Historial],Player,Column,Newgame2):-
	corresponde_player(Player2,Player),
	not(no_tienen_fichas(Player2)),
	get_current_player([Player1,Player2,Board,Turnoactual,Historial],Cp),
	corresponde_player(Cp,Player),
	saber_color(Player,Color),
	piece(Color,Ficha),
	play_piece(Board,Column,Ficha,Newboard),
	actualizar_historial(Column,Color,Historial,Newhistorial),
	Newturno is Turnoactual + 1,
	restar_fichas(Player2,NP2),
	game(Player1,NP2,Newboard,Newturno,Newhistorial,Newgame),
	is_draw(Newgame),
	end_game(Newgame,Newgame2),
	imprimir_tablero(Newboard), nl.
%caso de si juega el player 1 y revisa si alguien gana o si aun se puede jugar
player_play([Player1,Player2,Board,Turnoactual,Historial],Player,Column,Newgame2):-
	corresponde_player(Player1,Player),
	not(no_tienen_fichas(Player1)),
	get_current_player([Player1,Player2,Board,Turnoactual,Historial],Cp),
	corresponde_player(Cp,Player),
	saber_color(Player,Color),
	piece(Color,Ficha),
	play_piece(Board,Column,Ficha,Newboard),
	actualizar_historial(Column,Color,Historial,Newhistorial),
	Newturno is Turnoactual + 1,
	restar_fichas(Player1,NP1),
	game(NP1,Player2,Newboard,Newturno,Newhistorial,Newgame),
	not(is_draw(Newgame)),
	(algien_gana(Newboard)->
	(end_game([NP1,Player2,Newboard,Turnoactual,Newhistorial],Newgame2));
	(game(NP1,Player2,Newboard,Newturno,Newhistorial,Newgame2))),
	imprimir_tablero(Newboard), nl.
%caso de si juega el player 2 y revisa si alguien gana o si aun se puede jugar
player_play([Player1,Player2,Board,Turnoactual,Historial],Player,Column,Newgame2):-
	corresponde_player(Player2,Player),
	not(no_tienen_fichas(Player2)),
	get_current_player([Player1,Player2,Board,Turnoactual,Historial],Cp),
	corresponde_player(Cp,Player),
	saber_color(Player,Color),
	piece(Color,Ficha),
	play_piece(Board,Column,Ficha,Newboard),
	actualizar_historial(Column,Color,Historial,Newhistorial),
	Newturno is Turnoactual + 1,
	restar_fichas(Player2,NP2),
	game(Player1,NP2,Newboard,Newturno,Newhistorial,Newgame),
	not(is_draw(Newgame)),
	(algien_gana(Newboard)->
	(end_game([Player1,NP2,Newboard,Turnoactual,Newhistorial],Newgame2));
	(game(Player1,NP2,Newboard,Newturno,Newhistorial,Newgame2))),
	imprimir_tablero(Newboard), nl.
	
%-------------------------------------------------------------------
%Predicados auxiliares para poder tener una lógica más entendible al ejecutarlo.

actualizar_historial(Column,Color,Lista,[[Column,Color]|Lista]).


saber_color([_,_, Color,_,_,_,_],Color).

restar_fichas([Id1, Name1, Color1, Win1, Losses1, Draws1, Piezas1],
			[Id1, Name1, Color1, Win1, Losses1, Draws1, PN1]):-
	PN1 is Piezas1 - 1.


corresponde_player([Id,_,_,_,_,_,_],[Id,_,_,_,_,_,_]).

algien_gana(Board):-
	who_is_winner(Board,Winner),
	Winner \= 0.


