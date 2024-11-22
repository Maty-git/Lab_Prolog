

%constructor game
game(Player1,Player2,Board,Turnoactual,[Player1,Player2,Board,Turnoactual,[]]).
game(Player1,Player2,Board,Turnoactual,Historial,[Player1,Player2,Board,Turnoactual,Historial]).

%----------------------------------

game_history([_,_,_,_,Lista],Lista).


	