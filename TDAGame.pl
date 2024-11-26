

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
get_current_player([Player1,_,_,Turnoactual,_],Player1):-
	1 is Turnoactual mod 2.
get_current_player([_,Player2,_,Turnoactual,_],Player2):-
	0 is Turnoactual mod 2.


%-------------------------------------------------------------
game_get_board([_,_,Board,_,_],Board).

%------------------------------------------------------------

end_game([Player1,Player2,Board,Turnoactual,Historial],[P1,P2,Board,Turnoactual,Historial]):-
	update_stats([Player1,Player2,Board,Turnoactual,Historial],
				[Player1,Player2],
				P1,P2),
	write(P1),nl,
	write(P2),nl.
%--------------------------------------------------------------
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

actualizar_historial(Column,Color,Lista,[[Column,Color]|Lista]).


saber_color([_,_, Color,_,_,_,_],Color).

restar_fichas([Id1, Name1, Color1, Win1, Losses1, Draws1, Piezas1],
			[Id1, Name1, Color1, Win1, Losses1, Draws1, PN1]):-
	PN1 is Piezas1 - 1.


corresponde_player([Id,_,_,_,_,_,_],[Id,_,_,_,_,_,_]).

algien_gana(Board):-
	who_is_winner(Board,Winner),
	Winner \= 0.


