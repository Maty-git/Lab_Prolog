

%constructor game
game(Player1,Player2,Board,Turnoactual,[Player1,Player2,Board,Turnoactual,[]]).
game(Player1,Player2,Board,Turnoactual,Historial,[Player1,Player2,Board,Turnoactual,Historial]).

%----------------------------------

game_history([_,_,_,_,Historial],H):-
	reverse(Historial,H),
	write(H).

%-----------------------------------

is_draw([Player1,Player2,Board,_,_]):-
	not(can_play(Board));
	(no_tienen_fichas(Player1),
	no_tienen_fichas(Player2)).

no_tienen_fichas([_,_,_,_,_,_,0]).

%----------------------------------------
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

%------------------------------------------------------------


